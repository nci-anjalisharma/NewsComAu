 


import UIKit
import SnapKit

class OnboardingPageViewController: UIPageViewController {
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pages: [UIViewController] = {
        onboardingItems.map { OnboardingContentViewController(item: $0) }
    }()
    
    private let skipButton: UIButton = {

        let button = UIButton(type: .system)

        button.setTitle("Skip", for: .normal)
        button.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)

        return button
    }()
    
    @objc private func didTapSkip(){
        UserDefaults.standard.set(false, forKey: "hasLoggedIn")
        UserDefaults.standard.set(false, forKey: "hasSignedUp")
        RootNavigationService.shared.showTabBar()
    }
    
    private let loginButton: UIButton = {

        let button = UIButton(type: .system)

        button.setTitle("Login", for: .normal)

        button.backgroundColor = .autumnPrimary
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        return button
    }()
    
    @objc private func didTapLogin(){
        RootNavigationService.shared.showLoginPage()
    }
    
    private let signUpButton: UIButton = {

        let button = UIButton(type: .system)

        button.setTitle("Sign Up", for: .normal)

        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)

        return button
    }()
    
    @objc private func didTapSignup(){
        RootNavigationService.shared.showSignupPage()
    }
    
    private let pageControl: UIPageControl = {

        let pageControl = UIPageControl()

        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        dataSource = self
        delegate = self
        
        configurePages()
        setupUI()
        signUpButton.isHidden = true
        pageControl.numberOfPages = pages.count
    }
    
    private func configurePages() {

        setViewControllers([pages[0]], direction: .forward, animated: false)
        pageControl.currentPage = 0
    }
    
    private let onboardingItems: [OnboardingItem] = [

        OnboardingItem(
            imageName: "onboarding_page1",
            title: " ",
            subtitle: " "
        ),

        OnboardingItem(
            imageName: "onboarding_page2",
            title: " ",
            subtitle: " "
        ),

        OnboardingItem(
            imageName: "onboarding_page3",
            title: " ",
            subtitle: " "
        )
    ]
    
    private func setupUI() {

        view.addSubview(skipButton)
        view.addSubview(pageControl)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)

        skipButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().offset(-24)
        }

        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(loginButton.snp.top).offset(-24)
        }

        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-16)
        }

        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
    }
}

extension OnboardingPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let index = pages.firstIndex(of: viewController)
        else { return nil }

        let previousIndex = index - 1

        guard previousIndex >= 0
        else { return nil }

        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let index = pages.firstIndex(of: viewController)
        else { return nil }

        let nextIndex = index + 1

        guard nextIndex < pages.count
        else { return nil }

        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard completed,
              let currentVC = viewControllers?.first,
              let index = pages.firstIndex(of: currentVC)
        else { return }

        pageControl.currentPage = index

        signUpButton.isHidden = index != pages.count - 1
    }
    
}



