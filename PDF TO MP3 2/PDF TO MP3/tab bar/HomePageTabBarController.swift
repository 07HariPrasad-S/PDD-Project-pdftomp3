//
//  HomePageTabBarController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 04/02/25.
//

import UIKit

class HomePageTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(hex: "#24A8EF")
        initViewControllers()
        initTabbarApperance()
    }
    
    
    private func initViewControllers() {
        
        let homeVC: HomeViewController = HomeViewController.instantiate()
        homeVC.tabBarItem.image = UIImage(named: "HomePage")
        homeVC.tabBarItem.title = "Home"
//        homeVC.navigationItem.title = "Home"
//        let homeNavVC = UINavigationController(rootViewController: homeVC)

        let favoriteVC : FavoritesViewController = FavoritesViewController.instantiate()
        favoriteVC.tabBarItem.image = UIImage(named: "heart")
        favoriteVC.tabBarItem.title = "Favorite"
//        let favoriteNavVC = UINavigationController(rootViewController: favoriteVC)
        
        let profileVC : ProfileViewController = ProfileViewController.instantiate()
        profileVC.tabBarItem.image = UIImage(named: "profilepage")
        profileVC.tabBarItem.title = "Profile"
//        let profileNavVC = UINavigationController(rootViewController: profileVC)

        viewControllers = [homeVC, favoriteVC, profileVC]
    }

    
    func initTabbarApperance() {
        let customColor = UIColor(hex: "#24A8EF")
        let appearance = UITabBarAppearance()
        
        appearance.backgroundColor = customColor
        
        // Increase text size
        let largerFont = UIFont.boldSystemFont(ofSize: 12) // Text size for selected items
        let normalFont = UIFont.systemFont(ofSize: 10)     // Text size for unselected items
        
        // Set the color and font for selected items
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(hex: "#070808"),
            
            .font: largerFont
        ]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(hex: "#070808")
        
        // Set the color and font for unselected items
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(hex: "#070808"),
            .font: normalFont
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(hex: "#070808")
        
        // Apply the appearance to the tab bar
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
            tabBar.tintColor = UIColor(hex: "#070808")
        }

        // Resize the icons manually
        resizeTabBarIcons()
    }

    func resizeTabBarIcons() {
        if let tabItems = tabBar.items {
            for tabItem in tabItems {
                // Resize the selected icon
                if let image = tabItem.selectedImage?.withRenderingMode(.alwaysOriginal) {
                    tabItem.selectedImage = resizeImage(image: image, targetSize: CGSize(width: 20, height: 20))
                }
                // Resize the unselected icon
                if let image = tabItem.image?.withRenderingMode(.alwaysOriginal) {
                    tabItem.image = resizeImage(image: image, targetSize: CGSize(width: 18, height: 18))
                }
            }
        }
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? image
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Iterate through each tab item to find the selected one
        for tabBarItem in tabBar.items ?? [] {
            let isSelected = (tabBarItem == item)
//            tabBar.tintColor = UIColor(hex: "#7052F2")
            //tabBarItem.standardAppearance?.stackedLayoutAppearance.selected.iconColor = UIColor(hex: "#7052F2")
            //appearance.stackedLayoutAppearance.selected.iconColor = UIColor(hex: "#7052F2")
            // Update the text size and color when the tab is selected
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: isSelected ? UIColor(hex: "#7052F2") : UIColor(hex: "#7E8A8C"),
                .font: isSelected ? UIFont.boldSystemFont(ofSize: 12) : UIFont.systemFont(ofSize: 10)
            ]
            
            // Apply attributes to the tab item
            tabBarItem.setTitleTextAttributes(attributes, for: .normal)
            tabBarItem.setTitleTextAttributes(attributes, for: .selected)
        }
    }

}
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex
        hexSanitized = hexSanitized.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
extension UIViewController {
    class func instantiate<T: UIViewController>() -> T {
        let storyBoardId = String(describing: T.self)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: storyBoardId) as! T
    }
    
    class func instantiateTabbar<T: UITabBarController>() -> T {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "HomePageTabBarController") as! T
    }
    
}
