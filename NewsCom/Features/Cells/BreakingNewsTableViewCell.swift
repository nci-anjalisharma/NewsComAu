
//
//  BreakingNewsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/05/26.
//



import UIKit
import SnapKit

class BreakingNewsTableViewCell: UITableViewCell,
                                 UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {
    
   

    
    weak var parentViewController: UIViewController?
    var collectionView: UICollectionView!

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let article = articles[indexPath.row]
        
        let vc = FullArticleViewController()
        vc.articleText = article.headline
        
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
        
    
    
    }
    
    
    let articles: [BreakingNews] = [
        
        BreakingNews(topic: "Entertainment News", imageName: "news8", headline: "9 Grammy Awards for this season - 2026 goes to Taylor Swift"),
        
        BreakingNews(topic: "Technology", imageName: "news5", headline: "Apple unveils new AI-powered iPhone called Apple Intelligence"),
        
        BreakingNews(topic: "Business", imageName: "news12", headline: "Economic crisis in third-world keeps rising albeit the massive bills and loans approved by world bank"),
        
        BreakingNews(topic: "Travel", imageName: "news9", headline: "Amid war states between Iran and Israel, travel destinations have become cheaper than ever with the ongoing luxury cruise introduced for Maldieves")
    ]

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {

        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        

        setupCollectionView()
        
        collectionView.register(
            BreakingNewsCollectionViewCell.self,
            forCellWithReuseIdentifier:
                BreakingNewsCollectionViewCell.identifier
        )
    }

    private func setupCollectionView() {

        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal

        layout.minimumLineSpacing = 16

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.backgroundColor = .clear

        collectionView.showsHorizontalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self

        

        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in

            make.edges.equalToSuperview().inset(10)
        }
    }

 

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return articles.count
    }

   

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
    -> CGSize {

        return CGSize(width: 280,
                      height: 300)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreakingNewsCollectionViewCell.identifier, for: indexPath) as! BreakingNewsCollectionViewCell
            
            
        let article = articles[indexPath.item]
        
        cell.configure(title: article.topic, imageName: article.imageName, headLine: article.headline)
        
        
        return cell
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
