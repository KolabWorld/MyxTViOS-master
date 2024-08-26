//
//  EventDetailsViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 29/08/22.
//

import UIKit
import SVProgressHUD
import Alamofire
import RealmSwift
import SwiftyJSON
import Lottie

class EventDetailsViewController: UIViewController, UICollectionViewDelegate {
    var objEventDetailsAPIModel : EventDetailsAPIModel?
    var objBuyNowOfferAPIModel : BuyNowOfferAPIModel?
    
    var objTwitchData : TwitchVideo?
    
    @IBOutlet weak var tblDetails: UITableView!
    @IBOutlet weak var lblJoinNowMember: UILabel!
    @IBOutlet weak var lblBuyNowText: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    var realm : Realm!
    @IBOutlet weak var vwBuyNow: UIView!
    @IBOutlet weak var btnBuyNow: UIButton!
    
    @IBOutlet weak var vwOfferPrice: UIView!
    
    var offerId = ""
    var objTwitchVideoData : TwitchVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tblDetails.rowHeight = UITableView.automaticDimension
        self.tblDetails.estimatedRowHeight = 100
        
        if objTwitchVideoData != nil {
            
        } else {
            self.eventDetails(offerId: offerId)
        }
        tblDetails.register(UINib(nibName: "BlankCell", bundle: nil), forCellReuseIdentifier: "BlankCell")
        
    }
    
    @IBAction func actionBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionJoinNow(sender: UIButton) {
        eventJoin()
    }
    @objc func actionWallet() {
        
        
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

extension EventDetailsViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if objEventDetailsAPIModel?.data.data.event != nil{
            return 6
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailBannerCell") as! ShopDetailBannerCell
            cell.selectionStyle = .none
            cell.displayEventDetails(objEventDetailsAPIModel: objEventDetailsAPIModel!)
            cell.btnWallet.addTarget(self, action: #selector(actionWallet), for: .touchUpInside)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OfferHighlightCell") as! OfferHighlightCell
            cell.selectionStyle = .none
            cell.displayEventHighlightesData(objEventDetailsAPIModel: objEventDetailsAPIModel!)
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventVenueCell") as! EventVenueCell
            cell.selectionStyle = .none
            cell.displayVenueInfo(objEventDetailsAPIModel: objEventDetailsAPIModel!)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCompanyCell") as! AboutCompanyCell
            cell.selectionStyle = .none
            cell.displayEventCompanyData(objEventDetailsAPIModel: objEventDetailsAPIModel!)
            cell.btnVisitWebsite.addTarget(self, action: #selector(actionVisitWebsite), for: .touchUpInside)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventSponserCell") as! EventSponserCell
            cell.selectionStyle = .none
            cell.ObjSponsors = objEventDetailsAPIModel?.data.data.event.sponser
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionViewSponsers.reloadData()
            cell.collectionViewSponsers.layoutIfNeeded()
            cell.productCollectionViewHeight.constant = cell.collectionViewSponsers.collectionViewLayout.collectionViewContentSize.height
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell") as! BlankCell
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func actionVisitWebsite(button: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        // destinationVC.urlLink = objEventDetailsAPIModel!.data.data.event. ?? ""
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    func openWebLink(urlString: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        destinationVC.urlLink = urlString
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
}

extension EventDetailsViewController {
    //OfferDetailsAPIModel
    
    func eventDetails(offerId: String) {
        SVProgressHUD.show()
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        print("\(offerId)")
        AF.request("\(WxrsStudyAPI.baseUrl)event/\(offerId)/view", method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: EventDetailsAPIModel.self) { response in
            switch response.result {
            case .success(let post):
                SVProgressHUD.dismiss()
                self.objEventDetailsAPIModel = post
                
                if self.objEventDetailsAPIModel?.status != 200 {
                    self.showAlert(message: self.objEventDetailsAPIModel?.errors?.message ?? "something wrong -> event/\(offerId)/view", navigate: false, isSuccess: false)
                } else {
                    self.lblJoinNowMember.text = "JOIN \(self.objEventDetailsAPIModel?.data.data.event.totalMembers ?? 0) MEMBERS"
                    self.tblDetails.reloadData()
                }
                SVProgressHUD.dismiss()
                
                
            case .failure(let error):
                
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("Failure Response: \(json)")
                }
                
                
                SVProgressHUD.dismiss()
                print("Failed with error: \(error)")
            }
        }
    }
    
    func eventJoin() {
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        var param = [String: String]()
        param["user_id"] =  (UserDefaults.standard.value(forKey: "user_id") as! String)
        param["event_id"] = "\(self.objEventDetailsAPIModel?.data.data.event.id ?? 0)"
        let url = URL(string: WxrsStudyAPI.joinEventAPI)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: param, options: [])
        request.headers = headers
        
        
        AF.request(request).response { response in
            
            switch response.result {
            case .success:
                self.eventDetails(offerId: self.offerId)
                let json = JSON(response.value!)
                
                var message = json["data"]["message"].stringValue
                if message.count == 0 {
                    message = json["errors"]["message"].stringValue
                    self.showAlert(message: message , navigate: true, isSuccess: false)
                    
                } else {
                    self.showAlert(message: message , navigate: true, isSuccess: true)
                }
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    
    func showAlert(message: String, navigate: Bool, isSuccess: Bool) {
        
        if isSuccess == true {
            
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
                destinationVC.objEvent = self.objEventDetailsAPIModel?.data.data.event
                self.navigationController?.pushViewController(destinationVC, animated: true)
                
            }
            
        } else {
            let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            
            let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
                
                if navigate == true {
                    let storyboard = UIStoryboard(name: "Events", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "EventJoinViewController") as! EventJoinViewController
                    destinationVC.objEvent = self?.objEventDetailsAPIModel?.data.data.event
                    self?.navigationController?.pushViewController(destinationVC, animated: true)
                }
            }
            ac.addAction(submitAction)
            present(ac, animated: true)
        }
    }
    
}

extension EventDetailsViewController: OfferHighlightCellDelegate{
    func linkOpen(openUrl url: String) {
        let url = URL(string: url)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                 print("Open url : \(success)")
            })
        }
    }
    
    
}

