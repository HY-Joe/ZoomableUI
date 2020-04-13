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

class ViewController3: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var house: UIImageView!
    @IBOutlet weak var window1: UIImageView!
    @IBOutlet weak var window2: UIImageView!
    @IBOutlet weak var door: UIImageView!
    @IBOutlet weak var flowerpot: UIImageView!
    @IBOutlet weak var petal1: UIImageView!
    @IBOutlet weak var petal2: UIImageView!
    @IBOutlet weak var petal3: UIImageView!
    @IBOutlet weak var petal4: UIImageView!
    
    var flag = "none"
    var current = "none"
    var previous = "none"
    
    var highlighted = 0
    
    let synth = AVSpeechSynthesizer()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubletap.numberOfTapsRequired = 2
        doubletap.numberOfTouchesRequired = 1
        doubletap.require(toFail: doubletap)
        view.addGestureRecognizer(doubletap)
        
        // two finger double tap
        let tfdoubletap = UITapGestureRecognizer(target: self, action: #selector(twoFingerDoubleTap))
        tfdoubletap.numberOfTapsRequired = 2
        tfdoubletap.numberOfTouchesRequired = 2
        tfdoubletap.require(toFail: doubletap)
        view.addGestureRecognizer(tfdoubletap)
        
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 30.0
        scrollView.delegate = self
    
        scrollView.isScrollEnabled = false
        //scrollView.isUserInteractionEnabled = false
        
        house.accessibilityIdentifier = "house"
        window1.accessibilityIdentifier = "window_1"
        window2.accessibilityIdentifier = "window_2"
        door.accessibilityIdentifier = "door"
        flowerpot.accessibilityIdentifier = "flower pot"
        background.accessibilityIdentifier = "background"
        petal1.accessibilityIdentifier = "petal_1"
        petal2.accessibilityIdentifier = "petal_2"
        petal3.accessibilityIdentifier = "petal_3"
        petal4.accessibilityIdentifier = "petal_4"
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
       swipeLeft.delegate = self
       self.view.addGestureRecognizer(swipeLeft)
       
       let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
       swipeRight.direction = .right
       swipeRight.delegate = self
       self.view.addGestureRecognizer(swipeRight)
       
       let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
       pan.delegate = self
       innerView.addGestureRecognizer(pan)
           
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.require(toFail: doubletap)
        tap.delegate = self
        innerView.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
            
        let position = recognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
        
        var i = 0
        var touched = "background"
        
        for view in allViews{
            
             let origin = view.frame.origin
             if position.x >= origin.x && position.x <= origin.x + view.frame.width && position.y >= origin.y && position.y <= origin.y + view.frame.height{
                
                touched = view.accessibilityIdentifier!
                 highlighted = i
             }
             i += 1
         }
        
        tts(input: String(touched))
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
        return true
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer){
        let allViews = UIView.getAllSubviews(from: innerView)
        let count = allViews.count
        
        if gesture.direction == .right {
            //print("Swipe right detected")
            if highlighted < count - 1{
                highlighted += 1

                tts(input: allViews[highlighted].accessibilityIdentifier!)
            }
            else if highlighted == count - 1 {
                AudioServicesPlaySystemSound(1053)
            }
        }
        else if gesture.direction == .left {
            //print("Swipe left detected")
            if highlighted > 0 {
                highlighted -= 1

                tts(input: allViews[highlighted].accessibilityIdentifier!)
            }
            else if highlighted == 0{
                AudioServicesPlaySystemSound(1053)
            }
        }
    }
    
    @objc func buttonTap(_ sender: UIButton){
      
        let utterance = AVSpeechUtterance(string: sender.accessibilityIdentifier!.components(separatedBy: "_")[0])
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        synth.stopSpeaking(at: .immediate)
        synth.speak(utterance)
         
    }

     @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
           let position = recognizer.location(in: innerView)

           let allViews = UIView.getAllSubviews(from: innerView)
          
           previous = flag
           
           var i = 0

            for view in allViews{
                let origin = view.frame.origin
                if position.x >= origin.x && position.x <= origin.x + view.frame.width && position.y >= origin.y && position.y <= origin.y + view.frame.height{
                    
                    if flag != view.accessibilityIdentifier!{
                        
                        flag = view.accessibilityIdentifier!
                       highlighted = i
                    }
                }
               i += 1
            }
            if previous != flag{
                
                tts(input: String(flag))
                //print(flag)
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
            AudioServicesPlaySystemSound(1109)
            tts(input: "200%")
            
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
            AudioServicesPlaySystemSound(1109)
            tts(input: "400%")
            
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
            AudioServicesPlaySystemSound(1109)
            tts(input: "800%")
            
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
            /*
        else if scrollView.zoomScale == 8.0 { //zoom out
            
            tts(input: "100%")
            
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
 */
    }
    
    @objc func twoFingerDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1.0 { // zoom in
        
        }
        else if scrollView.zoomScale == 2.0{
            AudioServicesPlaySystemSound(1109)
            tts(input: "100%")
            
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
            AudioServicesPlaySystemSound(1109)
            tts(input: "200%")
            
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
            AudioServicesPlaySystemSound(1109)
            tts(input: "400%")
            
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
    
    func tts(input: String){

        let utterance = AVSpeechUtterance(string: input)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        synth.stopSpeaking(at: .immediate)
        synth.speak(utterance)
    }

    
}
