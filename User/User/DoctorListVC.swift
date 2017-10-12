//
//  DoctorListVC.swift
//  User
//
//  Created by User on 10/12/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class DoctorListVC: RootViewController {
    
    
    @IBOutlet weak var searchDoctorTextFieldOutlet: UITextField!
    
    @IBOutlet weak var doctorsTableView: UITableView!
    
    @IBOutlet weak var showOnMapViewOutlet: UIView!
    var specializationID: String?
    var specializationName: String?
    var offset = 0
    
    private var lastContentOffset: CGFloat = 0
    
    var footerView = UIView()
    
    var doctorsArray: Results<DoctorModel>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorsTableView.delegate = self
        doctorsTableView.dataSource = self
        
        doctorsTableView.tableFooterView = UIView(frame: .zero)
        
        GetDoctorRequest.getDoctorList(specializationID: specializationID!, searchText: "", offset: offset) { success in
            if success {
                self.doctorsArray = RealmDataManager.getDoctorsArray()
                self.doctorsTableView.reloadData()
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMapTapped(_ :)))
        
        showOnMapViewOutlet.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showMapTapped(_ sender: UITapGestureRecognizer) {
        
    }

}

extension DoctorListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = doctorsArray?.count {
            return numberOfRows
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doctorCell = tableView.dequeueReusableCell(withIdentifier: "doctorCell") as! DoctorCellTableViewCell
        
        doctorCell.doctorNameLabelOutlet.text = doctorsArray![indexPath.row].name
        doctorCell.doctorAddressLabelOutlet.text = doctorsArray![indexPath.row].address
        doctorCell.doctorFeeLabelOutlet.text = "Fee - " + doctorsArray![indexPath.row].consultationsFees!
        doctorCell.doctorExperienceLabelOutelt.text = "Experience - " + doctorsArray![indexPath.row].experienceYears!
        
        return doctorCell
    }
}

extension DoctorListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            showOnMapViewOutlet.isHidden = false
            
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            showOnMapViewOutlet.isHidden = true
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
    }
}
