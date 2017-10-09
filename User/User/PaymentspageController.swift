//
//  PaymentspageController.swift
//  User
//
//  Created by Egor Yanukovich on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PaymentsPageController: RootViewController {
    
    
    

    
    @IBOutlet weak var paymentsPageTableView: UITableView!
    
    var pageOp = OrdersPaymentsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentsPageTableView.delegate = self
        paymentsPageTableView.dataSource = self
        paymentsPageTableView.tableFooterView = UIView(frame: .zero)
        
    }
    
}

extension PaymentsPageController : UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return RealmDataManager.getPaymentList().count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentsPageCell", for: indexPath) as! PaymentPageCell
        
        let fullDate = RealmDataManager.getPaymentList()[0].createDate!
        var splittedDate = fullDate.components(separatedBy: "T")
        var finalDate = splittedDate[0].components(separatedBy: "-")
        cell.paymentData.text = finalDate[0]+"."+finalDate[1]+"."+finalDate[2]
        cell.paymentOrderId.text = RealmDataManager.getPaymentList()[0].orderId!
        cell.paymentText.text = RealmDataManager.getPaymentList()[0].statusName!
        cell.paymentPrice.text = RealmDataManager.getPaymentList()[0].fullAmount!
        cell.paymentImage.image = UIImage(named: "bill.png")
        return cell
    }
    
}

extension PaymentsPageController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}
