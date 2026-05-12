//
//  HomeTableView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 05/05/26.
//

import UIKit

class HomeTableView: UITableViewController {
    
    @IBOutlet weak var firstCell: UITableViewCell!
    
    
    @IBOutlet weak var secondCell: UITableViewCell!
    
    
    @IBOutlet weak var thirdCell: UITableViewCell!
    
    
    @IBOutlet weak var fourthCell: UIView!
    

    @IBOutlet weak var fifthCell: UITableViewCell!
    
    
    @IBOutlet weak var sixthCell: UITableViewCell!
    
    
    @IBOutlet weak var seventhCell: UITableViewCell!
    
    @IBOutlet weak var eigthCell: UITableViewCell!
    
    
    @IBOutlet var tableview: UITableView!   //important
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        
    }
}
//extension HomeTableView: UITableViewDelegate, UITableViewDataSource {
//    savedArtcile
//    section
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return savedArtcile.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            
//        }
//        return UITableViewCell()
//    }
//}
