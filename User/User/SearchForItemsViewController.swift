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
    
    var arrayOfCitiesFromServer = [City]()
    var arrayOfSections = [String]()
    
    var arrayOfCountriesAndCitiesForCountry = [ String: [String] ]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetCitiesRequest.getCities { success in
            if success {
                self.arrayOfCitiesFromServer = Array(RealmDataManager.getCitiesNamesFromRealm())
                self.arrayOfSections = City.formSectionsForCities()
                self.citiesForSearchingTalbeView.reloadData()
                self.arrayOfCountriesAndCitiesForCountry = self.formDictionaryOfCountriesAndCities()
                print(self.arrayOfCountriesAndCitiesForCountry)
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
    
    func formDictionaryOfCountriesAndCities() -> [ String : [String] ] {
        let arrayOfCitiesFromRealm = Array(RealmDataManager.getCitiesNamesFromRealm())
        var previousSection = String()
        var section = String()
        var arrayOfCities = [String]()
        var dictionaryOfCountriesAndCities = [ String: [String]]()
        previousSection = (arrayOfCitiesFromRealm.first?.countryName)!
        for object in arrayOfCitiesFromRealm {
            
            if arrayOfCities.contains(object.cityName!) == false {
                arrayOfCities.append(object.cityName!)
                section = object.countryName!
                if section != previousSection {
                    print(previousSection)
                    print(arrayOfCities)
                    dictionaryOfCountriesAndCities[previousSection] = arrayOfCities
                    arrayOfCities = [String]()
                    previousSection = section
                }
            }
            previousSection = object.countryName!
        }
//        print(dictionaryOfCountriesAndCities)
        return dictionaryOfCountriesAndCities
    }

}

extension SearchForItemsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayOfSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayOfSections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCitiesFromServer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameCell", for: indexPath) as! CityTableViewCell
        if arrayOfCitiesFromServer[indexPath.row].countryName != arrayOfSections[indexPath.section] {
            
        }
        cell.cityNameLabelOutlet.text = arrayOfCitiesFromServer[indexPath.row].cityName
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.indexPathsForVisibleRows?.last?.row {
            print("last visible row loaded")
        }
    }
}
