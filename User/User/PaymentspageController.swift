//
//  PaymentspageController.swift
//  User
//
//  Created by Egor Yanukovich on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PaymentsPageController: UIViewController {
    
    @IBOutlet weak var paymentsPageTableView: UITableView!
    
    var pageOp = OrdersPaymentsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentsPageTableView.delegate = self
        paymentsPageTableView.dataSource = self
        
    }
    
}

extension PaymentsPageController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //Here will be number of months, which has orders
        let numberOfSections = 1
        return numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let cell : PaymentPageCell = tableView.dequeueReusableCell(withIdentifier: "PaymentsPageCell", for: indexPath) as! PaymentPageCell
        cell.cardNumberLabel.text = "1234 **** **** 9876"
        cell.dateAndIdlabel.text = "12.09.2017/001"
        cell.typeOfCardImage.image = #imageLiteral(resourceName: "typeOfCardImage")
        cell.priceOfOrderLabel.text = "1000 BYN"
        return cell
    }
    
}

extension PaymentsPageController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // add name of month from array of monthes
        let titleForHeaderInSection = "\(section)"
        
        return titleForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}
