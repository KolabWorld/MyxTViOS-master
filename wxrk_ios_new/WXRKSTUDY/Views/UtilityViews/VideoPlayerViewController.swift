//
//  VideoPlayerViewController.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 18/08/22.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    @IBOutlet weak var videoPlayer: PlayerView!
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoPlayer.isHidden = true
        playVideo(urlString: urlString)
    }
    func playVideo(urlString: String){
                let url = NSURL(string: urlString);
                let avPlayer = AVPlayer(url: url! as URL);
                videoPlayer?.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPlayer?.playerLayer.player = avPlayer;
                videoPlayer.player?.play();
    }

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        videoPlayer.player?.pause();
        videoPlayer.player = nil


    }
}
