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

class ViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var roof1: UIImageView!
    @IBOutlet weak var roof2: UIImageView!
    @IBOutlet weak var roof3: UIImageView!
    
    @IBOutlet weak var house1: UIImageView!
    @IBOutlet weak var house2: UIImageView!
    @IBOutlet weak var house3: UIImageView!
    @IBOutlet weak var house4: UIImageView!
    @IBOutlet weak var house5: UIImageView!
    
    @IBOutlet weak var window1: UIImageView!
    @IBOutlet weak var window2: UIImageView!
    @IBOutlet weak var window3: UIImageView!
    @IBOutlet weak var window4: UIImageView!
    @IBOutlet weak var window5: UIImageView!
    @IBOutlet weak var window6: UIImageView!
    @IBOutlet weak var window7: UIImageView!
    @IBOutlet weak var window8: UIImageView!
    @IBOutlet weak var window9: UIImageView!
    @IBOutlet weak var window10: UIImageView!
    
    @IBOutlet weak var door1: UIImageView!
    @IBOutlet weak var door2: UIImageView!
    @IBOutlet weak var door3: UIImageView!
    
    @IBOutlet weak var petal1: UIImageView!
    @IBOutlet weak var petal2: UIImageView!
    @IBOutlet weak var petal3: UIImageView!
    @IBOutlet weak var petal4: UIImageView!
    @IBOutlet weak var petal5: UIImageView!
    @IBOutlet weak var petal6: UIImageView!
    @IBOutlet weak var petal7: UIImageView!
    @IBOutlet weak var petal8: UIImageView!
    @IBOutlet weak var petal9: UIImageView!
    @IBOutlet weak var petal10: UIImageView!
    @IBOutlet weak var petal11: UIImageView!
    @IBOutlet weak var petal12: UIImageView!
    @IBOutlet weak var petal13: UIImageView!
    @IBOutlet weak var petal14: UIImageView!
    @IBOutlet weak var petal15: UIImageView!
    @IBOutlet weak var petal16: UIImageView!
    @IBOutlet weak var petal17: UIImageView!
    
    
    @IBOutlet weak var flowerpot1: UIImageView!
    @IBOutlet weak var flowerpot2: UIImageView!
    @IBOutlet weak var flowerpot3: UIImageView!
    @IBOutlet weak var flowerpot4: UIImageView!
    @IBOutlet weak var flowerpot5: UIImageView!
    
    var flag = "none"
    var current = "none"
    var previous = "none"
    
    var currentViews = [UIView]()
    
    var currentIndexes = [Int]()
    
    var highlighted = 0
    var currentIndex = 0

    let synth = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //drawHouse(origin_x: 0, origin_y: 0)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // two finger double tap
        let tfdoubletap = UITapGestureRecognizer(target: self, action: #selector(twoFingerDoubleTap))
        tfdoubletap.numberOfTapsRequired = 2
        tfdoubletap.numberOfTouchesRequired = 2
        innerView.addGestureRecognizer(tfdoubletap)
        
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = scrollView.frame.width / petal1.frame.width
        scrollView.delegate = self
        
        scrollView.isScrollEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        innerView.addGestureRecognizer(tap)
        
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
        
        tap.require(toFail: swipeLeft)
        tap.require(toFail: swipeRight)
        
        pan.require(toFail: swipeLeft)
        pan.require(toFail: swipeRight)
        
        background.accessibilityIdentifier = "background"
        
        roof1.accessibilityIdentifier = "roof1"
        roof2.accessibilityIdentifier = "roof2"
        roof3.accessibilityIdentifier = "roof3"
        
        house1.accessibilityIdentifier = "house1"
        house2.accessibilityIdentifier = "house2"
        house3.accessibilityIdentifier = "house3"
        house4.accessibilityIdentifier = "house4"
        house5.accessibilityIdentifier = "house5"
        
        window1.accessibilityIdentifier = "window1"
        window2.accessibilityIdentifier = "window2"
        window3.accessibilityIdentifier = "window3"
        window4.accessibilityIdentifier = "window4"
        window5.accessibilityIdentifier = "window5"
        window6.accessibilityIdentifier = "window6"
        window7.accessibilityIdentifier = "window7"
        window8.accessibilityIdentifier = "window8"
        window9.accessibilityIdentifier = "window9"
        window10.accessibilityIdentifier = "window10"
        
        door1.accessibilityIdentifier = "door1"
        door2.accessibilityIdentifier = "door2"
        door3.accessibilityIdentifier = "door3"
        
        petal1.accessibilityIdentifier = "petal1"
        petal2.accessibilityIdentifier = "petal2"
        petal3.accessibilityIdentifier = "petal3"
        petal4.accessibilityIdentifier = "petal4"
        petal5.accessibilityIdentifier = "petal5"
        petal6.accessibilityIdentifier = "petal6"
        petal7.accessibilityIdentifier = "petal7"
        petal8.accessibilityIdentifier = "petal8"
        petal9.accessibilityIdentifier = "petal9"
        petal10.accessibilityIdentifier = "petal10"
        petal11.accessibilityIdentifier = "petal11"
        petal12.accessibilityIdentifier = "petal12"
        petal13.accessibilityIdentifier = "petal13"
        petal14.accessibilityIdentifier = "petal14"
        petal15.accessibilityIdentifier = "petal15"
        petal16.accessibilityIdentifier = "petal16"
        petal17.accessibilityIdentifier = "petal17"
        
        flowerpot1.accessibilityIdentifier = "flowerpot1"
        flowerpot2.accessibilityIdentifier = "flowerpot2"
        flowerpot3.accessibilityIdentifier = "flowerpot3"
        flowerpot4.accessibilityIdentifier = "flowerpot4"
        flowerpot5.accessibilityIdentifier = "flowerpot5"
        
        let allViews = UIView.getAllSubviews(from: innerView)
        
        currentViews = allViews
        
        
        for view in currentViews {
           for i in 0...allViews.count - 1 {
               if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                   currentIndexes.append(i)
               }
           }
        }
    
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
        return true
    }
    
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        AudioServicesPlaySystemSound(1109)
        
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
        
        let allViews = UIView.getAllSubviews(from: innerView)
        
        currentViews.removeAll()
        currentIndexes.removeAll()
        
        for view in allViews{
            if hasIntersection(zoomedView: scrollView, subView: view) {
                currentViews.append(view)
                print(view.accessibilityIdentifier!)
            }
        }
        print("__________________")
        
        for view in currentViews {
           for i in 0...allViews.count - 1 {
               if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                   currentIndexes.append(i)
               }
           }
        }
        
        if currentIndexes[0] == 0 {
            highlighted = currentIndexes[1]
            currentIndex = 1
        }
        else {
            highlighted = currentIndexes[0]
            currentIndex = 0
        }
        
        
        for view in allViews{
            view.layer.borderWidth = 0
            print(view.accessibilityIdentifier!)
        }
        
  
    }
    
    @objc func twoFingerDoubleTap() {
        let origin = scrollView.frame.origin
        
        scrollView.zoom(to:CGRect(origin: origin, size: scrollView.frame.size), animated: true)
        AudioServicesPlaySystemSound(1109)
        tts(input: "zoomed out")
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
         self.navigationItem.title = "tap"
            
        let position = recognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
        
         var i = 0
        var touched = "background"
         
         for view in allViews{
             view.layer.borderWidth = 0
         }
        
        for view in allViews {
            
            let origin = view.frame.origin
            if position.x >= origin.x && position.x <= origin.x + view.frame.width && position.y >= origin.y && position.y <= origin.y + view.frame.height{
                
                allViews[highlighted].layer.borderWidth = 0
               
                touched = view.accessibilityIdentifier!
                
                highlighted = i
            }
            i += 1
            
         }
        
        if touched == "background"{
            tts(input: String(allViews[highlighted].accessibilityIdentifier!))
        }
        else{
            tts(input: String(touched))
        }
        
        allViews[highlighted].layer.borderWidth = 5
        
    }
    
    @objc func hasIntersection(zoomedView: UIScrollView, subView: UIView) -> Bool{
        
        let subRect = CGRect(origin: subView.frame.origin, size: subView.bounds.size)
        
        let origin = CGPoint(x: scrollView.contentOffset.x / scrollView.zoomScale, y: scrollView.contentOffset.y / scrollView.zoomScale)
        let size = CGSize(width: scrollView.contentSize.width / (scrollView.zoomScale * scrollView.zoomScale) , height: scrollView.contentSize.height / (scrollView.zoomScale * scrollView.zoomScale))
        
        let rect = CGRect(origin: origin, size: size)
       
        if rect.intersects(subRect) == true{
            return true
        }
        return false
        
    }
    
    
    @objc func getNextIndex(highlighted: Int, currentIndexes: [Int], mode: String) -> Int {
        
        for i in 0...currentIndexes.count - 1 {
            if currentIndexes[i] == highlighted {
                //print(highlighted)
                if mode == "right" {
                    return currentIndexes[i+1]
                }
                else if mode == "left" {
                    return currentIndexes[i-1]
                }
            }
        }
        
        return 0
    }
     
     @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer){
        let allViews = UIView.getAllSubviews(from: innerView)
        
        print(highlighted)
        print(currentIndexes)
       
        if gesture.direction == .right {
            //print("Swipe right detected")
            self.navigationItem.title = "swipe right"
            if highlighted < currentIndexes.last! {
                allViews[highlighted].layer.borderWidth = 0
                
               print(currentIndexes)
                print(highlighted)
                
                highlighted = getNextIndex(highlighted: highlighted, currentIndexes: currentIndexes, mode: "right")
                
                allViews[highlighted].layer.borderWidth = 5

                tts(input: allViews[highlighted].accessibilityIdentifier!)
            }
            else if highlighted == currentIndexes.last! {
                AudioServicesPlaySystemSound(1053)
            }
        }
        else if gesture.direction == .left {
            //print("Swipe left detected")
            self.navigationItem.title = "swipe left"
            if highlighted > currentIndexes.first! {
                allViews[highlighted].layer.borderWidth = 0
               
                highlighted = getNextIndex(highlighted: highlighted, currentIndexes: currentIndexes, mode: "left")
                
                allViews[highlighted].layer.borderWidth = 5

                tts(input: allViews[highlighted].accessibilityIdentifier!)
            }
            else if highlighted == currentIndexes.first! {
                AudioServicesPlaySystemSound(1053)
            }
        }
        
     
     }

     @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
         //self.navigationItem.title = "pan"
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
              for view1 in allViews{
                         view1.layer.borderWidth = 0
             }
              tts(input: String(flag))
              //print(flag)
             allViews[highlighted].layer.borderWidth = 5
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
        
        synth.stopSpeaking(at: .immediate)
        synth.speak(utterance)
    }
    
    
}




