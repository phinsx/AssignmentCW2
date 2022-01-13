//
//  HomePage.swift
//  Assignment
//
//  Created by k ph on 10/1/2022.
//

import UIKit
import AVKit

class HomePage: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }

    func setUpVideo(){
        let bundlePath = Bundle.main.path(forResource: "HomeVideo", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
        videoPlayer = AVPlayer(playerItem:  item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
//        videoPlayerLayer?.frame = CGRect(x: 0, y: 0,
//                                         width: self.view.frame.size.width,
//                                         height: self.view.frame.size.height)
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.4,
                                         y: 0,
                                         width: self.view.frame.size.width*4,
                                         height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
