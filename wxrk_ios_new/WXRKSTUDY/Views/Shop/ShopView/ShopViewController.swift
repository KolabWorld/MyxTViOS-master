//
//  ShopViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 18/08/22.
//

import UIKit

class ShopViewController: UIViewController {
    @IBOutlet weak var lblNoRecodFound: UILabel!

    @IBOutlet weak var tblShop: UITableView!
    @IBOutlet weak var colShopCategory: UICollectionView!
    @IBOutlet weak var lblBalanceAmount: UILabel!
    var objOfferCategoriesAPIModel : OfferCategoriesAPIModel?
    var objShopOffersAPIModel : ShopOffersAPIModel?
    var arySelectedCategoryId : [String]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arySelectedCategoryId = []
        self.lblNoRecodFound.isHidden = true
        // Do any additional setup after loading the view.
        self.tblShop.rowHeight = UITableView.automaticDimension
        self.tblShop.estimatedRowHeight = 100
        addCellsInTableView()
        watchTimeDataAPI()
        ShopCategoryAPI()
        
        lblBalanceAmount.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalanceAmount.text = balance as? String
        }

    }
    
    func addCellsInTableView() {
        tblShop.register(UINib(nibName: "FeaturedProductCell", bundle: nil), forCellReuseIdentifier: "FeaturedProductCell")
        tblShop.register(UINib(nibName: "BlankCell", bundle: nil), forCellReuseIdentifier: "BlankCell")

        
    }
    
    @IBAction func actionWallet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true

        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}







