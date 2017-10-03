//
//  OrdersPageController.swift
//  User
//
//  Created by Egor Yanukovich on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrdersPageController: RootViewController {

    @IBOutlet weak var ordersPageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersPageTableView.delegate = self
        ordersPageTableView.dataSource = self
    }

}

extension OrdersPageController : UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        //Here will be number of months, which has orders
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Here will be number of orders in one month
        return RealmDataManager.getOrdersListFromRealm().count
        //will work only with data!!!!
        //        let numberOfRowsInSection: Int = 0
        //                if myArray.count > 0
        //                {
        //                    tableView.separatorStyle = .singleLine
        //                    numberOfRowsInSection            = myArray.count
        //                    tableView.backgroundView = nil
        //                }
        //                else
        //                {
        //        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        //        noDataLabel.text          = "No apoointments available"
        //        noDataLabel.textColor     = UIColor.black
        //        noDataLabel.textAlignment = .center
        //        tableView.backgroundView  = noDataLabel
        //        tableView.separatorStyle  = .none
        //                }
        //        return numberOfRowsInSection
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
        if RealmDataManager.getOrdersListFromRealm()[indexPath.row].statusId! == "1" {
            cell.statusLabelOutlet.text = "In Process"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "time"))
        } else {
            cell.statusLabelOutlet.text = "No Offers"
            cell.fillCellInfo(orderStatusImage: #imageLiteral(resourceName: "cancel"))
        }
        
        
        return cell
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
