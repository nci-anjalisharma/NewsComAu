 
//
//  SplashViewController.swift
//NewsCom
//
//  Created by ANJALI SHARMA R on 07/04/26.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.image = UIImage(named: "splash_screen")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemBackground
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpLayout()
        startSplashAnimation()
    }
    
    private func setUpLayout() {
        
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func startSplashAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                RootNavigationService.shared.moveFromSplashToRoot()
            }
        }
        UserDefaults.standard.set(false, forKey: "hasFinishedOnboarding")
    }
}
 

 
