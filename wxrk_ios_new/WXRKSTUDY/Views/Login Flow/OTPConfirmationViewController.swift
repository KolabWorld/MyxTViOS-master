//
//  OTPConfirmationViewController.swift
//  WXRKSTUDY
//
//  Created by KaramjeetSingh on 29/07/22.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire
import SVProgressHUD

class OTPConfirmationViewController: UIViewController {
    var realm : Realm!
    @IBOutlet weak var firstDigitField: SingleDigitField!
    @IBOutlet weak var secondDigitField: SingleDigitField!
    @IBOutlet weak var thirdDigitField: SingleDigitField!
    @IBOutlet weak var fourthDigitField: SingleDigitField!
    @IBOutlet weak var lblWrongPhoneNo: UILabel!
    @IBOutlet weak var lblCodeSentOn: UILabel!

    var objVerifyOtpAPIModel : VerifyOtpAPIModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        self.lblCodeSentOn.text = UserDefaults.standard.value(forKey: "userEmail") as? String
        self.lblWrongPhoneNo.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.lblWrongPhoneNo.addGestureRecognizer(tapgesture)
        [firstDigitField,secondDigitField,thirdDigitField,fourthDigitField].forEach {
                   $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
               }
               // make the firsDigitField the first responder
               firstDigitField.isUserInteractionEnabled = true
               firstDigitField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.lblWrongPhoneNo.text else { return }
        let privacyPolicyRange = (text as NSString).range(of: "Tap here")
        if gesture.didTapAttributedTextInLabel(label: self.lblWrongPhoneNo, inRange: privacyPolicyRange) {
            print("user tapped on privacy policy text")
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func actionVerifyOTP(_ sender: Any) {
        
        if firstDigitField.text?.count == 1 && secondDigitField.text?.count == 1 && thirdDigitField.text?.count == 1 && fourthDigitField.text?.count == 1 {
            verifyOTP()
        } else {
            showAlert(message: "Please enter correct OTP", navigate: false)
        }
        
       
    }
    // here you control what happens to each change that occurs to the fields
        @objc func editingChanged(_ textField: SingleDigitField) {
            // check if the deleteBackwards key was pressed
            if textField.pressedDelete {
                // reset its state
                textField.pressedDelete = false
                // if the field has text empty its content
                if textField.hasText {
                    textField.text = "\(firstDigitField.text ?? "0" )\(secondDigitField.text ?? "0")\(thirdDigitField.text ?? "0")\(fourthDigitField.text ?? "0")"
                } else {
                    // otherwise switch the field, resign the first responder and activate the previous field and empty its contents
                    switch textField {
                    case secondDigitField, thirdDigitField, fourthDigitField:
                        textField.resignFirstResponder()
                        textField.isUserInteractionEnabled = false
                        switch textField {
                        case secondDigitField:
                            firstDigitField.isUserInteractionEnabled = true
                            firstDigitField.becomeFirstResponder()
                            firstDigitField.text = ""
                        case thirdDigitField:
                            secondDigitField.isUserInteractionEnabled = true
                            secondDigitField.becomeFirstResponder()
                            secondDigitField.text = ""
                        case fourthDigitField:
                            thirdDigitField.isUserInteractionEnabled = true
                            thirdDigitField.becomeFirstResponder()
                            thirdDigitField.text = ""
                        default:
                            break
                        }
                    default: break
                    }
                }
            }
            // make sure there is only one character and it is a number otherwise delete its contents
            guard textField.text?.count == 1, textField.text?.last?.isWholeNumber == true else {
                textField.text = ""
                return
            }
            // switch the textField, resign the first responder and make the next field active
            switch textField {
            case firstDigitField, secondDigitField, thirdDigitField:
                textField.resignFirstResponder()
                textField.isUserInteractionEnabled = false
                switch textField {
                case firstDigitField:
                    secondDigitField.isUserInteractionEnabled = true
                    secondDigitField.becomeFirstResponder()
                case secondDigitField:
                    thirdDigitField.isUserInteractionEnabled = true
                    thirdDigitField.becomeFirstResponder()
                case thirdDigitField:
                    fourthDigitField.isUserInteractionEnabled = true
                    fourthDigitField.becomeFirstResponder()
                default: break
                }
            case fourthDigitField:
                fourthDigitField.resignFirstResponder()
            default: break
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

extension OTPConfirmationViewController {
    func verifyOTP(){
        SVProgressHUD.show()

        realm = try! Realm()
        var param = [String: String]()
        param["user_id"] =  UserDefaults.standard.value(forKey: "user_id") as? String
        param["otp"] =  "\(firstDigitField.text ?? "0")\(secondDigitField.text ?? "0")\( thirdDigitField.text ?? "0")\(fourthDigitField.text ?? "0")"

        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        print(param)
        AF.request(WxrsStudyAPI.verifyOtpAPI, method: .post, parameters: param, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: VerifyOtpAPIModel.self) { response in
            
            switch response.result {
                case .success(let post):
                self.objVerifyOtpAPIModel = post
                if self.objVerifyOtpAPIModel?.status != 200 {
                    self.showAlert(message: self.objVerifyOtpAPIModel?.errors?.message ?? "something wrong -> verifyOtpAPI", navigate: false)
                } else {
                    SVProgressHUD.dismiss()
                    
                    self.showAlert(message: self.objVerifyOtpAPIModel?.data.message ?? "", navigate: true)
                }
                SVProgressHUD.dismiss()

                case .failure(let error):
                let json = JSON(response.value)
                self.showAlert(message: json["error"]["message"].stringValue, navigate: false)

                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
        
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
               if navigate == true {
                   
                   UserDefaults.standard.set(1, forKey: "isUserVerified")
                   
                   if self!.objVerifyOtpAPIModel?.data.data.user.isNewUser == "1" {
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let destinationVC = storyboard.instantiateViewController(withIdentifier: "FirstNameViewController")
                       self?.navigationController?.pushViewController(destinationVC, animated: true)
                   } else {
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                       self?.navigationController?.pushViewController(destinationVC, animated: true)
                   }
               }
           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
}

class SingleDigitField: UITextField {
    // create a boolean property to hold the deleteBackward info
    var pressedDelete = false
    // customize the text field as you wish
    override func willMove(toSuperview newSuperview: UIView?) {
        keyboardType = .numberPad
        textAlignment = .center
        //backgroundColor = UIColor.white
        isSecureTextEntry = false
        isUserInteractionEnabled = true
    }
    // hide cursor
    override func caretRect(for position: UITextPosition) -> CGRect { .zero }
    // hide selection
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    // disable copy paste
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
    // override deleteBackward method, set the property value to true and send an action for editingChanged
    override func deleteBackward() {
        pressedDelete = true
        sendActions(for: .editingChanged)
    }
}
