//
//  EventCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 29/08/22.
//

import UIKit
import Kingfisher

protocol EventCellDelegate: AnyObject {
    func joinEventClicked(objEvent: Event)
}

class EventCell: UITableViewCell  {
    
    var events = [Event]()
    var objEvent : Event? = nil

    

    weak var delegate: EventCellDelegate?

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnJoinNow: UIButton!
    @IBOutlet weak var vwJoinNow: UIView!
    @IBOutlet weak var vwDate: UIView!
    @IBOutlet weak var vwTwitchUser: UIView!
    @IBOutlet weak var lblTwithcUserCount: UILabel!

    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var vwMainBgr: UIView!

    var linkToOpen = ""
    
   @IBAction func joinAction(_ sender: Any) {
       delegate?.joinEventClicked(objEvent: objEvent!)

   }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // registerCell()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayData(objEvent : Event){
        self.objEvent = objEvent
        vwTwitchUser.isHidden = true
        lblDate.text = objEvent.name
        lblName.text = objEvent.name
        lblDescription.text = objEvent.eventDescription
        setGradientBackground()
        imgEvent.kf.setImage(with: URL(string: objEvent.thumbnailImage  ?? ""))
        let dateObj = objEvent.startDateTime?.datestringToStringDisplay(style: .long)
        lblDate.text = dateObj?.components(separatedBy: ",").last
        lblMonth.text = dateObj?.components(separatedBy: ",").first
        //linkToOpen = objEvent.link
        vwMainBgr.layer.borderWidth = 1.0
        vwMainBgr.layer.cornerRadius = 23.0
        vwMainBgr.layer.backgroundColor = UIColor.clear.cgColor
        btnJoinNow.isUserInteractionEnabled = true
        
        vwMainBgr.layer.backgroundColor = UIColor.clear.cgColor
        btnJoinNow.setTitle("JOIN NOW", for: .normal)
        vwJoinNow.backgroundColor = UIColor.init(red: 45.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1)
        btnJoinNow.isUserInteractionEnabled = true
        
        if objEvent.alreadyJoined == 1 {
            vwMainBgr.layer.backgroundColor = UIColor.init(red: 105.0/255.0, green: 227.0/255.0, blue: 89.0/255.0, alpha: 1).cgColor
            btnJoinNow.setTitle("ALREADY SIGNED", for: .normal)
            vwJoinNow.backgroundColor = UIColor.init(red: 14.0/255.0, green: 28.0/255.0, blue: 50.0/255.0, alpha: 1)
            btnJoinNow.isUserInteractionEnabled = false

        }
        
    }
    
    func displayTwitchData(objData : TwitchVideo){
        vwTwitchUser.isHidden = false

        vwJoinNow.isHidden = true
        btnJoinNow.isHidden = true
        vwDate.isHidden = true
        
        lblDate.text = "" //objData.createdAt.datestringToStringDisplay(style: .long)
        lblName.text = objData.title
        lblDescription.text = ""// "\(objData.userName)\n\(objData.twitchVideoDescription)"
        setGradientBackground()
        lblTwithcUserCount.text = objData.viewCount
        var urlThumb = objData.thumbnailURL //{width}x{height}.jpg",
        urlThumb = urlThumb.replacingOccurrences(of: "%{width}", with: "315")
        urlThumb = urlThumb.replacingOccurrences(of: "%{height}", with: "215")

        imgEvent.kf.setImage(with: URL(string: urlThumb ))
//        let dateObj = objEvent.startDateTime?.datestringToStringDisplay(style: .long)
//        lblDate.text = dateObj?.components(separatedBy: ",").last
//        lblMonth.text = dateObj?.components(separatedBy: ",").first
        //linkToOpen = objEvent.link
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 45.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 32.0/255.0, green: 78.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
                
        vwJoinNow.layer.insertSublayer(gradientLayer, at:0)
    }
}
