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

        let orderStatus = RealmDataManager.getOrdersListFromRealm()[tappedCellIndex].statusId!
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDescCellImage") as! OrderDescriptionTableViewCell
        cell.drugsReceptImage.image = UIImage(named: "obama.png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.didExpandCell()
        
    }
  
}

extension OrderDescriptionViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded && self.selectedIndex == indexPath {
            if indexPath.row == 0 {
                return 250
            }
        }
        if indexPath.row == 1 {
            return 60
        }
        return 60
    }
    
}

