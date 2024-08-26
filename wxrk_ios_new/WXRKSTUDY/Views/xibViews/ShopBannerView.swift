//
//  ShopBannerView.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 19/08/22.
//

import AVKit
import AVFoundation

class ShopBannerView: UIView {
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var videoPlayer: PlayerView!


    func showHideView(isVideo: Bool) {
        
    }
    
    func displayData(objDataBanner : DataBanner){
        if objDataBanner.attachmentType == "video" {
            videoPlayer.isHidden = false
            playVideo(urlString: objDataBanner.image  ?? "")
        } else {
            videoPlayer.isHidden = true
            imgBanner.kf.setImage(with: URL(string: objDataBanner.image  ?? ""))
        }
    }
    
    func playVideo(urlString: String){
                let url = NSURL(string: urlString);
                let avPlayer = AVPlayer(url: url! as URL);
                videoPlayer?.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPlayer?.playerLayer.player = avPlayer;
    }
}
