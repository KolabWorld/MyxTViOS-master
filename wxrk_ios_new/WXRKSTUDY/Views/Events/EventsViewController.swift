//
//  EventsViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 28/08/22.
//

import UIKit
import RealmSwift
import Alamofire
import SVProgressHUD
import SwiftyJSON
import Lottie

class EventsViewController: UIViewController, EventCellDelegate {
    
    @IBOutlet weak var lblNoRecodFound: UILabel!
    
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    
    @IBOutlet weak var tblEvents: UITableView!
    var realm : Realm!
    
    
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblFromDate: UILabel!
    @IBOutlet weak var lblToDate: UILabel!
    @IBOutlet weak var fromDateStack: UIStackView!
    @IBOutlet weak var toDateStack: UIStackView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lblVideos: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var datesViewHeightConstrants: NSLayoutConstraint!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    
    var datePickerFrom = "From"
    var strFromDate = ""
    var strToDate = ""
    
    
    @IBOutlet weak var vwDatePicker: UIView!
    
    var objEventsAPIModel : EventsAPIModel?
    var objTwitchAPIModel : TwitchVideosAPI?
    var isForTwitch = false
    var isTwitchBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // "updateEventList"
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateEventList),
            name: NSNotification.Name(rawValue: "updateEventList") ,
            object: nil)
        self.lblNoRecodFound.isHidden = true
        vwDatePicker.isHidden = true
        datePickerFrom = "From"
        setDateOnLabels(dateSe :  Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date())
        datePickerFrom = "To"
        setDateOnLabels(dateSe : Date())
        datePickerFrom = "From"
        
        
        btnBack.isHidden = true
        backBtnWidth.isActive = true
        backBtnWidth.constant = 0
        lblVideos.isHidden = false
        lblVideos.text = "EVENTS"
        if isTwitchBack == true {
            //lblVideos.isHidden = true
            btnBack.isHidden = false
            lblVideos.text = "VIDEOS"
            backBtnWidth.constant = 32
            
        }
        if isForTwitch == true {
            datesViewHeightConstrants.constant = 0
            lblVideos.text = "VIDEOS"
        }
        
        
        vwDatePicker.isHidden = true
        // Do any additional setup after loading the view.
        self.tblEvents.rowHeight = UITableView.automaticDimension
        self.tblEvents.estimatedRowHeight = 100
        
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(fromStackViewTapped))
        fromDateStack.addGestureRecognizer(tapFrom)
        
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(toStackViewTapped))
        toDateStack.addGestureRecognizer(tapTo)
        // Do any additional setup after loading the view.
        
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.backgroundColor = UIColor(red: 1.0/255.0, green: 16.0/255.0, blue: 39.0/255.0, alpha: 1)
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        addCellsInTableView()
        if isForTwitch == true {
            getTwitchVideos()
        } else {
            getEvents(fromDate: strFromDate, toDate: strToDate)
            
        }
        
    }
    func animateLotte(objEvent: Event) {
        animationView.isHidden = false
        // 1. Set animation content mode
        animationView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        animationView.loopMode = .playOnce
        // 3. Adjust animation speed
        animationView.animationSpeed = 1.0
        // 4. Play animation
        //  animationView.play()
        
        animationView.play { (finished) in
            self.animationView.isHidden = true
            
            let storyboard = UIStoryboard(name: "Events", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "EventJoinViewController") as! EventJoinViewController
            destinationVC.objEventHome = objEvent
            self.navigationController?.pushViewController(destinationVC, animated: true)
            
        }
    }
    @objc func updateEventList() {
        if isForTwitch == true {
            getTwitchVideos()
        } else {
            getEvents(fromDate: strFromDate, toDate: strToDate)
        }
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
        self.tblEvents.reloadData()
        
    }
    
    func addCellsInTableView() {
        tblEvents.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        tblEvents.register(UINib(nibName: "BlankCell", bundle: nil), forCellReuseIdentifier: "BlankCell")
        
    }
    
    @objc func dateChanged() {
        
        setDateOnLabels(dateSe : datePicker.date)
        
        
    }
    
    // MARK: - Action
    @objc func fromStackViewTapped() {
        datePickerFrom = "From"
        self.vwDatePicker.isHidden = false
        
    }
    
    @objc func toStackViewTapped() {
        datePickerFrom = "To"
        self.vwDatePicker.isHidden = false
        
    }
    @IBAction func actionDoneDatePicker(_ sender: Any) {
        self.vwDatePicker.isHidden = true
        
    }
    
    @IBAction func actionWallet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EventsViewController : UITableViewDelegate, UITableViewDataSource
{
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
        if isForTwitch == true {
            var countObj = objTwitchAPIModel?.data.data.twitchVideos.count ?? 0
            if countObj > 0 {
                countObj = countObj + 1
            }
            return countObj
            
        }
        var countObj = objEventsAPIModel?.data.data.events.count ?? 0
        if countObj > 0 {
            countObj = countObj + 1
        }
        return countObj
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        if isForTwitch == true {
            if indexPath.row < objTwitchAPIModel?.data.data.twitchVideos.count ?? 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
                cell.selectionStyle = .none
                cell.displayTwitchData(objData: (objTwitchAPIModel?.data.data.twitchVideos[indexPath.row])!)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell") as! BlankCell
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
                return cell
            }
            
        }
        if indexPath.row < objEventsAPIModel?.data.data.events.count ?? 0  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.displayData(objEvent: (objEventsAPIModel?.data.data.events[indexPath.row])!)
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell") as! BlankCell
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if isForTwitch == true {
            
            let objData : TwitchVideo = (objTwitchAPIModel?.data.data.twitchVideos[indexPath.row])!
            let storyboard = UIStoryboard(name: "Events", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "TwitchVideoViewController") as! TwitchVideoViewController
            destinationVC.objData = objData
            self.navigationController?.pushViewController(destinationVC, animated: true)
        } else {
            
            let storyboard = UIStoryboard(name: "Events", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
            destinationVC.offerId = "\(objEventsAPIModel?.data.data.events[indexPath.row].id ?? 0)"
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func joinEventClicked(objEvent: Event) {
        eventJoinAPI(objEvent: objEvent)
    }
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        
        let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
            
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}


extension EventsViewController {
    func getEvents(fromDate: String, toDate: String) {
        if fromDate.isEmpty {
            SVProgressHUD.show()
        }
        
        var param = [String: String]()
        param["from_date"] =  fromDate
        param["to_date"] =  toDate
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.getEventsAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: EventsAPIModel.self) { response in
            
            switch response.result {
            case .success(let post):
                self.objEventsAPIModel = post
                
                if self.objEventsAPIModel?.status != 200 {
                    self.showAlert(message: self.objEventsAPIModel?.errors?.message ?? "something wrong -> getEventsAPI", navigate: false)
                } else {
                    self.tblEvents.reloadData()
                }
                
                
                self.lblNoRecodFound.isHidden = true
                
                if self.objTwitchAPIModel?.data.data.twitchVideos.count == 0 {
                    self.lblNoRecodFound.isHidden = false
                }
                SVProgressHUD.dismiss()
                
                
            case .failure(let error):
                SVProgressHUD.dismiss()
                print("Failed with error: \(error)")
            }
        }
    }
    
    func getTwitchVideos(){
        
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.getTwitchVideosAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: TwitchVideosAPI.self) { response in
            
            switch response.result {
            case .success(let post):
                self.objTwitchAPIModel = post
                
                if self.objTwitchAPIModel?.status != 200 {
                    self.showAlert(message: self.objTwitchAPIModel?.errors?.message ?? "something wrong -> getTwitchVideosAPI", navigate: false)
                } else {
                    self.tblEvents.reloadData()
                }
                
                
                self.lblNoRecodFound.isHidden = true
                
                if self.objTwitchAPIModel?.data.data.twitchVideos.count == 0 {
                    self.lblNoRecodFound.isHidden = false
                }
                
                
                
                SVProgressHUD.dismiss()
                
            case .failure(let error):
                SVProgressHUD.dismiss()
                print("Failed with error: \(error)")
            }
        }
    }
    
    func eventJoinAPI(objEvent: Event) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        var param = [String: String]()
        param["user_id"] =  (UserDefaults.standard.value(forKey: "user_id") as! String)
        param["event_id"] =  "\(objEvent.id)"
        let url = URL(string: WxrsStudyAPI.joinEventAPI)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: param, options: [])
        request.headers = headers
        
        
        AF.request(request).response { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.value!)
                
                var message = json["data"]["message"].stringValue
                if message.count == 0 {
                    message = json["errors"]["message"].stringValue
                    let ac = UIAlertController(title: "", message: message , preferredStyle: .alert)
                    
                    
                    let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in
                        
                        let storyboard = UIStoryboard(name: "Events", bundle: nil)
                        let destinationVC = storyboard.instantiateViewController(withIdentifier: "EventJoinViewController") as! EventJoinViewController
                        destinationVC.objEventHome = objEvent
                        self?.navigationController?.pushViewController(destinationVC, animated: true)
                        
                        
                    }
                    ac.addAction(submitAction)
                    self.present(ac, animated: true)
                } else {
                    self.animateLotte(objEvent: objEvent)
                }
                
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
