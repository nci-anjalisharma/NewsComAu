import UIKit
import SnapKit

class MenuViewController: UIViewController {

    private lazy var myTopics = makeButton(title: "My Topics")
    private lazy var myNews = makeButton(title: "My News")
    private lazy var notifications = makeButton(title: "Notifications")
    private lazy var textSize = makeButton(title: "Text Size")
    private lazy var about = makeButton(title: "About")
    
    

    private lazy var loginLogoutButton: UIButton = {
        let button = UIButton()
        if RootNavigationService.isUserLoggedIn == true {
            button.setTitle("Logout", for: .normal)
        } else {
            button.setTitle("Login", for: .normal)
        }
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapSetting), for: .touchUpInside)
        return button
    }()

    private func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapSetting), for: .touchUpInside)
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        self.title = "Menu"
        setupMenus()
        layout()
    }

    private func setupMenus() {
        view.addSubview(myTopics)
        view.addSubview(myNews)
        view.addSubview(notifications)
        view.addSubview(textSize)
        view.addSubview(about)
        view.addSubview(loginLogoutButton)
    }

    private func layout() {

        let buttons = [myTopics, myNews, notifications, textSize, about]

        for (index, button) in buttons.enumerated() {
            button.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(45)

                if index == 0 {
                    make.top.equalTo(view.safeAreaLayoutGuide)
                } else {
                    make.top.equalTo(buttons[index - 1].snp.bottom).offset(5)
                }
            }
        }

        loginLogoutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    @objc private func didTapSetting(sender: UIButton) {

        let currentTitle = sender.currentTitle ?? ""

        if currentTitle == "My Topics" {
            navigationController?.pushViewController(MyTopicsViewController(), animated: true)
             
        } else if currentTitle == "My News" {
            navigationController?.pushViewController(MyNewsViewController(), animated: true)
             
        } else if currentTitle == "Notifications" {
            navigationController?.pushViewController(NotificationsViewController(), animated: true)
             
        } else if currentTitle == "Text Size" {
            navigationController?.pushViewController(TextSizeViewController(), animated: true)
             
        } else if currentTitle == "About" {
            navigationController?.pushViewController(AboutViewController(), animated: true)
        } else if currentTitle == "Logout" {
             
            RootNavigationService.shared.showOnboardingPage()
            
        } else if currentTitle == "Login" {
            
            RootNavigationService.shared.showLoginPage()
        }
    }
}
