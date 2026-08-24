//
//  SaveArticlesDelegate.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/06/26.
//

protocol SaveArticlesDelegate: AnyObject {
    func didSaveArticle(_ article: Article)
    func didRemoveSaveArticle(_ article: Article)
}
