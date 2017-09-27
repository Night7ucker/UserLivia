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
    
    var arrayOfCitiesFromServer = [City]()
    var arrayOfSections = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetCitiesRequest.getCities { success, arrayOfCities in
            if success {
                self.arrayOfCitiesFromServer = arrayOfCities
                self.arrayOfSections = City.formSectionsForCities(citiesArray: self.arrayOfCitiesFromServer)
                
            }
        }
        
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
        titleLabel.text = "My location"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        citiesForSearchingTalbeView.delegate = self
        citiesForSearchingTalbeView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
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
