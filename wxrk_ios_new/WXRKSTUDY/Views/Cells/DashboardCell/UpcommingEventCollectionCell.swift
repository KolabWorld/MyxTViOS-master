//
//  UpcommingEventCollectionCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 17/08/22.
//

import UIKit
protocol UpcommingEventCollectionCellDelegate: AnyObject {
    func openJoinLink(objEvent: Event )
}

class UpcommingEventCollectionCell: UICollectionViewCell {

    weak var delegate: UpcommingEventCollectionCellDelegate?

    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnJoinNow: UIButton!
    @IBOutlet weak var vwJoinNow: UIView!

    @IBOutlet weak var lblDateday: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var vwMainBgr: UIView!

    
    var linkToOpen = ""
    var objEventD : Event? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionJoinNow(_ sender: Any) {
        delegate?.openJoinLink(objEvent : objEventD!)

    }
    
    func displayData(objEvent : Event){
        objEventD = objEvent
        lblName.text = objEvent.name
        lblDescription.text = objEvent.eventDescription
        setGradientBackground()
        imgEvent.kf.setImage(with: URL(string: objEvent.thumbnailImage  ?? ""))
        let dateObj = objEvent.startDateTime?.datestringToStringDisplay(style: .long)
        lblDateday.text = dateObj?.components(separatedBy: ",").last
        lblMonth.text = dateObj?.components(separatedBy: ",").first
        //linkToOpen = objEvent.link
        
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
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 45.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 32.0/255.0, green: 78.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
                
        vwJoinNow.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
}
