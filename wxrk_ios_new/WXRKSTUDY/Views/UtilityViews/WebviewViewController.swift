//
//  WebviewViewController.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 16/08/22.
//

import UIKit
import WebKit

class WebviewViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var urlLink = ""
    var timer = Timer()
    
    var isRedeemed = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        if isRedeemed == true {
            showAlert(message: "Redeem successfully", navigate: false)

        }
        if urlLink.count == 0 {
            showAlert(message: "Not a valid link", navigate: true)
            return
        }
       
         //  webView.navigationDelegate = self
        // Do any additional setup after loading the view.
      //  urlLink = "https://staging-wxrk.staqo.com/app-video/1619489364?playsinline=1"
        print("Twitch Link to Play: \(urlLink)")
        let url = URL(string: urlLink)!
        webView.load(URLRequest(url: url))
      //  webView.allowsBackForwardNavigationGestures = true
        webView.configuration.allowsInlineMediaPlayback = true
        
        
        
//
//        if let url = Bundle.main.url(forResource: "Player", withExtension: "html") {
//            webView.load(URLRequest(url: "url"))
//        }
//
        
        
     //   webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.requestMediaPlaybackState), options: .new, context: nil)
       var isPlaying = false
        var isPaused = false

//        if urlLink.contains("twitch.tv") {
//            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//           // print("Timer fired!")
//            if #available(iOS 15.0, *) {
//                self.webView.requestMediaPlaybackState { state in
////                    print("Player state records : - \(state) -- \(state.rawValue)")
//
//
//                    switch state.rawValue {
//                    case 0:
//                        isPlaying = false
//                        isPaused = false
//                        print("--=-=-=-=->>> Not Started")
//                        self.view.makeToast("Not Playing stat")
//                        self.view.bringSubviewToFront(self.view)
//
//                    case 1:
//                        isPaused = false
//
//                        if isPlaying == false {
//                            isPlaying = true
//                            print("--=-=-=-=->>> Now Playing")
//
//                            self.view.makeToast("Now Playing state")
//                            self.view.bringSubviewToFront(self.view)
//
//                        }
//                    case 2:
//                        isPlaying = false
//                        if isPaused == false {
//                            isPaused = true
//                            print("--=-=-=-=->>> Now Paused")
//
//                            self.view.makeToast("Now Pause state")
//                            self.view.bringSubviewToFront(self.view)
//
//                        }
//                    default:
//                        isPaused = false
//
//                        isPlaying = false
//                        self.view.makeToast("Now Suspended state")
//                        print("--=-=-=-=->>> Now Suspended")
//
//                        self.view.bringSubviewToFront(self.view)
//                    }
//
//                }
//            } else {
//                // Fallback on earlier versions
//            }
//        }
//            print("exists")
//        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
    {
        print("action")
    }
  
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(Float(webView.estimatedProgress))
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        timer.invalidate()
        self.navigationController?.popViewController(animated: true)
    }
}
