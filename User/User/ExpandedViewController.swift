//
//  ExpandedViewController.swift
//  User
//
//  Created by User on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class ExpandedViewController: RootViewController, UITableViewDataSource, UITableViewDelegate, SectionHeaderViewDelegate {

    @IBOutlet weak var expandedTableViewOutlet: UITableView!
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet weak var descriptionViewOutlet: UIView!
    fileprivate let cellReuseIdentifier = "myCell"
    fileprivate let sectionHeaderReuseIdentifier = "expandedSectionHeader"
    
    var whichSectionIsChecked = 1
    var whichRowIsChecked = 0
    
    var sections = [
        Section(name: "Self-collected", data: ["Let LIVIA suggest the Chemist that will deliver the items to me", "I will pick the Chemist that will deliver the items to me"], expanded: false),
        Section(name: "Delivery", data: ["Let LIVIA suggest the Chemist that will deliver the items to me", "I will pick the Chemist that will deliver the items to me"], expanded: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Select order type")
        
        expandedTableViewOutlet.delegate = self
        expandedTableViewOutlet.dataSource = self
        
        expandedTableViewOutlet.separatorStyle = .none
        
        nextButtonOutlet.layer.cornerRadius = 2
        nextButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        
        expandedTableViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        descriptionViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        view.backgroundColor = Colors.Root.lightGrayColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].sectionRowData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        header.customInit(title: sections[section].sectionName, section: section, delegate: self, checked: sections[section].expanded)
        
        if section == 1 {
            let label = UILabel()
            label.frame = CGRect(x: 100, y: 5, width: 150, height: 30)
            label.textColor = Colors.Root.lightBlueColor
            label.text = "Cost 5 BYN"
            label.font = label.font.withSize(14)
            
            header.addSubview(label)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandedTableViewOutlet.dequeueReusableCell(withIdentifier: "myCell") as! ExpandedTableViewCell
        
        cell.backgroundColor = Colors.Root.lightGrayColor
        cell.radioButtonOutlet.backgroundColor = Colors.Root.lightGrayColor
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.radioButtonOutlet.image = UIImage(named: "radioButtonChecked")
        case 1:
            cell.radioButtonOutlet.image = UIImage(named: "radioButtonUnchecked")
        default:
            break
        }
        
        cell.dataLabelOutlet.text = sections[indexPath.section].sectionRowData[indexPath.row]
        
        return cell
    }
    
    func toggleSection(header: SectionHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        switch section {
        case 0:
            sections[section + 1].expanded = false
        case 1:
            sections[section - 1].expanded = false
        default:
            break
        }
        
        if sections[section].expanded == true {
            whichSectionIsChecked = section
            whichRowIsChecked = 0
        }
        
        expandedTableViewOutlet.beginUpdates()
        for i in 0..<sections[section].sectionRowData.count {
            expandedTableViewOutlet.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        expandedTableViewOutlet.endUpdates()
        
        let checkedCheckbox = UIImage(named: "checkBoxChecked.png")
        let uncheckedCheckbox = UIImage(named: "checkBoxUnchecked.png")
        
        if header.radioButonImageView.image != checkedCheckbox && sections[section].expanded == true {
            header.radioButonImageView.image = checkedCheckbox
        } else {
            header.radioButonImageView.image = uncheckedCheckbox
        }
        
        
        switch section {
        case 0:
            let bottomSection = expandedTableViewOutlet.headerView(forSection: section + 1) as! SectionHeaderView
            bottomSection.radioButonImageView.image = uncheckedCheckbox
        case 1:
            let bottomSection = expandedTableViewOutlet.headerView(forSection: section - 1) as! SectionHeaderView
            bottomSection.radioButonImageView.image = uncheckedCheckbox
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let cell = tableView.cellForRow(at: indexPath) as! ExpandedTableViewCell
            cell.radioButtonOutlet.image = UIImage(named: "radioButtonChecked")
            
            let bottomRowIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            let bottomCell = tableView.cellForRow(at: bottomRowIndexPath) as! ExpandedTableViewCell
            bottomCell.radioButtonOutlet.image = UIImage(named: "radioButtonUnchecked")
            whichRowIsChecked = 0
        case 1:
            let cell = tableView.cellForRow(at: indexPath) as! ExpandedTableViewCell
            cell.radioButtonOutlet.image = UIImage(named: "radioButtonChecked")
            
            let topRowIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            let topCell = tableView.cellForRow(at: topRowIndexPath) as! ExpandedTableViewCell
            topCell.radioButtonOutlet.image = UIImage(named: "radioButtonUnchecked")
            whichRowIsChecked = 1
        default:
            break
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        print("Section")
        print(whichSectionIsChecked)
        print("Row")
        print(whichRowIsChecked)
    }

}
