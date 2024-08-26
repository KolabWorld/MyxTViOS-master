//
//  DashboardChallengeCell.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 03/08/22.
//

import UIKit

class DashboardChallengeCell: UITableViewCell {

    @IBOutlet weak var progress: KSBCircularProgress!
    @IBOutlet weak var progress2: KSBCircularProgress!
    @IBOutlet weak var progress3: KSBCircularProgress!
    @IBOutlet weak var progress4: KSBCircularProgress!
    @IBOutlet weak var progress5: KSBCircularProgress!
    @IBOutlet weak var progress6: KSBCircularProgress!
    @IBOutlet weak var progress7: KSBCircularProgress!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateProgress() {
//        progress.startAngle = -90
//        progress.progressThickness = 0.2
//        progress.trackThickness = 0.2
//        progress.clockwise = true
//        progress.gradientRotateSpeed = 2
//        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.set(colors: UIColor(red: 105.0/255.0, green: 227.0/255.0, blue: 89.0/255.0, alpha: 1))
        progress.angle = Double(70)

//
//        progress2.startAngle = -90
//        progress2.progressThickness = 0.2
//        progress2.trackThickness = 0.2
//        progress2.clockwise = true
//        progress2.gradientRotateSpeed = 2
//        progress2.roundedCorners = false
//        progress2.glowMode = .forward
//        progress2.glowAmount = 1.9
//        progress2.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
//        progress2.angle = Double(70)
//
//
//        progress3.startAngle = -90
//        progress3.progressThickness = 0.2
//        progress3.trackThickness = 0.2
//        progress3.clockwise = true
//        progress3.gradientRotateSpeed = 2
//        progress3.roundedCorners = false
//        progress3.glowMode = .forward
//        progress3.glowAmount = 1.9
//        progress3.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
//        progress3.angle = Double(70)
//
//        progress4.startAngle = -90
//        progress4.progressThickness = 0.2
//        progress4.trackThickness = 0.2
//        progress4.clockwise = true
//        progress4.gradientRotateSpeed = 2
//        progress4.roundedCorners = false
//        progress4.glowMode = .forward
//        progress4.glowAmount = 1.9
//        progress2.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
//        progress2.angle = Double(70)
        
    }
}
