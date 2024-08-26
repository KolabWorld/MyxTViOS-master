//
//  InsightDataCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 31/08/22.
//

import UIKit

class InsightDataCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblIdelTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayInsightData(objInsight: IosAppPerformace) {
        
        lblDate.text = objInsight.createdAt?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMM yyyy", style: .long)
        let time = Int(objInsight.watchTime ?? "00") //Double( Double(Int(objInsight.watchTime ?? "00") ?? 00))
        
        
        self.hmsFrom(seconds: time ?? 00) { hours, minutes, seconds in
            let hoursV = self.getStringFrom(seconds: hours)
            let minutesV = self.getStringFrom(seconds: minutes)
            let secondsV = self.getStringFrom(seconds: seconds)
            self.lblIdelTime.text = " \(hoursV):\(minutesV):\(secondsV) "
            
        }
        

    }
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
            completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    

}
