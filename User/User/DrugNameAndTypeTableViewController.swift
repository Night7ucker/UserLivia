//
//  DrugNameAndTypeTableViewController.swift
//  User
//
//  Created by User on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

// make outlet from constrain then pass it to this controller and set constrain in this controller to that to reach dynamic width

import UIKit

class DrugNameAndTypeTableViewController: UIViewController {

    @IBOutlet weak var drugTypePopupTableView: UITableView!
    
    var delegate: DrugNameAndTypeTableViewControllerDelegate!
    var whereToShow: CGPoint?
    
    var numbersFrom1To10000 = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drugTypePopupTableView.dataSource = self
        drugTypePopupTableView.delegate = self

        drugTypePopupTableView.layer.cornerRadius = 1
        drugTypePopupTableView.separatorStyle = .none
        if whereToShow != nil {
            let whereToShowTableView = CGPoint(x: (whereToShow?.x)!, y: (whereToShow?.y)! + 67)
            drugTypePopupTableView.frame = CGRect(x: whereToShowTableView.x, y: whereToShowTableView.y, width: drugTypePopupTableView.frame.width, height: drugTypePopupTableView.frame.height)
        }
        for i in 1...10000 {
            numbersFrom1To10000.append(i)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}

extension DrugNameAndTypeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbersFrom1To10000.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drugTypeCell = drugTypePopupTableView.dequeueReusableCell(withIdentifier: "drugNumberTypeCell") as! NumberAndTypeTableViewCell
        
        drugTypeCell.drugCountLabelOutlet.text = String(numbersFrom1To10000[indexPath.row])
        
        return drugTypeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drugCell = tableView.cellForRow(at: indexPath) as! NumberAndTypeTableViewCell
        
        delegate.transferDrugsCountAndType(drugsNumber: drugCell.drugCountLabelOutlet.text!)
        
        dismiss(animated: false, completion: nil)
    }
}

extension DrugNameAndTypeTableViewController: UITableViewDelegate {
    
}
