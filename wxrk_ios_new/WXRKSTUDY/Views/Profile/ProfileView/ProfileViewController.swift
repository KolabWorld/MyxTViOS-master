//
//  ProfileViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 26/08/22.
//

import UIKit
import RealmSwift
import Alamofire
import SVProgressHUD
import Lottie

class ProfileViewController: UIViewController {
    var realm : Realm!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var vwProfileAnimation: LottieAnimationView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tblProfileData: UITableView!
    var objDeleteUserAPIModel : DeleteUserAPIModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgProfile.cornerRadius = imgProfile.frame.size.height / 2
        
        realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblProfileData.reloadData()
        


        imgProfile.kf.setImage(with: URL(string: UserDefaults.standard.value(forKey: "profilePic") as? String ?? "" ),
                placeholder: UIImage(named: "user"),
                options: [.forceRefresh, .cacheOriginalImage],
                progressBlock: nil,
                completionHandler: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 1. Set animation content mode
        vwProfileAnimation.contentMode = .scaleAspectFit
         // 2. Set animation loop mode
        vwProfileAnimation.loopMode = .loop
//         // 3. Adjust animation speed
        vwProfileAnimation.animationSpeed = 0.1
         // 4. Play animation
        vwProfileAnimation.play()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionWallet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true

        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func actionEditProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func actionDeleteAccount(_ sender: Any) {
        let ac = UIAlertController(title: "Delete Account", message: "Deleting your account will erase all your data and tokens. Are you sure you want to delete your account.", preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "Delete", style: .default) { [weak self, weak ac] action in
               self?.deleteAccount()
           }
            
            let dontDeleteAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self, weak ac] action in

            }
        ac.addAction(submitAction)
        ac.addAction(dontDeleteAction)

           present(ac, animated: true)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func deleteAccount() {
        SVProgressHUD.show()

        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request("\(WxrsStudyAPI.getDeleteUserAPI)", method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: DeleteUserAPIModel.self) { response in
            switch response.result {
                case .success(let post):

                self.objDeleteUserAPIModel = post
                
                if self.objDeleteUserAPIModel?.status != 200 {
                    self.showAlert(message: self.objDeleteUserAPIModel?.errors?.message ?? "something wrong -> Delete User", navigate: false)
                } else {
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                    }
                    SVProgressHUD.dismiss()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SplashVideoViewController") as! SplashVideoViewController
                    self.navigationController?.pushViewController(destinationVC, animated: true)
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
    
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
}



