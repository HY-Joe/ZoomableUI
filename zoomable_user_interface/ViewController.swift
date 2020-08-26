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
            if let view = subView as? T {
                //if view.accessibilityIdentifier! != "background" {
                    
                    if selectedGroup.contains(view.accessibilityIdentifier!) {
                        result.append(view)
                    }
                //}
            }
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
    
    @IBOutlet weak var group1: UIImageView!
    @IBOutlet weak var group2: UIImageView!
    @IBOutlet weak var group3: UIImageView!
    @IBOutlet weak var group4: UIImageView!
    @IBOutlet weak var group5: UIImageView!
    
    var flag = "none"
    var current = "none"
    var previous = "none"
    
    var currentViews = [UIView]()
    
    var currentIndexes = [Int]()
    
    var highlighted = 0
    var currentIndex = 0
    
    var selectedMenu = ""

    let synth = AVSpeechSynthesizer()
    
    // for fixed zoom level
    var zoomLevel = 1
    
    var rotateMode = 0 // 0: touch-to-explore, 1: panning
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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
        
        // two finger triple tap (zoom reset to default)
        let tftripletap = UITapGestureRecognizer(target: self, action: #selector(handleTwoFingerTripleTap))
        tftripletap.numberOfTapsRequired = 3
        tftripletap.numberOfTouchesRequired = 2
        innerView.addGestureRecognizer(tftripletap)
    
        // two finger double tap
        let tfdoubletap = UITapGestureRecognizer(target: self, action: #selector(handleTwoFingerDoubleTap))
        tfdoubletap.numberOfTapsRequired = 2
        tfdoubletap.numberOfTouchesRequired = 2
        tfdoubletap.require(toFail: tftripletap)
        innerView.addGestureRecognizer(tfdoubletap)
        
        // three finger double tap
        let threefingertap = UITapGestureRecognizer(target: self, action: #selector(handleThreeFingerTap))
        threefingertap.numberOfTapsRequired = 1
        threefingertap.numberOfTouchesRequired = 3
        innerView.addGestureRecognizer(threefingertap)
        
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false

        scrollView.minimumZoomScale = 1.0
        //scrollView.maximumZoomScale = scrollView.frame.width / petal1.frame.width
        
        if mode == "None" || mode == "Pan-Only" { // no zooming(no pinch)
            //scrollView.maximumZoomScale = 1.0
            scrollView.pinchGestureRecognizer?.isEnabled = false
            scrollView.maximumZoomScale = CGFloat((initialZoomLevel as NSString).floatValue) / 100
            scrollView.minimumZoomScale = CGFloat((initialZoomLevel as NSString).floatValue) / 100
        }
        else {
            scrollView.maximumZoomScale = 28.0
        }
        
        scrollView.delegate = self
        
        scrollView.isScrollEnabled = false
        
        if mode == "Pan-Only" { // mode: panning only
            rotateMode = 1
        }
        else if mode == "Zoom-Only" { // mode: zooming only
            rotateMode = 0
        }
        
        // target found
        let tripletap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
        tripletap.numberOfTapsRequired = 3
        tripletap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tripletap)
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubletap.numberOfTapsRequired = 2
        doubletap.numberOfTouchesRequired = 1
        doubletap.require(toFail: tripletap)
        view.addGestureRecognizer(doubletap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.require(toFail: doubletap)
        tap.require(toFail: threefingertap)
        tap.require(toFail: tripletap)
        innerView.addGestureRecognizer(tap)
   
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        pan.delegate = self
        innerView.addGestureRecognizer(pan)
        
        if condition == "Continuous" { // two-finger panning
            let twofingerpan = UIPanGestureRecognizer(target: self, action: #selector(handleTwoFingerPan))
            twofingerpan.delegate = self
            twofingerpan.minimumNumberOfTouches = 2
            innerView.addGestureRecognizer(twofingerpan)
            
            let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
            rotate.delegate = self
            innerView.addGestureRecognizer(rotate)
        }
        else if condition == "Pixel" || condition == "Object" { // not continuous
            print(condition)
            scrollView.pinchGestureRecognizer?.isEnabled = false
            scrollView.isScrollEnabled = false
        }
        
        let allViews = UIView.getAllSubviews(from: innerView)
            
        currentViews = allViews
    
        for view in currentViews {
           for i in 0...allViews.count - 1 {
               if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                   currentIndexes.append(i)
               }
           }
        }
        
        for view in allViews {
            view.layer.borderWidth = 1
        }
        
        allViews[highlighted].layer.borderWidth = 5
        
        background.layer.borderWidth = 1
        //background.layer.borderColor = UIColor.red.cgColor
        
        setInitialZoomScale()
        
        informTarget()
        
        if mode == "Pan+SpecialZoom" {
            centerZoom = true
        }

    }
    
    func informTarget() {
        if taskTarget == "Random" {
            taskTarget = selectedGroup.randomElement()!
            tts(input: "Find " + taskTarget)
        }
    }
    
    func setInitialZoomScale() {
        
        let allViews = UIView.getAllSubviews(from: innerView)
        
        let initialZoomScale : CGFloat = CGFloat((initialZoomLevel as NSString).floatValue) / 100
        
        var initialObject = ""
        var initialObjectCenterPoint = CGPoint()
        
        if initialZoomLevel != "100" {
            if centerPoint == "Random" {
                initialObject = selectedGroup.randomElement()!
                
                print(initialObject)
                
                for view in allViews {
                    if view.accessibilityIdentifier! == initialObject {
                        initialObjectCenterPoint = CGPoint(x: view.frame.origin.x + view.frame.width / 2, y: view.frame.origin.y + view.frame.height / 2)
                        
                        print(initialObjectCenterPoint)
                        
                        scrollView.zoom(to: CGRect( x: initialObjectCenterPoint.x - (background.frame.width / initialZoomScale) / 2, y: initialObjectCenterPoint.y - (background.frame.height / initialZoomScale) / 3, width: background.frame.width / initialZoomScale, height: background.frame.height / initialZoomScale), animated: false)
                        
                        break
                    }
                }
            }
            else if centerPoint == "TopLeft" {
                scrollView.zoom(to: CGRect(x: scrollView.frame.origin.x, y: scrollView.frame.origin.y, width: scrollView.frame.width / initialZoomScale, height: scrollView.frame.height / initialZoomScale ), animated: false)
                print("topleft")
            }
                
            else if centerPoint == "ImgCenter" {
                let imgCenterPoint_x = innerView.frame.origin.x + innerView.frame.width / 2
                let imgCenterPoint_y = innerView.frame.origin.y + innerView.frame.height / 2
                scrollView.zoom(to: CGRect( x: imgCenterPoint_x - (innerView.frame.width / initialZoomScale) / 2, y: imgCenterPoint_y - (innerView.frame.height / initialZoomScale) / 2, width: innerView.frame.width / initialZoomScale, height: innerView.frame.height / initialZoomScale), animated: false)
                print(imgCenterPoint_x - (innerView.frame.width / initialZoomScale) / 2)
                print(imgCenterPoint_y - (innerView.frame.height / initialZoomScale) / 2)
            }
            else { // certain object
                initialObject = centerPoint
                
                for view in allViews {
                    
                    if view.accessibilityIdentifier! == initialObject {
                        print(view.frame.origin.x)
                        print(view.frame.width / 2)
                        initialObjectCenterPoint = CGPoint(x: view.frame.origin.x + view.frame.width / 2, y: view.frame.origin.y + view.frame.height / 2)
                        
                        scrollView.zoom(to: CGRect( x: initialObjectCenterPoint.x - (scrollView.frame.width / initialZoomScale) / 2, y: initialObjectCenterPoint.y - (scrollView.frame.height / initialZoomScale) / 4, width: scrollView.frame.width / initialZoomScale, height: scrollView.frame.height / initialZoomScale), animated: false)
                        
                        break
                    }
                }
            }

        }
        
    }
    
    // target found (task end)
    @objc func handleTripleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let allViews = UIView.getAllSubviews(from: innerView)
        
        if allViews[highlighted].accessibilityIdentifier! == taskTarget {
            outputAlert(title: "Task complete!", message: "You've found the target object.", text: "Enter")
            
            print("Task complete, you've found the target object.")
        }
        
    }
    
    @objc func handleTwoFingerPan(_ gestureRecognizer: UIPanGestureRecognizer) { // only for "continuous" condition
        if rotateMode == 1 && condition == "Continuous" { // panning mode
            scrollView.isScrollEnabled = true
            scrollView.panGestureRecognizer.isEnabled = true
            //print(gestureRecognizer.velocity(in: innerView).x)
            /*
            var panned_x = 0.0 - gestureRecognizer.velocity(in: innerView).x / scrollView.zoomScale
            
            var panned_y = 0.0 - gestureRecognizer.velocity(in: innerView).y / scrollView.zoomScale
            
            if panned_x < 0.0 {
                panned_x = 0.0
            }
            else if panned_x >= innerView.frame.width {
                panned_x = innerView.frame.width
            }
            
            if panned_y < 0.0 {
                panned_y = 0.0
            }
            else if panned_y >= innerView.frame.height {
                panned_y = innerView.frame.height
            }
            
            scrollView.setContentOffset(CGPoint(x: panned_x, y: panned_y), animated: true)
            */
            var panned_x = scrollView.contentOffset.x - gestureRecognizer.velocity(in: innerView).x
            
            var panned_y = scrollView.contentOffset.y - gestureRecognizer.velocity(in: innerView).y
            
            if panned_x < 0.0 {
                panned_x = 0.0
            }
            else if panned_x > scrollView.frame.width {
                panned_x = scrollView.frame.width
            }
            
            if panned_y < 0.0 {
                panned_y = 0.0
            }
            else if panned_y > scrollView.frame.height {
                panned_y = scrollView.frame.height
            }
            
            scrollView.setContentOffset(CGPoint(x: panned_x, y: panned_y), animated: true)
        }
        
        /*
        print("scrollViewoffset")
        
       print(scrollView.contentOffset)
       print("panned_x")
       print(panned_x)
       print("panned_y")
       print(panned_y)
 */
        
    }
    
    @objc func getDirection(targetPoint: CGPoint) -> String {
        // scrollView center point(absolute)
        let centerPoint = CGPoint(x: scrollView.frame.width / 2, y: scrollView.frame.height / 2)
        
        let defaultPoint = CGPoint(x: scrollView.frame.origin.x + scrollView.frame.width / 2, y: scrollView.frame.origin.y) // default vector (12 o'clock direction)
        
        let vector1 = CGVector(dx: defaultPoint.x - centerPoint.x, dy: defaultPoint.y - centerPoint.y)
        let vector2 = CGVector(dx: targetPoint.x - centerPoint.x, dy: targetPoint.y - centerPoint.y)
        
        let angle = atan2(vector2.dy, vector2.dx) - atan2(vector1.dy, vector1.dx)
        
        var degree = angle * CGFloat(180.0 / .pi)
        
        if degree < 0 { degree += 360.0 }
        
        if degree > 345.0 {
            return "12"
        }
        else if degree <= 15.0 {
            return "12"
        }
        else if degree <= 45.0 {
            return "1"
        }
        else if degree <= 75.0 {
            return "2"
        }
        else if degree <= 105.0 {
            return "3"
        }
        else if degree <= 135.0 {
            return "4"
        }
        else if degree <= 165.0 {
            return "5"
        }
        else if degree <= 195.0 {
            return "6"
        }
        else if degree <= 225.0 {
            return "7"
        }
        else if degree <= 255.0 {
            return "8"
        }
        else if degree <= 285.0 {
            return "9"
        }
        else if degree <= 315.0 {
            return "10"
        }
        else if degree <= 345 {
            return "11"
        }
        else {
            return ""
        }
        
    }
    
    @objc func handleThreeFingerTap(_ gestureRecognizer:
        UITapGestureRecognizer) { // get current state
        //scrollView.zoom(to: CGRect(x: 0.0, y: 0.0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
        
        let origin = CGPoint(x: scrollView.contentOffset.x / scrollView.zoomScale, y: scrollView.contentOffset.y / scrollView.zoomScale)
        let size = CGSize(width: scrollView.contentSize.width / (scrollView.zoomScale * scrollView.zoomScale) , height: scrollView.contentSize.height / (scrollView.zoomScale * scrollView.zoomScale))
        
        let rect = CGRect(origin: origin, size: size)
        
        let absoluteCenterPoint = CGPoint(x: scrollView.frame.width / 2, y: scrollView.frame.height / 2)
        
        let currentCenterPoint = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        
        let distance = sqrt(pow(currentCenterPoint.x - absoluteCenterPoint.x, 2) + pow(currentCenterPoint.y - absoluteCenterPoint.y, 2))
     
        let zoomscale = Int(Double(round(1000 * scrollView.zoomScale) / 1000) * 100 / 10) * 10
        
        tts(input: String(zoomscale) + "%, " + getDirection(targetPoint: currentCenterPoint) + " o'clock, " + String(format: "%.1f", Double(distance)) + " pixels")
        
    }
    
    @objc func handleTwoFingerTripleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        tts(input: "reset zoom to default, 100%")
        
        /*
        let allViews = UIView.getAllSubviews(from: innerView)
        
        let point = allViews[highlighted].frame.origin
        
        let point_x = point.x + allViews[highlighted].frame.width/2
        let point_y = point.y + allViews[highlighted].frame.height/2

        let scrollSize = scrollView.frame.size
        let size = CGSize(width: scrollSize.width,
                          height: scrollSize.height)
        let origin = CGPoint(x: point_x - size.width / 2,
                             y: point_y - size.height / 2)
        scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        */
        
        scrollView.zoom(to:CGRect(x: 0.0, y: 0.0, width: innerView.frame.width, height: innerView.frame.height), animated: true)
        
    }
    
    @objc func handleRotation(_ gestureRecognizer: UIRotationGestureRecognizer) {
        if mode != "None" || mode != "Pan-Only" || mode != "Zoom-Only" {
            scrollView.isScrollEnabled = false
            if gestureRecognizer.state == .ended && gestureRecognizer.rotation > 0.4 {
                
                if rotateMode == 0 {
                    rotateMode = 1
                    tts(input: "panning mode")
                    scrollView.pinchGestureRecognizer?.isEnabled = false
                }
                else {
                    rotateMode = 0
                    tts(input: "zooming mode")
                    scrollView.pinchGestureRecognizer?.isEnabled = true
                   
                }
            }
            
            writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "rotation", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
        }
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            
            return false
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        
        if mode == "pinch" && centerZoom == true {
        
            //AudioServicesPlaySystemSound(1109)
            
        }
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        //tts(input: "decelerating")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
      
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        let origin = CGPoint(x: scrollView.contentOffset.x / scrollView.zoomScale, y: scrollView.contentOffset.y / scrollView.zoomScale)
        let size = CGSize(width: scrollView.contentSize.width / (scrollView.zoomScale * scrollView.zoomScale) , height: scrollView.contentSize.height / (scrollView.zoomScale * scrollView.zoomScale))
        
        let rect = CGRect(origin: origin, size: size)
        
        if centerZoom == true {
                    
            let allViews = UIView.getAllSubviews(from: innerView)
            
            //scrollView.contentInset = CGPoint(x: allViews[highlighted].frame.origin.x + allViews[highlighted].frame.width / 2, y: allViews[highlighted].frame.origin.y + allViews[highlighted].frame.height / 2)
            
            //innerView.center = CGPoint(x: allViews[highlighted].frame.origin.x + allViews[highlighted].frame.width / 2, y: allViews[highlighted].frame.origin.y + allViews[highlighted].frame.height / 2)
            print(allViews[highlighted].accessibilityIdentifier!)
            
            let point = allViews[highlighted].frame.origin
            
            let point_x = point.x + allViews[highlighted].frame.width/2
            let point_y = point.y + allViews[highlighted].frame.height/2
    
            let size = CGSize(width: scrollView.frame.width / scrollView.zoomScale,
                              height: scrollView.frame.height / scrollView.zoomScale)
            let origin = CGPoint(x: point_x - scrollView.frame.width / scrollView.zoomScale,
                                 y: point_y - scrollView.frame.height / scrollView.zoomScale)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            
        }
        else if condition == "Continuous" {
            
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

            for view in currentViews {
               for i in 0...allViews.count - 1 {
                   if view.accessibilityIdentifier! == allViews[i].accessibilityIdentifier!{
                       currentIndexes.append(i)
                   }
               }
            }
            
            /*
            if currentIndexes[0] == 0 {
                highlighted = currentIndexes[1]
                currentIndex = 1
            }
            else {
                highlighted = currentIndexes[0]
                currentIndex = 0
            }
            */
            
            highlighted = currentIndexes[0]
            currentIndex = 0
            
            for view in allViews{
                view.layer.borderWidth = 1
            }
            
            allViews[highlighted].layer.borderWidth = 5
            //(PID: String, mode: String, timestamp: String, state: Int, gesture: String, zoomScale: CGFloat, location: CGPoint, highlightedObject: Int, currentViews: String)
            
        }
    
        
    }
    
    @objc func handleDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let allViews = UIView.getAllSubviews(from: innerView)
        
        if condition == "Object" {
             
            let scale = allViews[highlighted].frame.width + CGFloat(60)

             if allViews[highlighted].accessibilityIdentifier != "background"{
                 if scale != scrollView.zoomScale { //zoom in
                         
                     let point = allViews[highlighted].frame.origin
                     
                     let point_x = point.x + allViews[highlighted].frame.width/2
                     let point_y = point.y + allViews[highlighted].frame.height/2
             
                     let size = CGSize(width: scale,
                                       height: scale)
                     let origin = CGPoint(x: point_x - size.width / 2,
                                          y: point_y - size.height / 3)
                     scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                    
                    AudioServicesPlaySystemSound(1109)
                     
                    tts(input: String(allViews[highlighted].accessibilityIdentifier!) + " zoomed")
                         
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
            
            if !currentIndexes.contains(highlighted) && currentIndexes.count != 0 {
                highlighted = currentIndexes[0]
                currentIndex = 0
                
                for view in allViews{
                    view.layer.borderWidth = 1
                }
                
                allViews[highlighted].layer.borderWidth = 5
            }
        }
        
        else if condition == "Pixel" { // linear
            
            if zoomLevel == 1 { // zoom in
                //AudioServicesPlaySystemSound(1109)
                tts(input: "200%")
                
                zoomLevel = 2

                let point = centerZoom == true ?  CGPoint(x: allViews[highlighted].frame.origin.x + allViews[highlighted].frame.height / 2, y: allViews[highlighted].frame.origin.y + allViews[highlighted].frame.width / 2)  : gestureRecognizer.location(in: innerView)

                let scrollSize = scrollView.frame.size
                let size = CGSize(width: scrollSize.width / 2,
                                  height: scrollSize.height / 2)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            
            }
            else if zoomLevel == 2 {
                //AudioServicesPlaySystemSound(1109)
                tts(input: "400%")
                zoomLevel = 4
                
                let point = centerZoom == true ?  CGPoint(x: allViews[highlighted].frame.origin.x + allViews[highlighted].frame.height / 2, y: allViews[highlighted].frame.origin.y + allViews[highlighted].frame.width / 2)  : gestureRecognizer.location(in: innerView)
               
                let scrollSize = scrollView.frame.size
             
                let size = CGSize(width: scrollSize.width / 4,
                                  height: scrollSize.height / 4)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
              
            }
            else if zoomLevel == 4 {
                //AudioServicesPlaySystemSound(1109)
                tts(input: "800%")
                
                zoomLevel = 8
                
                let point = centerZoom == true ?  CGPoint(x: allViews[highlighted].frame.origin.x + allViews[highlighted].frame.height / 2, y: allViews[highlighted].frame.origin.y + allViews[highlighted].frame.width / 2)  : gestureRecognizer.location(in: innerView)

                let scrollSize = scrollView.frame.size
            
                let size = CGSize(width: scrollSize.width / 8,
                                  height: scrollSize.height / 8)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        
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
            
            if !currentIndexes.contains(highlighted) && currentIndexes.count != 0 {
                highlighted = currentIndexes[0]
                currentIndex = 0
                
                for view in allViews{
                    view.layer.borderWidth = 1
                }
                
                allViews[highlighted].layer.borderWidth = 5
            }
            
        }
        
    
        writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "double tap", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
        
        
       }
    
    @objc func handleTwoFingerDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        //if mode == "pinch" || mode == "functional" {
        if mode == "Object" {
            let origin = scrollView.frame.origin
            
            scrollView.zoom(to:CGRect(origin: origin, size: scrollView.frame.size), animated: true)
            AudioServicesPlaySystemSound(1109)
            tts(input: "zoomed out")
        }
        
        else if condition == "Pixel" {
            if scrollView.zoomScale == 1.0 { // zoom in
            
            }
            else if zoomLevel == 2 {
                AudioServicesPlaySystemSound(1109)
                tts(input: "100%")
                
                zoomLevel = 1
                
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

            }
            else if zoomLevel == 8 { //zoom out
                AudioServicesPlaySystemSound(1109)
                tts(input: "400%")
                
                zoomLevel = 4
                
                let point = gestureRecognizer.location(in: innerView)
                print(point)
                let scrollSize = scrollView.frame.size
             
                let size = CGSize(width: scrollSize.width / 4,
                                  height: scrollSize.height / 4)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
               
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
            
            if !currentIndexes.contains(highlighted) && currentIndexes.count != 0 {
                highlighted = currentIndexes[0]
                currentIndex = 0
                
                for view in allViews{
                    view.layer.borderWidth = 1
                }
                
                allViews[highlighted].layer.borderWidth = 5
            }
        }
        
        writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "2-finger double tap", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer){
        
        self.navigationItem.title = "tap"
            
        let position = gestureRecognizer.location(in: innerView)

        let allViews = UIView.getAllSubviews(from: innerView)
        
         var i = -1
        var touched = "background"
        var touchedIndex = -1
         
         for view in allViews{
             view.layer.borderWidth = 1
         }
        
        for view in allViews {
            i += 1
            
            let origin = view.frame.origin
            if position.x >= origin.x && position.x <= origin.x + view.frame.width && position.y >= origin.y && position.y <= origin.y + view.frame.height{
                
                allViews[highlighted].layer.borderWidth = 1
               
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
     
    /*
     @objc func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer){
        let allViews = UIView.getAllSubviews(from: innerView)
        
        if gestureRecognizer.direction == .right {
            //print("Swipe right detected")
            self.navigationItem.title = "swipe right"
            if highlighted < currentIndexes.last! {
                allViews[highlighted].layer.borderWidth = 1
                
               //print(currentIndexes)
                //print(highlighted)
                
                highlighted = getNextIndex(highlighted: highlighted, currentIndexes: currentIndexes, mode: "right")
                
                allViews[highlighted].layer.borderWidth = 5

                tts(input: allViews[highlighted].accessibilityIdentifier!)
            }
            else if highlighted == currentIndexes.last! {
                AudioServicesPlaySystemSound(1053)
            }
            
            writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "swipe right", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
        }
        else if gestureRecognizer.direction == .left {
            //print("Swipe left detected")
            self.navigationItem.title = "swipe left"
            if highlighted > currentIndexes.first! {
                allViews[highlighted].layer.borderWidth = 1
               
                highlighted = getNextIndex(highlighted: highlighted, currentIndexes: currentIndexes, mode: "left")
                
                allViews[highlighted].layer.borderWidth = 5

                tts(input: allViews[highlighted].accessibilityIdentifier!)
            }
            else if highlighted == currentIndexes.first! {
                AudioServicesPlaySystemSound(1053)
            }
            
            writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "swipe left", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
        }
        
        if gestureRecognizer.state == .ended {
            print("swipe has ended")
            return
        }
     
     }
    */
    
    func delay(delay:Double, closure:()->()) {

        //dispatch_after(dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)

    }

     @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer){
        
        if gestureRecognizer.numberOfTouches <= 1 {
        
            scrollView.isScrollEnabled = false
            
            let origin = CGPoint(x: scrollView.contentOffset.x / scrollView.zoomScale, y: scrollView.contentOffset.y / scrollView.zoomScale)
            let size = CGSize(width: scrollView.contentSize.width / (scrollView.zoomScale * scrollView.zoomScale) , height: scrollView.contentSize.height / (scrollView.zoomScale * scrollView.zoomScale))
            
            let rect = CGRect(origin: origin, size: size)
            
            let velocity = gestureRecognizer.velocity(in: UIView(frame: rect))
            
            let speed = sqrt(pow(Double(velocity.x), 2) + pow(Double(velocity.y), 2))
        
            var direction = ""
            
            if abs(velocity.x) > abs(velocity.y) {

                if velocity.x < 0 {
                    direction = "left"
                }
                else {
                    direction = "right"
                }
                
            }
            
            if speed > 600 && gestureRecognizer.state == .ended && swipeEnabled == true { // swipe
                let allViews = UIView.getAllSubviews(from: innerView)
                
                if direction == "right" {
                   
                    self.navigationItem.title = "swipe right"
                    
                    if currentIndexes.count == 0 {
                        AudioServicesPlaySystemSound(1053)
                    }
                    else if highlighted < currentIndexes.last! {
                        allViews[highlighted].layer.borderWidth = 1
                        
                        highlighted = getNextIndex(highlighted: highlighted, currentIndexes: currentIndexes, mode: "right")
                        
                        for view in allViews{
                            view.layer.borderWidth = 1
                        }
                        
                        allViews[highlighted].layer.borderWidth = 5

                        tts(input: allViews[highlighted].accessibilityIdentifier!)
                    }
                    else if highlighted == currentIndexes.last! {
                        AudioServicesPlaySystemSound(1053)
                    }
                    
                    writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "swipe right", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
                }
                else if direction == "left" {
                  
                    self.navigationItem.title = "swipe left"
                    
                    if currentIndexes.count == 0 {
                        AudioServicesPlaySystemSound(1053)
                    }
                    else if highlighted > currentIndexes.first! {
                        allViews[highlighted].layer.borderWidth = 1
                       
                        highlighted = getNextIndex(highlighted: highlighted, currentIndexes: currentIndexes, mode: "left")
                        
                        for view in allViews{
                            view.layer.borderWidth = 1
                        }
                        
                        allViews[highlighted].layer.borderWidth = 5

                        tts(input: allViews[highlighted].accessibilityIdentifier!)
                    }
                    else if highlighted == currentIndexes.first! {
                        AudioServicesPlaySystemSound(1053)
                    }
                    
                    writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "swipe left", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
                }
                
            }
                
            else if speed < 200 { // pan
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
                  
              if previous != flag {
                
                for view in allViews {
                    view.layer.borderWidth = 1
                }
                
                if flag != "background" {
                    tts(input: String(flag))
                    
                    allViews[highlighted].layer.borderWidth = 5
                }
                else{
                    //AudioServicesPlaySystemSound(1255)
                }
              }
                
                writeLog(PID: PID, mode: mode, objHi: objHi, centerZoom: centerZoom, rotateMode: rotateMode, timestamp: "\(NSDate().timeIntervalSince1970)", state: gestureRecognizer.state.rawValue, gesture: "pan", zoomScale: scrollView.zoomScale, location: gestureRecognizer.location(in: innerView), highlightedObject: highlighted, currentViews: "\(currentIndexes)")
            
            }
                
        }
        else {
            
        }
     
        
       //print(scrollView.isScrollEnabled)
        
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
        
        //AudioServicesPlaySystemSound(1105)
        
        //synth.stopSpeaking(at: .immediate)
        //synth.speak(utterance)
        
        print(input)
    }
    
    @objc func hasIntersection(zoomedView: UIScrollView, subView: UIView) -> Bool{
        
        let subRect = CGRect(origin: subView.frame.origin, size: subView.bounds.size)
        
        let origin = CGPoint(x: scrollView.contentOffset.x / scrollView.zoomScale, y: scrollView.contentOffset.y / scrollView.zoomScale)
        let size = CGSize(width: scrollView.contentSize.width / (scrollView.zoomScale * scrollView.zoomScale) , height: scrollView.contentSize.height / (scrollView.zoomScale * scrollView.zoomScale))
        
        let rect = CGRect(origin: origin, size: size)
       
        if rect.intersects(subRect) == true {
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
    
    @objc func writeLog(PID: String, mode: String, objHi: Bool, centerZoom: Bool, rotateMode: Int, timestamp: String, state: Int, gesture: String, zoomScale: CGFloat, location: CGPoint, highlightedObject: Int, currentViews: String){
      
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
        
        let indexString = "PID, mode, objHi, centerZoom, rotateMode, gesture, state, timestamp, zoomScale, scrollView_offset_x, scrollView_offset_y, scrollView_contentSize_width, scrollView_contentSize_height, location_x, location_y, highlightedObject, currentViews(index)"
        
        let logString = PID
            + ", " + zoomMode
            + ", " + String(objHi)
            + ", " + String(centerZoom)
            + ", " + String(rotateMode)
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
        
        //print(logString)
        
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
    
    func outputAlert(title : String, message : String, text : String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let okButton = UIAlertAction(title: text, style: UIAlertAction.Style.cancel, handler: nil)

        alertController.addAction(okButton)

        return self.present(alertController, animated: true, completion: nil)

    }
    
    func getObjectCoordinatesFromImageView () {
        var i = 0
        
        let allViews = UIView.getAllSubviews(from: innerView)
        
        for view in allViews {
            view.isAccessibilityElement = true
            
            let fileManager = FileManager.default
                    
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

            let fileURL = documentsURL.appendingPathComponent("annotations.csv")
            
            var fileText = try? String(contentsOf: fileURL, encoding: .utf8)
            
            let indexString = "index, object_name, origin_x, origin_y, width, height"
            
            let logString = String(i) + ", " + view.accessibilityIdentifier! + ", " + "\(view.frame.origin.x)" + ", " + "\(view.frame.origin.y)" + ", " + "\(view.frame.width)" + ", " + "\(view.frame.height)"
                
            if fileText == nil { // if the file does not exist
                fileText = indexString
            }
        
            let myTextString = NSString(string: fileText! + "\n" + logString)

            try? myTextString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8.rawValue)
            
            i += 1
        }
    }
    
}




