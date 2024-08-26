//
//  OfferRedeemViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 23/08/22.
//

import UIKit
import RealmSwift

class OfferRedeemViewController: UIViewController {
    var realm : Realm!
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var vwLowStock: UIView!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblTitile: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblExpireTime: UILabel!
    @IBOutlet weak var lblRedemCode: UILabel!
    @IBOutlet weak var lblOfferPrice: UILabel!
    
    var objBuyNowOfferAPIModel : BuyNowOfferAPIModel?
    
    var expireydate = Date()
    var expireTimer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        imgBanner.kf.setImage(with: URL(string: objBuyNowOfferAPIModel?.data?.promoCode.offer.thumbnailImage
                                        ?? ""))
        lblTitile.text = objBuyNowOfferAPIModel?.data?.promoCode.offer.offerName
        lblSubTitle.text = objBuyNowOfferAPIModel?.data?.promoCode.offer.detailsOfOffer
        
        lblRedemCode.text = objBuyNowOfferAPIModel?.data?.order.offerPromoCode
        
        vwLowStock.isHidden = true
        
        lblOfferPrice.text = objBuyNowOfferAPIModel?.data?.order.offerPrice
        
        
        //        if objBuyNowOfferAPIModel?.data?.promoCode.offer.isLowStock == "1" {
        //            vwLowStock.isHidden = false
        //        }
        
        //        let stockV:Int? = Int (objBuyNowOfferAPIModel?.data?.promoCode.offer.stock ?? "")
        //        if stockV ?? 0 <= Int(objBuyNowOfferAPIModel?.data?.promoCode.offer.lowStock ?? "") ?? 0 {
        //            vwLowStock.isHidden = false
        //        }
        
        
        if objBuyNowOfferAPIModel?.data?.order.remainingHours == "00:00:00" {
            lblExpireTime.text = "00:00:00"
            
        } else {
            expireTime()
        }
    }
    
    func expireTime() {
        
        let hours = Int(objBuyNowOfferAPIModel?.data?.order.remainingHours?.components(separatedBy: ":")[0] ?? "00")
        let minutes =  Int(objBuyNowOfferAPIModel?.data?.order.remainingHours?.components(separatedBy: ":")[1] ?? "00")
        let seconds =  Int(objBuyNowOfferAPIModel?.data?.order.remainingHours?.components(separatedBy: ":")[2] ?? "00")
        
        var totalSeconds : Int = 0
        totalSeconds = totalSeconds + (hours! * 3600)
        totalSeconds = totalSeconds + (minutes! * 60)
        totalSeconds = totalSeconds + seconds!
        
        let calendar = Calendar.current
        expireydate = calendar.date(byAdding: .second, value: Int(totalSeconds), to: Date())!
        timerStart(expiredate: expireydate)
    }
    
    func timerStart(expiredate: Date) {
        
        expireTimer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            let secondsV = expiredate.seconds(from: Date())
            self.hmsFrom(seconds: secondsV) { hours, minutes, seconds in
                let hoursV = self.getStringFrom(seconds: hours)
                let minutesV = self.getStringFrom(seconds: minutes)
                let secondsV = self.getStringFrom(seconds: seconds)
                self.lblExpireTime.text = " \(hoursV):\(minutesV):\(secondsV) "
                let expiretime = "\(hoursV):\(minutesV):\(secondsV)"
                if  expiretime == "00:00:00"{
                    print("Time invalidate")
                    self.expireTimer?.invalidate()
                }else{
                    
                }
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
    @IBAction func actionWallet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    @IBAction func actionBuyNow(_ sender: Any) {
        
        if objBuyNowOfferAPIModel!.data?.order.link?.count == 0 {
            showAlert(message: "Not a valid link", navigate: false)
            return
        }
        let pasteboard = UIPasteboard.general
        pasteboard.string = lblRedemCode.text ?? ""
        
        
        let ac = UIAlertController(title: "", message: "Coupon code copied successfully. Please click on \"OK\" to visit the offer page. ", preferredStyle: .alert)
        
        
        let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
            destinationVC.urlLink = self?.objBuyNowOfferAPIModel!.data?.order.link ?? ""
            destinationVC.isRedeemed = false
            self?.navigationController?.pushViewController(destinationVC, animated: true)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionCopyCode(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = lblRedemCode.text ?? ""
        
        
        let ac = UIAlertController(title: "", message: "copied to your clipboard", preferredStyle: .alert)
        
        
        //           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
        //               let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //               let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        //               destinationVC.urlLink = self?.objBuyNowOfferAPIModel!.data?.order.link ?? ""
        //               destinationVC.isRedeemed = false
        //               self?.navigationController?.pushViewController(destinationVC, animated: true)
        //           }
        //  ac.addAction(submitAction)
        present(ac, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            ac.dismiss(animated: true, completion: nil)
        })
        
    }
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        
        let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

