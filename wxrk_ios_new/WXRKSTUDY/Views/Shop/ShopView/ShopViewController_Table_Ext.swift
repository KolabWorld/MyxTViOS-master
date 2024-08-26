//
//  ShopViewController_Table_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import UIKit

extension ShopViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.clear
        return vw
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countObj = objShopOffersAPIModel?.data.data.offers.count ?? 0
        if countObj > 0 {
            countObj = countObj + 1
        }
        return countObj
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.row < objShopOffersAPIModel?.data.data.offers.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedProductCell") as! FeaturedProductCell
            cell.displayShopListData(objOffer: (objShopOffersAPIModel?.data.data.offers[indexPath.row])!)
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell") as! BlankCell
        cell.isUserInteractionEnabled = false
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    
        let storyboard = UIStoryboard(name: "Shop", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
        destinationVC.offerId = "\(objShopOffersAPIModel?.data.data.offers[indexPath.row].id ?? -1)"
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        
    }
    
}
