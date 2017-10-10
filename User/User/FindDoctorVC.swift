//
//  FindDoctorVC.swift
//  User
//
//  Created by User on 10/9/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class FindDoctorVC: RootViewController {
    
    @IBOutlet weak var textFieldForSearchingOutlet: UITextField!
    @IBOutlet weak var specialityTypesTableView: UITableView!
    
    var doctorsSpecializationList: Results<DoctorSpecialityModel>? = nil
    var offsetForSpecializations = 0
    var isOneScrollBottom = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldForSearchingOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if RealmDataManager.getUserDataFromRealm().count != 0 {
            addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: RealmDataManager.getUserDataFromRealm()[0].cityName! + ", " + RealmDataManager.getUserDataFromRealm()[0].countryName!)
        } else {
            addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: RealmDataManager.getCitiesNamesFromRealm()[0].cityName! + ", " + RealmDataManager.getCitiesNamesFromRealm()[0].countryName!)
        }
        specialityTypesTableView.tableFooterView = UIView(frame: .zero)
        
//        addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: "Minsk, Belarus")
        addCityButtonToNavigationBar()
        
        specialityTypesTableView.delegate = self
        specialityTypesTableView.dataSource = self
        
        specialityTypesTableView.bounces = false
        if RealmDataManager.getUserDataFromRealm().count != 0 {
            FindDoctorSpecialityRequest.getSpecialityList { success in
                if success {
                    self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                    self.specialityTypesTableView.reloadData()
                }
            }
        } else {
            FindDoctorSpecialityRequest.getSpecialityListForUnsignedUser { success in
                if success {
                    self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                    self.specialityTypesTableView.reloadData()
                }
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    override func addBackButtonAndTitleToNavigationBar(title: String) {
//        let backButton = UIButton(type: .system)
//        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        backButton.setTitle("", for: .normal)
//        
//        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
//        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
//        
//        let backButtonBarButton = UIBarButtonItem(customView: backButton)
//        
//        let titleLabel = UILabel()
//        titleLabel.text = title
//        titleLabel.textColor = .white
//        titleLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
//        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
//        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
//        
//        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        if RealmDataManager.getDoctorSpecialityList().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getDoctorSpecialityList())
            }
        }
    }
    
    override func backButtonTapped(_ sender: UIButton) {
        navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: false)
    }
    
    private func addCityButtonToNavigationBar() {
        let addReminderButton = UIButton(type: .system)
        addReminderButton.frame = CGRect(x: 0, y: 0, width: 70, height: 50)
        addReminderButton.setTitle("City >", for: .normal)
        addReminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
        addReminderButton.setTitleColor(.white, for: .normal)
        addReminderButton.titleEdgeInsets = UIEdgeInsetsMake(5, 25, 0, 0)
        addReminderButton.addTarget(self, action: #selector(cityButtonTapped(_ :)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addReminderButton)
    }
    
    func cityButtonTapped(_ sender: UIButton) {
        let mainViewsStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
        let searchForItemsViewController = mainViewsStoryboard.instantiateViewController(withIdentifier: "kSearchForItemsViewController") as! SearchForItemsViewController
        navigationController?.pushViewController(searchForItemsViewController, animated: false)
    }
    
    func textFieldDidChange(_ sender: UITextField) {
        if RealmDataManager.getDoctorSpecialityList().count != 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getDoctorSpecialityList())
            }
        }
        if RealmDataManager.getUserDataFromRealm().count != 0 {
            FindDoctorSpecialityRequest.getSpecialityList(searchText: sender.text!) {
                success in
                if success {
                    self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                    self.specialityTypesTableView.reloadData()
                }
            }
        } else {
            FindDoctorSpecialityRequest.getSpecialityListForUnsignedUser(searchText: sender.text!) {
                success in
                if success {
                    self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                    self.specialityTypesTableView.reloadData()
                }
            }
        }
        
    }
}

extension FindDoctorVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmDataManager.getDoctorSpecialityList().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let specializationCell = tableView.dequeueReusableCell(withIdentifier: "findDoctorCell") as! FindDoctorCellTableViewCell
        
        specializationCell.specializationNameLabelOutlet.text = doctorsSpecializationList?[indexPath.row].name
        specializationCell.imageViewOutlet.image = #imageLiteral(resourceName: "pharmacySign")
        
        if indexPath.row == (doctorsSpecializationList?.count)! - 1 {
            if RealmDataManager.getUserDataFromRealm().count != 0 {
                offsetForSpecializations += 20
                FindDoctorSpecialityRequest.getSpecialityList(offset: offsetForSpecializations) { success in
                    if success {
                        self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                        self.specialityTypesTableView.reloadData()
                    }
                }
            } else {
                offsetForSpecializations += 20
                FindDoctorSpecialityRequest.getSpecialityListForUnsignedUser(offset: offsetForSpecializations) { success in
                    if success {
                        self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                        self.specialityTypesTableView.reloadData()
                    }
                }
            }
        }
        
        return specializationCell
    }
}

extension FindDoctorVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var isOneScrollBottom = true
        
        let reloadTableActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        reloadTableActivityIndicator.color = .gray
        reloadTableActivityIndicator.center = view.center
        
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && isOneScrollBottom {
            isOneScrollBottom = false
            reloadTableActivityIndicator.startAnimating()
            view.addSubview(reloadTableActivityIndicator)
            offsetForSpecializations += 20
            if RealmDataManager.getUserDataFromRealm().count != 0 {
                FindDoctorSpecialityRequest.getSpecialityList(offset: offsetForSpecializations) { success in
                    if success {
                        self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                        self.specialityTypesTableView.reloadData()
                        isOneScrollBottom = true
                        reloadTableActivityIndicator.stopAnimating()
                    }
                }
            } else {
                FindDoctorSpecialityRequest.getSpecialityListForUnsignedUser(offset: offsetForSpecializations) { success in
                    if success {
                        self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                        self.specialityTypesTableView.reloadData()
                        isOneScrollBottom = true
                        reloadTableActivityIndicator.stopAnimating()
                    }
                }
            }
            
        }
    }
}
