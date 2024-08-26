//
//  FirstNameViewController.swift
//  WXRKSTUDY
//
//  Created by KaramjeetSingh on 01/08/22.
//

import UIKit
import RealmSwift
import SVProgressHUD
import Alamofire
import SwiftyJSON

class FirstNameViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    var objProfileAPIModel : ProfileAPIModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionNext(_ sender: Any) {
        
        if txtName.text!.count > 0 {
            updateProfile()
        } else {
            showAlert(message: "Please enter name", navigate: false)
        }
    }

}
extension FirstNameViewController {
    
    
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
        parameterDict.setValue(txtName.text, forKey: "name")
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
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.profileImageURL ?? "", forKey: "profilePic")
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.mobile ?? "", forKey: "mobile")
                            UserDefaults.standard.set( self.objProfileAPIModel?.data.data.user.email ?? "", forKey: "userEmail")
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let destinationVC = storyboard.instantiateViewController(withIdentifier: "IntroViewController")
                            self.navigationController?.pushViewController(destinationVC, animated: true)
                        }
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
