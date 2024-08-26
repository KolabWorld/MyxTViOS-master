//
//  PhoneNumberViewController.swift
//  WXRK $STUDY
//
//  Created by KaramjeetSingh on 29/07/22.
//

import UIKit
import SKCountryPicker
import RealmSwift
import SwiftyJSON
import Alamofire
import SVProgressHUD

class PhoneNumberViewController: UIViewController, UITextFieldDelegate {
   
    var realm : Realm!

    
    @IBOutlet weak var lblPrivacyPolicy: UILabel!
    @IBOutlet weak var btnPhoneCode: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()

        // Do any additional setup after loading the view.
        btnPhoneCode.semanticContentAttribute = .forceRightToLeft

        self.lblPrivacyPolicy.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.lblPrivacyPolicy.addGestureRecognizer(tapgesture)
        self.txtEmail.text = (UserDefaults.standard.value(forKey: "userEamil") ?? "") as? String
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
           guard let text = self.lblPrivacyPolicy.text else { return }
           let privacyPolicyRange = (text as NSString).range(of: "Privacy Policy")
          // if gesture.didTapAttributedTextInLabel(label: self.lblPrivacyPolicy, inRange: privacyPolicyRange) {
               print("user tapped on privacy policy text")
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
               destinationVC.urlLink = "http://staging-wxrk.staqo.com/privacy-policy"
               self.navigationController?.pushViewController(destinationVC, animated: true)
               
          // }
       }
    
    @IBAction func actionPhoneCode(_ sender: Any) {
        countryPickerInit()
    }
    
    @IBAction func actionSendCode(_ sender: Any) {
        if txtPhoneNumber.text == "" {
            print("Enter either valid phone or email 1")
            self.showAlert(message: "Enter valid phone number", navigate: false)
        } else if txtEmail.text?.isValidEmail() == false {
            self.showAlert(message: "Enter valid email Address", navigate: false)
        }
            else if let validphone = txtPhoneNumber.text, validphone.isValidPhone() {
            print("Success")
            sendOTP()
        } else {
            self.showAlert(message: "Enter valid phone number", navigate: false)
            }
          }

        
        // MARK: - Country Picker

    func countryPickerInit() {
        presentCountryPickerScene(withSelectionControlEnabled: true)
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
/// MARK: - Private Methods
private extension PhoneNumberViewController {
    func presentCountryPickerScene(withSelectionControlEnabled selectionControlEnabled: Bool = true) {
           switch selectionControlEnabled {
           case true:
               // Present country picker with `Section Control` enabled
               let countryController = CountryPickerController.presentController(on: self) { country in
                  self.btnPhoneCode.setTitle(country.dialingCode, for: .normal)
               }
               
              // countryController.configuration.flagStyle = .circular
              // countryController.isCountryFlagHidden = false
              // countryController.isCountryDialHidden = false
           case false:
               // Present country picker with `Section Control` enabled
               let countryController = CountryPickerController.presentController(on: self) { country in
                  self.btnPhoneCode.setTitle(country.dialingCode, for: .normal)
               }
               
              // countryController.configuration.flagStyle = .circular
             //  countryController.isCountryFlagHidden = false
             //  countryController.isCountryDialHidden = false

           }
       }
   }


extension PhoneNumberViewController {
    
    func sendOTP(){
        SVProgressHUD.show()

        realm = try! Realm()
        var param = [String: String]()
        param["user_id"] =  UserDefaults.standard.value(forKey: "user_id") as? String
        param["mobile"] =  "\(txtPhoneNumber.text ?? "")"
        param["dial_code"] = "\(self.btnPhoneCode.title(for: .normal) ?? "")"
        param["email"] = "\(txtEmail.text ?? "")"

        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        print(param)
        
        AF.request(WxrsStudyAPI.sendOtpAPI, method: .post, parameters: param, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: SendOtpAPIModel.self) { response in
            
            switch response.result {
                case .success(let post):
                var objSendOtpAPIModel : SendOtpAPIModel?
                objSendOtpAPIModel = post

                if objSendOtpAPIModel?.status != 200 {
                    self.showAlert(message: objSendOtpAPIModel?.errors?.message ?? "something wrong -> sendOtpAPI", navigate: false)
                } else {
                    // print(objDashboardAPIModel?.data.data.id)
                    SVProgressHUD.dismiss()
                    
                    UserDefaults.standard.set(self.txtEmail.text ?? "", forKey: "userEmail")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "OTPConfirmationViewController")
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                    
                    // self.showAlert(message: "\(objSendOtpAPIModel?.data.message ?? ""), You email id is \(self.txtEmail.text ?? "")", navigate: true)
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
                   let destinationVC = storyboard.instantiateViewController(withIdentifier: "OTPConfirmationViewController")
               self?.navigationController?.pushViewController(destinationVC, animated: true)
           }
           }

           ac.addAction(submitAction)
           present(ac, animated: true)
       
    }
}


extension PhoneNumberViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtEmail {
            return true

        }
        return range.location < 10 //Here 10 is your character limit
        
    }
}
