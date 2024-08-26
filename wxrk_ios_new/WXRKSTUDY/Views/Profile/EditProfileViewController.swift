//
//  EditProfileViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 26/08/22.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class EditProfileViewController: UIViewController, ImagePickerDelegate {

    @IBOutlet weak var vwDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldPhoneNO: UITextField!
    @IBOutlet weak var txtFldDOB: UITextField!
    var objProfileAPIModel : ProfileAPIModel?
    var imagePicker: ImagePicker!
    var DOBForAPI = ""
    let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -10, to: Date())!;
    // Age of 150.
    let MAXIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -150, to: Date())!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imgProfile.cornerRadius = imgProfile.frame.size.height / 2

        datePicker.maximumDate = MINIMUM_AGE;
        datePicker.minimumDate = MAXIMUM_AGE;
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.backgroundColor = UIColor(red: 1.0/255.0, green: 16.0/255.0, blue: 39.0/255.0, alpha: 1)

        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)

        
        let dobString = UserDefaults.standard.value(forKey: "dateOfBirth") as? String
        txtFldDOB.text =  UserDefaults.standard.value(forKey: "userEmail") as? String //dobString?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "dd MMM yyyy", style: .long)
        DOBForAPI = dobString ?? ""
        txtFldPhoneNO.text = UserDefaults.standard.value(forKey: "mobile") as? String
        txtFldName.text = UserDefaults.standard.value(forKey: "userName") as? String
    
        imgProfile.kf.setImage(with: URL(string: UserDefaults.standard.value(forKey: "profilePic") as? String ?? ""),
                               placeholder: UIImage(named: "user"),
                               options: [.forceRefresh, .cacheOriginalImage],
                               progressBlock: nil,
                               completionHandler: nil)
        
      }

      @objc func datePickerDone() {
          txtFldDOB.resignFirstResponder()
      }

      @objc func dateChanged() {
          
          let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd MMM yyyy"
          
          let dateFormatterAPI = DateFormatter()
          dateFormatterAPI.dateFormat = "yyyy-MM-dd"
          DOBForAPI = dateFormatterAPI.string(from: datePicker.date)
          
          txtFldDOB.text = dateFormatter.string(from: datePicker.date)
          
      }

    func didSelect(image: UIImage?) {
        self.imgProfile.image = image
    }
    
    
    // MARK: - Action
    @IBAction func actionDoneDatePicker(_ sender: Any) {
        self.vwDatePicker.isHidden = true

    }
    @IBAction func actionShowDatePicker(_ sender: Any) {
      //  self.vwDatePicker.isHidden = false

    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionEditProfile(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)

    }
   
    @IBAction func actionUpdateProfile(_ sender: Any) {
        if checkValidation() == true {
            updateData()
        }
    }
    
    func checkValidation() -> Bool {
//            if txtFldPhoneNO.text == "" || txtFldName.text == "" {
//                print("Enter valid data")
//                self.showAlert(message: "Enter valid data", navigate: false)
//                return false
//
//            }
//        else if let validphone = txtFldPhoneNO.text, !validphone.isValidPhone() {
//                self.showAlert(message: "Enter valid phone number", navigate: false)
//                return false
//
//            }
//        else if txtFldDOB.text == "" {
//                self.showAlert(message: "Enter valid Date Of Birth", navigate: false)
//                return false
//
//            }
        //else
        if txtFldName.text == "" {
                self.showAlert(message: "Enter valid Name", navigate: false)
                return false

            }
            return true
          }
    
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
               if navigate == true {
                   self?.navigationController?.popViewController(animated: true)
           }
           }

           ac.addAction(submitAction)
           present(ac, animated: true)
       
    }
    
}

extension EditProfileViewController {
    
    
    func updateData() {
        let api_url = WxrsStudyAPI.profileAPI
            guard let url = URL(string: api_url) else {
                return
            }
        SVProgressHUD.show()
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
            urlRequest.headers = headers
            //Set Your Parameter
            let parameterDict = NSMutableDictionary()
        
        
        parameterDict.setValue(UserDefaults.standard.value(forKey: "user_id") ?? "", forKey: "user_id")
        parameterDict.setValue(self.txtFldName.text ?? "", forKey: "name")
        parameterDict.setValue(self.DOBForAPI, forKey: "date_of_birth")
        let phoneNo = UserDefaults.standard.value(forKey: "mobile") as? String
        
        if phoneNo != self.txtFldPhoneNO.text {
            parameterDict.setValue(self.txtFldPhoneNO.text, forKey: "mobile")
        }

            //Set Image Data
            let imgData = self.imgProfile.image!.jpegData(compressionQuality: 0.5)!
print("\(imgData) =-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=?????")
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
                multiPart.append(imgData, withName: "profile_pic", fileName: "file.png", mimeType: "image/png")
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
                            self.showAlert(message: self.objProfileAPIModel?.data.message ?? "", navigate: true)
                            
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.name ?? "", forKey: "userName")
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.dateOfBirth ?? "", forKey: "dateOfBirth")
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.profilePic ?? "", forKey: "profilePic")
                            UserDefaults.standard.set(self.objProfileAPIModel?.data.data.user.mobile ?? "", forKey: "mobile")
                        }
                        SVProgressHUD.dismiss()

                        case .failure(let error):
                        SVProgressHUD.dismiss()
                            print("Failed with error: \(error)")
                        }
                }
    }
}

extension EditProfileViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldPhoneNO {
            return range.location < 10
        }
           return true
        }
}
