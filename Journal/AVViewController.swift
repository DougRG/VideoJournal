//
//  AVViewController.swift
//  Journal
//
//  Created by Douglas Goodwin on 12/5/15.
//  Copyright © 2015 Dr.G. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation



class AVViewController: AVPlayerViewController {
    
    var videoURL: NSURL?
    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
//   override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        playerItem = AVPlayerItem(URL: videoURL! as NSURL)
//        print("url: \(videoURL)")
//        player = AVPlayer(playerItem: self.playerItem!)
//        player!.play()
//
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        playerItem = AVPlayerItem(URL: videoURL!)
        player = AVPlayer(playerItem: self.playerItem!)
        player?.play()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
