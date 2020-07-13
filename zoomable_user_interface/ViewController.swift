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

extension String {
    func appendLine(to url: URL) throws {
        try self.appending("\n").append(to: url)
    }
    func append(to url: URL) throws {
        let data = self.data(using: String.Encoding.utf8)
        try data?.append(to: url)
    }
}

extension Data {
    func append(to url: URL) throws {
        if let fileHandle = try? FileHandle(forWritingTo: url) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: url)
        }
    }
}

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
    
    var highlighted = 1
    var currentIndex = 1
    
    var selectedMenu = ""

    let synth = AVSpeechSynthesizer()
    
    // for fixed zoom level
    var zoomLevel = 1
    
    var rotateMode = 0 // 0: touch-to-explore, 1: panning
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //drawHouse(origin_x: 0, origin_y: 0)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // outlet
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
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubletap.numberOfTapsRequired = 2
        doubletap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(doubletap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.require(toFail: doubletap)
        innerView.addGestureRecognizer(tap)
        /*
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        swipeLeft.delegate = self
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        swipeRight.delegate = self
        self.view.addGestureRecognizer(swipeRight)
        */
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        pan.delegate = self
        innerView.addGestureRecognizer(pan)
        
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        rotate.delegate = self
        innerView.addGestureRecognizer(rotate)
        /*
        tap.require(toFail: swipeLeft)
        tap.require(toFail: swipeRight)
        
        pan.require(toFail: swipeLeft)
        pan.require(toFail: swipeRight)
        */
        let allViews = UIView.getAllSubviews(from: innerView)
        
        currentViews = allViews
        
        for view in currentViews {
           for i in 0...allViews.count - 1 {
               if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                   currentIndexes.append(i)
               }
           }
        }
        
        allViews[highlighted].layer.borderWidth = 5
        
        print(mode)
        print(PID)
        
    }
    
    @objc func handleRotation(_ gestureRecognizer: UIRotationGestureRecognizer) {
            
        gestureRecognizer.rotation = 0
        
        if gestureRecognizer.state == .ended {
            if rotateMode == 0 {
                rotateMode = 1
                tts(input: "panning mode")
                scrollView.isScrollEnabled = true
            }
            else {
                rotateMode = 0
                tts(input: "touch to explore mode")
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            
            return true
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        
        if mode == "pinch" {
        
            AudioServicesPlaySystemSound(1109)
            
            // writeLog(PID: PID, mode: mode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "pinch", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentViews)")
        }
        
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        //tts(input: "decelerating")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale == scrollView.minimumZoomScale
        {
            //print("zoomed out")
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        if mode == "pinch" {
            
            let zoomscale = Int(Double(round(1000 * scrollView.zoomScale) / 1000) * 100 / 10) * 10
            tts(input: String(zoomscale) + "%")
            
            let allViews = UIView.getAllSubviews(from: innerView)
            
            currentViews.removeAll()
            currentIndexes.removeAll()
            
            for view in allViews{
                if hasIntersection(zoomedView: scrollView, subView: view) {
                    currentViews.append(view)
                    //print(view.accessibilityIdentifier!)
                }
            }
            //print("__________________")
            
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
            }
            
            allViews[highlighted].layer.borderWidth = 5
            //(PID: String, mode: String, timestamp: String, state: Int, gesture: String, zoomScale: CGFloat, location: CGPoint, highlightedObject: Int, currentViews: String)
          
            
        }
    
        
    }
    
    @objc func handleDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        if mode == "functional" {
            let allViews = UIView.getAllSubviews(from: innerView)
             
            let scale = allViews[highlighted].frame.width + CGFloat(60)

             if allViews[highlighted].accessibilityIdentifier != "background"{
                 if scale != scrollView.zoomScale { //zoom in
                         
                     let point = allViews[highlighted].frame.origin
                     
                     let point_x = point.x + allViews[highlighted].frame.width/2
                     let point_y = point.y + allViews[highlighted].frame.height/2
             
                     let size = CGSize(width: scale,
                                       height: scale)
                     let origin = CGPoint(x: point_x - size.width / 2,
                                          y: point_y - size.height / 2)
                     scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                    
                    AudioServicesPlaySystemSound(1109)
                     
                    tts(input: String(allViews[highlighted].accessibilityIdentifier!) + "zoomed")
                         
                 } else if scrollView.zoomScale == allViews[highlighted].frame.width { //zoom out
                     let point = allViews[highlighted].frame.origin
                     
                     let point_x = point.x + allViews[highlighted].frame.width/2
                     let point_y = point.y + allViews[highlighted].frame.height/2

                     let scrollSize = scrollView.frame.size
                     let size = CGSize(width: scrollSize.width,
                                       height: scrollSize.height)
                     let origin = CGPoint(x: point_x - size.width / 2,
                                          y: point_y - size.height / 2)
                     scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                     AudioServicesPlaySystemSound(1109)
                     tts(input: "zoomed out")
                 }
             }
             
             //get currentViews
            currentViews.removeAll()
            currentIndexes.removeAll()
            
            for view in allViews{
                if hasIntersection(zoomedView: scrollView, subView: view) == true {
                    currentViews.append(view)
                    //print(view.accessibilityIdentifier!)
                }
            }
            //print("__________________")
            
            for view in currentViews {
               for i in 0...allViews.count - 1 {
                   if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                       currentIndexes.append(i)
                   }
               }
            }
            
            highlighted = currentIndexes[0]
            currentIndex = 0
            
            for view in allViews{
                 view.layer.borderWidth = 0
             }
        }
        
        else if mode == "fixed" {
            //let scale = scrollView.zoomScale * 2
            
            if zoomLevel == 1 { // zoom in
                AudioServicesPlaySystemSound(1109)
                tts(input: "200%")
                
                zoomLevel = 2
                
                let point = gestureRecognizer.location(in: innerView)
                //print(point)
                let scrollSize = scrollView.frame.size
                let size = CGSize(width: scrollSize.width / 2,
                                  height: scrollSize.height / 2)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                //print("doubleTap zoomin")
                //print(scrollView.zoomScale)
            
            }
            else if zoomLevel == 2 {
                AudioServicesPlaySystemSound(1109)
                tts(input: "400%")
                zoomLevel = 4
                
                let point = gestureRecognizer.location(in: innerView)
                //print(point)
                let scrollSize = scrollView.frame.size
                //print("frame size")
                //print(scrollView.frame.size)
                let size = CGSize(width: scrollSize.width / 4,
                                  height: scrollSize.height / 4)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                //print("doubleTap zoomin")
                //print(scrollView.zoomScale)
            }
            else if zoomLevel == 4 {
                AudioServicesPlaySystemSound(1109)
                tts(input: "800%")
                
                zoomLevel = 8
                
                let point = gestureRecognizer.location(in: innerView)

                let scrollSize = scrollView.frame.size
                //print("frame size")
                //print(scrollView.frame.size)
                let size = CGSize(width: scrollSize.width / 8,
                                  height: scrollSize.height / 8)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                //print("doubleTap zoomin")
                //print(scrollView.zoomScale)
            }
            
            //get currentViews
            let allViews = UIView.getAllSubviews(from: innerView)
            
            currentViews.removeAll()
            currentIndexes.removeAll()
            
            for view in allViews{
                if hasIntersection(zoomedView: scrollView, subView: view) == true {
                    currentViews.append(view)
                    //print(view.accessibilityIdentifier!)
                }
            }
            //print("__________________")
            
            for view in currentViews {
               for i in 0...allViews.count - 1 {
                   if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                       currentIndexes.append(i)
                   }
               }
            }
            
            highlighted = currentIndexes[0]
            currentIndex = 0
            
            for view in allViews{
                 view.layer.borderWidth = 0
             }
        }
        
        writeLog(PID: PID, mode: mode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "double tap", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
    
       }
    
    @objc func twoFingerDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if mode == "pinch" || mode == "functional" {
            let origin = scrollView.frame.origin
            
            scrollView.zoom(to:CGRect(origin: origin, size: scrollView.frame.size), animated: true)
            AudioServicesPlaySystemSound(1109)
            tts(input: "zoomed out")
        }
        
        else if mode == "fixed" {
            if scrollView.zoomScale == 1.0 { // zoom in
            
            }
            else if zoomLevel == 2 {
                AudioServicesPlaySystemSound(1109)
                tts(input: "100%")
                
                zoomLevel = 1
                
                print("doubleTap zoomout")
                print(scrollView.zoomScale)
                let point = gestureRecognizer.location(in: innerView)

                let scrollSize = UIScreen.main.bounds.size
                let size = CGSize(width: scrollSize.width,
                                  height: scrollSize.height)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            }
            else if zoomLevel == 4 {
                AudioServicesPlaySystemSound(1109)
                tts(input: "200%")
                
                zoomLevel = 2
                
                let point = gestureRecognizer.location(in: innerView)
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
            else if zoomLevel == 8 { //zoom out
                AudioServicesPlaySystemSound(1109)
                tts(input: "400%")
                
                zoomLevel = 4
                
                let point = gestureRecognizer.location(in: innerView)
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
            
            //get currentViews
            let allViews = UIView.getAllSubviews(from: innerView)
            
            currentViews.removeAll()
            currentIndexes.removeAll()
            
            for view in allViews{
                if hasIntersection(zoomedView: scrollView, subView: view) == true {
                    currentViews.append(view)
                    //print(view.accessibilityIdentifier!)
                }
            }
            //print("__________________")
            
            for view in currentViews {
               for i in 0...allViews.count - 1 {
                   if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                       currentIndexes.append(i)
                   }
               }
            }
            
            highlighted = currentIndexes[0]
            currentIndex = 0
            
            for view in allViews{
                 view.layer.borderWidth = 0
             }
        }
        
        writeLog(PID: PID, mode: mode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "2-finger double tap", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer){
        
        self.navigationItem.title = "tap"
            
        let position = gestureRecognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
        
         var i = -1
        var touched = "background"
        var touchedIndex = -1
         
         for view in allViews{
             view.layer.borderWidth = 0
         }
        
        for view in allViews {
            i += 1
            
            let origin = view.frame.origin
            if position.x >= origin.x && position.x <= origin.x + view.frame.width && position.y >= origin.y && position.y <= origin.y + view.frame.height{
                
                allViews[highlighted].layer.borderWidth = 0
               
                touched = view.accessibilityIdentifier!
                
                touchedIndex = i
            }
            
         }
        
        if touched == "background" {
            
            //AudioServicesPlaySystemSound(1255)
        }
        else{
            highlighted = touchedIndex
            tts(input: String(touched))
        }
        
        allViews[highlighted].layer.borderWidth = 5
        
    }
     
     @objc func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer){
        let allViews = UIView.getAllSubviews(from: innerView)
        
        //print(highlighted)
        //print(currentIndexes)
        
        if currentIndexes[0] == 0 {
            currentIndexes.remove(at: 0)
        }
        
        if highlighted == 0 {
            highlighted = currentIndexes[0]
        }
       
        if gestureRecognizer.direction == .right {
            //print("Swipe right detected")
            self.navigationItem.title = "swipe right"
            if highlighted < currentIndexes.last! {
                allViews[highlighted].layer.borderWidth = 0
                
               //print(currentIndexes)
                //print(highlighted)
                
                highlighted = getNextIndex(highlighted: highlighted, currentIndexes: currentIndexes, mode: "right")
                
                allViews[highlighted].layer.borderWidth = 5

                tts(input: allViews[highlighted].accessibilityIdentifier!)
            }
            else if highlighted == currentIndexes.last! {
                AudioServicesPlaySystemSound(1053)
            }
            
            writeLog(PID: PID, mode: mode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "swipe right", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
        }
        else if gestureRecognizer.direction == .left {
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
            
            writeLog(PID: PID, mode: mode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "swipe left", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
        }
        
        if gestureRecognizer.state == .ended {
            print("swipe has ended")
            return
        }
     
     }

     @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer){
        
        let velocity = gestureRecognizer.velocity(in: innerView)
        
        var speed = sqrt(pow(Double(velocity.x), 2) + pow(Double(velocity.y), 2))
        
        var direction = ""
        
        if abs(velocity.x) > abs(velocity.y) {

            if velocity.x < 0 {
                direction = "left"
            }
            else {
                direction = "right"
            }

        }

        if speed > 900 && gestureRecognizer.state == .ended {
            if direction == "left" {
                print("swipe left")
            }
            else if direction == "right" {
                print("swipe right")
            }
            
        }
        
        /*
        if rotateMode == 0 { // touch-to-explore
            
            let position = gestureRecognizer.location(in: innerView)
            
            let allViews = UIView.getAllSubviews(from: innerView)
            
            self.navigationItem.title = "pan"
            
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
            
            for view in allViews{
                view.layer.borderWidth = 0
            }
            
            if flag != "background"{
                tts(input: String(flag))
                
                allViews[highlighted].layer.borderWidth = 5
            }
            else{
                //AudioServicesPlaySystemSound(1255)
            }
          }
            
            writeLog(PID: PID, mode: mode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "pan", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
        
        }
        else if rotateMode == 1 { // panning
            
        }
 */
     
     }
    
    /*
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
    */
    
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
        
        AudioServicesPlaySystemSound(1105)
        
        synth.stopSpeaking(at: .immediate)
        synth.speak(utterance)
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
    
    @objc func writeLog(PID: String, mode: String, timestamp: String, state: Int, gesture: String, zoomScale: CGFloat, location: CGPoint, highlightedObject: Int, currentViews: String){
      
        let fileManager = FileManager.default
                
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let fileURL = documentsURL.appendingPathComponent("log.csv")
        
        var fileText = try? String(contentsOf: fileURL, encoding: .utf8)
        
        var zoomMode = ""
        
        switch mode {
        
        case "pinch":
            zoomMode = "pinch-to-zoom"
        case "functional":
            zoomMode = "functional zoom"
        case "fixed":
            zoomMode = "fixed zoom"
        default:
            zoomMode = ""
        
        }
        
        let indexString = "PID, mode, gesture, state, timestamp, zoomScale, scrollView_offset_x, scrollView_offset_y, scrollView_contentSize_width, scrollView_contentSize_height, location_x, location_y, highlightedObject, currentViews(index)"
        
        let logString = PID
            + ", " + zoomMode
            + ", " + gesture
            + ", " + getState(rawValue: state)
            + ", " + timestamp
            + ", " +  "\(zoomScale)"
            + ", " +  "\(scrollView.contentOffset.x/scrollView.zoomScale)"
            + ", " +  "\(scrollView.contentOffset.y/scrollView.zoomScale)"
            + ", " +  "\(scrollView.contentSize.width / (scrollView.zoomScale * scrollView.zoomScale))"
            + ", " +  "\(scrollView.contentSize.height / (scrollView.zoomScale * scrollView.zoomScale))"
            + ", " +  "\(location.x)"
            + ", " +  "\(location.y)"
            + ", " + getObjectName(index: highlightedObject)
            + ", " + currentViews.replacingOccurrences(of: ",", with: ";")
        
        print(logString)
        
        if fileText == nil { // if the file does not exist
            fileText = indexString
        }
    
        let myTextString = NSString(string: fileText! + "\n" + logString)

        try? myTextString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8.rawValue)
        
    }
    
    @objc func getState(rawValue: Int) -> String {
        
        switch rawValue{
        
        case 0:
            return "possible"
        case 1:
            return "began"
        case 2:
            return "changed"
        case 3:
            return "ended"
        case 4:
            return "canceled"
        case 5:
            return "failed"
        default:
            return "none"
        
        }
    }
    
    @objc func getObjectName(index: Int) -> String {
        
        let allViews = UIView.getAllSubviews(from: innerView)
        
        var i = 0
        
        for view in allViews {
            if i == index {
                return view.accessibilityIdentifier!
            }
            i += 1
        }
        
        return "null"
    }
    
    
}




