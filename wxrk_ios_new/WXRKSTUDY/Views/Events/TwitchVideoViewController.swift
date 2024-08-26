//
//  TwitchVideoViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 21/10/22.
//

import UIKit
import WebKit
import RealmSwift
import Alamofire
import SVProgressHUD
import SwiftyJSON

class TwitchVideoViewController: UIViewController{

    @IBOutlet weak var webViewTwitchVideo: WKWebView!
    @IBOutlet weak var lblViewCount: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    var realm : Realm!
    var objData : TwitchVideo!
    var timerTo : Timer?
    var objWatchTimeData : WatchTimeAPIModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        webViewTwitchVideo.uiDelegate = self
        webViewTwitchVideo.allowsBackForwardNavigationGestures = true
        webViewTwitchVideo.allowsLinkPreview = true
        webViewTwitchVideo.navigationDelegate = self

        // topTransactionAPI(fromDate: strFromDate, toDate: strToDate)
         realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        lblTitle.text = objData.title
        lblViewCount.text = "\(Int(objData.viewCount ?? "0")?.roundedWithAbbreviations ?? "00") views"
        lblDateTime.text  = "\(objData.videoPublishedAt)"
        let urlLink = "https://staging-wxrk.staqo.com/app-video/\(objData.twitchID)?user_id=\(UserDefaults.standard.value(forKey: "user_id") as! String)"
        
        print("Twitch Link to Play: \(urlLink)")
        let url = URL(string: urlLink)!
        webViewTwitchVideo.load(URLRequest(url: url))
      //  webView.allowsBackForwardNavigationGestures = true
        webViewTwitchVideo.configuration.allowsInlineMediaPlayback = true
              
        timerTo = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)

    }
    @objc func runTimedCode() {
        print("timer")
        self.watchTimeDataAPI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerTo?.invalidate()
        watchTimeDataAPI()
        UIApplication.shared.isIdleTimerDisabled = false

    }
  
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

extension TwitchVideoViewController {
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
                
                    self.objWatchTimeData = post
                    
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.todayWatchTime, forKey: "WatchTimeValue")
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.todayWxrkBalance, forKey: "WxrkBalanceValue")
                    UserDefaults.standard.setValue(self.objWatchTimeData?.data.data.actualWxrkBalance, forKey: "actualWxrkBalanceValue")
                    
                    if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
                        self.lblBalance.text = balance as? String
                    }
                
                SVProgressHUD.dismiss()

            case .failure(let error):
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


extension TwitchVideoViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frame = navigationAction.targetFrame,
           frame.isMainFrame {print("click1")
            return nil
        }
        print("click2")
        
        webView.load(navigationAction.request)
        return nil
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish loading")
        //self.spinner.stop()
        //        flag = 1
        //timer.invalidate()
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Set the indicator everytime webView started loading
        print("start loading")
        //        flag = 0
        //spinner.start(container: self)
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("faild loading")
        //self.spinner.stop()
        
    }
    
}
