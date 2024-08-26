//
//  AllTransactionViewController_Table_Ext.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 27/10/22.
//

import Foundation
import UIKit

extension AllTransactionViewController : UITableViewDelegate, UITableViewDataSource {
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
        lblNoDate.isHidden = true

        if objAllTransactionsAPIModel?.data.data.transactions.count == 0 {
            lblNoDate.isHidden = false
        }
        
        return objAllTransactionsAPIModel?.data.data.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTransactionCell") as! WalletTransactionCell
        cell.displayTransaction(objTransaction: (objAllTransactionsAPIModel?.data.data.transactions[indexPath.row])!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
}
