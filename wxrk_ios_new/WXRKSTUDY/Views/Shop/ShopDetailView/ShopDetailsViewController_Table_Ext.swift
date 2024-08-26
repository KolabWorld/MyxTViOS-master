//
//  ShopDetailsViewController_Table_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import UIKit

extension ShopDetailsViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if objOfferDetailsAPIModel?.data?.data?.offer != nil{
            return 4

        }
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailBannerCell") as! ShopDetailBannerCell
            cell.selectionStyle = .none
          
            cell.btnWallet.addTarget(self, action: #selector(actionWallet), for: .touchUpInside)
            
            
            cell.displayOffers(objOfferDetailsAPIModel: objOfferDetailsAPIModel!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OfferHighlightCell") as! OfferHighlightCell
            cell.selectionStyle = .none
            cell.displayHighlightesData(objOfferDetailsAPIModel: objOfferDetailsAPIModel!)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCompanyCell") as! AboutCompanyCell
            cell.selectionStyle = .none
            cell.displayCompanyData(objOfferDetailsAPIModel: objOfferDetailsAPIModel!)
            cell.btnVisitWebsite.addTarget(self, action: #selector(actionVisitWebsite), for: .touchUpInside)

            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell") as! BlankCell
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    
    }
    
    @objc func actionVisitWebsite(button: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        destinationVC.urlLink = objOfferDetailsAPIModel?.data?.data?.offer?.link ?? ""
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

    
    func openWebLink(urlString: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        destinationVC.urlLink = urlString
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
}
