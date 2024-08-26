//
//  AboutCompanyCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 19/08/22.
//

import UIKit
import Kingfisher

class AboutCompanyCell: UITableViewCell {
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblAboutCompnay: UILabel!
    @IBOutlet weak var btnVisitWebsite: UIButton!
    @IBOutlet weak var imgCompanyLogo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayCompanyData(objOfferDetailsAPIModel : OfferDetailsAPIModel) {
        imgCompanyLogo.kf.setImage(with: URL(string: objOfferDetailsAPIModel.data?.data?.offer?.thumbnailImage ?? ""))
        lblAboutCompnay.text = objOfferDetailsAPIModel.data?.data?.offer?.aboutTheCompany
        lblCompanyName.text = objOfferDetailsAPIModel.data?.data?.offer?.companyName ?? ""
    }

    func displayEventCompanyData(objEventDetailsAPIModel : EventDetailsAPIModel) {
        imgCompanyLogo.kf.setImage(with: URL(string: objEventDetailsAPIModel.data.data.event.thumbnailImage ?? "" ))
        lblAboutCompnay.text = objEventDetailsAPIModel.data.data.event.aboutTheCompany
        lblCompanyName.text = objEventDetailsAPIModel.data.data.event.companyName ?? ""
        btnVisitWebsite.isHidden = true
    }
}
