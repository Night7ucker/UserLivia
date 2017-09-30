//
//  RootViewController.swift
//  User
//
//  Created by User on 9/30/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    enum Colors {
        struct Root {
            static var lightBlueColor: UIColor { return UIColor(red: CGFloat(121/255.0), green: CGFloat(181/255.0), blue: CGFloat(208/255.0), alpha: CGFloat(1.0)) }
            static var lightGrayColor: UIColor { return UIColor( red: CGFloat(230/255.0), green: CGFloat(230/255.0), blue: CGFloat(230/255.0), alpha: CGFloat(1.0)) }
            static var greenColorForNavigationBar: UIColor { return UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    func addBackButtonAndTitleToNavigationBar(title: String) {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
    }
    
    func createTitleInNavigtaionBar(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.leftBarButtonItem = titleLabelBarButton
    }
    
    func backButtonTapped(_ sender: UIButton) {
        let transition = CATransition()
        
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        navigationController!.view.layer.add(transition, forKey: nil)
        
        navigationController?.popViewController(animated: false)
    }
}

extension RootViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RootViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
