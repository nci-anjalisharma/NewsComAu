//
//  RelatedStoriesCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/05/26.
//

import UIKit
import SnapKit


 

class RelatedStoriesCell: UITableViewCell  {
    
    var collectionView: UICollectionView!
    static let identifier = "RelatedStoriesCell"
    
    private let relatedArticles: [Article] = [
       Article(
           title: "AI is changing journalism",
           author: "BBC",
           imageURL: "news3",
           description: "AI article"
       ),

       Article(
           title: "Markets rally again",
           author: "Bloomberg",
           imageURL: "news4",
           description: "Finance article"
       ),

       Article(
           title: "Apple unveils new tech",
           author: "TechCrunch",
           imageURL: "news7",
           description: "Apple article"
       ),
       
       Article(
           title: "AI is changing journalism",
           author: "BBC",
           imageURL: "news3",
           description: "AI article"
       ),

       Article(
           title: "Markets rally again",
           author: "Bloomberg",
           imageURL: "news4",
           description: "Finance article"
       ),

       Article(
           title: "Apple unveils new tech",
           author: "TechCrunch",
           imageURL: "news7",
           description: "Apple article"
       ),
       Article(
           title: "AI is changing journalism",
           author: "BBC",
           imageURL: "news3",
           description: "AI article"
       ),

       Article(
           title: "Markets rally again",
           author: "Bloomberg",
           imageURL: "news4",
           description: "Finance article"
       ),

       Article(
           title: "Apple unveils new tech",
           author: "TechCrunch",
           imageURL: "news7",
           description: "Apple article"
       )
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCollectionViews()
    
    }
    
    private func setupCollectionViews(){

        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: 300, height: 500)
        layout.estimatedItemSize = .zero

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            BreakingNewsCollectionViewCell.self,
            forCellWithReuseIdentifier:
                BreakingNewsCollectionViewCell.identifier
        )

        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RelatedStoriesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreakingNewsCollectionViewCell.identifier, for: indexPath) as! BreakingNewsCollectionViewCell
            
        let article = relatedArticles[indexPath.item]

        cell.configure(title: article.author, imageName: article.imageURL, headLine: article.title)
       print("Row cell")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size for row called")
        return CGSize(width: 280, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
