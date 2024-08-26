//
//  OfferHighlightCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 19/08/22.
//

import UIKit


protocol OfferHighlightCellDelegate: AnyObject {
    
    func linkOpen(openUrl:String)
    
}
class OfferHighlightCell: UITableViewCell {
    var urlStr = ""
    @IBOutlet weak var lblOffersHightlighInfo: UILabel!
    
    var delegate: OfferHighlightCellDelegate?
    @IBOutlet weak var linkBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func displayHighlightesData(objOfferDetailsAPIModel : OfferDetailsAPIModel) {
        lblOffersHightlighInfo.text = objOfferDetailsAPIModel.data?.data?.offer?.highlightOfOffer
       
    }
    func displayEventHighlightesData(objEventDetailsAPIModel : EventDetailsAPIModel) {
       // lblOffersHightlighInfo.text = objEventDetailsAPIModel.data.data.event.highlights
        lblOffersHightlighInfo.setHTMLFromString(htmlText: objEventDetailsAPIModel.data.data.event.highlights ?? "")
        let input = objEventDetailsAPIModel.data.data.event.highlights ?? ""
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input , options: [], range: NSRange(location: 0, length: input.utf16.count ))

        for match in matches {
            guard let range = Range(match.range, in: input ?? "") else { continue }
            let url = input[range]
            print(url)
            urlStr = "\(url ?? "")"
        }
    }
    
    @IBAction func linkBtnAction(_ sender: UIButton) {
        if urlStr != ""{
            self.delegate?.linkOpen(openUrl: urlStr)
        }
    }
}
