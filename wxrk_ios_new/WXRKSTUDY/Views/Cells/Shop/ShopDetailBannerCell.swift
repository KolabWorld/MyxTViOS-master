//
//  ShopDetailBannerCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 19/08/22.
//

import UIKit
import RealmSwift

class ShopDetailBannerCell: UITableViewCell {
    var realm : Realm!

    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblOfferPrice: UILabel!
    @IBOutlet weak var btnWallet: UIButton!

    @IBOutlet weak var lblOfferName: UILabel!
    @IBOutlet weak var lblStockLeft: UILabel!
    @IBOutlet weak var lblExpire: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var vwOfferPrice: UIView!
    
    @IBOutlet weak var lblBy: UILabel!
    var expireTimer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionWallet(_ sender: Any)
    {
        
    }
    func displayOffers(objOfferDetailsAPIModel : OfferDetailsAPIModel) {
        
        lblBy.text = "by \(objOfferDetailsAPIModel.data?.data?.offer?.companyName ?? "")"
        lblOfferName.text = objOfferDetailsAPIModel.data?.data?.offer?.offerName
        lblOfferPrice.text = objOfferDetailsAPIModel.data?.data?.offer?.offerPriceInWxrk
        lblStockLeft.text = "Only \(objOfferDetailsAPIModel.data?.data?.offer?.stock ?? "") in stock"
      
        realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        
        let stockV:Int? = Int (objOfferDetailsAPIModel.data?.data?.offer?.stock ??  "" )
        if (stockV ?? -1) >= Int(objOfferDetailsAPIModel.data?.data?.offer?.stock ?? "") ?? 0 {
            lblStockLeft.text = "Only \(objOfferDetailsAPIModel.data?.data?.offer?.stock ?? "") left"
        }
      //  lblExpire.text = "Expires in \(objOfferDetailsAPIModel.data?.data?.offer?.remainingDays ?? "")"
        
        timerStart(expiredate: objOfferDetailsAPIModel.data?.data?.offer?.offerEndDate?.returnDateWithTime() ?? Date(), isEvent: false)

        var addBanner = [ShopBannerView]()
        for obj in objOfferDetailsAPIModel.data?.data?.offer?.banner  ?? [] {
            let page1 = ShopBannerView.loadFromXib() as! ShopBannerView
            
            page1.videoPlayer.isHidden = true
            page1.imgBanner.kf.setImage(with: URL(string: obj.fullURL ?? ""))
            addBanner.append(page1)            
        }
        setupBanner(pages: addBanner)
        
    }
    
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    func timerStart(expiredate: Date, isEvent : Bool) {
        
        if isEvent == false {
            expireTimer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                let difference = expiredate.timeIntervalSince(Date()) //(expiredate - Date())
                if difference.asDays() > 1 {
                    self.lblExpire.text = "Expires in \(Int(difference.asDays())) days "
                    self.expireTimer?.invalidate()
                } else {
                    
                    self.hmsFrom(seconds: Int(difference)) { hours, minutes, seconds in
                        let hoursV = self.getStringFrom(seconds: hours)
                        let minutesV = self.getStringFrom(seconds: minutes)
                        let secondsV = self.getStringFrom(seconds: seconds)
                        self.lblExpire.text = "Expires in \(hoursV):\(minutesV):\(secondsV) "
                    }
                }
            }
        } else {
            expireTimer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                
                
                self.lblExpire.text = "\(expiredate.offsetFrom(date: Date())) Left"
                
//                let difference = expiredate.timeIntervalSince(Date()) //(expiredate - Date())
//                if difference.asDays() > 1 {
//                    self.lblExpire.text = "Expires in \(Int(difference.asDays())) days "
//                    self.hmsFrom(seconds: Int(difference)) { hours, minutes, seconds in
//                        let hoursV = self.getStringFrom(seconds: hours)
//                        let minutesV = self.getStringFrom(seconds: minutes)
//                        let secondsV = self.getStringFrom(seconds: seconds)
//                        self.lblExpire.text = "\(Int(difference.asDays())) \(hoursV):\(minutesV):\(secondsV) Left"
//                    }
//
//                } else {
//
//
//                }
            }
        }
        
    }
    
    func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
            completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func displayEventDetails(objEventDetailsAPIModel : EventDetailsAPIModel) {
        
        lblOfferName.text = objEventDetailsAPIModel.data.data.event.eventDescription
        lblBy.text = objEventDetailsAPIModel.data.data.event.companyName ?? ""
        vwOfferPrice.isHidden = true
        lblStockLeft.text = "\(objEventDetailsAPIModel.data.data.event.totalMembers) signups"
      
        realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
      //  lblExpire.text = "\(objEventDetailsAPIModel.data.data.event.remainingTime ?? "") left"
        timerStart(expiredate: objEventDetailsAPIModel.data.data.event.endDateTime?.returnDate() ?? Date(), isEvent: true)

        
        var addBanner = [ShopBannerView]()
        for obj in objEventDetailsAPIModel.data.data.event.banner {
            let page1 = ShopBannerView.loadFromXib() as! ShopBannerView
            page1.videoPlayer.isHidden = true
            page1.imgBanner.kf.setImage(with: URL(string: obj.fullURL ?? ""))
            addBanner.append(page1)
        }
        setupBanner(pages: addBanner)
        
    }
    
    
    func setupBanner(pages : [ShopBannerView] ) {
        setupScrollView(pages: pages)
        pageController.numberOfPages = pages.count
        pageController.currentPage = 0
    }

    func setupScrollView(pages: [ShopBannerView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 336.5)
        scrollView.contentSize = CGSize(width: contentView.frame.size.width * CGFloat(pages.count), height: 336.5)
        scrollView.isPagingEnabled = true
        for i in 0..<pages.count {
            pages[i].frame = CGRect(x: contentView.frame.size.width * CGFloat(i), y: 0, width: contentView.frame.size.width, height: 336.5)
            scrollView.addSubview(pages[i])
        }
    }
    
}
extension ShopDetailBannerCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/contentView.frame.width)
        pageController.currentPage = Int(pageIndex)
    }
    


}


extension TimeInterval {
    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
    
    
//    print(difference, "seconds")
//    print(difference.asMinutes(), "minutes")
//    print(difference.asHours(), "hours")
//    print(difference.asDays(), "days")
//    print(difference.asWeeks(), "weeks")
//    print(difference.asMonths(), "months")
//    print(difference.asYears(), "years")
    
    
    
}
