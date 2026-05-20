
//
//  BreakingNewsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/05/26.
//



import UIKit
import SnapKit



class BreakingNewsTableViewCell: UITableViewCell{

    static let identifier = "BreakingNewsTableViewCell"
    weak var parentViewController: UIViewController?
    var collectionView: UICollectionView!

    let articles: [Article] = [
        
        Article(
                title: "Apple sold for 5000. Nutritionists Concerned",
                author: "Apple Man",
                imageURL: "news13",
                description: "Increase rise in the trend of Excotic fruits like Kiwi and Dragon fruit has left apples in grave danger"),
        
        Article(
                title: "Sports",
                author: "ESPN",
                imageURL: "news12",
                description: "Chelsea secure dramatic win in final minutes after intense second half"),

        Article(
                title: "Politics",
                author: "BBC",
                imageURL: "news9",
                description: "Global leaders gather for climate summit discussions in Geneva"),

        Article(
                title: "Finance",
                author: "Bloomberg",
                imageURL: "news3",
                description: "Stock markets surge as tech companies report stronger earnings"),

                Article(
                    title: "Entertainment",
                    author: "Netflix Daily",
                    imageURL: "news4",
                    description: "New sci-fi thriller becomes the most streamed show this week"
                ),

                Article(
                    title: "Science",
                    author: "NASA",
                    imageURL: "news5",
                    description: "Astronomers discover potentially habitable planet near solar system"
                ),

                Article(
                    title: "Travel",
                    author: "Lonely Planet",
                    imageURL: "news8",
                    description: "Japan announces new digital nomad visa for remote workers"
                ),

                Article(
                    title: "Gaming",
                    author: "IGN",
                    imageURL: "news7",
                    description: "Major open-world RPG delayed until early next year"
                ),

                Article(
                    title: "Fashion",
                    author: "Vogue",
                    imageURL: "news8",
                    description: "Minimal streetwear trends dominate summer collections"
                ),

                Article(
                    title: "Health",
                    author: "WHO",
                    imageURL: "news9",
                    description: "Experts recommend new sleep routines for better mental health"
                ),

                Article(
                    title: "Food",
                    author: "Food Insider",
                    imageURL: "news10",
                    description: "Traditional South Indian dishes gain global popularity"
                ),

                Article(
                    title: "AI",
                    author: "OpenAI",
                    imageURL: "news7",
                    description: "New AI tools are transforming productivity across industries"
                )
    ]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

            make.edges.equalToSuperview()
        }
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BreakingNewsTableViewCell: UICollectionViewDelegate,
                                     UICollectionViewDataSource,
                                     UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let vc = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.configure(with: self.articles, startIndex: indexPath.item)
        
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return articles.count
    }

   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 280, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreakingNewsCollectionViewCell.identifier, for: indexPath) as! BreakingNewsCollectionViewCell
            
            
        let article = articles[indexPath.item]
        
        cell.configure(title: article.title, imageName: article.imageURL, headLine: article.description)
        
        
        return cell
        
    }
    
}
