//
//  InsightViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 30/08/22.
//

import UIKit
import RealmSwift
import Alamofire
import SVProgressHUD
import SwiftyJSON
import SwiftUI
import Charts

class InsightViewController: UIViewController {
    
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var lblWeeklyAverage: UILabel!
    @IBOutlet weak var tblLast7DayData: UITableView!
    @IBOutlet weak var barChartView: BarChartView!
    
    
    @IBOutlet weak var lblDay1: UILabel!
    @IBOutlet weak var lblDay2: UILabel!
    @IBOutlet weak var lblDay3: UILabel!
    @IBOutlet weak var lblDay4: UILabel!
    @IBOutlet weak var lblDay5: UILabel!
    @IBOutlet weak var lblDay6: UILabel!
    @IBOutlet weak var lblDay7: UILabel!
    
    @IBOutlet weak var lblMinVal: UILabel!
    @IBOutlet weak var lblMaxVal: UILabel!

    
    var realm : Realm!
    var objInsightAPIModel : InsightAPIModel?
    
    var goals : [Double] = []
    var maximumValue = 0.0
    var weekDays  : [String] = []

    weak var axisFormatDelegate: AxisValueFormatter?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBalance.text = "0.0"
        if let balance = UserDefaults.standard.value(forKey: "WxrkBalanceValue") {
            lblBalance.text = balance as? String
        }
          insightDataAPI()
        axisFormatDelegate = self
        
        
    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
        func customizeChart(dataPoints: [String], values: [Double]) {
    
            lblDay1.text = dataPoints[0]
            lblDay2.text = dataPoints[1]
            lblDay3.text = dataPoints[2]
            lblDay4.text = dataPoints[3]
            lblDay5.text = dataPoints[4]
            lblDay6.text = dataPoints[5]
            lblDay7.text = dataPoints[6]

            
            
            
            //remove vertical grid and labels
                    self.barChartView.xAxis.drawGridLinesEnabled = false
                    self.barChartView.rightAxis.drawLabelsEnabled = false
                    self.barChartView.xAxis.drawLabelsEnabled = false
    
                    self.barChartView.legend.textColor = UIColor.clear
                    //change left numbers (bpm values)
            self.barChartView.leftAxis.labelTextColor = UIColor.clear
            self.barChartView.rightAxis.labelTextColor = UIColor.red
                    self.barChartView.rightAxis.labelTextColor = UIColor.red
                    //change right border line color
                    self.barChartView.rightAxis.axisLineColor = UIColor.clear
                    //change left border line to white
                    self.barChartView.leftAxis.axisLineColor = UIColor.clear
    
            self.barChartView.xAxis.axisLineColor = UIColor.clear
    
            self.barChartView.rightAxis.gridColor = UIColor.clear
    
            self.barChartView.leftAxis.gridColor = UIColor.clear //UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
    
            self.barChartView.drawBordersEnabled = false
            self.barChartView.borderColor = UIColor.clear
            self.barChartView.isUserInteractionEnabled = false
            self.barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
            self.barChartView.xAxis.labelTextColor = .clear
            self.barChartView.cornerRadius = CGFloat(25.0)
            var dataEntries: [BarChartDataEntry] = []
    
            if dataPoints.count > 0 {
                for i in 0..<7 {
                    
                    var value = 0.0
                    if (values.count - 1) >= i {
                        value  = Double(values[i])
                    }
                    
                    let dataEntry = BarChartDataEntry(x: Double(i), y: value)
                    dataEntries.append(dataEntry)
                }
            }
    
    
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
            let chartData = BarChartData(dataSet: chartDataSet)
            chartData.barWidth = Double(0.50)
            chartData.setValueTextColor(UIColor.clear)
    
         //   let chartData = BarChartData(xVals: salesMonths, dataSets: [chartDataSet])
    
            // Set bar chart data to previously created data
          //  barChart.data = chartData
    
    
            barChartView.data = chartData
            
            
            let yAxisLeft = barChartView.leftAxis
            yAxisLeft.drawGridLinesEnabled = true
            yAxisLeft.gridColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)
           // yAxisLeft.labelFont = Theme.Font.main(ofSize: 9, weight: .regular)
            yAxisLeft.labelXOffset = 2
            yAxisLeft.labelTextColor = UIColor.clear
            yAxisLeft.axisLineColor = UIColor.clear //UIColor(hex: "DCE5EE")
            yAxisLeft.drawAxisLineEnabled = false
            yAxisLeft.labelCount = 3
            yAxisLeft.axisMinLabels = 1
            yAxisLeft.enabled = true
            yAxisLeft.axisMinimum = 0
            
            
            
        }
    
    
    @IBAction func actionWallet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        destinationVC.notFromTabbar = true
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}
//InsightAPIModel

