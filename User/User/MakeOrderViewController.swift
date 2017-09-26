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
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Request price"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
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
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
}

extension MakeOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
