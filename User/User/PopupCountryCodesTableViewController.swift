//
//  PopupCountryCodesTableViewController.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import CoreGraphics

class PopupCountryCodesTableViewController: UIViewController{

    @IBOutlet weak var countryCodesTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countryCodesTableView.layer.cornerRadius = 5
        self.countryCodesTableView.indicatorStyle = .default
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissIfTappedOnView(_:)))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.view.addGestureRecognizer(tap)
        
        countryCodesTableView.delegate = self
        countryCodesTableView.dataSource = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dismissIfTappedOnView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Table view data source

    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PopupCountryCodesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCodeCell", for: indexPath) as! CountryCodeCell
        
        cell.countryCodeLabelOutlet.text = "+375"
        cell.countryNameLabelOutlet.text = "Belarus"
        cell.countryFlagImageViewOutlet.image = UIImage(named: "usaFlag")
        
        return cell
    }
}

extension PopupCountryCodesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: false, completion: nil)
    }
}
