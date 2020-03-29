//
//  ViewController2.swift
//  zoomable_user_interface
//
//  Created by kwon on 2020/03/17.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import SwiftUI

extension UIView {

    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        return parenView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    class func getAllSubviews(from parenView: UIView, types: [UIView.Type]) -> [UIView] {
        return parenView.subviews.flatMap { subView -> [UIView] in
            var result = getAllSubviews(from: subView) as [UIView]
            for type in types {
                if subView.classForCoder == type {
                    result.append(subView)
                    return result
                }
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get<T: UIView>(all type: T.Type) -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get(all types: [UIView.Type]) -> [UIView] { return UIView.getAllSubviews(from: self, types: types) }
}

class ViewController2: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var background: UIButton!
    @IBOutlet weak var house: UIButton!
    @IBOutlet weak var window1: UIButton!
    @IBOutlet weak var window2: UIButton!
    @IBOutlet weak var door: UIButton!
    @IBOutlet weak var flowerpot: UIButton!
    @IBOutlet weak var petal1: UIButton!
    @IBOutlet weak var petal2: UIButton!
    @IBOutlet weak var petal3: UIButton!
    @IBOutlet weak var petal4: UIButton!
    
    var flag = "none"
    var current = "none"
    var previous = "none"
    
    var highlighted = 0
    
    let synth = AVSpeechSynthesizer()
    //var flag = String(innerView.accessibilityLabel!)
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // two finger double tap
        let tfdoubletap = UITapGestureRecognizer(target: self, action: #selector(twoFingerDoubleTap))
        tfdoubletap.numberOfTapsRequired = 2
        tfdoubletap.numberOfTouchesRequired = 2
        innerView.addGestureRecognizer(tfdoubletap)
        

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
        
        
        let allViews = UIView.getAllSubviews(from: innerView)
        
        for view in allViews{
            if let btn = view as? UIButton {
                btn.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
                btn.addTarget(self,action: #selector(buttonDoubleTap), for: .touchDownRepeat)
            }
        }
        
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
                tts(input: allViews[highlighted].accessibilityIdentifier!.components(separatedBy: "_")[0])
            }
            else if highlighted == count - 1 {
                AudioServicesPlaySystemSound(1112)
            }
        }
        else if gesture.direction == .left {
            //print("Swipe left detected")
            if highlighted > 0 {
                highlighted -= 1
                tts(input: allViews[highlighted].accessibilityIdentifier!.components(separatedBy: "_")[0])
            }
            else if highlighted == 0{
                AudioServicesPlaySystemSound(1112)
            }
        }
    }

    @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
        let position = recognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
       
        previous = flag
        
        for view in allViews{
            if let btn = view as? UIButton {
                let origin = btn.frame.origin
                if position.x >= origin.x && position.x <= origin.x + btn.frame.width && position.y >= origin.y && position.y <= origin.y + btn.frame.height{
                    
                    if flag != String(btn.accessibilityIdentifier!){
                        
                        flag = String(btn.accessibilityIdentifier!)
                    }
                }
            }
        }
        if previous != flag{
           
            let utterance = AVSpeechUtterance(string: flag.components(separatedBy: "_")[0])
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

            synth.stopSpeaking(at: .immediate)
            synth.speak(utterance)
        }
    
    }
    
    @objc func buttonDoubleTap(_ sender: UIButton){
        
        let scale = sender.frame.width

            if scale != scrollView.zoomScale { //zoom in
                
                let point = sender.frame.origin
                
                let point_x = point.x + sender.frame.width/2
                let point_y = point.y + sender.frame.height/2
        
                let size = CGSize(width: scale,
                                  height: scale)
                let origin = CGPoint(x: point_x - size.width / 2,
                                     y: point_y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                
            } else if scrollView.zoomScale == sender.frame.width { //zoom out
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
    
    @objc func buttonTap(_ sender: UIButton){
      
        tts(input: sender.accessibilityIdentifier!.components(separatedBy: "_")[0])
         
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
      
        print("doubleTap zoomout")
        
    
    }
    
    @objc func twoFingerDoubleTap() {
        let origin = scrollView.frame.origin
        
        scrollView.zoom(to:CGRect(origin: origin, size: scrollView.frame.size), animated: true)
    }

    func tts(input: String){

        let utterance = AVSpeechUtterance(string: input)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        synth.stopSpeaking(at: .immediate)
        synth.speak(utterance)
    }
        
}
