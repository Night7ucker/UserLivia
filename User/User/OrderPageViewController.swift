//
//  OrderPageViewController.swift
//  User
//
//  Created by BAMFAdmin on 04.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderPageViewController: RootViewController {

    
    @IBOutlet var headerView: UIView!
    @IBOutlet var descriptionTextViewOutlet: UITextView!
    
    var tappedCellIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBackButtonAndTitleToNavigationBar(title: "ORDER ID - 2570D")
        navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        navigationController?.navigationBar.layer.shadowOpacity = 0
        

        let orderStatus = RealmDataManager.getOrdersListFromRealm()[tappedCellIndex].statusId!
        switch orderStatus {
        case "1":
            navigationController?.navigationBar.barTintColor = Colors.Root.inProgressStatusColor
            headerView.backgroundColor = Colors.Root.inProgressStatusColor
        case "2":
            navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
            headerView.backgroundColor = Colors.Root.greenColorForNavigationBar
        default:
            return
        }

        headerView.translatesAutoresizingMaskIntoConstraints = true
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
