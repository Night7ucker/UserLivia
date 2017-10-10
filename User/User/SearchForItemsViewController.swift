//
//  SearchForItemsViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class SearchForItemsViewController: RootViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var citiesForSearchingTalbeView: UITableView!
    @IBOutlet weak var textForSearchFieldOutlet: UITextField!
    var checkEditProfile = false
    var arrayOfCitiesFromServer = [City]()
    var arrayOfSections = [String]()
    var checkIsRegistered = true
    var transitionFromMainController = false
    var arrayOfCountriesAndCitiesForCountry = [ String: [String] ]()
    let realm = try! Realm()
    var offsetForCities = 0
    
    struct CountriesAndCities {
        var country: String!
        var city: [String]!
    }
    
    var  countriesAndCitiesArray = [CountriesAndCities]()
    
    var isSearchStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "My location")
        
        citiesForSearchingTalbeView.delegate = self
        citiesForSearchingTalbeView.dataSource = self
        
        textForSearchFieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        if RealmDataManager.getCitiesNamesFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getCitiesNamesFromRealm())
            }
        }
        
        GetCitiesRequest.getCities(offsetForCities: offsetForCities) { success in
            if success {
                self.countriesAndCitiesArray = self.formDictionaryOfCountriesAndCities()
                self.citiesForSearchingTalbeView.reloadData()
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func formDictionaryOfCountriesAndCities() -> [CountriesAndCities] {
        let arrayOfCitiesFromRealm = Array(RealmDataManager.getCitiesNamesFromRealm())
        var previousSection = String()
        var section = String()
        var arrayOfCities = [String]()
        var countriesAndCitiesArray = [CountriesAndCities]()
        var ifFirstSection = true
        previousSection = (arrayOfCitiesFromRealm.first?.countryName)!
        for object in arrayOfCitiesFromRealm {
            if arrayOfCities.contains(object.cityName!) == false {
                section = object.countryName!
                if section != previousSection {
                    countriesAndCitiesArray.append(CountriesAndCities(country: previousSection, city: arrayOfCities))
                    arrayOfCities = [String]()
                    previousSection = section
                }
                arrayOfCities.append(object.cityName!)
                if (arrayOfCitiesFromRealm.last == object && previousSection != section) ||
                    (arrayOfCitiesFromRealm.last == object && ifFirstSection) {
                    countriesAndCitiesArray.append(CountriesAndCities(country: section, city: arrayOfCities))
                    ifFirstSection = false
                }
            }
        }
        return countriesAndCitiesArray
    }
    
    func textFieldDidChange(_ sender: UITextField) {
        isSearchStarted = true
        GetCitiesRequest.getCitiesForSearchRequest(searchStringForCities: sender.text!) { success in
            self.countriesAndCitiesArray = self.formDictionaryOfCountriesAndCities()
            self.citiesForSearchingTalbeView.reloadData()
            if sender.text == "" {
                self.isSearchStarted = false
            }
        }
    }
    
}

extension SearchForItemsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countriesAndCitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countriesAndCitiesArray[section].country
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesAndCitiesArray[section].city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameCell", for: indexPath) as! CityTableViewCell
        
        cell.fillCellInfo(cityName: countriesAndCitiesArray[indexPath.section].city[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if RealmDataManager.getUserDataFromRealm().count == 0 {
            let selectedCityWithCountry = City()
            let cell = tableView.cellForRow(at: indexPath) as? CityTableViewCell
            selectedCityWithCountry.countryName = countriesAndCitiesArray[indexPath.section].country
            selectedCityWithCountry.cityName = cell?.cityNameLabelOutlet.text
            let arrayWithputChoosedCity = RealmDataManager.getCitiesNamesFromRealm()
            for element in arrayWithputChoosedCity {
                if element.cityName != selectedCityWithCountry.cityName {
                    try! realm.write {
                        realm.delete(element)
                    }
                }
            }
            let findDoctorStoryboard = UIStoryboard(name: "FindDoctor", bundle: nil)
            let findDoctorViewController = findDoctorStoryboard.instantiateViewController(withIdentifier: "kFindDoctorVC") as! FindDoctorVC
            navigationController?.pushViewController(findDoctorViewController, animated: false)
        } else {
            if transitionFromMainController == true {
                let GetDrugsStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
                let GetDrugsViewController = GetDrugsStoryboard.instantiateViewController(withIdentifier: "kSearchDrugsStoryboardId") as? GetDrugsViewController
                navigationController?.pushViewController(GetDrugsViewController!, animated: true)
            } else {
                
                if checkIsRegistered == true {
                    let selectedCityWithCountry = City()
                    let cell = tableView.cellForRow(at: indexPath) as? CityTableViewCell
                    selectedCityWithCountry.countryName = countriesAndCitiesArray[indexPath.section].country
                    selectedCityWithCountry.cityName = cell?.cityNameLabelOutlet.text
                    let arrayWithputChoosedCity = RealmDataManager.getCitiesNamesFromRealm()
                    for element in arrayWithputChoosedCity {
                        if element.cityName != selectedCityWithCountry.cityName {
                            try! realm.write {
                                realm.delete(element)
                            }
                        }
                    }
                    
                    let realmAddCityInfo = RealmDataManager.getUserDataFromRealm()
                    
                    try! realm.write {
                        realmAddCityInfo[0].cityName = RealmDataManager.getCitiesNamesFromRealm()[0].cityName!
                        realmAddCityInfo[0].countryName = RealmDataManager.getCitiesNamesFromRealm()[0].countryName!
                        realmAddCityInfo[0].cityId = RealmDataManager.getCitiesNamesFromRealm()[0].cityId!
                        realmAddCityInfo[0].countryId = RealmDataManager.getCitiesNamesFromRealm()[0].countryId!
                        realmAddCityInfo[0].countryCode = RealmDataManager.getCitiesNamesFromRealm()[0].countryCode!
                    }
                    let obj = EditUserCityRequest()
                    obj.editUserFunc { (success) in
                        if success {
                            if self.checkEditProfile == true {
                                self.navigationController?.popViewController(animated: false)
                            } else {
                                let MainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: Bundle.main)
                                let MainScreenController = MainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
                                MainScreenController.userIsRegistred = true
                                self.navigationController?.pushViewController(MainScreenController, animated: true)
                            }
                            
                        }
                    }
                } else {
                    let GetDrugsStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
                    let GetDrugsViewController = GetDrugsStoryboard.instantiateViewController(withIdentifier: "kSearchDrugsStoryboardId") as? GetDrugsViewController
                    navigationController?.pushViewController(GetDrugsViewController!, animated: true)
                }
                
            }
        }
        

    }
}

extension SearchForItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width:
        tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 10)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 10)
        headerLabel.textColor = .gray
        headerLabel.text = self.tableView(self.citiesForSearchingTalbeView, titleForHeaderInSection: section)?.uppercased()
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var isOneScrollBottom = true
        
        let reloadTableActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        reloadTableActivityIndicator.color = .gray
        reloadTableActivityIndicator.center = view.center
        
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && isOneScrollBottom && isSearchStarted == false {
            isOneScrollBottom = false
            reloadTableActivityIndicator.startAnimating()
            view.addSubview(reloadTableActivityIndicator)
            offsetForCities += 20
            GetCitiesRequest.getCities(offsetForCities: offsetForCities) { success in
                if success {
                    let arrayOfCitiesAndCountries = self.formDictionaryOfCountriesAndCities()
                    self.countriesAndCitiesArray = arrayOfCitiesAndCountries
                    self.citiesForSearchingTalbeView.reloadData()
                    isOneScrollBottom = true
                    reloadTableActivityIndicator.stopAnimating()
                }
            }
        }
    }
}
