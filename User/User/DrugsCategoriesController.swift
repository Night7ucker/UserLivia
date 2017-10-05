//
//  DrugsCategoriesController.swift
//  User
//
//  Created by Egor Yanukovich on 10/4/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DrugsCategoriesController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension DrugsCategoriesController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = 1
        
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //categories.count
        let numberOfRowsInSection = 9
        
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = cell.reuseIdentifier
        
        return cell
    }
    
}

extension DrugsCategoriesController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}
