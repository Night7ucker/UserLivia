//
//  MakeOrderViewController.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MakeOrderViewController: UIViewController {
    
    
    @IBOutlet weak var makeOrderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeOrderTableView.layer.cornerRadius = 10
        makeOrderTableView.dataSource = self
        makeOrderTableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MakeOrderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "makeOrderCell", for: indexPath) as! MakeOrderCellTableViewCell
            
            cell.makeOrderTopMenuLabelOutlet.text = "Take a Photo of Prescription"
            cell.makeOrderBottomMenuLabelOutlet.text = "GENERATE ORDER FROM YOUR PHOTO"
            cell.makeOrderIconImageOutlet.image = UIImage(named: "makeOrderPhoto")
            cell.imageInsideImageMakeOrderOutlet.image = UIImage(named: "cameraFromMakeOrder")
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "makeOrderCell", for: indexPath) as! MakeOrderCellTableViewCell
            // number of drugs must be from server
            cell.makeOrderTopMenuLabelOutlet.text = "Search for medicines / items"
            cell.makeOrderBottomMenuLabelOutlet.text = "SEARCH FROM 1003 DRUGS"
            cell.makeOrderIconImageOutlet.image = UIImage(named: "makeOrderPhoto")
            cell.imageInsideImageMakeOrderOutlet.image = UIImage(named: "searchFromMakeOrder")
            
            return cell
        }
        return UITableViewCell()
    }
}

extension MakeOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
