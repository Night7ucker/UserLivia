//
//  RootViewController.swift
//  User
//
//  Created by User on 9/30/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import Alamofire

class RootViewController: UIViewController {
    
    enum Colors {
        struct Root {
            static var backgroundColor: UIColor { return UIColor(red: CGFloat(244/255.0), green: CGFloat(247/255.0), blue: CGFloat(247/255.0), alpha: CGFloat(1.0)) }
            static var lightBlueColor: UIColor { return UIColor(red: CGFloat(121/255.0), green: CGFloat(181/255.0), blue: CGFloat(208/255.0), alpha: CGFloat(1.0)) }
            static var receivedStatus: UIColor { return UIColor(red: CGFloat(72/255.0), green: CGFloat(176/255.0), blue: CGFloat(84/255.0), alpha: CGFloat(1.0)) }
            static var orangeColor: UIColor { return UIColor(red: CGFloat(228/255.0), green: CGFloat(181/255.0), blue: CGFloat(106/255.0), alpha: CGFloat(1.0)) }
            static var lightGrayColor: UIColor { return UIColor( red: CGFloat(230/255.0), green: CGFloat(230/255.0), blue: CGFloat(230/255.0), alpha: CGFloat(1.0)) }
            static var inProgressStatusColor: UIColor { return UIColor( red: CGFloat(122/255.0), green: CGFloat(162/255.0), blue: CGFloat(107/255.0), alpha: CGFloat(1.0)) }
            static var greenColorForNavigationBar: UIColor { return UIColor( red: CGFloat(102/255.0), green: CGFloat(204/255.0), blue: CGFloat(178/255.0), alpha: CGFloat(1.0)) }
            static var canceledStatusColor: UIColor { return UIColor(red: CGFloat(255/255.0), green: CGFloat(123/255.0), blue: CGFloat(105/255.0), alpha: CGFloat(1.0)) }
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
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.setTitle("", for: .normal)
        
        let origImage = UIImage(named: "backButtonImage");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = .white
        
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
    }
    
    func addShadowFor(view: UIView, shadowRadius: CGFloat) {
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
    }
    
    func addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: String, bottomLabelTitle: String) {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let viewForLabels = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        titleLabel.frame = CGRect(x: 0, y: -10, width: 250, height: 20)
        
        let bottomLabel = UILabel()
        bottomLabel.text = bottomLabelTitle
        bottomLabel.textColor = .white
        bottomLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        bottomLabel.frame = CGRect(x: 0, y: 3, width: 250, height: 20)
        
        viewForLabels.addSubview(titleLabel)
        viewForLabels.addSubview(bottomLabel)
        
        let viewForLabelsBarButton = UIBarButtonItem(customView: viewForLabels)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, viewForLabelsBarButton], animated: true)
    }
    
    func createTitleInNavigtaionBar(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.leftBarButtonItem = titleLabelBarButton
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        let transition = CATransition()
        
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        navigationController!.view.layer.add(transition, forKey: nil)
        
        navigationController?.popViewController(animated: false)
    }
    
    func getImage(pictureUrl: String?, onCompletion: @escaping (Bool, UIImage?) -> Void) {
        if let urlRequest = pictureUrl {
            Alamofire.request(urlRequest).responseData(completionHandler: { (response) in
                if response.error == nil, let imageData = response.data {
                    let image = UIImage(data: imageData)!
                    onCompletion(true, image)
                } else {
                    onCompletion(false, nil)
                }
            })
        }
    }
}

extension RootViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RootViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
