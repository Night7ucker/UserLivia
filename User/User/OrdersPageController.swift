//
//  OrdersPageController.swift
//  User
//
//  Created by Egor Yanukovich on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrdersPageController: UIViewController {

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
        let numberOfSections = 2
        return numberOfSections
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Here will be number of orders in one month
        let numberOfRowsInSection = 1
        return numberOfRowsInSection
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
        cell.orderDateAndIdLabel.text = "11.09.2017/100"
        cell.orderStatusImage.image = #imageLiteral(resourceName: "orderStatusImage")
        return cell
    }
}

extension OrdersPageController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleForHeaderInSection = "\(section)"
        
        return titleForHeaderInSection
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}