extension InsightViewController {
    func showAlert(message: String, navigate: Bool) {
        let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)

       
           let submitAction = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] action in

           }
           ac.addAction(submitAction)
           present(ac, animated: true)
    }
    
    func insightDataAPI() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [.authorization(bearerToken:   UserDefaults.standard.value(forKey: "user_token") as? String ?? "")]
        
        AF.request(WxrsStudyAPI.dashboardAPI, method: .get, parameters: nil, encoding:  JSONEncoding.default ,headers: headers).responseDecodable(of: InsightAPIModel.self) { response in
            
            switch response.result {
            case .success(let post):
                self.objInsightAPIModel = post
                if self.objInsightAPIModel?.status != 200 {
                    self.showAlert(message: self.objInsightAPIModel?.errors?.message ?? "something wrong -> dashboardAPI", navigate: false)
                } else {
                    for obj in self.objInsightAPIModel?.data.data.iosAppPerformace ?? [] {
                        
                        if self.weekDays.count == 0 {
                            
                            for i in 0...6 {
                                let yesterday = Calendar.current.date(byAdding: .day, value: -i, to: obj.createdAt!.returnDate())
                                let dayInitial  =  yesterday!.dayNameOfWeek()?.first
                                self.weekDays.append("\(String(describing: dayInitial!))")
                            }
                        }
                        let valueIdle = Double(Int(obj.watchTime ?? "00") ?? 00)
                        self.goals.append(valueIdle)
                    }
                    
                    
                    
                    if self.weekDays.count == 0 {
                        
                        for i in 0...6 {
                            let yesterday = Calendar.current.date(byAdding: .day, value: -i, to: Date())
                            let dayInitial  =  yesterday!.dayNameOfWeek()?.first
                            self.weekDays.append("\(String(describing: dayInitial!))")
                        }
                    }
                    
                    
                    //   self.setChart(dataEntryX: players , dataEntryY: self.goals)
                    
                    
                    //  self.months = ["W", "T", "M", "S", "S", "F", "T"]
                    //   self.unitsSold = [120.0, 4.0, 336.0, 663.0, 312.0, 116.0, 4.0]
                    self.maximumValue = self.goals.max() ?? 0.0
                    
                    
                    // let time = Double( Double(Int(self.maximumValue ?? "00") ?? 00))
                    
                    if (self.minutesToHoursAndMinutes(self.maximumValue/60).hours) != 0 {
                        self.lblMinVal.text = "0 hr"
                        self.lblMaxVal.text = "\(self.minutesToHoursAndMinutes(self.maximumValue/60).hours)) hr"
                        
                    } else if (self.minutesToHoursAndMinutes(self.maximumValue/60).leftMinutes) != 0 {
                        self.lblMinVal.text = "0 min"
                        self.lblMaxVal.text = "\(self.minutesToHoursAndMinutes(self.maximumValue/60).leftMinutes) min"
                    } else {
                        self.lblMinVal.text = "0 sec"
                        self.lblMaxVal.text = "\(self.minutesToHoursAndMinutes(self.maximumValue/60).leftMinutes) sec"
                    }
                    
                    // lblIdelTime.text =  "\(minutesToHoursAndMinutes(time/60).hours)h \(minutesToHoursAndMinutes(time/60).leftMinutes)m"
                    
                    
                    self.customizeChart(dataPoints: self.weekDays as? [String] ?? [""] , values: self.goals.map{ Double($0) })
                    
                    self.tblLast7DayData.reloadData()
                    SVProgressHUD.dismiss()
                }
                SVProgressHUD.dismiss()

            case .failure(let error):
                SVProgressHUD.dismiss()
                print("Failed with error: \(error)")
            }
        }
    }
    func minutesToHoursAndMinutes(_ minutes: Double) -> (hours: Int , leftMinutes: Int) {
        return (Int(minutes) / 60, (Int(minutes) % 60))
    }
    
}
extension InsightViewController : UITableViewDelegate, UITableViewDataSource {
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
        return objInsightAPIModel?.data.data.iosAppPerformace.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsightDataCell") as! InsightDataCell
        cell.displayInsightData(objInsight: (objInsightAPIModel?.data.data.iosAppPerformace[indexPath.row])!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
}

struct Anchor<T: AnyObject>{
    var type: NSLayoutAnchor<T>
    var constant: CGFloat? = 0.0
}

extension UIView {
    func setAnchors<T: AnyObject>(top: Anchor<T>? = nil,
                                  bottom: Anchor<T>? = nil,
                                  leading: Anchor<T>? = nil,
                                  trailing: Anchor<T>? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top, let anchorType = top.type as? NSLayoutAnchor<NSLayoutYAxisAnchor>, let constant = top.constant {
            let constraint = topAnchor.constraint(equalTo: anchorType, constant: constant)
            constraint.isActive = true
        }
        
        if let bottom = bottom, let anchorType = bottom.type as? NSLayoutAnchor<NSLayoutYAxisAnchor>, let constant = bottom.constant {
            let constraint = bottomAnchor.constraint(equalTo: anchorType, constant: constant)
            constraint.isActive = true
        }
        
        if let leading = leading, let anchorType = leading.type as? NSLayoutAnchor<NSLayoutXAxisAnchor>, let constant = leading.constant {
            let constraint = leadingAnchor.constraint(equalTo: anchorType, constant: constant)
            constraint.isActive = true
        }
        
        if let trailing = trailing, let anchorType = trailing.type as? NSLayoutAnchor<NSLayoutXAxisAnchor>, let constant = trailing.constant {
            let constraint = trailingAnchor.constraint(equalTo: anchorType, constant: constant)
            constraint.isActive = true
        }
    }
}
extension InsightViewController: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return weekDays[Int(value)]
    }
}
