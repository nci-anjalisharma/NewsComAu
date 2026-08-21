//
//  Topic2ViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 15/04/26.
//

import UIKit
import SnapKit

class AppThemeViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let themes = ThemeRepository.allThemes

    private var selectedTheme = ThemeManager.shared.currentTheme
    
    private var selectedAppearance: UIUserInterfaceStyle = UserDefaults.standard.integer(forKey: "AppearanceMode") == 0 ? .light : .dark
    
    private let applyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "App Theme"
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
        
        setupTableView()
        setupApplyButton()
        applyTheme()
        updateApplyButton()
    }
    
    private func setupApplyButton() {
        applyButton.setTitle("Apply Theme", for: .normal)
        applyButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)

        applyButton.layer.cornerRadius = 25
        applyButton.clipsToBounds = true

        applyButton.addTarget(
            self,
            action: #selector(applyThemeButtonTapped),
            for: .touchUpInside
        )

        view.addSubview(applyButton)

        applyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(190)
            make.height.equalTo(50)
        }
    }
    
    @objc
    private func applyThemeButtonTapped() {

        ThemeManager.shared.applyTheme(selectedTheme)

        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first
        else {
            navigationController?.popViewController(animated: true)
            return
        }

        window.overrideUserInterfaceStyle = selectedAppearance

        UserDefaults.standard.set(
            selectedAppearance == .light ? 0 : 1,
            forKey: "AppearanceMode"
        )

        navigationController?.popViewController(animated: true)
    }
    
    @objc private func themeChanged() {

        print("Theme Changed Notification Received")

        applyTheme()
    }
    
    private func updateApplyButton() {
        applyButton.backgroundColor = selectedTheme.colors.primary

        applyButton.setTitleColor(selectedTheme.colors.background, for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        applyTheme()
    }
    
    private func setupTableView() {
        
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(AppearanceHeaderCell.self, forCellReuseIdentifier: AppearanceHeaderCell.identifier)
        tableView.register(ThemePaletteCell.self, forCellReuseIdentifier: ThemePaletteCell.identifier)
        
        view.addSubview(tableView)
        
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//            make.top.equalTo(view.safeAreaLayoutGuide)
//        }
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
    }
    
    private func applyTheme() {

        view.backgroundColor = selectedTheme.colors.background

        tableView.reloadData()
    }
    
//    private func previewTheme() {
//
//        overrideUserInterfaceStyle = selectedAppearance
//
//        view.backgroundColor = selectedTheme.colors.background
//
//        tableView.reloadData()
//    }
    
    private func previewTheme() {

        overrideUserInterfaceStyle = selectedAppearance

        view.backgroundColor = selectedTheme.colors.background

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()

        appearance.titleTextAttributes = [
            .foregroundColor: selectedTheme.colors.primary
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        tableView.reloadData()
        updateApplyButton()
    }
}

extension AppThemeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AppearanceHeaderCell.identifier,
                for: indexPath) as! AppearanceHeaderCell
            cell.configure(theme: selectedTheme, appearance: selectedAppearance)
            
            cell.onAppearanceChanged = { [weak self] index in
                
                guard let self else { return }
                
                self.selectedAppearance = index == 0 ? .light : .dark
                
                self.overrideUserInterfaceStyle = self.selectedAppearance
            }
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ThemePaletteCell.identifier,
                for: indexPath
            ) as! ThemePaletteCell
            
            let theme = themes[indexPath.row]
            
            cell.configure(theme: theme, isSelected: theme.id == selectedTheme.id)
            
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        switch section {

        case 0:
            return 1

        case 1:
            return themes.count

        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case 0:
            return 100
        case 1:
            return 90
//        case 2:
//            return 50
        default:
            return 120
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            
        case 1:
            return "Themes"
//        case 3:
//            return "Live Preview"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        
        header.textLabel?.textColor = .gray
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 1 else {
            return
        }
        
        selectedTheme = themes[indexPath.row]
        previewTheme()

        tableView.reloadData()
    }
}
