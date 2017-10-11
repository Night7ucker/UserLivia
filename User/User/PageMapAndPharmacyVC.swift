//
//  PageMapAndPharmacyVC.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import PageMenu

protocol GoogleMapViewControllerDelegate {
    func pushToReviewOrderVC(pharmacyID: String)
}

class PageMapAndPharmacyVC: RootViewController, CAPSPageMenuDelegate, GoogleMapViewControllerDelegate {
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
        navigationController?.navigationBar.layer.masksToBounds = true
        addBackButtonAndTitleToNavigationBar(title: "Choose pharmacy")
        
        let controllerOne = newViewControllerToInstantiate(name: "kGoogleMapViewController") as! GoogleMapViewController
        controllerOne.isPaged = true
        controllerOne.delegate = self
        controllerOne.title = "GOOGLE MAP VIEW"
        
        controllerArray.append(controllerOne)
        
        let controllerTwo = newViewControllerToInstantiate(name: "kPharmacyViewController") as! PharmacyViewController
        controllerTwo.title = "LIST VIEW"
        controllerTwo.delegate = self
        controllerArray.append(controllerTwo)
        
        let font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.regular)
        
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
    
    func pushToReviewOrderVC(pharmacyID: String) {
        let reviewOrderStoryboard = UIStoryboard(name: "ReviewYourOrder", bundle: nil)
        let reviewYourOrderViewController = reviewOrderStoryboard.instantiateViewController(withIdentifier: "kReviewYourOrdedViewController") as! ReviewYourOrdedViewController
        reviewYourOrderViewController.pharmacyID = pharmacyID
        navigationController?.pushViewController(reviewYourOrderViewController, animated: false)
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

