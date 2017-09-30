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
        
        navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        addBackButtonAndTitleToNavigationBar(title: "Status")
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.clipsToBounds = true
               
        let controllerOne = self.newColoredViewController(name: "ordersPageVC")
        controllerOne.title = "ORDERS"
//        let titleView = UIView()
//        
//        let titleLabel = UILabel()
//        titleLabel.text = "ORDERS"
//        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 14)
//        titleLabel.textColor = .white
//        titleLabel.frame = CGRect(x: 15, y: 15, width: 60, height: 20)
//        
//        titleView.addSubview(titleLabel)
//        
//        controllerOne.navigationItem.titleView = titleView
        
        controllerArray.append(controllerOne)
        
        let controllerTwo = self.newColoredViewController(name: "paymentsPageVC")
        controllerTwo.title = "PAYMENTS"
        controllerArray.append(controllerTwo)
        
        
        
        //Custom CAPSPageMenu
        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(39),
            .scrollMenuBackgroundColor((Colors.Root.greenColorForNavigationBar)),
            .menuItemSeparatorWidth(10.0),
            .enableHorizontalBounce(false),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorWidth(0.0)
        ]
        
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0,y: 64.0, width:self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)

    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func showInfoPopover(_ sender: UIBarButtonItem) {
        let settingsStoryboard = UIStoryboard(name: "Orders Appointments Payments", bundle: nil)
        let orderStatusesPopupVC = settingsStoryboard.instantiateViewController(withIdentifier: "kOrdersStatusesPopoup") as? OrdersStatusesPopupController
        
        orderStatusesPopupVC?.delegate = self
        orderStatusesPopupVC?.resultChecked = checkesArray
        
        present(orderStatusesPopupVC!, animated: true, completion: nil)

    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        print("DidScrollToPageAtIndex: \(index)")
        print(navigationItem.rightBarButtonItem?.title ?? "PAPA")
        if index == controllerArray.count - 1 {
            navigationItem.rightBarButtonItem?.title = ""
            navigationItem.rightBarButtonItem?.isEnabled = false
            
        }
        else{
            navigationItem.rightBarButtonItem?.title = "⇅"
            navigationItem.rightBarButtonItem?.tintColor = .white
            navigationItem.rightBarButtonItem?.isEnabled = true
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
