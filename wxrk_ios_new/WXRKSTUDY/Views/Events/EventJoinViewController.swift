//
//  EventJoinViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 29/08/22.
//

import UIKit
import RealmSwift

class EventJoinViewController: UIViewController {
    var realm : Realm!

    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var vwLowStock: UIView!
    @IBOutlet weak var lblEventEndIn: UILabel!

    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblTitile: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblExpireTime: UILabel!
    @IBOutlet weak var lblRedemCode: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!

    var objEvent : EventEventDetails?
    var objEventHome : Event?

    var expireydate = Date()
    var expireTimer: Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateEventList"), object: nil)
        // Do any additional setup after loading the view.
        realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        
        if objEvent != nil {
            imgBanner.kf.setImage(with: URL(string: objEvent!.banner[0].fullURL
                                                      ?? ""))
            lblTitile.text = objEvent!.name
            
            let dateObj = objEvent!.startDateTime?.datestringToStringDisplay(style: .long)
            lblDay.text = dateObj?.components(separatedBy: ",").last
            lblMonth.text = dateObj?.components(separatedBy: ",").first
            
            let dateToShow = objEvent!.startDateTime?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "EE, MMM dd", style: .long)
            
           // expireTime(dateTime: objEvent!.endDateTime!)
            
            let date =   objEvent!.startDateTime!.returnDate()
            self.lblEventEndIn.isHidden = false

            if date < Date() {
                let date1 =   objEvent!.endDateTime!.returnDate()
                timerStart(expiredate: date1)
            } else {
                self.lblEventEndIn.isHidden = true
                self.lblExpireTime.text = "Event has not started yet"
                self.lblExpireTime.font = UIFont(name: "AquawaxPro-Medium", size: 20)
            }

            lblSubTitle.text = "\(dateToShow ?? "") \n \(objEvent!.venue ?? "")"
            
         //   lblRedemCode.text = objBuyNowOfferAPIModel?.data.order.offerPromoCode
            
        //    vwLowStock.isHidden = true
    //        let stockV:Int? = Int (objBuyNowOfferAPIModel?.data.promoCode.offer.stock ?? "")
    //        if stockV ?? 0 <= Int(objBuyNowOfferAPIModel?.data.promoCode.offer.lowStock ?? "") ?? 0 {
    //            vwLowStock.isHidden = false
    //        }
        } else {
            imgBanner.kf.setImage(with: URL(string: objEventHome!.banner[0].fullURL
                                                      ?? ""))
            lblTitile.text = objEventHome!.name
            
            let dateObj = objEventHome!.startDateTime?.datestringToStringDisplay(style: .long)
            lblDay.text = dateObj?.components(separatedBy: ",").last
            lblMonth.text = dateObj?.components(separatedBy: ",").first
            let dateToShow = objEventHome!.startDateTime?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "EE, MMM dd", style: .long)
            
            
            lblSubTitle.text = "\(dateToShow ?? "") \n\(objEventHome!.venue ?? "")"
            
            
            let date =   objEventHome!.startDateTime!.returnDate()
            self.lblEventEndIn.isHidden = false
            if date < Date() {
                let date1 =   objEventHome!.endDateTime!.returnDate()

                timerStart(expiredate: date1)
            } else {
                self.lblEventEndIn.isHidden = true
                self.lblExpireTime.text = ""
            }
            
            
           // expireTime(dateTime: objEventHome!.endDateTime!)

         //   lblRedemCode.text = objBuyNowOfferAPIModel?.data.order.offerPromoCode
            
        //    vwLowStock.isHidden = true
    //        let stockV:Int? = Int (objBuyNowOfferAPIModel?.data.promoCode.offer.stock ?? "")
    //        if stockV ?? 0 <= Int(objBuyNowOfferAPIModel?.data.promoCode.offer.lowStock ?? "") ?? 0 {
    //            vwLowStock.isHidden = false
    //        }
        }
        
       
    }
    
  
    

    func timerStart(expiredate: Date) {
        
        expireTimer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in

            let secondsV = expiredate.seconds(from: Date())
            
            self.hmsFrom(seconds: secondsV) { hours, minutes, seconds in
                let hoursV = self.getStringFrom(seconds: hours)
                let minutesV = self.getStringFrom(seconds: minutes)
                let secondsV = self.getStringFrom(seconds: seconds)
                self.lblExpireTime.text = " \(hoursV):\(minutesV):\(secondsV) "
                
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        expireTimer?.invalidate()

    }
    
    func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
            completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    @IBAction func actionBuyNow(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
//        destinationVC.urlLink = objBuyNowOfferAPIModel!.data.data.event.li ?? ""
//        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionCopyCode(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = lblRedemCode.text ?? ""
    }
}
