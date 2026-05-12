import UIKit
import SnapKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var tableView = UITableView()

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1{
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath ) {
        
        if indexPath.section == 1 {
            var vc = UIViewController()
            
            
            switch indexPath.row {
            case 0:
                vc = ReadingHistory()
                
            case 1:
                vc = InterestsAndPreferences()
            
            case 2:
                vc = Notifications()
            
            case 3:
                vc = AppTheme()
                
            case 4:
                vc = HelpAndSupport()
                
            default:
                break
            }
            navigationController?.pushViewController(vc, animated: true)
        }
            

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsTableViewCell
            cell.configure(articlesRead: "324", saved: "82", topics: "12")
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
            switch indexPath.row {
            case 0:
                cell.configure(title: "Reading History", icon: "clock.arrow.trianglehead.counterclockwise.rotate.90")
            case 1:
                cell.configure(title: "Interests & Preferences", icon: "line.3.horizontal")
            case 2:
                cell.configure(title: "Notifications", icon: "bell")
            case 3:
                cell.configure(title: "App Theme", icon: "moon")
            case 4:
                cell.configure(title: "Help & Support", icon: "questionmark.circle")
                
            default:
                break
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath) as! LoginTableViewCell
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 {
            return "ACCOUNT SETTINGS"
        }
        
        return nil
    }
    

//    private lazy var myTopics = makeButton(title: "My Topics")
//    private lazy var myNews = makeButton(title: "My News")
//    private lazy var notifications = makeButton(title: "Notifications")
//    private lazy var textSize = makeButton(title: "Text Size")
//    private lazy var about = makeButton(title: "About")
//    
    
    
    
    
    

    
    
    
//    
//    
//    private lazy var loginLogoutButton: UIButton = {
//        let button = UIButton()
//        if RootNavigationService.isUserLoggedIn == true {
//            button.setTitle("Logout", for: .normal)
//        } else {
//            button.setTitle("Login", for: .normal)
//        }
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 8
//        button.addTarget(self, action: #selector(didTapSetting), for: .touchUpInside)
//        return button
//
//    }()

//    private func makeButton(title: String) -> UIButton {
//        let button = UIButton()
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .white
//        button.contentHorizontalAlignment = .left
//        button.addTarget(self, action: #selector(didTapSetting), for: .touchUpInside)
//        return button
//    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "profileBackgroundColor")
        
        navigationItem.title = "The Daily News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapAdd))
        
        
//        layout()
        
        view.addSubview(tableView)

        tableView.backgroundView = nil
         
        tableView.backgroundColor = .clear
        
        
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: "StatsCell")
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.register(LoginTableViewCell.self, forCellReuseIdentifier: "loginCell")
        
        
        tableView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        tableView.layer.cornerRadius = 16
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.clipsToBounds = true
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            
        }
        
    }
    
    @objc private func didTapAdd(){
        let searchBar = UISearchController()
        searchBar.modalPresentationStyle = .fullScreen
        present(searchBar, animated: true, completion: nil)
    }
    
    
//
//    private func setupMenus() {
////        view.addSubview(myTopics)
////        view.addSubview(myNews)
////        view.addSubview(notifications)
////        view.addSubview(textSize)
////        view.addSubview(about)
//        view.addSubview(loginLogoutButton)
//    }
////
//    private func layout() {
//
////        let buttons = [myTopics, myNews, notifications, textSize, about]
////
////        for (index, button) in buttons.enumerated() {
////            button.snp.makeConstraints { make in
////                make.leading.trailing.equalToSuperview().inset(16)
////                make.height.equalTo(45)
////
////                if index == 0 {
////                    make.top.equalTo(view.safeAreaLayoutGuide)
////                } else {
////                    make.top.equalTo(buttons[index - 1].snp.bottom).offset(5)
////                }
////            }
////        }
//        view.addSubview(loginLogoutButton)
//        
//        loginLogoutButton.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(45)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
//        }
//    }
//
//    @objc private func didTapSetting(sender: UIButton) {
//
//        let currentTitle = sender.currentTitle ?? ""
//
////        if currentTitle == "My Topics" {
////            navigationController?.pushViewController(MyTopicsViewController(), animated: true)
////             
////        } else if currentTitle == "My News" {
////            navigationController?.pushViewController(MyNewsViewController(), animated: true)
////             
////        } else if currentTitle == "Notifications" {
////            navigationController?.pushViewController(NotificationsViewController(), animated: true)
////             
////        } else if currentTitle == "Text Size" {
////            navigationController?.pushViewController(TextSizeViewController(), animated: true)
////             
////        } else if currentTitle == "About" {
////            navigationController?.pushViewController(AboutViewController(), animated: true)
////        } else
//        if currentTitle == "Logout" {
//             
//            RootNavigationService.shared.showOnboardingPage()
//            
//        } else if currentTitle == "Login" {
//            
//            RootNavigationService.shared.showLoginPage()
//        }
//    }
//    
    
    
    
    
    
}

 
