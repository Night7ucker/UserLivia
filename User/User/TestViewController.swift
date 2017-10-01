//
//  TestViewController.swift
//  User
//
//  Created by User on 9/30/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class TestViewController: CollapsibleTableSectionViewController {

    @IBOutlet weak var testTableViewOutlet: UITableView!
    
    var sections = sectionsData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "GEGEGE"
    
        testTableViewOutlet.delegate = self
        testTableViewOutlet.dataSource = self
        
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

extension TestViewController: CollapsibleTableSectionDelegate {
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        return 2
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Cell
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") as! TestTableViewCell
        
        cell.textLabel?.text = "Cell Text"
        
        return cell
    }
    
    
    
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row section is \(indexPath.section), it's row is \(indexPath.row)")
    }
    
    func shouldCollapseOthers(_ tableView: UITableView) -> Bool {
        return true
    }
}

extension TestViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        if sections[section].collapsed == true {
            switch section {
            case 0:
                sections[0].collapsed = false
                sections[1].collapsed = true
                testTableViewOutlet.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
                testTableViewOutlet.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .automatic)
            case 1:
                sections[1].collapsed = false
                sections[0].collapsed = true
                testTableViewOutlet.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
                testTableViewOutlet.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .automatic)
            default:
                break
            }
        }
//        let collapsed = !sections[section].collapsed
//        
//        sections[section].collapsed = collapsed
//        header.setCollapsed(collapsed)
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
        ], collapsed: true),
    Section(name: "iPad", items: [
        Item(name: "iPad Pro", detail: "iPad Pro delivers epic power, in 12.9-inch and a new 10.5-inch size."),
        Item(name: "Accessories", detail: "")
        ], collapsed: false)
]
