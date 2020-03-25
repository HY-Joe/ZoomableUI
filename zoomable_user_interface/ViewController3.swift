//
//  ViewController3.swift
//  zoomable_user_interface
//
//  Created by kwon on 2020/03/17.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import AVFoundation

class ViewController3: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var rect1: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var button_3: UIButton!
    @IBOutlet weak var button_4: UIButton!
    @IBOutlet weak var button_5: UIButton!
    @IBOutlet weak var background: UIButton!
    
    var flag = "none"
    var current = "none"
    var previous = "none"
    
    let synth = AVSpeechSynthesizer()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        // triple tap
        let tripletap = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
        tripletap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripletap)
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubletap.numberOfTapsRequired = 2
        doubletap.numberOfTouchesRequired = 1
        doubletap.require(toFail: tripletap)
        doubletap.require(toFail: doubletap)
        view.addGestureRecognizer(doubletap)
        
        // two finger double tap
        let tfdoubletap = UITapGestureRecognizer(target: self, action: #selector(twoFingerDoubleTap))
        tfdoubletap.numberOfTapsRequired = 2
        tfdoubletap.numberOfTouchesRequired = 2
        tfdoubletap.require(toFail: tripletap)
        tfdoubletap.require(toFail: doubletap)
        view.addGestureRecognizer(tfdoubletap)
        

        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 8.0
        scrollView.delegate = self
    
        scrollView.isScrollEnabled = false
        //scrollView.isUserInteractionEnabled = false
        
    let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        innerView.addGestureRecognizer(pan)
        
    }

    @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
        let position = recognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
       
        previous = flag
        
        for view in allViews{
            if let btn = view as? UIButton {
                let origin = btn.frame.origin
                if position.x >= origin.x && position.x <= origin.x + btn.frame.width && position.y >= origin.y && position.y <= origin.y + btn.frame.height{
                    
                    if flag != String(btn.currentTitle!){
                        
                        flag = String(btn.currentTitle!)
                    }
                }
            }
        }
        if previous != flag{
           
            let utterance = AVSpeechUtterance(string: flag)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

            synth.stopSpeaking(at: .immediate)
            synth.speak(utterance)
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
    
    @objc func doubleTap(_ recognizer: UITapGestureRecognizer) {
        //let scale = scrollView.zoomScale * 2
        
        if scrollView.zoomScale == 1.0 { // zoom in
            
            let point = recognizer.location(in: innerView)
            print(point)
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / 2,
                              height: scrollSize.height / 2)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print("doubleTap zoomin")
            print(scrollView.zoomScale)
        
        }
        else if scrollView.zoomScale == 2.0{
            let point = recognizer.location(in: innerView)
            print(point)
            let scrollSize = scrollView.frame.size
            print("frame size")
            print(scrollView.frame.size)
            let size = CGSize(width: scrollSize.width / 4,
                              height: scrollSize.height / 4)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print("doubleTap zoomin")
            print(scrollView.zoomScale)
        }
        else if scrollView.zoomScale == 4.0{
            let point = recognizer.location(in: innerView)

            let scrollSize = scrollView.frame.size
            print("frame size")
            print(scrollView.frame.size)
            let size = CGSize(width: scrollSize.width / 8,
                              height: scrollSize.height / 8)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print("doubleTap zoomin")
            print(scrollView.zoomScale)
        }
        else if scrollView.zoomScale == 8.0 { //zoom out
            print("doubleTap zoomout")
            print(scrollView.zoomScale)
            let point = recognizer.location(in: innerView)

            let scrollSize = UIScreen.main.bounds.size
            let size = CGSize(width: scrollSize.width,
                              height: scrollSize.height)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
    }
    
    @objc func twoFingerDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1.0 { // zoom in
        
        }
        else if scrollView.zoomScale == 2.0{
            print("doubleTap zoomout")
            print(scrollView.zoomScale)
            let point = recognizer.location(in: innerView)

            let scrollSize = UIScreen.main.bounds.size
            let size = CGSize(width: scrollSize.width,
                              height: scrollSize.height)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
        else if scrollView.zoomScale == 4.0{
            let point = recognizer.location(in: innerView)
            print(point)
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / 2,
                              height: scrollSize.height / 2)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print("doubleTap zoomin")
            print(scrollView.zoomScale)
        }
        else if scrollView.zoomScale == 8.0 { //zoom out
            let point = recognizer.location(in: innerView)
            print(point)
            let scrollSize = scrollView.frame.size
            print("frame size")
            print(scrollView.frame.size)
            let size = CGSize(width: scrollSize.width / 4,
                              height: scrollSize.height / 4)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print("doubleTap zoomin")
            print(scrollView.zoomScale)
        }
    }
    
    @objc func tripleTapped(){
     
    }
    
    func tts(input: String){

        let utterance = AVSpeechUtterance(string: input)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }

    
}
