//
//  HomeViewController_Table_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 26/10/22.
//

import Foundation
import UIKit
import Lottie

extension HomeViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return aryHeaders.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 || section == 2 || section == 4 {
            return 0
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerObj = aryHeaders[section]
        if section == aryHeaders.count - 1 {
            let vw = UIView()
            vw.backgroundColor = UIColor.clear
            return vw
        } else if self.objDashboardAPIModel?.data.data.iosAppPerformace?.count ?? 0 < 0 && section == 3 {
            let vw = UIView()
            vw.backgroundColor = UIColor.clear
            return vw
        } else if section == 0 || section == 1 || section == 2 || section == 4{
            let vw = UIView()
            vw.backgroundColor = UIColor.clear
            return vw
        } else {
            return self.headerCell(tableView: tableView, titile: headerObj["title"] ?? "", subTitle: "")
        }
    }
    
    func headerCell(tableView: UITableView, titile : String, subTitle: String) -> UIView {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewCell") as! HeaderViewCell
        // headerCell.backgroundColor = UIColor.gray
        headerCell.lblTitle.text = titile
        headerCell.lblSubTitle.text = subTitle
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == aryHeaders.count - 1 {
            return 1
            
        } else if section == 0 || section == 1 || section == 3 || section == 4 || section == (aryHeaders.count - 2) {
            return 1
        } else if section == 2 {
            return self.objDashboardAPIModel?.data.data.banners.count ?? 0
        } else if section == 5 {
            
            if objDashboardAPIModel?.data.data.offers.count ?? 0 >= 5{
                return 5
            }else{
                return self.objDashboardAPIModel?.data.data.offers.count ?? 0
                
            }
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardProfileCell") as! DashboardProfileCell
            cell.animationView.play()
            cell.animationView.loopMode = .loop
            cell.btnStart.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
            cell.btnWallet.addTarget(self, action: #selector(actionWallet), for: .touchUpInside)
            cell.btnProfile.addTarget(self, action: #selector(actionProfile), for: .touchUpInside)
            cell.btnInsight.addTarget(self, action: #selector(actionInsight), for: .touchUpInside)

            cell.btnIntroScreens.addTarget(self, action: #selector(openIntroScreens), for: .touchUpInside)
            cell.displayProfileData()
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardChallengeCell") as! DashboardChallengeCell
            cell.updateProgress()
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SponsoredCell") as! SponsoredCell
            
            if self.objDashboardAPIModel?.data.data.banners.count ?? 0 > 0 {
            cell.displayData(objDataBanner: (self.objDashboardAPIModel?.data.data.banners[indexPath.row])!)
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastIdleTblCell") as! LastIdleTblCell
            cell.collectionViewLastIdle.reloadData()
            if self.objDashboardAPIModel?.data.data.iosAppPerformace?.count ?? 0 > 0 {
                cell.objDayWiseSummary = (self.objDashboardAPIModel?.data.data.iosAppPerformace)!
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyRewardsCell") as! DailyRewardsCell
            cell.collectionViewRewards.reloadData()
            
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section ==  (aryHeaders.count - 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingEventCell") as! UpcommingEventCell
            
            if self.objDashboardAPIModel?.data.data.events.count ?? 0 > 0 {
            cell.events = (self.objDashboardAPIModel?.data.data.events)!
            cell.collectionViewEvents.reloadData()
                cell.delegate = self
            }
//            cell.counter = self.objDashboardAPIModel?.data.data.events.count ?? 0
            cell.selectionStyle = .none
            return cell
        } else  if indexPath.section == aryHeaders.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell") as! BlankCell
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        } else if indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedProductCell") as! FeaturedProductCell
            
            if self.objDashboardAPIModel?.data.data.offers.count ?? 0 > 0 {
                cell.displayDashboardOfferData(objOffer: (self.objDashboardAPIModel?.data.data.offers[indexPath.row])!)
//          cell.displayDashboardOfferData(objOffer : (self.objDashboardAPIModel?.data.data.offers[indexPath.row]))
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section > 4 && indexPath.section < aryHeaders.count {
            
            let storyboard = UIStoryboard(name: "Shop", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
          destinationVC.offerId = "\(self.objDashboardAPIModel?.data.data.offers[indexPath.row].id ?? 0 )"
            self.navigationController?.pushViewController(destinationVC, animated: true)
            
        }else if indexPath.section == 2 {
            
            
            let objBanner = self.objDashboardAPIModel?.data.data.banners[indexPath.row]
            
            if objBanner?.attachmentType == "video" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
                destinationVC.urlLink = objBanner!.image  ?? ""
            self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
        
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = (cell as? SponsoredCell) else { return };
         
       let obj =  self.objDashboardAPIModel?.data.data.banners[indexPath.row]
         if obj?.attachmentType == "video" {
        let visibleCells = tableView.visibleCells;
        let minIndex = visibleCells.startIndex;
        // if tableView.visibleCells.firstIndex(of: cell) == minIndex {
            videoCell.videoPlayer.player?.play();
             videoCell.videoPlayer.player?.volume = 0.0
       // }
         }
    }
    
     func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? SponsoredCell else { return };
         let obj =  self.objDashboardAPIModel?.data.data.banners[indexPath.row]
           if obj?.attachmentType == "video" {
        videoCell.videoPlayer.player?.pause();
        videoCell.videoPlayer.player = nil;
           }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 0 //180
        } else if indexPath.section == 1 {
            return 0
        }
        return UITableView.automaticDimension
    }
    
 
}
