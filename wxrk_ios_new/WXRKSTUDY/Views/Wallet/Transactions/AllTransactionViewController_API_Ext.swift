//
//  AllTransactionViewController_API_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import RealmSwift
import Alamofire
import SVProgressHUD

extension AllTransactionViewController {

    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in

           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
    
    
    
//    func topTransactionAPI(fromDate: String, toDate: String) {
//
//        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
//        var param = [String: String]()
//        param["from_date"] =  fromDate
//        param["to_date"] =  toDate
//
//        let url = URL(string: WxrsStudyAPI.transactionsAPI)
//        var request = URLRequest(url: url!)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
//        request.httpBody = try! JSONSerialization.data(withJSONObject: param, options: [])
//        request.headers = headers
//
//
//        AF.request(request).responseDecodable(of: AllTransactionsAPIModel.self) { response in
//
//            switch response.result {
//                case .success(let post):
//                self.objAllTransactionsAPIModel = post
//
//                if self.objAllTransactionsAPIModel?.status != 200 {
//                    self.showAlert(message: self.objAllTransactionsAPIModel?.errors?.message ?? "something wrong", navigate: false)
//                } else {
//                    self.tblWalletTransactions.reloadData()
//                    //objEvent.startDateTime?.datestringToStringDisplay(style: .long)
//                    self.lblFromDate.text = self.objAllTransactionsAPIModel?.data.data.fromDate.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "MMM yy", style: .long)
//                    self.lblToDate.text = self.objAllTransactionsAPIModel?.data.data.toDate.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "MMM yy", style: .long)
//                }
//
//                SVProgressHUD.dismiss()
//
//                case .failure(let error):
//                SVProgressHUD.dismiss()
//                    print("Failed with error: \(error)")
//                }
//        }
//    }
    
    
    
    func topTransactionAPI(fromDate: String, toDate: String) {
        SVProgressHUD.show()

        var param = [String: String]()
        param["from_date"] =  fromDate
        param["to_date"] =  toDate

        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]

        AF.request("\(WxrsStudyAPI.transactionsAPI)?from_date=\(fromDate)&to_date=\(toDate)", method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: AllTransactionsAPIModel.self) { response in

            switch response.result {
                case .success(let post):
                self.objAllTransactionsAPIModel = post

                if self.objAllTransactionsAPIModel?.status != 200 {
                    self.showAlert(message: self.objAllTransactionsAPIModel?.errors?.message ?? "something wrong -> transactionsAPI", navigate: false)
                } else {
                    self.tblWalletTransactions.reloadData()
                    //objEvent.startDateTime?.datestringToStringDisplay(style: .long)
                    self.lblFromDate.text = self.objAllTransactionsAPIModel?.data.data.fromDate.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "dd MMM yy", style: .long)
                    self.lblToDate.text = self.objAllTransactionsAPIModel?.data.data.toDate.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "dd MMM yy", style: .long)
                }

                SVProgressHUD.dismiss()

                case .failure(let error):
                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
    
    
    
//    func topTransactionAPI(fromDate: String, toDate: String) {
//        let api_url = WxrsStudyAPI.transactionsAPI
//            guard let url = URL(string: api_url) else {
//                return
//            }
//        SVProgressHUD.show()
//            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
//            urlRequest.httpMethod = "GET"
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//            let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
//            urlRequest.headers = headers
//            //Set Your Parameter
//            let parameterDict = NSMutableDictionary()
//            parameterDict.setValue(fromDate, forKey: "from_date")
//            parameterDict.setValue(toDate, forKey: "to_date")
//
//
//        AF.upload(multipartFormData: { multiPart in
//                for (key, value) in parameterDict {
//                    if let temp = value as? String {
//                        multiPart.append(temp.data(using: .utf8)!, withName: key as! String)
//                    }
//                    if let temp = value as? Int {
//                        multiPart.append("\(temp)".data(using: .utf8)!, withName: key as! String)
//                    }
//                    if let temp = value as? NSArray {
//                        temp.forEach({ element in
//                            let keyObj = key as! String + "[]"
//                            if let string = element as? String {
//                                multiPart.append(string.data(using: .utf8)!, withName: keyObj)
//                            } else
//                                if let num = element as? Int {
//                                    let value = "\(num)"
//                                    multiPart.append(value.data(using: .utf8)!, withName: keyObj)
//                            }
//                        })
//                    }
//                }
//
//            }, with: urlRequest)
//                .uploadProgress(queue: .main, closure: { progress in
//                    //Current upload progress of file
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//
//                .responseDecodable(of: AllTransactionsAPIModel.self) { response in
//
//                    switch response.result {
//                        case .success(let post):
//                        self.objAllTransactionsAPIModel = post
//                        self.tblWalletTransactions.reloadData()
//                        //objEvent.startDateTime?.datestringToStringDisplay(style: .long)
//                        self.lblFromDate.text = self.objAllTransactionsAPIModel?.data.data.fromDate.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "MMM yy", style: .long)
//                        self.lblToDate.text = self.objAllTransactionsAPIModel?.data.data.toDate.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "MMM yy", style: .long)
//                        SVProgressHUD.dismiss()
//
//                        case .failure(let error):
//                        SVProgressHUD.dismiss()
//                            print("Failed with error: \(error)")
//                        }
//                }
//    }
    
    
}
