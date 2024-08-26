//
//  LoginViewController.swift
//  WXRK $STUDY
//
//  Created by KaramjeetSingh on 29/07/22.
//

import UIKit
import Lottie
import RealmSwift
import SVProgressHUD
import Alamofire
import PTCardTabBar
import BloctoSDK
import FCL_SDK
import AuthenticationServices
//import CoreLocation


class LoginViewController: UIViewController {
    
    var isProduction = true
    var bloctoSDKAppId: String {
        if isProduction {
            return "e3328c9b-287d-45e1-bf3b-c484de7295f5"
        } else {
            return "bb5afa5b-c369-4e07-915e-ffcd3450dc80"
        }
    }
   // var userLocation : CLLocation?
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var imgBackGround: UIImageView!
    @IBOutlet weak var imgDummyBlocto: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        
        if UserDefaults.standard.integer(forKey: "isUserVerified") == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
            self.navigationController?.pushViewController(tabBarController!, animated: true)
        }
        
        self.view.isUserInteractionEnabled = true
        
        // 1. Set animation content mode
         animationView.contentMode = .scaleAspectFit
         // 2. Set animation loop mode
         animationView.loopMode = .loop
         // 3. Adjust animation speed
         animationView.animationSpeed = 1
         // 4. Play animation
         animationView.play()
       // locationGet()
        setupFCL()
        self.imgDummyBlocto.isHidden = true

//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
//        imgDummyBlocto.addGestureRecognizer(tapGestureRecognizer)

      //  loginAPI(bloctoAddress: "1234qwer")

       }

       // MARK: - Actions

    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
           self.imgDummyBlocto.isHidden = true
      //  loginAPI(bloctoAddress: "0xb568647753aec851")
           
       }
//    private func locationGet(){
//        // Create a CLLocationManager and assign a delegate
//        let locationManager = CLLocationManager()
//        locationManager.delegate = self
//
//        // Request a user’s location once
//        locationManager.requestLocation()
//    }
//    func locationManager(
//        _ manager: CLLocationManager,
//        didUpdateLocations locations: [CLLocation]
//    ) {
//        userLocation = locations.first
////        if let location = locations.first {
////            let latitude = location.coordinate.latitude
////            let longitude = location.coordinate.longitude
////            // Handle location update
////        }
//    }
//    func locationManager(
//        _ manager: CLLocationManager,
//        didFailWithError error: Error
//    ) {
//        print(error)
//
//        // Handle failure to get a user’s location
//    }
    private func setupFCL() {
        do {
            let bloctoWalletProvider = try BloctoWalletProvider(
                bloctoAppIdentifier: bloctoSDKAppId,
                window: view.window,
                network: isProduction ? .mainnet : .testnet
            )
          //  let dapperWalletProvider = DapperWalletProvider.default
            fcl.delegate = self
            if isProduction {
                try fcl.config
                    .put(.network(.mainnet))
                    .put(.supportedWalletProviders(
                        [
                            bloctoWalletProvider,
                           // dapperWalletProvider,
                        ]
                    ))
            } else {
                try fcl.config
                    .put(.network(.testnet))
                    .put(.supportedWalletProviders(
                        [
                            bloctoWalletProvider,
                           // dapperWalletProvider,
                        ]
                    ))
            }
        } catch {
            debugPrint(error)
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
    
    // MARK: - Actions
    
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter you User Id here", message: "You can use this Id again to get the data for this user", preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Login", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            self.loginAPI(bloctoAddress: answer.text ?? "")
            // do something interesting with "answer" here
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    
    
    @IBAction func actionBloctoLogin(_ sender: Any) {

 //       loginAPI(bloctoAddress: "0000000000")
        
//        let nonce = "75f8587e5bd5f9dcc9909d0dae1f0ac5814458b2ae129620502cb936fde7120a"
//
//       let accountProofData = FCLAccountProofData(
//           appId: bloctoSDKAppId,
//           nonce: nonce
//       )
//       Task { @MainActor in
//           do {
//               let address = try await fcl.authanticate(accountProofData: accountProofData)
//               loginAPI(bloctoAddress: address.hexStringWithPrefix)
//           } catch {
//               //self.handleRequestAccountError(error)
//           }
//       }
//
//      //  self.imgDummyBlocto.isHidden = false
        
        Task { @MainActor in
            do {
                let address = try await fcl.login()
                loginAPI(bloctoAddress: address.hexStringWithPrefix)
            } catch {
                self.showAlert(message: error.localizedDescription, navigate: false)
            }
        }
        
//        promptForAnswer()
        
        
    }
    
    
    

    @IBAction func actionGoogleLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "PhoneNumberViewController")
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in

           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
}

extension LoginViewController {
    func jsonStringValue(payload: [String: JsonEncoding]) -> Data {
        let encoder = JSONEncoder()
        do {
            let encodedValues = try payload.encode(using: encoder)
            let jsonData = try encoder.encode(encodedValues)
            return jsonData
            // Write to file
        } catch {
            return Data()

        }
    }
    
   


