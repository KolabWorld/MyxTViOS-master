//
//  ShopViewController_Collection_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import UIKit
extension ShopViewController :  UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCategoriesCell", for: indexPath) as! ShopCategoriesCell
        
        print("Visible: \(arySelectedCategoryId)")
        
        if (arySelectedCategoryId?.firstIndex(of: "\(self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?[indexPath.row].id ?? 0 )")) != nil {
            cell.displayCategoryData(objOfferCategory:  (self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?[indexPath.row])!, isSelected: true)

            
        } else {
            if arySelectedCategoryId?.count == 0 {
                cell.displayCategoryData(objOfferCategory:  (self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?[indexPath.row])!, isSelected: false)
            } else  {
                cell.displayCategoryData(objOfferCategory:  (self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?[indexPath.row])!, isSelected: false)
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = arySelectedCategoryId?.firstIndex(of: "\(self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?[indexPath.row].id ?? 0 )") {
            arySelectedCategoryId?.remove(at: index)
        } else {
            arySelectedCategoryId?.append("\(self.objOfferCategoriesAPIModel?.data?.data?.offerCategories?[indexPath.row].id ?? 0 )")
        }
                    print("Selected: \(arySelectedCategoryId)")

        ShopDataAPI()
        collectionView.reloadData()
    }
}
