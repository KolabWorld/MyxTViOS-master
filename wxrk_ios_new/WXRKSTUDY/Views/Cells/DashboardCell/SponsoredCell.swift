//
//  SponsoredCell.swift
//  WXRKSTUDY
//
//  Created by Vishnu on 30/03/23.
//

import UIKit
import AVKit
import AVFoundation

class SponsoredCell: UITableViewCell //, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var imgSponsered: UIImageView!
    @IBOutlet weak var videoPlayer: PlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayData(objDataBanner : DataBanner){
        if objDataBanner.attachmentType == "video" {
            videoPlayer.isHidden = false
            playVideo(urlString: objDataBanner.image  ?? "")
        } else {
            videoPlayer.isHidden = true
            imgSponsered.kf.setImage(with: URL(string: objDataBanner.image ?? ""))
        }
    }
    
    func playVideo(urlString: String){
                let url = NSURL(string: urlString);
                let avPlayer = AVPlayer(url: url! as URL);
                videoPlayer?.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPlayer?.playerLayer.player = avPlayer;
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsoredCollectionCell", for: indexPath) as! SponsoredCollectionCell
//        return cell
//    }
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////           return CGSize(width: 100 , height: 120)
////       }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
