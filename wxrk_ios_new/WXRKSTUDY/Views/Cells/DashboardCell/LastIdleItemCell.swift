//
//  LastIdleItemCell.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 09/08/22.
//

import UIKit
import Foundation

class LastIdleItemCell: UICollectionViewCell {
    @IBOutlet weak var progress: KSBCircularProgress!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    var objDayWiseSummary : DayWiseSummary?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateProgress(progressValue : Int) {
        progress.glowMode = .constant
        progress.angle = Double(progressValue)
    }
    
    func displayData(objDayWiseSummary : DayWiseSummary) {
        let dateObj = objDayWiseSummary.createdAt?.datestringToStringDisplay(style: .long)
        lblDate.text = dateObj?.components(separatedBy: ",").last
        lblMonth.text = dateObj?.components(separatedBy: ",").first
        
        let isPositiveResult = objDayWiseSummary.timeSavedPercentage?.contains("-")
        
        if  isPositiveResult == true {
            progress.set(colors: UIColor.red)
            lblPercentage.textColor = UIColor.red
        }   else {
            progress.set(colors: UIColor(red: 105.0/255.0, green: 227.0/255.0, blue: 89.0/255.0, alpha: 1))
            lblPercentage.textColor = UIColor(red: 105.0/255.0, green: 227.0/255.0, blue: 89.0/255.0, alpha: 1)
        }
        let time = Double( Double(Int(objDayWiseSummary.watchTime ?? "00") ?? 00))
        
        lblTime.text =  "\(minutesToHoursAndMinutes(time/60).hours)h \(minutesToHoursAndMinutes(time/60).leftMinutes)m"
        
        let valueText = objDayWiseSummary.timeSavedPercentage?.replacingOccurrences(of: "-", with: "")
        lblPercentage.text = valueText
        updateProgress(progressValue: (360 * Int(valueText ?? "0")! )/100)//(100 - Int(valueText ?? "0")! ?? 0)  (360 * Int(valueText ?? "0")! ?? 0)/100
        
    }
    func minutesToHoursAndMinutes(_ minutes: Double) -> (hours: Int , leftMinutes: Int) {
        return (Int(minutes) / 60, (Int(minutes) % 60))
    }
    
}
