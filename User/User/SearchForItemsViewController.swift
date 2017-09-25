//
//  SearchForItemsViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class SearchForItemsViewController: UIViewController, UISearchBarDelegate {


    @IBOutlet weak var citiesForSearchingTalbeView: UITableView!
    @IBOutlet weak var textForSearchFieldOutlet: UITextField!
    
    let sectionsNames = ["Albania", "Australia", "Belarus", "Poland", "Ukraine"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        citiesForSearchingTalbeView.delegate = self
        citiesForSearchingTalbeView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }


}

extension SearchForItemsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionsNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsNames[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameCell", for: indexPath) as! CityTableViewCell
        
        cell.cityNameLabelOutlet.text = "Minsk"
        
        return cell
    }
}

extension SearchForItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
//        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 10)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 10)
        headerLabel.textColor = UIColor.gray
        headerLabel.text = self.tableView(self.citiesForSearchingTalbeView, titleForHeaderInSection: section)?.uppercased()
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
