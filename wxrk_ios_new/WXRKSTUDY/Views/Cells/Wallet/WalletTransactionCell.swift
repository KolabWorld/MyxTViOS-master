//
//  WalletTransactionCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 25/08/22.
//

import UIKit
import SwiftUI

class WalletTransactionCell: UITableViewCell {

    @IBOutlet weak var imgEarnedSpent: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblEarnedSpent: UILabel!
    @IBOutlet weak var lblBalanceCoin: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayTransaction(objTransaction: TopTransaction){
        
        if objTransaction.type == "spent" {
            imgEarnedSpent.image = UIImage(named: "vuesax-bulk-export")
            self.lblTime.text = objTransaction.offer?.offerName ?? ""
        } else {
            imgEarnedSpent.image = UIImage(named: "vuesax-bulk-import")
            let watchTimeValue : Int = Int(objTransaction.watchTime ?? "0.0") ?? 0
            
            hmsFrom(seconds: watchTimeValue) { hours, minutes, seconds in
                let hoursV = self.getStringFrom(seconds: hours)
                let minutesV = self.getStringFrom(seconds: minutes)
                let secondsV = self.getStringFrom(seconds: seconds)
                self.lblTime.text = "\(hoursV)h \(minutesV)m \(secondsV)s "
            }
        }
        
        lblBalanceCoin.text = "\(objTransaction.wxrkBalance ?? "0.00") "
        lblEarnedSpent.text = objTransaction.type

        
    
        let dateToShow = objTransaction.createdAt?.datestringToStringDisplaySuffix(style: .long) //.datestringToStringDisplaySuffix(dateString: objTransaction.createdAt ?? "", fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMM, yyyy 'at' hh:mma", style: .long)
        
      
       // print("---==-=-> \(dateToShow ?? "")")
        
        lblDate.text = dateToShow
        
      
        

    }
    func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
            completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }

}
