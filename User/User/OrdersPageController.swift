//
//  OrdersPageController.swift
//  User
//
//  Created by Egor Yanukovich on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class OrdersPageController: RootViewController {

    @IBOutlet weak var ordersPageTableView: UITableView!
    var delegate: OrdersPageControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersPageTableView.delegate = self
        ordersPageTableView.dataSource = self
        ordersPageTableView.allowsSelection = true
        let realm = try! Realm()
        if RealmDataManager.getPaymentList().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getPaymentList())
            }
        }
        PaymentListRequest.getPaymentList { (success) in
            if success {
                
            }
        }
    }

}

extension OrdersPageController : UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmDataManager.getOrdersListFromRealm().count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderPageCell = tableView.dequeueReusableCell(withIdentifier: "OrdersPageCell", for: indexPath) as! OrderPageCell

        let dateArray = RealmDataManager.getOrdersListFromRealm()[indexPath.row].createDate!.components(separatedBy: "T")
        cell.dateLabelOutlet.text = dateArray[0]
        cell.orderIDLabelOutlet.text = RealmDataManager.getOrdersListFromRealm()[indexPath.row].orderId!
        if RealmDataManager.getOrdersListFromRealm()[indexPath.row].selfCollect! == "1" {
            cell.selfCollectLabelOutlet.text = "C"
        } else {
            cell.selfCollectLabelOutlet.text = "D"
        }
        
        switch RealmDataManager.getOrdersListFromRealm()[indexPath.row].statusId! {
        case "1":
            cell.statusLabelOutlet.text = "In Process"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "time"))
        case "2":
            cell.statusLabelOutlet.text = "No Offers"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "cancel"))
        case "3":
            cell.statusLabelOutlet.text = "Best Offer"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "bestOffer"))
        case "4":
            cell.statusLabelOutlet.text = "Order being prepared"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "orderStatusImage"))
        case "5":
            cell.statusLabelOutlet.text = "On delivery"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "orderStatusImage"))
        case "6":
            cell.statusLabelOutlet.text = "Order cancelled"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "cancelOrder"))
        case "7":
            cell.statusLabelOutlet.text = "Order received"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "doneStatus"))
        case "14":
            cell.statusLabelOutlet.text = "Doctor's Prescription"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "bestOffer"))
        case "15":
            cell.statusLabelOutlet.text = "Waiting for alternative drugs"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "time"))
        case "16":
            cell.statusLabelOutlet.text = "Best offer with alternative drugs"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "bestOffer"))

        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        
        if RealmDataManager.getOrderDescriptionModelImage().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getOrderDescriptionModelImage())
            }
        }
        
        GetOrderDescriptionRequest.getOrderDescription(orderId: RealmDataManager.getOrdersListFromRealm()[indexPath.row].orderId!) { (success) in
            if success {
               self.delegate.pushToOrderPageController(index: indexPath.row)
            }
        }
        
    }
    

    
}

extension OrdersPageController : UITableViewDelegate{
    

    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }

}
