//
//  ProfileViewController_Table_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import UIKit

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell") as! ProfileInfoCell
        cell.selectionStyle = .none
        let objUserDB = self.realm.objects(UserDB.self)

        switch indexPath.row {
        case 0:
            cell.lblTitle.text = "Your name"
            cell.lblValue.text =  UserDefaults.standard.value(forKey: "userName") as? String
        case 1:
            cell.lblTitle.text = "Phone number"
            cell.lblValue.text = UserDefaults.standard.value(forKey: "mobile") as? String

        case 2:
            cell.lblTitle.text = "Email"
            cell.lblValue.text = UserDefaults.standard.value(forKey: "userEmail") as? String

        default:
            cell.lblTitle.text = "Your date of birth"
            let dobString = UserDefaults.standard.value(forKey: "dateOfBirth") as? String
            cell.lblValue.text =  dobString?.datestringToStringDisplay(fromFotmat: "yyyy-MM-dd", toFormat: "dd MMM yyyy", style: .long)

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    
     }
    
}
