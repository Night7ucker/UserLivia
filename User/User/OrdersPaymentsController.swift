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

protocol OrdersPageControllerDelegate {
    func pushToOrderPageController(index: Int)
}

class OrdersPaymentsController: RootViewController, CAPSPageMenuDelegate, OrdersPageControllerDelegate {
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []
    
    var checkesArray = [Int]()
    
    private func newColoredViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Orders Appointments Payments", bundle: nil) .
            instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newColor = Colors.Root.greenColorForNavigationBar
        navigationController?.navigationBar.barTintColor = newColor
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.layer.shadowOpacity = 0

        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0)
        navigationController?.navigationBar.layer.shadowRadius = 0
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "⇅", style: .plain, target: self, action: #selector(showInfoPopover))
        navigationItem.rightBarButtonItem?.tintColor = .white
        addBackButtonAndTitleToNavigationBar(title: "Status")
        
        let controllerOne = self.newColoredViewController(name: "ordersPageVC") as! OrdersPageController
        controllerOne.title = "ORDERS"
        controllerOne.delegate = self
        
        controllerArray.append(controllerOne)
        
        let controllerTwo = self.newColoredViewController(name: "paymentsPageVC")
        controllerTwo.title = "PAYMENTS"
        controllerArray.append(controllerTwo)
        
        let font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)
        
        //Custom CAPSPageMenu
        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(39),
            .scrollMenuBackgroundColor(newColor),
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
            navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar   
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
    
    func pushToOrderPageController(index: Int) {
        let orderPageStoryboard = UIStoryboard(name: "OrderPage", bundle: nil)
        let orderPageViewController = orderPageStoryboard.instantiateViewController(withIdentifier: "kOrderPage") as! OrderDescriptionViewController
        orderPageViewController.tappedCellIndex = index
        navigationController?.pushViewController(orderPageViewController, animated: false)
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
