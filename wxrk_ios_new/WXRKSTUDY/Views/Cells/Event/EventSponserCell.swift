//
//  EventSponserCell.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 30/08/22.
//

import UIKit

class EventSponserCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewSponsers: UICollectionView!
    var ObjSponsors : [SponserEventDetails]? = []
    @IBOutlet weak var productCollectionViewHeight: NSLayoutConstraint!

    override func layoutSubviews() {
         super.layoutSubviews()
//         if !(__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize)){
//             self.invalidateIntrinsicContentSize()
//         }
        
     }
//     override var intrinsicContentSize: CGSize {
//         return contentSize
//     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productCollectionViewHeight.constant = 20
        collectionViewSponsers.delegate = self

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ObjSponsors?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponserCell", for: indexPath) as! SponserCell
      //  cell.displayData(objEvent: events[indexPath.item])
        
        cell.imgSponser.kf.setImage(with: URL(string: (ObjSponsors?[indexPath.item].fullURL)!))

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // delegate?.openEvent(eventId: "\(events[indexPath.item].id)")
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           return CGSize(width: 315 , height: 252)
//       }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 68, height:68)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 4

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}
