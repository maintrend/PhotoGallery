//
//  MainTapBarController.swift
//  PhotoGallery
//
//  Created by talgat on 6/23/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
    
    let photosVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let likesVC = LikesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
//    let navigationVC = UINavigationController(rootViewController: photosVC)
//    navigationVC.tabBarItem.title = "Photos"
//    navigationVC.tabBarItem.image = #imageLiteral(resourceName: "photos")
    viewControllers = [generateNavigationController(rootViewController: photosVC, title: "Photos", image: #imageLiteral(resourceName: "photos")),
                       generateNavigationController(rootViewController: likesVC, title: "Favorites", image: #imageLiteral(resourceName: "heart"))]
    
   }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
