//
//  OrderPageViewController.swift
//  User
//
//  Created by BAMFAdmin on 04.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderDescriptionViewController: RootViewController {

    
    @IBOutlet var clockView: UIView!
    @IBOutlet var labelStatusOutlet: UILabel!
    @IBOutlet var imageStatusOutlet: UIImageView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var descriptionTextViewOutlet: UITextView!
    @IBOutlet var tableView: UITableView!
    var selectedIndex: IndexPath?
    var isExpanded = false
    var cellCount = 0
    var checkIsExpanded = 1
    @IBOutlet var rotateView: UIView!
    var tappedCellIndex = -1
    var timeTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        clockView.layer.cornerRadius = 15
        clockView.layer.borderColor = UIColor.white.cgColor
        clockView.layer.borderWidth = 2
        addBackButtonAndTitleToNavigationBar(title: "ORDER ID - "+RealmDataManager.getOrdersListFromRealm()[tappedCellIndex].orderId!)
        navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        navigationController?.navigationBar.layer.shadowOpacity = 0
        let nib = UINib.init(nibName: "CustomOrderCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "orderDescCellImage")
        tableView.tableFooterView = UIView(frame: .zero)
        let orderStatus = RealmDataManager.getOrdersListFromRealm()[tappedCellIndex].statusId!
        if RealmDataManager.getOrderDescriptionModelImage().count > 0 {
            cellCount = 2
        } else {
            cellCount = RealmDataManager.getOrderDescriptionModel().count + 1
        }
        switch orderStatus {
        case "1":
            imageStatusOutlet.isHidden = true
            clockView.isHidden = false
            labelStatusOutlet.text = "In Process"
            descriptionTextViewOutlet.font = descriptionTextViewOutlet.font?.withSize(12)
            descriptionTextViewOutlet.text = "We are working to get you the BEST PRICE OFFER for your  order. This may take a few minutes. We thank you for you patience"
            navigationController?.navigationBar.barTintColor = Colors.Root.inProgressStatusColor
            headerView.backgroundColor = Colors.Root.inProgressStatusColor
        case "2":
            imageStatusOutlet.isHidden = false
            clockView.isHidden = true
            labelStatusOutlet.text = "No Offers"
            descriptionTextViewOutlet.font = descriptionTextViewOutlet.font?.withSize(15)
            descriptionTextViewOutlet.text = "We can not find the drug"
            imageStatusOutlet.image = UIImage(named: "cancel.png")
            navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
            headerView.backgroundColor = Colors.Root.greenColorForNavigationBar
        default:
            return
        }
        rotate()
    }
    

    func rotate()
    {
        var rotationAnimation = CABasicAnimation()
        rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: (Double.pi))
        rotationAnimation.duration = 0.7
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 1000.0
        clockView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func didExpandCell() {
        self.isExpanded = !isExpanded
        self.tableView.reloadRows(at: [selectedIndex!], with: .automatic)
    }
}

extension OrderDescriptionViewController : UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if RealmDataManager.getOrderDescriptionModelImage().count > 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsCell") as! OrderDescriptionTableViewCell
                if RealmDataManager.getOrderDescriptionModelImage()[0].selfCollect! == "1" {
                    cell.selfCollectValue.text = "Self-collect"
                } else {
                    cell.selfCollectValue.text = "Delivery"
                }
                cell.isUserInteractionEnabled = false
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDescCellImage") as! OrderDescriptionTableViewCell
                getImage(pictureUrl: "https://test.liviaapp.com"+RealmDataManager.getOrderDescriptionModelImage()[0].imageUrl!) { success, image in
                    if success {
                        cell.drugsReceptImage.image = image
                        cell.drugsPreviewImage.image = image
                    }
                }

                return cell

            default:
                return UITableViewCell()
            }
        } else {
            switch indexPath.row {
            case 0..<RealmDataManager.getOrderDescriptionModel().count:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderDrugsDetailsCell") as! OrderDescriptionTableViewCell
                cell.isUserInteractionEnabled = false
                cell.drugAmount.text = RealmDataManager.getOrderDescriptionModel()[indexPath.row].quantity!
                cell.drugName.text = RealmDataManager.getOrderDescriptionModel()[indexPath.row].drugName!
                if RealmDataManager.getOrderDescriptionModel()[indexPath.row].quantityMeasuring != nil {
                    cell.drugQuantityMeasure.text = RealmDataManager.getOrderDescriptionModel()[indexPath.row].quantityMeasuring!.uppercased()
                } else {
                    cell.drugQuantityMeasure.text = " "
                }
                return cell

            case RealmDataManager.getOrderDescriptionModel().count:
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
            if indexPath.row == 1 {
                return 300
            }
        }
        if indexPath.row == 0 {
            return 50
        }
        return 50
    }
    
}

