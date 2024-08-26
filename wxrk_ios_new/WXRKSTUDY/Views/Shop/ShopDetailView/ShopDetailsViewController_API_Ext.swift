//
//  ShopDetailsViewController_API_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import SVProgressHUD
import Alamofire
import SwiftyJSON
import RealmSwift

extension ShopDetailsViewController {
    //OfferDetailsAPIModel
    
    func ShopDataAPI(offerId: String) {
        SVProgressHUD.show()

        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request("\(WxrsStudyAPI.baseUrl)offer/\(offerId)/view", method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: OfferDetailsAPIModel.self) { response in
            print(response.request as Any)
            print(response)
            switch response.result {
                case .success(let post):
                SVProgressHUD.dismiss()
                self.objOfferDetailsAPIModel = post
                let json1 = JSON(response.result)
                print(json1)
        
               // return .success(result)
                // Decode
//                let jsonDecoder = JSONDecoder()
//                let secondJson = try jsonDecoder.decode(objOfferDetailsAPIModel.self, from: post)
//                print(secondJson)
                if self.objOfferDetailsAPIModel?.status != 200 {
                    self.showAlert(message: self.objOfferDetailsAPIModel?.errors?.message ?? "something wrong -> offer/\(offerId)/view", navigate: false)
                } else {
                    let actualWxrkBalanceValue = UserDefaults.standard.value(forKey: "actualWxrkBalanceValue") as? String
                    self.realm = try! Realm()
                    //  let obj = self.realm.objects(IOSLogAPIData.self)
                    self.lblBuyNowPrice.text = self.objOfferDetailsAPIModel?.data?.data?.offer?.offerPriceInWxrk
                    
//                    if self.objOfferDetailsAPIModel?.data?.data?.offer?.alreadyJoined == 1 {
//                        self.lblBuyNowText.text = "MAXED"
//
//                    }
                    
                    
                    
                    if (Double(actualWxrkBalanceValue!) ?? 000 < Double((self.objOfferDetailsAPIModel?.data?.data?.offer?.offerPriceInWxrk ?? "0.0")) ?? 000) && self.objOfferDetailsAPIModel?.data?.data?.offer?.alreadyJoined == 0 {
                        self.vwBuyNow.backgroundColor = UIColor.init(red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1)
                        self.lblBuyNowText.textColor =  UIColor.init(red: 132.0/255.0, green: 132.0/255.0, blue: 132.0/255.0, alpha: 1)
                        self.lblBuyNowPrice.text = self.objOfferDetailsAPIModel?.data?.data?.offer?.offerPriceInWxrk
                        self.vwOfferPrice.backgroundColor = UIColor.init(red: 227.0/255.0, green: 89.0/255.0, blue: 89.0/255.0, alpha: 1)
                        self.btnBuyNow.isUserInteractionEnabled = false
                        self.lblBuyNowText.text = "Low Balance"
                    }
                    
                    
                    
                    
                    self.tblDetails.reloadData()
                }
                SVProgressHUD.dismiss()

                break
              

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
    
    func buyOffer(offer_Id: String){
        SVProgressHUD.show()

        realm = try! Realm()
        var param = [String: String]()
        param["user_id"] =  UserDefaults.standard.value(forKey: "user_id") as? String
        param["offer_id"] =  offer_Id
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        print(param)
        
        AF.request(WxrsStudyAPI.buyOfferAPI, method: .post, parameters: param, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: BuyNowOfferAPIModel.self) { response in
            
            print("BuyNow-- \(response)")
            switch response.result {
                case .success(let post):
                self.objBuyNowOfferAPIModel = post
                self.watchTimeDataAPI()
                let json1 = JSON(response.result)
                print(json1.self)
                if self.objBuyNowOfferAPIModel?.status != 200 {
                    self.showAlert(message: self.objBuyNowOfferAPIModel?.errors?.message ?? "something wrong -> buyOfferAPI", navigate: false)
                } else {
                    self.ShopDataAPI(offerId: self.offerId)
                    self.animateLotte()
                }
                
                SVProgressHUD.dismiss()
                case .failure(let error):
                
                let customError = error.underlyingError as? CustomErrorType
                SVProgressHUD.dismiss()
                let json = JSON(response.result)
                self.showAlert(message: json["error"]["message"].stringValue, navigate: false)
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
                
               
                    self.objWatchTimeData = post
                    
                    
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.todayWatchTime, forKey: "WatchTimeValue")
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.todayWxrkBalance, forKey: "WxrkBalanceValue")
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.actualWxrkBalance, forKey: "actualWxrkBalanceValue")
            
                SVProgressHUD.dismiss()


            case .failure(let error):
                SVProgressHUD.dismiss()

                    print("Failed with error: \(error)")
                }
        }
    }
    
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
//               if navigate == true {
//
//                   UserDefaults.standard.set(1, forKey: "isUserVerified")
//
//                   if self!.objVerifyOtpAPIModel?.data.data.user.isNewUser == "1" {
//                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                           let destinationVC = storyboard.instantiateViewController(withIdentifier: "FirstNameViewController")
//                       self?.navigationController?.pushViewController(destinationVC, animated: true)
//                   } else {
//                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                           let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//                       self?.navigationController?.pushViewController(destinationVC, animated: true)
//                   }
//               }
           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
}
