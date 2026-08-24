//MenuViewController

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setupNavigationBar()
        setupTableView()
        applyTheme()
       
        NotificationCenter.default.addObserver(self, selector: #selector(savedArticlesUpdated), name: .savedArticlesChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
    }
    
    @objc private func themeChanged() {
        applyTheme()
        tableView.reloadData()
    }
    
    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        view.backgroundColor = .white
        tableView.backgroundColor = theme.colors.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
    
    private func setupTableView(){
        
        view.addSubview(tableView)
    
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: "StatsCell")
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.register(LoginTableViewCell.self, forCellReuseIdentifier: "loginCell")
        
        tableView.layer.cornerRadius = 16
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.clipsToBounds = true
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        
        let theme = ThemeManager.shared.currentTheme
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.colors.primary]
        navigationItem.title = "The Daily News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chart.bar.xaxis"), style: .plain, target: self, action: #selector(didTapReadingStatistics))
    }

    @objc private func didTapReadingStatistics() {
        let statisticsVC = ReadingGraphViewController()
        navigationController?.pushViewController(statisticsVC, animated: true)
    }
    
    @objc private func savedArticlesUpdated() {
        tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1{
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath ) {
        
        if indexPath.section == 1 {
            var vc = UIViewController()
            
            switch indexPath.row {
            case 0:
                vc = ReadingStatisticsViewController()
                
            case 1:
                vc = InterestsPreferenceViewController()

            case 2:
                vc = AppThemeViewController()
                
            case 3:
                vc = HelpAndSupportViewController()
                
            default:
                break
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        if indexPath.section == 0 {
                
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsTableViewCell

            cell.configure(articlesRead: "324", saved: "82", topics: "18")

            cell.onReadTapped = { [weak self] in

                let vc = SavedArticlesViewController(type: .history)
                vc.hidesBottomBarWhenPushed = true

                self?.navigationController?.pushViewController(vc,animated: true)
            }

            cell.onSavedTapped = { [weak self] in

                let vc = SavedArticlesViewController(type: .saved)
                vc.hidesBottomBarWhenPushed = true

                self?.navigationController?.pushViewController(vc, animated: true)
            }
                
            cell.onMilestonesTapped = { [weak self] in

                let vc = MilestonesViewController()

                self?.navigationController?.pushViewController(vc, animated: true)
            }

            cell.selectionStyle = .none

        return cell
                
    } else if indexPath.section == 1 {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
                
        switch indexPath.row {
                    
        case 0:
            cell.configure(title: "Reading Statistics", icon: "books.vertical")
        case 1:
            cell.configure(title: "Interests & Preferences", icon: "line.3.horizontal")
        case 2:
            cell.configure(title: "App Theme", icon: "paintpalette")
        case 3:
            cell.configure(title: "Help & Support", icon: "questionmark.circle")
        
        default:
            break
        }
        return cell
                
    } else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath) as! LoginTableViewCell
        cell.selectionStyle = .none
                
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "ACCOUNT SETTINGS"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width, bottom: 0, right: 0)
        }
    }
}
