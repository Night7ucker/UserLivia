//
//  OrderPageViewController.swift
//  User
//
//  Created by BAMFAdmin on 04.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

protocol CancelPopupVCDelegate {
    func showLowerCostPopup(cancelReason: String)
}

protocol AlternativePopupVCDelegate {
    func pushToMainScreenViewController()
}

class OrderDescriptionViewController: RootViewController, CancelPopupVCDelegate, AlternativePopupVCDelegate {

    @IBOutlet var headerView: UIView!
    @IBOutlet var tableView: UITableView!
    var selectedIndex: IndexPath?
    var isExpanded = false
    var cellCount = 0
    var checkIsExpanded = 1
    var tappedCellIndex = -1
    var timeTimer: Timer?
    var uiview :UIView?
    var cancelReasonVar = ""
    var colorForNavigationBar: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        let fullDate = RealmDataManager.getOrderDescriptionModel()[0].createDate!
        var splittedDate = fullDate.components(separatedBy: "T")
        var finalDate = splittedDate[0].components(separatedBy: "-")

        addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "OrderID - "+RealmDataManager.getOrdersListFromRealm()[tappedCellIndex].orderId!, bottomLabelTitle: finalDate[0]+"."+finalDate[1]+"."+finalDate[2])
        navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        navigationController?.navigationBar.layer.shadowOpacity = 0
        let nib = UINib.init(nibName: "CustomOrderCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "orderDescCellImage")
        tableView.tableFooterView = UIView(frame: .zero)
        if RealmDataManager.getOrderDescriptionModelImage().count > 0 {
            cellCount = 2 + RealmDataManager.getOrderDrugsDescriptionModel().count
        } else {
            cellCount = RealmDataManager.getOrderDrugsDescriptionModel().count + 1
        }
        
        setBarTintColor(status: RealmDataManager.getOrderDescriptionModel()[0].statusId!)

        colorForNavigationBar = navigationController?.navigationBar.barTintColor
        let view = instanceFromNib()
        view.frame.size.height = 140
        self.headerView.addSubview(view)
    }

    
    func instanceFromNib() -> UIView {
        return UINib(nibName: RealmDataManager.getOrderDescriptionModel()[0].statusId!, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.navigationBar.barTintColor = colorForNavigationBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func didExpandCell() {
        self.isExpanded = !isExpanded
        self.tableView.reloadRows(at: [selectedIndex!], with: .automatic)
    }
    
    @objc func sectionTapped(_ sender: UITapGestureRecognizer) {
        print("section tapped")
        let pharmacyDetailsStoryboard = UIStoryboard(name: "PharmacyDetails", bundle: nil)
        let pharmacyDetailsViewController = pharmacyDetailsStoryboard.instantiateViewController(withIdentifier: "kPharmacyDetailsVC") as! PharmacyDetailsVC
        navigationController?.pushViewController(pharmacyDetailsViewController, animated: false)
    }
    
    func setBarTintColor(status: String) {
        switch status {
        case "1":
            navigationController?.navigationBar.barTintColor = Colors.Root.inProgressStatusColor
        case "2":
            navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        case "3":
            navigationController?.navigationBar.barTintColor = Colors.Root.lightBlueColor
        case "4":
            navigationController?.navigationBar.barTintColor = Colors.Root.orangeColor
        case "6":
            navigationController?.navigationBar.barTintColor = Colors.Root.canceledStatusColor
        case "7":
            navigationController?.navigationBar.barTintColor = Colors.Root.receivedStatus
        case "15":
            navigationController?.navigationBar.barTintColor = Colors.Root.inProgressStatusColor
        case "16":
            navigationController?.navigationBar.barTintColor = Colors.Root.lightBlueColor
        default:
            return
        }

    }
    
    func showLowerCostPopup(cancelReason: String) {
        if RealmDataManager.getOrderDescriptionModel()[0].statusId == "16" {
            pushToMainScreenViewController()
        } else {
            let cancelOrderStoryboard = UIStoryboard(name: "CancelOrder", bundle: nil)
            let alternativePopupViewController = cancelOrderStoryboard.instantiateViewController(withIdentifier: "kAlternativePopupVC") as! AlternativePopupVC
            alternativePopupViewController.cancelReason = cancelReason
            alternativePopupViewController.delegate = self
            present(alternativePopupViewController, animated: false, completion: nil)
        }
    }
    
    func pushToMainScreenViewController() {
        let mainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let mainScreenViewController = mainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
        navigationController?.pushViewController(mainScreenViewController, animated: false)
    }
    
    @IBAction func paymentButtontapped(_ sender: UIButton) {
        let paymentStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let paymentViewController = paymentStoryboard.instantiateViewController(withIdentifier: "kPaymentVC") as! PaymentVC
        navigationController?.pushViewController(paymentViewController, animated: false)
    }
    
    @IBAction func cancelOrderButtonTapped(_ sender: UIButton) {
            let cancelOrderStoryboard = UIStoryboard(name: "CancelOrder", bundle: nil)
            let cancelOrderViewController = cancelOrderStoryboard.instantiateViewController(withIdentifier: "kCancelPopupVC") as! CancelPopupVC
            cancelOrderViewController.delegate = self
            present(cancelOrderViewController, animated: false, completion: nil)
    }
}

extension OrderDescriptionViewController : UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if RealmDataManager.getOrderDescriptionModelImage().count > 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDescCellImage") as! OrderDescriptionTableViewCell
                getImage(pictureUrl: "https://test.liviaapp.com"+RealmDataManager.getOrderDescriptionModelImage()[0].imageUrl!) { success, image in
                    if success {
                        cell.drugsReceptImage.image = image
                        cell.drugsPreviewImage.image = image
                    }
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsCell") as! OrderDescriptionTableViewCell
                if RealmDataManager.getOrderDescriptionModel()[0].selfCollect! == "1" {
                    cell.selfCollectValue.text = "Self-collect"
                } else {
                    cell.selfCollectValue.text = "Delivery"
                }
                cell.isUserInteractionEnabled = false
                return cell
                
            case 2..<RealmDataManager.getOrderDrugsDescriptionModel().count + 2:

                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDrugsDetailsCell") as! OrderDescriptionTableViewCell
                cell.isUserInteractionEnabled = false
                if RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 2].activeItem! == "0" {
                    cell.backgroundColor = Colors.Root.backgroundColor
                    cell.alternativeLabel.isHidden = false
                    cell.alternativeLabel.text = "alternative: "+RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 1].drugName!
                } else {
                    cell.backgroundColor = UIColor.white
                    cell.alternativeLabel.isHidden = true
                }
                cell.drugAmount.text = RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 2].quantity!
                cell.drugName.text = RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 2].drugName!
                if RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 2].drugPrice != 0 {
                    cell.drugPriceLabel.text = String(describing: RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 2].drugPrice)
                } else {
                    cell.drugPriceLabel.isHidden = true
                    cell.drugCurrencyLabel.isHidden = true
                }
                if RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 2].quantityMeasuring != nil {
                    cell.drugQuantityMeasure.text = RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row - 2].quantityMeasuring!.uppercased()
                } else {
                    cell.drugQuantityMeasure.text = " "
                }
                return cell


            default:
                return UITableViewCell()
            }

        } else {
            switch indexPath.row {
            case 0..<RealmDataManager.getOrderDrugsDescriptionModel().count:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDrugsDetailsCell") as! OrderDescriptionTableViewCell
                cell.isUserInteractionEnabled = false
                if RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row].activeItem! == "0" {
                    cell.backgroundColor = Colors.Root.backgroundColor
                    cell.alternativeLabel.isHidden = false
                    cell.alternativeLabel.text = "alternative: "+RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row + 1].drugName!
                } else {
                    cell.backgroundColor = UIColor.white
                    cell.alternativeLabel.isHidden = true
                    
                }
                cell.drugAmount.text = RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row].quantity!
                cell.drugName.text = RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row].drugName!
                if RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row].drugPrice != 0 {
                    cell.drugPriceLabel.text = String(RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row].drugPrice)
                } else {
                    cell.drugPriceLabel.isHidden = true
                    cell.drugCurrencyLabel.isHidden = true
                }
                if RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row].quantityMeasuring != nil {
                    cell.drugQuantityMeasure.text = RealmDataManager.getOrderDrugsDescriptionModel()[indexPath.row].quantityMeasuring!.uppercased()
                } else {
                    cell.drugQuantityMeasure.text = " "
                }
                return cell

            case RealmDataManager.getOrderDrugsDescriptionModel().count:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsCell") as! OrderDescriptionTableViewCell
                cell.isUserInteractionEnabled = false
                if RealmDataManager.getOrderDescriptionModel()[0].selfCollect! == "1" {
                    cell.selfCollectValue.text = "Self-collect"
                } else {
                    cell.selfCollectValue.text = "Delivery"
                }
                return cell
            default:
                return UITableViewCell()
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.didExpandCell()
        let selectedCell = tableView.cellForRow(at: indexPath) as! OrderDescriptionTableViewCell
        checkIsExpanded += 1
        if checkIsExpanded % 2 == 0{
            selectedCell.drugsPreviewImage.isHidden = true
        } else {
            selectedCell.drugsPreviewImage.isHidden = false
        }
   
    }
  
}

