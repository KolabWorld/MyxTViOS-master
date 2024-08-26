//
//  WalletViewController_API_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import RealmSwift
import Alamofire
import SVProgressHUD

extension WalletViewController {
    
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in

           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
    
    func topTransactionAPI() {
        SVProgressHUD.show()

        var param = [String: String]()
        param[""] =  ""
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.topTransactionsAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: TopTransactionsAPIModel.self) { response in
            
            switch response.result {
                case .success(let post):
                self.objTopTransactionsAPIModel = post
                
                if self.objTopTransactionsAPIModel?.status != 200 {
                    self.showAlert(message: self.objTopTransactionsAPIModel?.errors?.message ?? "something wrong -> topTransactionsAPI", navigate: false)
                } else {
                    self.lblNoTansaction.isHidden = true
                    self.tblWalletTransactions.isHidden = false
                    self.vwAllTransactionToView.isHidden = false
                    if self.objTopTransactionsAPIModel?.data.data.transactions.count == 0 {
                        self.lblNoTansaction.isHidden = false
                        self.tblWalletTransactions.isHidden = true
                        self.vwAllTransactionToView.isHidden = true
                        
                    }
                    self.tblWalletTransactions.reloadData()
                }
                SVProgressHUD.dismiss()

                case .failure(let error):
                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
}
