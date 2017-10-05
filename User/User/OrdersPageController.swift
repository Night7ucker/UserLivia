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
        case "6":
            cell.statusLabelOutlet.text = "Order cancelled"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "cancelOrder"))
        case "7":
            cell.statusLabelOutlet.text = "Order received"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "doneStatus"))
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
        if RealmDataManager.getOrderDescriptionModel().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getOrderDescriptionModel())
            }
        }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        let sectionNameLabel = UILabel()
        sectionNameLabel.text = "OCT"
        sectionNameLabel.frame = CGRect(x: 15, y: 12, width: 375, height: 30)
        sectionNameLabel.textColor = UIColor.lightGray
        sectionNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)

        
        headerView.addSubview(sectionNameLabel)
        
        return headerView
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }

}
