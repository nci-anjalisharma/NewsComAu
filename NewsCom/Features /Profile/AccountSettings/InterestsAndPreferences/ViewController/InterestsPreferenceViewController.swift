//
//  MyTopicsViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//

import UIKit
import SnapKit

class InterestsPreferenceViewController: UIViewController {

    private let viewModel = InterestsPreferenceViewModel()

    private lazy var tableView: UITableView = {

        let table = UITableView(frame: .zero, style: .insetGrouped)

//        table.register(InterestToggleCell.self, forCellReuseIdentifier: InterestToggleCell.identifier)
//
//        table.register(NotificationToggleCell.self, forCellReuseIdentifier: NotificationToggleCell.identifier)

        table.register(ContentSettingSegmentCell.self, forCellReuseIdentifier: ContentSettingSegmentCell.identifier)
        
        table.register(DataManagementCell.self, forCellReuseIdentifier: DataManagementCell.identifier)
        
        table.register(ReadingEffectTableViewCell.self, forCellReuseIdentifier: ReadingEffectTableViewCell.identifier)

        table.dataSource = self
        table.delegate = self

        return table

    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Interests & Preferences"

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        applyTheme()

        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
    }
    
    @objc private func themeChanged() {
        applyTheme()
        tableView.reloadData()
    }
    
    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        view.backgroundColor = theme.colors.background
        tableView.backgroundColor = theme.colors.background
    }
    
    @objc private func dataManagementTapped(_ sender: UIButton) {

        switch sender.tag {

        case 0:
            showClearHistoryAlert()

        case 1:
            showClearSavedArticlesAlert()

        default:
            break
        }
    }
    
    private func showClearHistoryAlert() {

        let alert = UIAlertController(title: "Clear Reading History?", message: "This will remove your reading history and reset your recommendations.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { [weak self] _ in

            ReadingHistoryManager.shared.clearHistory()

            let success = UIAlertController(title: nil, message: "Reading history cleared.", preferredStyle: .alert)

            self?.present(success, animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                success.dismiss(animated: true)
            }
        })
        
        present(alert, animated: true)
    }

    
    private func showClearSavedArticlesAlert() {

        let alert = UIAlertController(title: "Clear Saved Articles?", message: "This will permanently remove all saved articles. This action cannot be undone.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { [weak self] _ in

            SavedManager.shared.clearAllSavedArticles()

            // Show success message
            let success = UIAlertController(title: nil, message: "Saved articles cleared.", preferredStyle: .alert)

            self?.present(success, animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                success.dismiss(animated: true)
            }
        })

        present(alert, animated: true)
    }
}

extension InterestsPreferenceViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {

        case 0:
            return viewModel.dataManagement.count

        case 1:
            return viewModel.contentSettings.count

        case 2:
            return ReadingEffect.allCases.count

        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {

        case 0:

//            let cell = tableView.dequeueReusableCell(withIdentifier: InterestToggleCell.identifier, for: indexPath) as! InterestToggleCell
//
//            cell.configure(with: viewModel.topics[indexPath.row])
//
//            return cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DataManagementCell.identifier, for: indexPath) as! DataManagementCell

                let item = viewModel.dataManagement[indexPath.row]
                cell.configure(with: item)

                cell.clearButton.tag = indexPath.row
                cell.clearButton.addTarget(self, action: #selector(dataManagementTapped(_:)), for: .touchUpInside)

                return cell

//        case 1:
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationToggleCell.identifier, for: indexPath) as! NotificationToggleCell
//
//            cell.configure(with: viewModel.notifications[indexPath.row])
//
//            return cell
            
        case 2:

            let cell = tableView.dequeueReusableCell(withIdentifier: ReadingEffectTableViewCell.identifier, for: indexPath) as! ReadingEffectTableViewCell

            let effect = ReadingEffect.allCases[indexPath.row]

            cell.configure(with: effect, isSelected: effect == DoubleTapPreferenceManager.shared.selectedEffect)

            return cell

        default:

            let cell = tableView.dequeueReusableCell(withIdentifier: ContentSettingSegmentCell.identifier, for: indexPath) as! ContentSettingSegmentCell

            return cell
        }
    }
}

extension InterestsPreferenceViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {

        case 0:
            return "DATA MANAGEMENT"

        case 1:
            return "CONTENT SETTINGS"

        case 2:
            return "READING EFFECTS"

        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {

        case 1:
            return 280      // Content Settings

        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard indexPath.section == 2 else { return }

        let selectedEffect = ReadingEffect.allCases[indexPath.row]

        guard selectedEffect != DoubleTapPreferenceManager.shared.selectedEffect else {
            return
        }

        DoubleTapPreferenceManager.shared.selectedEffect = selectedEffect

        updateReadingEffectSelection()
        
        switch selectedEffect {

        case .save:

//            BookmarkAnimationManager.shared.play(in: view, at: view.center, saved: true)
            break

        case .confetti:
//            break
            CelebrationManager.launch(in: self.view)
        case .hearts:
            HeartsManager.launch(in: self.view)
            
        case .fireworks:
//            FireworksManager.launch(in: self.view)
            SparklesManager.launch(in: self.view)
        
        case .crax:
            CraxManager.launch(in: self.view)
            
        }
        
    }
    
    private func updateReadingEffectSelection() {

        for cell in tableView.visibleCells {

            guard let effectCell = cell as? ReadingEffectTableViewCell,
                  let indexPath = tableView.indexPath(for: effectCell),
                  indexPath.section == 2
            else { continue }

            let effect = ReadingEffect.allCases[indexPath.row]

            effectCell.updateSelection(
                effect == DoubleTapPreferenceManager.shared.selectedEffect
            )
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width, bottom: 0, right: 0)
        }
    }
}
