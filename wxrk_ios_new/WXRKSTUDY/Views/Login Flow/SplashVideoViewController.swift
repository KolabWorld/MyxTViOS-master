//
//  SplashVideoViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 18/08/22.
//

import UIKit
import AVFoundation

class SplashVideoViewController: UIViewController {
    @IBOutlet weak var videoView: UIView!
    var avPlayer: AVPlayer!
       var avPlayerLayer: AVPlayerLayer!
       var paused: Bool = false
    
    @IBOutlet weak var topAnimateView: UIView!
    
    @IBOutlet weak var xLogoImage: UIImageView!
    // For Animation
    
    @IBOutlet weak var leadingTopViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var tralingXImgConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.xLogoImage.isHidden = false
        self.xLogoImage.alpha = 0.0
        playVideo()
        animateView()
    }
    
    func animateView() {
        leadingTopViewConstraint?.isActive = false
        leadingTopViewConstraint?.constant = CGFloat(-20)
        leadingTopViewConstraint?.isActive = true
        
        UIView.animate(withDuration: 1.0) {
            self.topAnimateView.isHidden = false
            self.xLogoImage.alpha = 1.0
             self.view.layoutIfNeeded()
          }
    }
    
    func playVideo() {
        let theURL = Bundle.main.url(forResource:"splashVideo", withExtension: "mp4")

                avPlayer = AVPlayer(url: theURL!)
                avPlayerLayer = AVPlayerLayer(player: avPlayer)
                avPlayerLayer.videoGravity = .resizeAspectFill
                avPlayer.volume = 0
                avPlayer.actionAtItemEnd = .none

                avPlayerLayer.frame = view.layer.bounds
            videoView.backgroundColor = .clear
            videoView.layer.insertSublayer(avPlayerLayer, at: 0)

                NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd(notification:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: avPlayer.currentItem)
                avPlayer.play()
               paused = false
        
        
        self.avPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main, using: { (time) in
              if self.avPlayer?.currentItem?.status == .readyToPlay {
                  let currentTime = CMTimeGetSeconds(self.avPlayer!.currentTime())

                  let secs = Int(currentTime)
                  
                  if secs == 3 {
                      self.avPlayer?.pause()
                      self.avPlayer = nil
                      
                      if UserDefaults.standard.integer(forKey: "isUserVerified") == 1 {
                          let storyboard = UIStoryboard(name: "Main", bundle: nil)
                          let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                          self.navigationController?.pushViewController(tabBarController!, animated: true)

                      } else {
                          let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                              self.navigationController?.pushViewController(destinationVC, animated: true)
                      }
                      
                    
                     
                  }
                  
              //    self.timeLabel.text = NSString(format: "%02d:%02d", secs/60, secs%60) as String//"\(secs/60):\(secs%60)"
              }
          })
        
//        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { timer in
//            // You can use for to append multiple elements to list
//            self.avPlayer?.pause()
//            self.avPlayer = nil
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                self.navigationController?.pushViewController(destinationVC, animated: true)
//
//
//        }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            self.navigationController?.pushViewController(destinationVC, animated: true)
       
        
    }
    @objc func playerItemDidReachEnd(notification: Notification) {
//           let p: AVPlayerItem = notification.object as! AVPlayerItem
//           p.seek(to: .zero)
//        avPlayer.pause()
//        avPlayer = nil
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
        
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
