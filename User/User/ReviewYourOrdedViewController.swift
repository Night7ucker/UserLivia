//
//  ReviewYourOrdedViewController.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//


// TODO:
// self-collect - 0, 1
// manual - checkbox 0, 1
// esli manual - 1 nado brat' pharm id
// pharm id polu4aetsya s page controla so vtoroi vkladki
// s tablici page controla

// zapros na apteki - prosto po coordinatam
// kogda na page control idu na vtoruu vkladku idet zapros c current coordinatami i na etoi vkladke poyavlyaetsya spisok aptek
// order kak nibud' otdelyanay model


import UIKit
import GoogleMaps
import GooglePlaces

class ReviewYourOrdedViewController: RootViewController {

    @IBOutlet weak var requestPriceButtonOutlet: UIButton!
    @IBOutlet weak var reviewYourOrderTableViewOutlet: UITableView!
    
    let sectionNames = ["Drugs:", "Location:", "Order Type:"]
    var arrayOfOrderedDrugs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewYourOrderTableViewOutlet.delegate = self
        reviewYourOrderTableViewOutlet.dataSource = self
        
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Review your order")

        requestPriceButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        reviewYourOrderTableViewOutlet.separatorStyle = .none
        reviewYourOrderTableViewOutlet.isScrollEnabled = false
        
        let orderedDrugs = RealmDataManager.getAddedDrugsDataFromRealm()
        for i in 0..<orderedDrugs.count {
            arrayOfOrderedDrugs.append("- " + orderedDrugs[i].brandName! + "(" + String(orderedDrugs[i].amount) + ")")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ReviewYourOrdedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return arrayOfOrderedDrugs.count
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    
    
    // Set the spacing between sections
    
    
    // Make the background color show through
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! OrderReviewTableViewCell
            
            descriptionCell.drugNameLabel.text = arrayOfOrderedDrugs[indexPath.row]
            
            return descriptionCell
        case 1:
            let mapCell = tableView.dequeueReusableCell(withIdentifier: "orderMapCell") as! OrderMapTableViewCell
            
            return mapCell
        case 2:
            let deliveryCell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! OrderReviewTableViewCell
            
            let deliveryType = Int(RealmDataManager.getSendingOrderFromRealm()[0].selfCollect!)!
            switch deliveryType {
            case 0:
                deliveryCell.drugNameLabel.text = "- Self-collect"
            case 1:
                deliveryCell.drugNameLabel.text = "- Delivery"
            default:
                break
            }
            
            return deliveryCell
        default:
            return UITableViewCell()
        }
    }
}

extension ReviewYourOrdedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewForHeaderInSection = UIView()
        
        let sectionNameLabel = UILabel()
        sectionNameLabel.text = sectionNames[section]
        sectionNameLabel.textColor = .black
        sectionNameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        sectionNameLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 20)
        
        viewForHeaderInSection.addSubview(sectionNameLabel)
        
        return viewForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        case 1:
            return 180
        case 2:
            return 0
        default:
            return 0
        }
    }
}
