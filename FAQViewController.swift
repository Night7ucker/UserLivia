//
//  FAQViewController.swift
//  User
//
//  Created by BAMFAdmin on 06.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class FAQViewController: RootViewController {

    var isExpanded = false
    var selectedIndex: IndexPath?
    @IBOutlet var tableView: UITableView!
    var x = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButtonAndTitleToNavigationBar(title: "FAQ")
        tableView.delegate = self
        tableView.dataSource = self
        let faqNib = UINib.init(nibName: "FAQ", bundle: nil)
        tableView.register(faqNib, forCellReuseIdentifier: "faqCell")
        tableView.tableFooterView = UIView(frame: .zero)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didExpandCell() {
        self.isExpanded = !isExpanded
        self.tableView.reloadRows(at: [selectedIndex!], with: .automatic)
    }


}

extension FAQViewController : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FAQTableViewCell

        
        switch indexPath.row {
        case 0:
            cell.titleFirst.text = "What supporting documents are needed to get "
            cell.titleSecond.text = "an approval to become a LIVIA Partner?"
            return cell
        case 1:
            cell.titleFirst.text = "What else in addition to the supporting"
            cell.titleSecond.text = "documents do i need to become Partner?"
            return cell
        case 2:
            cell.titleFirst.text = "How can i increase my chances of winning"
            cell.titleSecond.text = "orders?"
            return cell
        default:
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.didExpandCell()
        x += 1
        let selectedCell = tableView.cellForRow(at: indexPath) as! FAQTableViewCell
        if x % 2 == 0 {
            selectedCell.top.isHidden = true
            selectedCell.bottom.isHidden = false
        } else {
            selectedCell.top.isHidden = false
            selectedCell.bottom.isHidden = true
        }


    }
 
    
}

extension FAQViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded && self.selectedIndex == indexPath {
            return 190

        }
        return 60
    }

    
}



