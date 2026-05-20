//
//  newvc.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 05/05/26.
//

import UIKit
class newvc: UIViewController {
    
    
    
    
    
    @IBOutlet weak var button: UIButton!
    
    func buttonAction(_ button: UIButton) {
        
        button.setTitle("Hello", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action:
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAction(button)
    }
}
