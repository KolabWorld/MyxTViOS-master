//
//  HomeViewController_API_xt.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 26/10/22.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON

extension HomeViewController {
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in

           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
    
    func watchTimeDataAPI() {

        var param = [String: String]()
        param[""] =  ""
        print(UserDefaults.standard.value(forKey: "user_token") as? String ?? "")
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.watchTimeAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: WatchTimeAPIModel.self) { response in
            
            switch response.result {
                case .success(let post):
                let json = JSON(response.data)
                print(json)
                
               
                    self.objWatchTimeData = post
                    
                    
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.todayWatchTime, forKey: "WatchTimeValue")
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.todayWxrkBalance, forKey: "WxrkBalanceValue")
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.actualWxrkBalance, forKey: "actualWxrkBalanceValue")
                    self.dashboardDataAPI()
            


            case .failure(let error):
                self.dashboardDataAPI()

                    print("Failed with error: \(error)")
                }
        }
    }
    
    
    func dashboardDataAPI() {
        SVProgressHUD.show()

        var param = [String: String]()
        param[""] =  ""
        print(UserDefaults.standard.value(forKey: "user_token") as? String ?? "")
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.dashboardAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: DashboardAPIModel.self) { response in
          
            switch response.result {
                case .success(let post):
                let json = JSON(response.data)
                print(json)
                self.objDashboardAPIModel = post

                if self.objDashboardAPIModel?.status != 200 {
                    self.showAlert(message: self.objDashboardAPIModel?.errors?.message ?? "something wrong -> dashboardAPI", navigate: false)
                    SVProgressHUD.dismiss()

                } else {
                    
                    if let profilePic = self.objDashboardAPIModel?.data.data.user.profilePic {
                        UserDefaults.standard.setValue( profilePic , forKey: "profilePic")

                    }
                    
                    if self.objDashboardAPIModel?.data.data.user.status != "active" {
                       
                        if let appDomain = Bundle.main.bundleIdentifier {
                            UserDefaults.standard.removePersistentDomain(forName: appDomain)
                        }
                        SVProgressHUD.dismiss()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SplashVideoViewController") as! SplashVideoViewController
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    }
                    
                    self.updateTheDataToDisplay()
                    SVProgressHUD.dismiss()

                }

            case .failure(let error):
                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
    func updateTheDataToDisplay() {
        aryHeaders.removeAll()
        aryHeaders = [
            ["title" : "", "subTitle" : ""],
                      ["title" : "", "subTitle" : ""],
                      ["title" : "", "subTitle" : ""],
                      ["title" : "LAST 7 DAYS", "subTitle" : ""],
                      ["title" : "DAILY REWARDS", "subTitle" : ""],
                      ["title" : "LATEST OFFERS", "subTitle": ""]]
        
        aryHeaders.append(["title" : "UPCOMING EVENTS" , "subTitle" : "RSVP events"])
        aryHeaders.append(["title" : "" , "subTitle" : ""])

        self.tblDashboard.reloadData()
        SVProgressHUD.dismiss()
    }
    
    func eventJoinAPI(objEvent: Event) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        var param = [String: String]()
        param["user_id"] =  (UserDefaults.standard.value(forKey: "user_id") as! String)
        param["event_id"] =  "\(objEvent.id)"
        let url = URL(string: WxrsStudyAPI.joinEventAPI)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: param, options: [])
        request.headers = headers
        
        
        AF.request(request).response { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.value!)
                
                var message = json["data"]["message"].stringValue
                if message.count == 0 {
                    
                    message = json["errors"]["message"].stringValue
                    let ac = UIAlertController(title: "", message: message , preferredStyle: .alert)


                   
                       let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
                               let storyboard = UIStoryboard(name: "Events", bundle: nil)
                               let destinationVC = storyboard.instantiateViewController(withIdentifier: "EventJoinViewController") as! EventJoinViewController
                               destinationVC.objEventHome = objEvent
                               self?.navigationController?.pushViewController(destinationVC, animated: true)

                       }
                       ac.addAction(submitAction)
                    self.present(ac, animated: true)
                } else {
                    self.animateLotte(objEvent: objEvent)
                }
                
               
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
