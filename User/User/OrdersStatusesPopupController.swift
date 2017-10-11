//
//  OrdersStatusesPopupController.swift
//  User
//
//  Created by Egor Yanukovich on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrdersStatusesPopupController: RootViewController {

    var checkedBoxes = [Int](repeating: 20, count:15)
    
    var resultChecked = [Int]()
    
//    var filteredTableView = OrderStatusTableController()
    @IBOutlet weak var popoverView: UIView!
    
    
    @IBOutlet weak var filteredTableView: UITableView!
    //order_status == status_id
    
    var delegate : SavePopoverDataDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popoverView.layer.cornerRadius = 7.0
        popoverView.layer.masksToBounds = true
        
        filteredTableView.delegate = self
        filteredTableView.dataSource = self
        
    }


    @IBAction func dismissAndSavePopup(_ sender: UIButton) {
        delegate.saveCheckBoxes(checkes: checkedBoxes)
        self.dismiss(animated: true, completion: nil)
    }
}

extension OrdersStatusesPopupController : UITableViewDelegate{
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

extension OrdersStatusesPopupController : UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkedBoxes.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : OrderStatusCell = tableView.dequeueReusableCell(withIdentifier: "OrderFilterCell", for: indexPath) as! OrderStatusCell
        
        cell.fillCellInfo(orderFilterDescription: "In process", orderCheckImage: #imageLiteral(resourceName: "orderUncheckedBox"))
        
        if resultChecked.count > 0{
            for item in resultChecked{
                if indexPath.row == item - 1{
                    cell.orderCheckImage.image = #imageLiteral(resourceName: "orderCheckedBoxImage")
                }
            }
        } //повторные элементы не удаляются. сделать проверку при добавлении к resultChecked
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped(sender:)))
        cell.orderCheckImage.isUserInteractionEnabled = true
        cell.orderCheckImage.addGestureRecognizer(tapGesture)
        
        return cell;
        
    }
    
    @objc func cellTapped(sender : UITapGestureRecognizer) {
        
        let checkedBoxImage  = sender.view as! UIImageView
        let position = sender.location(in: filteredTableView)
        guard let index = filteredTableView.indexPathForRow(at: position) else {return }
        
        
        let firstImage = checkedBoxImage.image
        let secondImage = #imageLiteral(resourceName: "orderUncheckedBox")
        let obj = index.row + 1
        
        //select
        if firstImage == secondImage{
            checkedBoxImage.image = #imageLiteral(resourceName: "orderCheckedBoxImage")
            checkedBoxes.insert(obj, at: index.row)
            checkedBoxes.remove(at: index.row+1)
        }
            //deselect
        else{
            checkedBoxImage.image = #imageLiteral(resourceName: "orderUncheckedBox")
            //если убрать remove - он будет смещать на один элемент вправо
            //если убрать insert - он будет смещать на один элемент влево
            checkedBoxes.remove(at: index.row)
            checkedBoxes.insert(20, at: index.row)
        }
    }

    
}
