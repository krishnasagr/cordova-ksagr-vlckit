////
////  File.swift
////  videos-a
////
////  Created by Krishna sagar on 09/02/17.
////
////
//

//
import UIKit
import MediaPlayer

class ViewController: UIViewController, VLCMediaPlayerDelegate {
    
    var movieView: UIView!
    var mediaPlayer = VLCMediaPlayer()
    var volumeview = MPVolumeView()
    var button:UIButton!
    var urlValue:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        //Add rotation observer
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //Setup movieView
        self.movieView = UIView()
        self.movieView.backgroundColor = UIColor.gray
        self.movieView.frame = UIScreen.screens[0].bounds
        
        //Add tap gesture to movieView for play/pause
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.movieViewTapped(_:)))
        self.movieView.addGestureRecognizer(gesture)
        
        
        
        
        view.addSubview(self.movieView)
        //Add movieView to view controller
        button = UIButton(frame: CGRect(x: (self.movieView.frame.size.width - 90), y: 20, width: 80, height: 30))
        button.backgroundColor = UIColor.clear
        button.setTitle("Done", for:.normal)
        
        button.addTarget(self, action: #selector(dismissview(_:)) , for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    func dismissview(_ sender : UIButton){
        mediaPlayer.pause()
        self.dismiss(animated: true, completion:(()->Void)?{
            print("completed")
            self.movieView.removeFromSuperview()
            self.movieView = nil
            })
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //Playing multicast UDP (you can multicast a video from VLC)
        //let url = NSURL(string: "udp://@225.0.0.1:51018")
        
        //Playing HTTP from internet
        //        let url = NSURL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        
        let url = NSURL(string:self.urlValue)
        
        //        let url = NSURL(string: "http://admin:Abc@12345@192.168.1.66/video/mjpg.cgi")
        
        //Playing RTSP from internet
        //        let url = URL(string: "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_115k.mov")
        
        
        let media = VLCMedia(url: url as URL!)
        
        mediaPlayer.media = media
        print(self.urlValue)
        
        
        mediaPlayer.delegate = self
        mediaPlayer.drawable = self.movieView
        mediaPlayer.play()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func rotated() {
        
        let orientation = UIDevice.current.orientation
        
        if (UIDeviceOrientationIsLandscape(orientation)) {
            print("Switched to landscape")
        }
        else if(UIDeviceOrientationIsPortrait(orientation)) {
            print("Switched to portrait")
        }
        
        //Always fill entire screen
        self.movieView.frame = self.view.frame
        
        
    }
    
    func movieViewTapped(_ sender: UITapGestureRecognizer) {
        
        if mediaPlayer.isPlaying {
            mediaPlayer.pause()
            
            let remaining = mediaPlayer.remainingTime
            let time = mediaPlayer.time
            
            print("Paused at \(time) with \(remaining) time remaining")
            self.movieView.backgroundColor = UIColor.gray
        }
        else {
            mediaPlayer.play()
            self.movieView.backgroundColor = UIColor.black
            print("Playing")
        }
        
    }
    
    
}



