//
//  BODViewController.swift
//  WXRKSTUDY
//
//  Created by KaramjeetSingh on 01/08/22.
//

import UIKit
import RealmSwift
import SVProgressHUD
import Alamofire
import SwiftyJSON

class BODViewController: UIViewController {
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var objProfileAPIModel : ProfileAPIModel?

    var userName = ""
    var realm : Realm!
    var DOBForAPI = ""
    // Age of 10.
        let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -10, to: Date())!;
        // Age of 150.
        let MAXIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -150, to: Date())!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.maximumDate = MINIMUM_AGE;
        datePicker.minimumDate = MAXIMUM_AGE;
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.backgroundColor = UIColor(red: 1.0/255.0, green: 16.0/255.0, blue: 39.0/255.0, alpha: 1)

        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        txtDOB.inputView = datePicker
          let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
          let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        txtDOB.inputAccessoryView = toolBar
        txtDOB.becomeFirstResponder()
      }

      @objc func datePickerDone() {
          txtDOB.resignFirstResponder()
      }

      @objc func dateChanged() {
          
          let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd/MM/yyyy"
          
          let dateFormatterAPI = DateFormatter()
          dateFormatterAPI.dateFormat = "yyyy-MM-dd"
          DOBForAPI = dateFormatterAPI.string(from: datePicker.date)
          
          txtDOB.text = dateFormatter.string(from: datePicker.date)
          
      }
    @IBAction func actionNext(_ sender: Any) {
      
        if txtDOB.text!.count > 0 {
            updateProfile()
        } else {
            showAlert(message: "Please enter DOB", navigate: false)
        }
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

extension BODViewController {
    
    
    func updateProfile() {
        SVProgressHUD.show()

        let api_url = WxrsStudyAPI.profileAPI
            guard let url = URL(string: api_url) else {
                return
            }

            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
            urlRequest.headers = headers
            //Set Your Parameter
            let parameterDict = NSMutableDictionary()
        
        
        parameterDict.setValue(UserDefaults.standard.value(forKey: "user_id") ?? "", forKey: "user_id")
        parameterDict.setValue(userName, forKey: "name")
        parameterDict.setValue(DOBForAPI, forKey: "date_of_birth")


           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                for (key, value) in parameterDict {
                    if let temp = value as? String {
                        multiPart.append(temp.data(using: .utf8)!, withName: key as! String)
                    }
                    if let temp = value as? Int {
                        multiPart.append("\(temp)".data(using: .utf8)!, withName: key as! String)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key as! String + "[]"
                            if let string = element as? String {
                                multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                                if let num = element as? Int {
                                    let value = "\(num)"
                                    multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
               // multiPart.append(imgData, withName: "file", fileName: "file.png", mimeType: "image/png")
            }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
        
                .responseDecodable(of: ProfileAPIModel.self) { response in
                    
                    switch response.result {
                        case .success(let post):
                        
                        self.objProfileAPIModel = post

                        if self.objProfileAPIModel?.status != 200 {
                            self.showAlert(message: self.objProfileAPIModel?.errors?.message ?? "something wrong -> profileAPI", navigate: false)
                        } else {
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.name ?? "", forKey: "userName")
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.dateOfBirth ?? "", forKey: "dateOfBirth")
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.profileImageURL ?? "", forKey: "profilePic")
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.mobile ?? "", forKey: "mobile")
                            //                        self.realm = try! Realm()
                            //
                            //                        let objUserDB = self.realm.objects(UserDB.self)
                            //                        try! self.realm.write {
                            //                            objUserDB.first?.name =  self.objProfileAPIModel?.data.data.user.name
                            //                            objUserDB.first?.dateOfBirth =  self.objProfileAPIModel?.data.data.user.dateOfBirth
                            //                            objUserDB.first?.profilePic =  self.objProfileAPIModel?.data.data.user.profileImageURL
                            //                            objUserDB.first?.mobile =  self.objProfileAPIModel?.data.data.user.mobile
                            //                            self.realm.add(objUserDB)
                            //                        }
                            
                            
                            
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let destinationVC = storyboard.instantiateViewController(withIdentifier: "IntroViewController")
                            self.navigationController?.pushViewController(destinationVC, animated: true)
                            SVProgressHUD.dismiss()
                        }
                        SVProgressHUD.dismiss()

                        case .failure(let error):
                        SVProgressHUD.dismiss()
                            print("Failed with error: \(error)")
                        }
                }
    }
    

//    func updateProfile(){
//        SVProgressHUD.show()
//
//        realm = try! Realm()
//        var param = [String: String]()
//        param["user_id"] =  UserDefaults.standard.value(forKey: "user_id") as? String
//        param["name"] =  userName
//        param["date_of_birth"] =  DOBForAPI
//
//        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "token") as? String ?? "")]
//        print(param)
//        AF.request(WxrsStudyAPI.profileAPI, method: .post, parameters: param, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: ProfileAPIModel.self) { response in
//
//            switch response.result {
//                case .success(let post):
//                var objProfileAPIModel : ProfileAPIModel?
//                objProfileAPIModel = post
//                SVProgressHUD.dismiss()
//
//                self.showAlert(message: objProfileAPIModel?.data.message ?? "", navigate: true)
//
//                case .failure(let error):
//                SVProgressHUD.dismiss()
//
//                    print("Failed with error: \(error)")
//                }
//        }
//    }
        
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
               if navigate == true {
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let destinationVC = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController
                   self?.navigationController?.pushViewController(destinationVC!, animated: true)
           }
           }

           ac.addAction(submitAction)
           present(ac, animated: true)
       
    }
}
