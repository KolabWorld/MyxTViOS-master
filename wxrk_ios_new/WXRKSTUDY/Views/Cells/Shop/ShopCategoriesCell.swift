//
//  ShopCategoriesCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 24/08/22.
//

import UIKit

class ShopCategoriesCell: UICollectionViewCell {
    @IBOutlet weak var lblCatgory: UILabel!
    @IBOutlet weak var vwBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayCategoryData(objOfferCategory : OfferCategory , isSelected : Bool){
        lblCatgory.text = objOfferCategory.name

        if isSelected == true {
            lblCatgory.textColor = UIColor.init(red: 13.0/255.0, green: 50.0/255.0, blue: 108.0/255.0, alpha: 1)
            vwBack.backgroundColor = UIColor.init(red: 253.00/255.0, green: 253.00/255.0, blue: 253.00/255.0, alpha: 1)

        } else {
            lblCatgory.textColor = UIColor.white
            vwBack.backgroundColor = UIColor.init(red: 253.00/255.0, green: 253.00/255.0, blue: 253.00/255.0, alpha: 0.10)

        }
        
    }
}
