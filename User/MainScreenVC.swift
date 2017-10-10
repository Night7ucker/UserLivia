//
//  MainScreenVC.swift
//  User
//
//  Created by User on 10/9/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {

    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    @IBOutlet weak var mainViewOutlet: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: scrollViewOutlet.bounds)
        backgroundImage.image = UIImage(named: "backgroundWithPluses")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        scrollViewOutlet.insertSubview(backgroundImage, at: 0)
        scrollViewOutlet.isDirectionalLockEnabled = true
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

}
