//
//  HomeViewController.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 03/08/22.
//

import UIKit
import RealmSwift
import SVProgressHUD
import Lottie

class HomeViewController: UIViewController, upcommingEventDelegate {
 
    @IBOutlet weak var tblDashboard: UITableView!
    var realm : Realm!
    var aryHeaders = [[String: String]]()
    var objDashboardAPIModel : DashboardAPIModel?
    var objWatchTimeData : WatchTimeAPIModel?
    @IBOutlet weak var animationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarItem.selectedImage = UIImage(systemName: "home")
      //  self.tabBarItem.selectedImage = UIImage(named: "shopSelected")!
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(iOSAppLogsDataUpdate),
            name: NSNotification.Name(rawValue: "iOSAppLogsData") ,
            object: nil)
        
        self.tblDashboard.rowHeight = UITableView.automaticDimension
        self.tblDashboard.estimatedRowHeight = 100
        
        addCellsInTableView()
        SVProgressHUD.show()

        watchTimeDataAPI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = tblDashboard.cellForRow(at: indexPath) as? DashboardProfileCell {
            cell.displayProfileData()
        }
    }
    
    func animateLotte(objEvent: Event) {
        animationView.isHidden = false
        // 1. Set animation content mode
         animationView.contentMode = .scaleAspectFit
         // 2. Set animation loop mode
         animationView.loopMode = .playOnce
         // 3. Adjust animation speed
        animationView.animationSpeed = 1.0
         // 4. Play animation
       //  animationView.play()
        
        animationView.play { (finished) in
            self.animationView.isHidden = true
        
            let storyboard = UIStoryboard(name: "Events", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "EventJoinViewController") as! EventJoinViewController
            destinationVC.objEventHome = objEvent
            self.navigationController?.pushViewController(destinationVC, animated: true)

        }
    }
    
    func addCellsInTableView() {
        tblDashboard.register(UINib(nibName: "DashboardChallengeCell", bundle: nil), forCellReuseIdentifier: "DashboardChallengeCell")
        tblDashboard.register(UINib(nibName: "SponsoredCell", bundle: nil), forCellReuseIdentifier: "SponsoredCell")
        tblDashboard.register(UINib(nibName: "FeaturedProductCell", bundle: nil), forCellReuseIdentifier: "FeaturedProductCell")
        tblDashboard.register(UINib(nibName: "UpcommingEventCell", bundle: nil), forCellReuseIdentifier: "UpcommingEventCell")
        tblDashboard.register(UINib(nibName: "BlankCell", bundle: nil), forCellReuseIdentifier: "BlankCell")
        
    }
}

extension HomeViewController {
    
    func openEvent(eventId: String) {
        let storyboard = UIStoryboard(name: "Events", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
        destinationVC.offerId = eventId
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func iOSAppLogsDataUpdate() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = tblDashboard.cellForRow(at: indexPath) as? DashboardProfileCell {
            cell.displayProfileData()
        }
    }
    
    @objc func actionInsight() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "InsightViewController") as! InsightViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func joinEventClicked(objEvent: Event) {
        eventJoinAPI(objEvent: objEvent)
    }
    
    @objc func openIntroScreens() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
        destinationVC.FromDashboard = true
            self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func actionWallet() {
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true

        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func actionProfile() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func startTimer() {
        
        let storyboard = UIStoryboard(name: "Events", bundle: nil)
        let eventViewController = storyboard.instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController
       
        eventViewController?.isForTwitch = true
        eventViewController?.isTwitchBack = true
        self.navigationController?.pushViewController(eventViewController!, animated: true)
        
//        UserDefaults.standard.setValue(true, forKey: "TimerRunning")
//
//        self.realm = try! Realm()
//
//        // Create a new drink
//        let appStateDate = ApplicationLogsData()
//        appStateDate.stateName = "Timer Started"
//        appStateDate.timeStamp = Date().millisecondsSince1970
//
//        // Open the default realm.
//        try! self.realm.write {
//            // Add the drink to the realm
//            self.realm.add(appStateDate)
//            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                scene.updateDataOnServer()
//
//                scene.timerStart()
//            }
//        }
    }
    
    
    func openWebLink(urlString: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        destinationVC.urlLink = urlString
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
}


