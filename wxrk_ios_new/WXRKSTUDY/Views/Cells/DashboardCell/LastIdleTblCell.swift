//
//  LastIdleTblCell.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 10/08/22.
//

import UIKit

class LastIdleTblCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource  {
    @IBOutlet weak var lblNoRecordWatchContent: UILabel!

    @IBOutlet weak var collectionViewLastIdle: UICollectionView!
    var objDayWiseSummary = [DayWiseSummary]()
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        self.collectionViewLastIdle.delegate = self
        self.collectionViewLastIdle.dataSource = self
       
        lblNoRecordWatchContent.text = "Hey \(UserDefaults.standard.value(forKey: "userName") ?? "") watch content now to track your weekly usage"
    }
    
    func registerCell() {
      
//        let nib = UINib(nibName: "LastIdleItemCell", bundle: nil)
//        self.collectionViewLastIdle.register(nib, forCellWithReuseIdentifier: "LastIdleItemCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewLastIdle.isHidden = false
        lblNoRecordWatchContent.isHidden = true

        if objDayWiseSummary.count == 0 {
            collectionViewLastIdle.isHidden = true
            lblNoRecordWatchContent.isHidden = false
        }
        
        return objDayWiseSummary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastIdleItemCell", for: indexPath) as! LastIdleItemCell
        
        cell.displayData(objDayWiseSummary: objDayWiseSummary[indexPath.item])
        
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 100 , height: 120)
       }
}
