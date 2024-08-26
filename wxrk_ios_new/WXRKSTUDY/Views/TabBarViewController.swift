//
//  TabBarViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 20/08/22.
//

import UIKit
//import PTCardTabBar

class TabBarViewController:  UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var homeTabImg: UIImageView!
    @IBOutlet weak var homeTabBottomImg: UIImageView!

    @IBOutlet weak var shopTabImg: UIImageView!
    @IBOutlet weak var shopTabBottomImg: UIImageView!
    
    @IBOutlet weak var eventTabImg: UIImageView!
    @IBOutlet weak var eventTabBottomImg: UIImageView!

    @IBOutlet weak var walletTabImg: UIImageView!
    @IBOutlet weak var walletTabBottomImg: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNonSelected()
        setupHomeTab()
    }
    
    
    func setupDefaultNonSelected() {
        homeTabImg.image = UIImage(named: "home")
        homeTabBottomImg.isHidden = true
        
        shopTabImg.image = UIImage(named: "shop")
        shopTabBottomImg.isHidden = true
        
        eventTabImg.image = UIImage(named: "events")
        eventTabBottomImg.isHidden = true
        
        walletTabImg.image = UIImage(named: "twitch")
        walletTabBottomImg.isHidden = true
        
    }
    
    func setupHomeTab() {
        homeTabImg.image = UIImage(named: "homeSelected")
        homeTabBottomImg.isHidden = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        addChild(homeViewController)
        containerView?.addSubview(homeViewController.view)
        homeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        homeViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        homeViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        homeViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        homeViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor ).isActive = true
    }
    
    
    func setupShopTab() {
        shopTabImg.image = UIImage(named: "shopSelected")
        shopTabBottomImg.isHidden = false
        
        let storyboard = UIStoryboard(name: "Shop", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "ShopViewController")
        addChild(homeViewController)
        containerView?.addSubview(homeViewController.view)
        homeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        homeViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        homeViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        homeViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        homeViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor ).isActive = true
    }
    
    
    func setupEventTab() {
        eventTabImg.image = UIImage(named: "eventsSelected")
        eventTabBottomImg.isHidden = false
        
        let storyboard = UIStoryboard(name: "Events", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        homeViewController.isForTwitch = false
        addChild(homeViewController)
        containerView?.addSubview(homeViewController.view)
        homeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        homeViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        homeViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        homeViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        homeViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor ).isActive = true
    }
    
    
    func setupTwitchTab() {
        walletTabImg.image = UIImage(named: "twitchSelected")
        walletTabBottomImg.isHidden = false
        
        let storyboard = UIStoryboard(name: "Events", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        homeViewController.isForTwitch = true
        homeViewController.isTwitchBack = false
        addChild(homeViewController)
        containerView?.addSubview(homeViewController.view)
        homeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        homeViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        homeViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        homeViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        homeViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor ).isActive = true
    }
    
    @IBAction func actionTabBarItem(_ sender: UIButton) {
        
        setupDefaultNonSelected()
        switch sender.tag {
        case 100:
            self.setupHomeTab()
        case 101:
            self.setupTwitchTab()
        case 102:
            self.setupShopTab()
        case 103:
            self.setupEventTab()
        default:
            self.setupHomeTab()
        }
    }
}

