//
//  OrdersAppointmentsController.swift
//  User
//
//  Created by Egor Yanukovich on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import PageMenu

protocol SavePopoverDataDelegate {
    func saveCheckBoxes(checkes : [Int])
}


class OrdersPaymentsController: RootViewController, CAPSPageMenuDelegate{
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []
    
    var checkesArray = [Int]()
    
    private func newColoredViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Orders Appointments Payments", bundle: nil) .
            instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        navigationController?.navigationBar.barTintColor = newColor
        navigationController?.navigationBar.backgroundColor = .black
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "⇅", style: .plain, target: self, action: #selector(showInfoPopover))
        navigationItem.rightBarButtonItem?.tintColor = .white
        addBackButtonAndTitleToNavigationBar(title: "Status")
        
        let controllerOne = self.newColoredViewController(name: "ordersPageVC")
        controllerOne.title = "ORDERS"
        
        controllerArray.append(controllerOne)
        
        let controllerTwo = self.newColoredViewController(name: "paymentsPageVC")
        controllerTwo.title = "PAYMENTS"
        controllerArray.append(controllerTwo)
        
        let font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)
        
        //Custom CAPSPageMenu
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
        
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0,y: 64.0, width:self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)

    }
    
     func showInfoPopover() {
        print("showInfoPopover")
        let settingsStoryboard = UIStoryboard(name: "Orders Appointments Payments", bundle: nil)
        let orderStatusesPopupVC = settingsStoryboard.instantiateViewController(withIdentifier: "kOrdersStatusesPopoup") as? OrdersStatusesPopupController
        
        orderStatusesPopupVC?.delegate = self
        orderStatusesPopupVC?.resultChecked = checkesArray
        
        present(orderStatusesPopupVC!, animated: true, completion: nil)
    }
    
    
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        if index == controllerArray.count - 1 {
            let button = UIBarButtonItem()
            button.title = ""
            button.isEnabled = false
            
            navigationItem.rightBarButtonItem = button
        }
        else{
            let button = UIBarButtonItem()
            button.title = "⇅"
            button.tintColor = .white
            button.isEnabled = true
            
            navigationItem.rightBarButtonItem = button
        }
    }
    
    
}

extension OrdersPaymentsController : SavePopoverDataDelegate{
    
    func saveCheckBoxes(checkes : [Int]) {
        for checkBox in checkes{
            if checkBox != 20{
                checkesArray.append(checkBox)
            }
        }
        print(checkesArray)
    }
}

extension OrdersPaymentsController : UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
