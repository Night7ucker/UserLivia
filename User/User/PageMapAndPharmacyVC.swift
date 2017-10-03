//
//  PageMapAndPharmacyVC.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import PageMenu


class PageMapAndPharmacyVC: RootViewController, CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []
    
    var checkesArray = [Int]()
    
    private func newViewControllerToInstantiate(name: String) -> UIViewController {
        return UIStoryboard(name: "GoogleMap", bundle: nil) .
            instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
//        navigationController?.navigationBar.barTintColor = newColor
//        navigationController?.navigationBar.backgroundColor = .black
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Status")
        
        let controllerOne = newViewControllerToInstantiate(name: "kGoogleMapViewController")
        controllerOne.title = "Map"
        
        controllerArray.append(controllerOne)
        
        let controllerTwo = newViewControllerToInstantiate(name: "kPharmacyViewController")
        controllerTwo.title = "Choose pharmacy"
        controllerArray.append(controllerTwo)
        
        let font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(39),
            .scrollMenuBackgroundColor((navigationController?.navigationBar.barTintColor)!),
            .viewBackgroundColor(.white),
            .menuItemSeparatorWidth(10.0),
            .enableHorizontalBounce(false),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorWidth(0.0),
            .unselectedMenuItemLabelColor(.white),
            .selectedMenuItemLabelColor(.white),
            .menuItemFont(font)
        ]
        
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0, y: 64.0, width:self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
        
    }
    
    
    
//    func didMoveToPage(_ controller: UIViewController, index: Int) {
//        if index == controllerArray.count - 1 {
//            let button = UIBarButtonItem()
//            button.title = ""
//            button.isEnabled = false
//            
//            navigationItem.rightBarButtonItem = button
//        }
//        else{
//            let button = UIBarButtonItem()
//            button.title = "⇅"
//            button.tintColor = .white
//            button.isEnabled = true
//            
//            navigationItem.rightBarButtonItem = button
//        }
//    }
    
    
}

//extension PageMapAndPharmacyVC : SavePopoverDataDelegate{
//    
//    func saveCheckBoxes(checkes : [Int]) {
//        for checkBox in checkes{
//            if checkBox != 20 {
//                checkesArray.append(checkBox)
//            }
//        }
//        print(checkesArray)
//    }
//}

extension PageMapAndPharmacyVC : UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

