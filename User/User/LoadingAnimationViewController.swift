//
//  LoadingAnimationViewController.swift
//  User
//
//  Created by User on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingAnimationViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var popupViewOutlet: UIView!
    
    let darkGreenColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 300, height: 100)
//        NVActivityIndicatorView.DEFAULT_TYPE = .ballPulseSync
//        NVActivityIndicatorView.DEFAULT_COLOR = darkGreenColor
//        NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 10
//        NVActivityIndicatorView.DEFAULT_PADDING = CGFloat(20)
        
        
        let animatedView = NVActivityIndicatorView(frame: CGRect(x: 90, y: 100, width: 100, height: 50), type: .ballPulseSync, color: darkGreenColor, padding: -10)
        popupViewOutlet.addSubview(animatedView)
//        NVActivityIndicatorView.DEFAULT_TYPE = .ballScale
//        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.black
        animatedView.startAnimating()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        stopAnimating()
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
