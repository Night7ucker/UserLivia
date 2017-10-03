//
//  DrugsCategoriesController.swift
//  User
//
//  Created by Egor Yanukovich on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DrugsCategoriesController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories = [
        DrugsCategory(name: "Supplements", data: ["","",""], color: .blue, expanded: false),
        DrugsCategory(name: "Personal Items", data: ["","",""], color: .yellow, expanded: false),
        DrugsCategory(name: "Blood Pressure Machines", data: ["","",""], color: .orange, expanded: false),
        DrugsCategory(name: "Blood Glucose Monitors", data: ["","",""], color: .purple, expanded: false),
        DrugsCategory(name: "Physical Support", data: ["","",""], color: .purple, expanded: false),
        DrugsCategory(name: "Supplements", data: ["","",""], color: .blue, expanded: false),
        DrugsCategory(name: "Supplements", data: ["","",""], color: .red, expanded: false),
        DrugsCategory(name: "Supplements", data: ["","",""], color: .brown, expanded: false),
        DrugsCategory(name: "Supplements", data: ["","",""], color: .green, expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        print(categories.count)
    }


}

extension DrugsCategoriesController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].categoryData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrugsChildCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("OP")
    }
}

extension DrugsCategoriesController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if categories[indexPath.section].expanded {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CategoryHeader()
        
        header.customInit(title: categories[section].categoryName, section: section, checked: categories[section].expanded)
        
        return header
    }
    
    
    
}
