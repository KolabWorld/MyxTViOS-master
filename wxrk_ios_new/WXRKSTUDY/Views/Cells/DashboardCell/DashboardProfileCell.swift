//
//  DashboardProfileCell.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 03/08/22.
//

import UIKit
import Lottie

class DashboardProfileCell: UITableViewCell {
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var btnProfile: UIButton!

    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblStartSubTitle: UILabel!

    @IBOutlet weak var btnIntroScreens: UIButton!

    @IBOutlet weak var animationView: LottieAnimationView!
    
    @IBOutlet weak var lblBalanceAmount: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblLavel: UILabel!
    @IBOutlet weak var btnInsight: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!

    @IBOutlet weak var viewTokenLogo: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //viewTokenLogo.addBottomRoundedEdge(desiredCurve: 5)
        //print("User_id \(UserDefaults.standard.value(forKey: "user_id") as! String)")
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.imgProfile.cornerRadius = imgProfile.frame.size.height / 2

        // Configure the view for the selected state
    }
    
    func animateLotte() {
        // 1. Set animation content mode
         animationView.contentMode = .scaleAspectFit
         // 2. Set animation loop mode
         animationView.loopMode = .loop
         // 3. Adjust animation speed
         animationView.animationSpeed = 0.1
         // 4. Play animation
         animationView.play()
    }

    func displayProfileData() {

        lblBalanceAmount.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalanceAmount.text = balance as? String
        }
          
        imgProfile.kf.setImage(with: URL(string: UserDefaults.standard.value(forKey: "profilePic") as? String ?? "" ),
                               placeholder: UIImage(named: "user"),
                               options: [.forceRefresh, .cacheOriginalImage],
                               progressBlock: nil,
                               completionHandler: nil)
        
        let watchTimeValue : Int = UserDefaults.standard.value(forKey: "WatchTimeValue") as? Int ?? 0
        
        hmsFrom(seconds: watchTimeValue) { hours, minutes, seconds in
            let hoursV = self.getStringFrom(seconds: hours)
            let minutesV = self.getStringFrom(seconds: minutes)
            let secondsV = self.getStringFrom(seconds: seconds)
            self.lblTimer.text = " \(hoursV):\(minutesV):\(secondsV) "
            self.btnStart.setTitle("WATCH TO EARN", for: .normal)
            self.lblStartSubTitle.text = "TAP TO WATCH"


            
        }
    }
    
    func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
            completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
 
}
extension UIView {
    func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
}



extension UIView {
  
  
  /* Usage Example
   * bgView.addBottomRoundedEdge(desiredCurve: 1.5)
   */
    func addBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.height / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x , y: bounds.origin.y - offset / 2, width: bounds.size.width , height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
}
