//
//  DailyRewardsCell.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 09/08/22.
//

import UIKit

class DailyRewardsCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewRewards: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        self.collectionViewRewards.delegate = self
        self.collectionViewRewards.dataSource = self
    }
    func registerCell() {
       // collectionViewRewards.register(RewardItemCell.self, forCellWithReuseIdentifier: "RewardItemCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardItemCell", for: indexPath) as! RewardItemCell
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           return CGSize(width: 100 , height: 120)
//       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
