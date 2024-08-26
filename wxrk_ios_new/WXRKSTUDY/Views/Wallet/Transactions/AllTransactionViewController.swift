//
//  AllTransactionViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 25/08/22.
//

import UIKit
import RealmSwift


class AllTransactionViewController: UIViewController {
    var realm : Realm!

    @IBOutlet weak var vwDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblFromDate: UILabel!
    @IBOutlet weak var lblToDate: UILabel!
    @IBOutlet weak var lblNoDate: UILabel!
    @IBOutlet weak var lblSelectDateFor: UILabel!

    @IBOutlet weak var tblWalletTransactions: UITableView!
    var objAllTransactionsAPIModel : AllTransactionsAPIModel?

    @IBOutlet weak var fromDateStack: UIStackView!
    @IBOutlet weak var toDateStack: UIStackView!
    var datePickerFrom = "From"
    var strFromDate = ""
    var strToDate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwDatePicker.isHidden = true
        datePickerFrom = "From"
        setDateOnLabels(dateSe :  Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date())
        datePickerFrom = "To"
        setDateOnLabels(dateSe : Date())
        datePickerFrom = "From"

        
        
        
        
        
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(fromStackViewTapped))
        fromDateStack.addGestureRecognizer(tapFrom)
        
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(toStackViewTapped))
        toDateStack.addGestureRecognizer(tapTo)
        // Do any additional setup after loading the view.
        
        topTransactionAPI(fromDate: strFromDate, toDate: strToDate)
        realm = try! Realm()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.backgroundColor = UIColor(red: 1.0/255.0, green: 16.0/255.0, blue: 39.0/255.0, alpha: 1)

        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
    }
    
    @objc func dateChanged() {
        setDateOnLabels(dateSe : datePicker.date)
    }

    func setDateOnLabels(dateSe : Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let dateFormatterAPI = DateFormatter()
        dateFormatterAPI.dateFormat = "yyyy-MM-dd"

      if datePickerFrom == "From" {
          lblFromDate.text =  dateFormatter.string(from: dateSe)
          strFromDate = dateFormatterAPI.string(from: dateSe)
      } else {
          lblToDate.text =  dateFormatter.string(from: dateSe)
          strToDate = dateFormatterAPI.string(from: dateSe)
      }
    }
    
    
    // MARK: - Action
    @objc func fromStackViewTapped() {
        lblSelectDateFor.text = "Select From Date"
        datePickerFrom = "From"
        self.vwDatePicker.isHidden = false

    }
    
    @objc func toStackViewTapped() {
        lblSelectDateFor.text = "Select To Date"

        datePickerFrom = "To"
        self.vwDatePicker.isHidden = false

    }
    @IBAction func actionDoneDatePicker(_ sender: Any) {
        self.vwDatePicker.isHidden = true
        topTransactionAPI(fromDate: strFromDate, toDate: strToDate)

    }
    
    @IBAction func actionWallet(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: WalletViewController .self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionDateFrom(_ sender: Any) {
        lblSelectDateFor
    }
    
    @IBAction func actionDateTo(_ sender: Any) {
        
    }

}





//topTransactionsAPI


