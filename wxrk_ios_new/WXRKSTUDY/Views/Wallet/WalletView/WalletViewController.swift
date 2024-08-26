//
//  WalletViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 25/08/22.
//

import UIKit
import RealmSwift


class WalletViewController: UIViewController {
    var realm : Realm!
    @IBOutlet weak var lblNoTansaction: UILabel!
    @IBOutlet weak var vwAllTransactionToView: UIView!

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var tblWalletTransactions: UITableView!
    var objTopTransactionsAPIModel : TopTransactionsAPIModel?
    @IBOutlet weak var bottomViewConstrants: NSLayoutConstraint!
    var notFromTabbar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblNoTansaction.isHidden = true
        self.tblWalletTransactions.isHidden = false
        self.vwAllTransactionToView.isHidden = false
        
        topTransactionAPI()
        realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        
        if notFromTabbar == false {
            bottomViewConstrants.isActive = true
            bottomViewConstrants.constant = 130
            self.btnBack.isHidden = true
        }
        
        
    }
    

    // MARK: - Action
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionHowToEarn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
        destinationVC.FromDashboard = true
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func actionAllTransactions(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "AllTransactionViewController") as! AllTransactionViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


