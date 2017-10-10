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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: RealmDataManager.getUserDataFromRealm()[0].cityName! + ", " + RealmDataManager.getUserDataFromRealm()[0].countryName!)
//        addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: "Minsk, Belarus")
        addCityButtonToNavigationBar()
        
        specialityTypesTableView.delegate = self
        specialityTypesTableView.dataSource = self
        
        specialityTypesTableView.bounces = false
        FindDoctorSpecialityRequest.getSpecialityList { success in
            if success {
                self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                self.specialityTypesTableView.reloadData()
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        print("city button tapped")
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
        
        return specializationCell
    }
}

extension FindDoctorVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