    func loginAPI(bloctoAddress: String) {
        SVProgressHUD.show()
        var deviceAddress = ""
//        for interface in EnumerateNetworkInterfaces.enumerate() {
//            print("\(interface.name):  \(interface.ip)")
//            deviceAddress = interface.ip
//          //  break
//        }
        
        
        var param = [String: JsonEncoding]()
        param["grant_type"] =  "password"
        param["client_id"] =  "2"
        param["client_secret"] =   "CBRYoCsb8L8Fmx6uam9q2rBT797yDybaTB2JQFzS"
        
        param["username"] = bloctoAddress
        param["password"] =   "Test123!"
        param["scope" ] =   "*"
        
        param["device_name" ] =   UIDevice.current.name
        param["device_address" ] =   deviceAddress
        param["os_version" ] =   "iOS - \(UIDevice.current.systemVersion)"
        param["app_version" ] =   "\(Bundle.main.releaseVersionNumber ?? "")(\(Bundle.main.buildVersionNumber ?? ""))"
        param["latitude" ] =  "0.0" //"\(userLocation?.coordinate.latitude ?? 0.0)"
        param["longitude" ] =   "0.0" //"\(userLocation?.coordinate.longitude ?? 0.0)"
        param["firebase_id" ] =   "0"
        
        print(param)
        
        AF.request(WxrsStudyAPI.loginAPI, method: .post, parameters: param, encoding:  JSONEncoding.default ,headers: nil).responseDecodable(of: LoginAPIModel.self) { response in
            
            
            switch response.result {
                case .success(let post):
               
                var objDashboardAPIModel : LoginAPIModel?
                objDashboardAPIModel = post

                if objDashboardAPIModel?.status != 200 {
                    self.showAlert(message: objDashboardAPIModel?.errors?.message ?? "something wrong -> loginAPI", navigate: false)
                } else {
               // print(objDashboardAPIModel?.data?.data.id)
                UserDefaults.standard.set("\(objDashboardAPIModel?.data?.data.id ?? 0)", forKey: "user_id")
                UserDefaults.standard.set("\(objDashboardAPIModel?.data?.accessToken ?? "")", forKey: "user_token")
                SVProgressHUD.dismiss()
                    if objDashboardAPIModel?.data?.data.isNewUser == "0" {
                        UserDefaults.standard.set(1, forKey: "isUserVerified")
                        UserDefaults.standard.set( objDashboardAPIModel?.data?.data.name ?? "", forKey: "userName")
                        UserDefaults.standard.set( objDashboardAPIModel?.data?.data.dateOfBirth ?? "", forKey: "dateOfBirth")
                        UserDefaults.standard.set( objDashboardAPIModel?.data?.data.profileImageURL ?? "", forKey: "profilePic")
                        UserDefaults.standard.set( objDashboardAPIModel?.data?.data.mobile ?? "", forKey: "mobile")
                        UserDefaults.standard.set( objDashboardAPIModel?.data?.data.email ?? "", forKey: "userEmail")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                        self.navigationController?.pushViewController(tabBarController!, animated: true)
                    } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let destinationVC = storyboard.instantiateViewController(withIdentifier: "PhoneNumberViewController")
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    
                }
                    
                    
                }
                SVProgressHUD.dismiss()

                case .failure(let error):
                SVProgressHUD.dismiss()
                    print("Failed with error: \(error)")
                }
        }
    }
}


extension UIViewController {
    func alertExt(withTitle ttl: String = "",
                  withMessage msg : String = "",
                  withPreferredStyle pstyle : UIAlertController.Style = UIAlertController.Style.alert,
                  withButtons buttons: [[String:[UIAlertAction.Style:() -> ()]]] = [["Ok":[UIAlertAction.Style.cancel:{}]]])
    {
        let alertVC = UIAlertController(title: ttl, message: msg, preferredStyle: pstyle)
        for i in 0...buttons.count-1{
            alertVC.addAction(
                UIAlertAction(
                    title: buttons[i].keys.first,
                    style: buttons[i].values.first!.keys.first!,
                    handler: {
                        (alert: UIAlertAction!) in (buttons[i].values.first!.values.first!())
                }
                )
            )
        }
        if let popoverController = alertVC.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }

        self.present(alertVC, animated: true, completion: nil)
    }
}
// MARK: FCLDelegate

extension LoginViewController: FCLDelegate {

    func webAuthenticationContextProvider() -> ASPresentationAnchor? {
        view.window
    }

}

public class EnumerateNetworkInterfaces {
    public struct NetworkInterfaceInfo {
        let name: String
        let ip: String
        let netmask: String
    }
    public static func enumerate() -> [NetworkInterfaceInfo] {
        var interfaces = [NetworkInterfaceInfo]()

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {

            // For each interface ...
            var ptr = ifaddr
            while( ptr != nil) {

                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee

                // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {

                        var mask = ptr!.pointee.ifa_netmask.pointee

                        // Convert interface address to a human readable string:
                        let zero  = CChar(0)
                        var hostname = [CChar](repeating: zero, count: Int(NI_MAXHOST))
                        var netmask =  [CChar](repeating: zero, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                        nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            let address = String(cString: hostname)
                            let name = ptr!.pointee.ifa_name!
                            let ifname = String(cString: name)


                            if (getnameinfo(&mask, socklen_t(mask.sa_len), &netmask, socklen_t(netmask.count),
                                            nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                                let netmaskIP = String(cString: netmask)

                                let info = NetworkInterfaceInfo(name: ifname,
                                                                ip: address,
                                                                netmask: netmaskIP)
                                interfaces.append(info)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return interfaces
    }
}
