//
//  UpcommingEventCell.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 07/08/22.
//

import UIKit
import Kingfisher

protocol upcommingEventDelegate: AnyObject {
    func joinEventClicked(objEvent: Event)
    func openEvent(eventId: String)
}

class UpcommingEventCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UpcommingEventCollectionCellDelegate {
   
    
    @IBOutlet weak var collectionViewEvents: UICollectionView!
    var events = [Event]()
    weak var delegate: upcommingEventDelegate?

    @IBOutlet weak var scrollBtn: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnJoinNow: UIButton!
    @IBOutlet weak var vwJoinNow: UIView!

    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var imgForward: UIImageView!

    var linkToOpen = ""
    var counter = 0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCell()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func scrollBtnAction(_ sender: UIButton) {
        if counter < events.count{
            counter += 1
            if counter != events.count{
                DispatchQueue.main.async {
                    self.collectionViewEvents.scrollToItem(at:IndexPath(item: self.counter, section: 0), at: .centeredHorizontally, animated: true)
                }
            }
        }else {
            counter = 0
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y == 0.0{
            self.counter = 0
        }
    }
    
    func displayData(objEvent : Event){
        lblDate.text = objEvent.name
        lblName.text = objEvent.name
        lblDescription.text = objEvent.eventDescription
        setGradientBackground()
        imgEvent.kf.setImage(with: URL(string: objEvent.thumbnailImage  ?? ""))
        let dateObj = objEvent.startDateTime?.datestringToStringDisplay(style: .long)
        lblDate.text = dateObj?.components(separatedBy: ",").last
        lblMonth.text = dateObj?.components(separatedBy: ",").first
        //linkToOpen = objEvent.link
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 45.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 32.0/255.0, green: 78.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
                
        vwJoinNow.layer.insertSublayer(gradientLayer, at:0)
    }
    func registerCell() {
       // collectionViewEvents.register(UpcommingEventCollectionCell.self, forCellWithReuseIdentifier: "UpcommingEventCollectionCell")
        
        let nib = UINib(nibName: "UpcommingEventCollectionCell", bundle: nil)
        self.collectionViewEvents.register(nib, forCellWithReuseIdentifier: "UpcommingEventCollectionCell")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.scrollBtn.isHidden = false
        if events.count == 0 {
            self.scrollBtn.isHidden = true
        }
        return events.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcommingEventCollectionCell", for: indexPath) as! UpcommingEventCollectionCell
        cell.displayData(objEvent: events[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.openEvent(eventId: "\(events[indexPath.item].id)")
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.35, height: 252)
    }

    func openJoinLink(objEvent: Event) {
        delegate?.joinEventClicked(objEvent: objEvent)
    }
    
    
    
}
