//
//  EventVenueCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 30/08/22.
//

import UIKit

class EventVenueCell: UITableViewCell {

    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblVenue: UILabel!
    @IBOutlet weak var lblHomstName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayVenueInfo(objEventDetailsAPIModel : EventDetailsAPIModel){
        
        let date =   objEventDetailsAPIModel.data.data.event.startDateTime?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMM yyyy", style: .long)
        let time =   objEventDetailsAPIModel.data.data.event.startDateTime?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a", style: .long)
        lblStartDate.text = "\(date ?? "")\n\(time ?? "")"
        
        let date1 =   objEventDetailsAPIModel.data.data.event.endDateTime?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMM yyyy", style: .long)
        let time1 =   objEventDetailsAPIModel.data.data.event.endDateTime?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a", style: .long)
        
        lblEndDate.text = "\(date1 ?? "")\n\(time1 ?? "")"
        lblVenue.text = objEventDetailsAPIModel.data.data.event.venue
        
        lblHomstName.text = objEventDetailsAPIModel.data.data.event.eventHost
    }
  
}
