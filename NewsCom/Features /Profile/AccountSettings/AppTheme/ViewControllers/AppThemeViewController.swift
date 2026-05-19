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
    
    
    var themes: [Theme] = [
        
        Theme(
               title: "Default",
               subtitle: "Classic NewsCom look",
               primaryColor: .systemBlue,
               secondaryColor: .systemGray,
               backgroundColor: .white,
               isSelected: true
           ),

        Theme(
               title: "Autumn",
               subtitle: "Warm tones",
               primaryColor: .systemOrange,
               secondaryColor: .red,
               backgroundColor: .white,
               isSelected: false
           ),
        
        Theme(
               title: "Fairytale",
               subtitle: "Enchanted Royal",
               primaryColor: .systemPurple,
               secondaryColor: .blue,
               backgroundColor: .white,
               isSelected: false
           )
    ]
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "App Theme"
        
        setupTableView()
        
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
        tableView.register(LivePreviewCell.self, forCellReuseIdentifier: LivePreviewCell.identifier)
        tableView.register(ApplyThemeCell.self, forCellReuseIdentifier: ApplyThemeCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
            
    }
}


extension AppThemeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {

        case 0:

            return tableView.dequeueReusableCell(
                withIdentifier: AppearanceHeaderCell.identifier,
                for: indexPath
            )

        case 1:

            let cell = tableView.dequeueReusableCell(
                withIdentifier: ThemePaletteCell.identifier,
                for: indexPath
            ) as! ThemePaletteCell

            cell.configure(theme: themes[indexPath.row])

            return cell

        case 2:

            return tableView.dequeueReusableCell(
                withIdentifier: LivePreviewCell.identifier,
                for: indexPath
            )

        default:

            return tableView.dequeueReusableCell(
                withIdentifier: ApplyThemeCell.identifier,
                for: indexPath
            )
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        switch section {

        case 0:
            return 1

        case 1:
            return themes.count

        case 2:
            return 1

        default:
            return 1
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
            return 140
        case 1:
            return 90
        case 2:
            return 280
        default:
            return 120
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            
        case 1:
            return "Themes"
        case 3:
            return "Live Preview"
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
        
        themes = themes.enumerated().map { index, theme in
            
            Theme(
                title: theme.title,
                subtitle: theme.subtitle,
                primaryColor: theme.primaryColor,
                secondaryColor: theme.secondaryColor,
                backgroundColor: theme.backgroundColor,
                isSelected: index == indexPath.row
            )
            
        }
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}
