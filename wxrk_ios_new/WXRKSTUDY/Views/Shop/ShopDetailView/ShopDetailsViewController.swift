//
//  ShopDetailsViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 19/08/22.
//

import UIKit
import RealmSwift
import Lottie


class ShopDetailsViewController: UIViewController {
    var objOfferDetailsAPIModel : OfferDetailsAPIModel?
    var objBuyNowOfferAPIModel : BuyNowOfferAPIModel?
    var objWatchTimeData : WatchTimeAPIModel?

    @IBOutlet weak var tblDetails: UITableView!
    @IBOutlet weak var lblBuyNowPrice: UILabel!
    @IBOutlet weak var lblBuyNowText: UILabel!

    var realm : Realm!
    @IBOutlet weak var vwBuyNow: UIView!
    @IBOutlet weak var btnBuyNow: UIButton!
    
    @IBOutlet weak var vwOfferPrice: UIView!
    @IBOutlet weak var animationView: LottieAnimationView!

    var offerId = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblDetails.rowHeight = UITableView.automaticDimension
        self.tblDetails.estimatedRowHeight = 100
        tblDetails.register(UINib(nibName: "BlankCell", bundle: nil), forCellReuseIdentifier: "BlankCell")

        self.ShopDataAPI(offerId: offerId)
        
    }
    func animateLotte() {
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
        
            let storyboard = UIStoryboard(name: "Shop", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "OfferRedeemViewController") as! OfferRedeemViewController
            destinationVC.objBuyNowOfferAPIModel = self.objBuyNowOfferAPIModel
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

    @IBAction func actionBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBuyNow(sender: UIButton) {
        self.buyOffer(offer_Id: offerId)
    }
    @objc func actionWallet() {


        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true

        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}


