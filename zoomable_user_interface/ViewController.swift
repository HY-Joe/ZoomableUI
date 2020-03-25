//
//  ViewController.swift
//  zoomable_user_interface
//
//  Created by kwon on 03/03/2020.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import UIKit
import AVFoundation
import CoreGraphics

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imageview1: UIImageView!
    @IBOutlet weak var imageview2: UIImageView!
    @IBOutlet weak var imageview3: UIImageView!
    @IBOutlet weak var imageview4: UIImageView!
    @IBOutlet weak var imageview5: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    var flag = "none"
    var current = "none"
    var previous = "none"
    
    let synth = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //drawHouse(origin_x: 0, origin_y: 0)
        
        imageview1.accessibilityIdentifier = "1"
        imageview2.accessibilityIdentifier = "2"
        imageview3.accessibilityIdentifier = "3"
        imageview4.accessibilityIdentifier = "4"
        imageview5.accessibilityIdentifier = "5"
        background.accessibilityIdentifier = "background"
        
   
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.delegate = self
        
        scrollView.isScrollEnabled = false
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        innerView.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        innerView.addGestureRecognizer(tap)
        
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        tts(input: "decelerating")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale == scrollView.minimumZoomScale
        {
            print("zoomed out")
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let zoomscale = Int(Double(round(1000 * scrollView.zoomScale) / 1000) * 100 / 10) * 10
        tts(input: String(zoomscale) + "%")
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
        
        let position = recognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
        
        var touched = "background"
        
        for view in allViews{
            
             let origin = view.frame.origin
             if position.x >= origin.x && position.x <= origin.x + view.frame.width && position.y >= origin.y && position.y <= origin.y + view.frame.height{
                
                touched = view.accessibilityIdentifier!
             }
             
         }
        
        tts(input: touched)
        
    }

    @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
        let position = recognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
       
        previous = flag
        
        for view in allViews{
            let origin = view.frame.origin
            if position.x >= origin.x && position.x <= origin.x + view.frame.width && position.y >= origin.y && position.y <= origin.y + view.frame.height{
                
                if flag != view.accessibilityIdentifier!{
                    
                    flag = view.accessibilityIdentifier!
                }
            }
        }
        if previous != flag{
           
            let utterance = AVSpeechUtterance(string: flag)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

            synth.stopSpeaking(at: .immediate)
            synth.speak(utterance)
            //print(flag)
        }
    
    }
    
    @objc func buttonTap(_ sender: UIButton){
        print(sender.tag)
        let scale = min(scrollView.zoomScale * 2, scrollView.maximumZoomScale)

        if scale != scrollView.zoomScale { // zoom in
            
            let point = sender.frame.origin
            
            let point_x = point.x + sender.frame.width/2
            let point_y = point.y + sender.frame.height/2
        
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / scrollView.maximumZoomScale,
                              height: scrollSize.height / scrollView.maximumZoomScale)
            let origin = CGPoint(x: point_x - size.width / 2,
                                 y: point_y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print(scrollView.zoomScale)
        } else if scrollView.zoomScale == 2.0 { //zoom out
            let point = sender.frame.origin
            
            let point_x = point.x + sender.frame.width/2
            let point_y = point.y + sender.frame.height/2

            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width,
                              height: scrollSize.height)
            let origin = CGPoint(x: point_x - size.width / 2,
                                 y: point_y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @available(iOS 2.0, *)
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.innerView
    }
    
    func tts(input: String){

        let utterance = AVSpeechUtterance(string: input)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    
}




