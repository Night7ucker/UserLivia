//
//  PaymentVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

protocol SuccessPopupVCDelegate {
    func pushToMainMenu()
}

class PaymentVC: RootViewController, SuccessPopupVCDelegate {

    
    @IBOutlet weak var topBarViewOutlet: UILabel!
    
    @IBOutlet weak var payButtonOutlet: UIButton!
    
    @IBOutlet weak var paymentsTableViewOutlet: UITableView!
    
    var selectedPayType = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Payment")
        
        paymentsTableViewOutlet.delegate = self
        paymentsTableViewOutlet.dataSource = self
        
        view.backgroundColor = Colors.Root.lightGrayColor
        topBarViewOutlet.backgroundColor = Colors.Root.greenColorForNavigationBar
        
        payButtonOutlet.layer.cornerRadius = 2
        payButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        
        view.backgroundColor = Colors.Root.lightGrayColor
        paymentsTableViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        let paymentStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let mpesaPopViewController = paymentStoryboard.instantiateViewController(withIdentifier: "kMpesaPopupVC") as! MpesaPopupVC
        present(mpesaPopViewController, animated: false, completion: nil)
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        // success ok popup
        let loadingAnimationStoryboard = UIStoryboard(name: "LoadingAnimation", bundle: nil)
        let loadingAnimationViewController = loadingAnimationStoryboard.instantiateViewController(withIdentifier: "kLoadingAnimationViewController") as! LoadingAnimationViewController
        present(loadingAnimationViewController, animated: false)
        PaymentRequest.payForOrder(orderID: RealmDataManager.getOrderDescriptionModel()[0].orderId!) { success in
            loadingAnimationViewController.dismiss(animated: false) {
                let paymentStoryboard = UIStoryboard(name: "Payment", bundle: nil)
                let successPopupViewController = paymentStoryboard.instantiateViewController(withIdentifier: "kSuccessPopupVC") as! SuccessPopupVC
                successPopupViewController.delegate = self
                self.present(successPopupViewController, animated: false, completion: nil)
            }
        }
    }
    
    func pushToMainMenu() {
        let mainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let mainScreenViewController = mainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
        navigationController?.pushViewController(mainScreenViewController, animated: false)
    }
    

}

extension PaymentVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let paymentCell = tableView.dequeueReusableCell(withIdentifier: "paymentCell") as! PaymentCell
            paymentCell.selectionStyle = .none
            
            return paymentCell
        case 1:
            let cashPaymentCell = tableView.dequeueReusableCell(withIdentifier: "cashPaymentCell") as! CashPaymentCell
            cashPaymentCell.selectionStyle = .none
            
            cashPaymentCell.payByCashLabelOutlet.textColor = Colors.Root.lightBlueColor
            
            return cashPaymentCell
        default:
            return UITableViewCell()
        }
    }
    
}

extension PaymentVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectedCell = tableView.cellForRow(at: indexPath) as! PaymentCell
            
            selectedCell.layer.borderWidth = 2.0
            selectedCell.layer.borderColor = UIColor.blue.cgColor
            selectedPayType = 0
        case 1:
            let selectedCell = tableView.cellForRow(at: indexPath) as! CashPaymentCell
            
            selectedCell.layer.borderWidth = 2.0
            selectedCell.layer.borderColor = UIColor.blue.cgColor
            selectedPayType = 1
        default:
            break
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectedCell = tableView.cellForRow(at: indexPath) as! PaymentCell
            
            selectedCell.layer.borderWidth = 0
        case 1:
            let selectedCell = tableView.cellForRow(at: indexPath) as! CashPaymentCell
            
            selectedCell.layer.borderWidth = 0
        default:
            break
            
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        return emptyView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
