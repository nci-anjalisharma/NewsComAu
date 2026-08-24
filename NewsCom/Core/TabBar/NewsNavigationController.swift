//
//  NewsNavigationController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 20/07/26.
//
import UIKit

class NewsNavigationController: UINavigationController {

    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}
