//
//  FeaturedProductCell.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 07/08/22.
//

import UIKit

class FeaturedProductCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var vwLowStock: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayDashboardOfferData(objOffer  : DataOffer?){
        lblName.text = objOffer?.offerName
        lblDescription.text = objOffer?.detailsOfOffer
        lblAmount.text = objOffer?.offerPriceInWxrk
        imgProduct.kf.setImage(with: URL(string: objOffer?.thumbnailImage ?? ""))
        vwLowStock.isHidden = true
        if objOffer?.isLowStock == "0" {
            vwLowStock.isHidden = true
        } else {
            vwLowStock.isHidden = false
        }
    }
    
    func displayShopData(objOffer  : OfferOffer){
        lblName.text = objOffer.offerName
        lblDescription.text = objOffer.detailsOfOffer
        lblAmount.text = objOffer.offerPriceInWxrk
        imgProduct.kf.setImage(with: URL(string: objOffer.thumbnailImage ?? ""))
        //vwLowStock.isHidden = true
//        let stock:Int? = Int (objOffer.stock ?? "-1")
//        if ((stock ?? 0) <= Int(objOffer.lowStock ?? "0") ?? 0 ) && Int(objOffer.lowStock ?? "0") != 0 {
//            vwLowStock.isHidden = false
//        }
        if objOffer.isLowStock == "1" {
            vwLowStock.isHidden = false
        } else {
            vwLowStock.isHidden = true
        }
    }
    
    func displayShopListData(objOffer  : Offer){
        lblName.text = objOffer.offerName
        lblDescription.text = objOffer.detailsOfOffer
        lblAmount.text = objOffer.offerPriceInWxrk
        imgProduct.kf.setImage(with: URL(string: objOffer.thumbnailImage ?? "" ))
        vwLowStock.isHidden = true
//        let stock:Int? = Int (objOffer.stock ?? "-1")
//        if ((stock ?? 0) <= Int(objOffer.lowStock ?? "0") ?? 0 ) && Int(objOffer.lowStock ?? "0") != 0 {
//            vwLowStock.isHidden = false
//        }
       
        if objOffer.isLowStock == "1" {
            vwLowStock.isHidden = false
        }
    }
    
    
}
