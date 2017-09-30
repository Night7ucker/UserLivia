//
//  TestViewController.swift
//  User
//
//  Created by User on 9/30/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class TestViewController: UITableViewController {

    @IBOutlet weak var testTableViewOutlet: UITableView!
    
    var sections = sectionsData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "GEGEGE"
    
        testTableViewOutlet.delegate = self
        testTableViewOutlet.dataSource = self
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        testTableViewOutlet.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        
        testTableViewOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        let button = UIButton()
        button.setTitle("testButton", for: .normal)
        button.frame = CGRect(x: 0, y: 300, width: 150, height: 40)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonAction() {
        print("button tapped")
    }

}

extension TestViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = testTableViewOutlet.dequeueReusableCell(withIdentifier: "testCell") as! TestTableViewCell
        
        cell.testLabelOutlet.text = "GOvno"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row section is \(indexPath.section), it's row is \(indexPath.row)")
    }
}

extension TestViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}

public struct Item {
    var name: String
    var detail: String
    
    public init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

public var sectionsData: [Section] = [
    Section(name: "Self-collect", items: [
        Item(name: "MacBook", detail: "Apple's ultraportable laptop, trading portability for speed and connectivity."),
        Item(name: "Accessories", detail: "")
        ]),
    Section(name: "iPad", items: [
        Item(name: "iPad Pro", detail: "iPad Pro delivers epic power, in 12.9-inch and a new 10.5-inch size."),
        Item(name: "Accessories", detail: "")
        ])
]