extension OrderDescriptionViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded && self.selectedIndex == indexPath {
            if indexPath.row == 0 {
                return 300
            }
        }

        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if RealmDataManager.getOrderDrugsDescriptionModel().count != 0 {
            let orderDrugsDescriptionObject = RealmDataManager.getOrderDrugsDescriptionModel()[0]
            if orderDrugsDescriptionObject.pAdmin != nil {
                let pharmacyView = UIView()
                
                let imageView = UIImageView()
                imageView.frame = CGRect(x: 10, y: 15, width: 30, height: 30)
                imageView.image = #imageLiteral(resourceName: "pharmacySign")
                
                pharmacyView.addSubview(imageView)
                
                let pharmacyLabel = UILabel()
                pharmacyLabel.text = "Pharmacy"
                pharmacyLabel.font = UIFont.boldSystemFont(ofSize: 14)
                pharmacyLabel.frame = CGRect(x: 50, y: 10, width: 100, height: 15)
                
                pharmacyView.addSubview(pharmacyLabel)
                
                let pharmacyNameLabel = UILabel()
                pharmacyNameLabel.text = orderDrugsDescriptionObject.pName
                pharmacyNameLabel.frame = CGRect(x: 50, y: 30, width: 100, height: 15)
                pharmacyNameLabel.font = pharmacyNameLabel.font.withSize(15)
                
                pharmacyView.addSubview(pharmacyNameLabel)
                
                let arrowImageLabel = UILabel()
                arrowImageLabel.text = ">"
                arrowImageLabel.textColor = .gray
                arrowImageLabel.font = arrowImageLabel.font.withSize(20)
                arrowImageLabel.frame = CGRect(x: 350, y: 10, width: 40, height: 40)
                
                pharmacyView.addSubview(arrowImageLabel)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionTapped(_:)))
                pharmacyView.addGestureRecognizer(tapGesture)
                
                return pharmacyView
            }
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if RealmDataManager.getOrderDrugsDescriptionModel().count != 0 {
            if RealmDataManager.getOrderDrugsDescriptionModel()[0].pAdmin != nil {
                return 60
            }
        }
        
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        return emptyView
    }
}

