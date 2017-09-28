//
//  SelectOrderTypeViewController.swift
//  User
//
//  Created by User on 9/28/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 3
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

class SelectOrderTypeViewController: UIViewController {
    
    
    struct Section {
        var name: String
        var items: [String]
        var collapsed: Bool
        
        init(name: String, items: [String], collapsed: Bool = false) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    
//    sections = [
//        Section(name: "Mac", items: ["MacBook", "MacBook Air"]),
//        Section(name: "iPad", items: ["iPad Pro", "iPad Air 2"]),
//        Section(name: "iPhone", items: ["iPhone 7", "iPhone 6"])
//    ]
    
    var sections = [
        Section(name: "Mac", items: ["MacBook", "MacBook Air"]),
        Section(name: "iPad", items: ["iPad Pro", "iPad Air 2"]),
    ]
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet weak var selectDeliveryMethodTableView: UITableView!
    
    let lightBluecolor = UIColor( red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0) )
    
    let lightGrayColor = UIColor( red: CGFloat(230/255.0), green: CGFloat(230/255.0), blue: CGFloat(230/255.0), alpha: CGFloat(1.0) )
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTapGesture(_: )))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tap.delegate = self
        
        selectDeliveryMethodTableView.delegate = self
        selectDeliveryMethodTableView.dataSource = self
        
        nextButtonOutlet.layer.cornerRadius = 2
        nextButtonOutlet.backgroundColor = lightBluecolor
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Select order type"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    func handleTapGesture(_ sender: UITapGestureRecognizer) {
        print("tapped")
    }
    
}

extension SelectOrderTypeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectOrderCell") as!SelectOrderCell
        
        switch indexPath.row {
        case 0:
            cell.imageOutlet.image = UIImage(named: "radioButtonUnchecked.png")
            cell.textViewOutlet.text = "Let LIVIA suggest the Chemist that will deliver the items to me"
        case 1:
            cell.imageOutlet.image = UIImage(named: "radioButtonUnchecked.png")
            cell.textViewOutlet.text = "I will pick the Chemist that will deliver the items to me"
        default:
            break
        }
        
        cell.contentView.addGestureRecognizer(tap)
        
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "selectOrderCell", for: indexPath) as! SelectOrderCell
//        
        
//
//        return cell
    }
}

extension SelectOrderTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        switch section {
        case 0:
            header.titleLabel.text = "Self-collect"
        case 1:
            header.titleLabel.text = "Delivery"
            header.optionalCostLabel.text = "Cost 5 BYN"
        default:
            break
        }
        
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        header.radioButtonImageView.image = UIImage(named: "checkBoxUnchecked.png")
//        if section == 1 {
//
//        }
        header.section = section
        header.delegate = self
        return header
//        let sectionHeaderView = UIView()
//        
//        sectionHeaderView.backgroundColor = lightGrayColor
//        
//        let image = UIImageView()
//        image.image = UIImage(named: "checkBoxUnchecked.png")
//        image.frame = CGRect(x: 18, y: 7, width: 20, height: 20)
//        
//        sectionHeaderView.addSubview(image)
//        
//        switch section {
//        case 0:
//            let titleLabel = UILabel(frame: CGRect(x: 50, y: 5, width: 150, height: 25))
//            
//            titleLabel.text = "Self-collect"
//            titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 14)
//            
//            sectionHeaderView.addSubview(titleLabel)
//        case 1:
//            let titleLabel = UILabel(frame: CGRect(x: 50, y: 5, width: 80, height: 25))
//            
//            titleLabel.text = "Delivery"
//            titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 14)
//            
//            sectionHeaderView.addSubview(titleLabel)
//            
//            let costLabel = UILabel(frame: CGRect(x: 108, y: 5, width: 120, height: 25))
//            
//            costLabel.text = "Cost 5 BYN"
//            costLabel.font = UIFont(name: costLabel.font.fontName, size: 14)
//            costLabel.textColor = lightBluecolor
//            
//            sectionHeaderView.addSubview(costLabel)
//        default:
//            break
//        }
//        
//        
//        let openButton = UIButton(frame: CGRect(x: 350, y: 8, width: 15, height: 15))
//        openButton.setTitle("▾", for: .normal)
//        openButton.setTitleColor(.gray, for: .normal)
//        
//        sectionHeaderView.addSubview(openButton)
//        
//        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row is selected")
    }
    
}

extension SelectOrderTypeViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        // Reload the whole section
        selectDeliveryMethodTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}

extension SelectOrderTypeViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != nil && touch.view!.isDescendant(of: self.selectDeliveryMethodTableView) {
            return false
        }
        return true
    }
}
