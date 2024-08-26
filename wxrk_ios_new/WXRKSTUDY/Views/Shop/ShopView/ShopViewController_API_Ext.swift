//
//  ShopViewController_API_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import Alamofire
import SVProgressHUD


extension ShopViewController {
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in

           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
    
    func ShopDataAPI() {
        SVProgressHUD.show()

        var param = [String: [String]]()
        param["offer_category_ids"] =  self.arySelectedCategoryId
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.offerListAPI, method: .get, parameters: param, encoding:  URLEncoding.default ,headers: headers).responseDecodable(of: ShopOffersAPIModel.self) { response in
            print(response)
            switch response.result {
                case .success(let post):
                self.objShopOffersAPIModel = post
                print(post.data)
                SVProgressHUD.dismiss()
                if self.objShopOffersAPIModel?.status != 200 {
                    self.showAlert(message: self.objShopOffersAPIModel?.errors?.message ?? "something wrong -> offerListAPI", navigate: false)
                } else {
                    self.tblShop.reloadData()
                }
                self.lblNoRecodFound.isHidden = true

                if self.objShopOffersAPIModel?.data.data.offers.count == 0 {
                    self.lblNoRecodFound.isHidden = false
                }
                
                SVProgressHUD.dismiss()


                case .failure(let error):
                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
    
    func watchTimeDataAPI() {
        SVProgressHUD.show()

        var param = [String: String]()
        param[""] =  ""
        print(UserDefaults.standard.value(forKey: "user_token") as? String ?? "")
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.watchTimeAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: WatchTimeAPIModel.self) { response in
            
            switch response.result {
                case .success(let post):
                
                let objWatchTimeData : WatchTimeAPIModel?
                objWatchTimeData = post
                SVProgressHUD.dismiss()
              
                    
                    UserDefaults.standard.setValue(objWatchTimeData?.data.data.todayWatchTime, forKey: "WatchTimeValue")
                    UserDefaults.standard.setValue(objWatchTimeData?.data.data.todayWxrkBalance, forKey: "WxrkBalanceValue")
                    UserDefaults.standard.setValue(objWatchTimeData?.data.data.actualWxrkBalance, forKey: "actualWxrkBalanceValue")
                
                SVProgressHUD.dismiss()

            case .failure(let error):
                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
    
    func ShopCategoryAPI() {
        SVProgressHUD.show()

        var param = [String: String]()
        param[""] =  ""
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.offerCategoriesAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: OfferCategoriesAPIModel.self) { response in
            
            switch response.result {
                case .success(let post):
                self.objOfferCategoriesAPIModel = post
                if self.objOfferCategoriesAPIModel?.status != 200 {
                    self.showAlert(message: self.objOfferCategoriesAPIModel?.errors?.message ?? "something wrong -> offerCategoriesAPI", navigate: false)
                } else {
                    self.arySelectedCategoryId?.removeAll()
                    self.arySelectedCategoryId?.append("\(self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?[0].id ?? -1 )")
                    
                    self.ShopDataAPI()
                    self.colShopCategory.reloadData()
                    
                }
                SVProgressHUD.dismiss()

                case .failure(let error):
                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
}
