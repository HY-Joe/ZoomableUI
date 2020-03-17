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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //drawHouse(origin_x: 0, origin_y: 0)
        
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
        
        // tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.require(toFail: tfdoubletap)
        tap.require(toFail: tripletap)
        view.addGestureRecognizer(tap)
        
        // swipe
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        /*
        // pan
        let pan = UIPanGestureRecognizer(target:self, action: #selector(handlePan))
        //pan.require(toFail: swipeLeft)
        //pan.require(toFail: swipeRight)
        //pan.require(toFail: swipeUp)
        //pan.require(toFail: swipeDown)
        pan.minimumNumberOfTouches = 2
        pan.maximumNumberOfTouches = 2
        innerView.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target:self, action: #selector(handlePinch))
        
        innerView.addGestureRecognizer(pinch)
        
        house1.accessibilityLabel = "test"
        house1.accessibilityHint = "Your current score"
        */
        //house1.addGestureRecognizer(pinch)
        
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.delegate = self
        
        house1.tag = 1
        house2.tag = 3
        flower1.tag = 2
        flower2.tag = 4
        house1.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        house2.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        flower1.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        flower2.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
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

    @IBOutlet weak var textfield2: UITextField!
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer){
        /*
        // 1
        let translation = gesture.translation(in: view)
        
        // 2
        guard let gestureView = gesture.view else {
            return
        }
        
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        
        // 3
        gesture.setTranslation(.zero, in: view)
        
        
        let translation = sender.translation(in: self.view)
        let statusFrame = UIApplication.shared.statusBarFrame

        if let senderView = sender.view {
            if senderView.frame.origin.x < 0.0 {
                senderView.frame.origin = CGPoint(x: 0.0, y: senderView.frame.origin.y)
            }
            if senderView.frame.origin.y < statusFrame.height {
                senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: statusFrame.height)
            }
            if senderView.frame.origin.x + senderView.frame.size.width > view.frame.width {
                senderView.frame.origin = CGPoint(x: view.frame.width - senderView.frame.size.width, y: senderView.frame.origin.y)
            }
            if senderView.frame.origin.y + senderView.frame.size.height > view.frame.height {
                senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: view.frame.height - senderView.frame.size.height)
            }
        }

        if let centerX = sender.view?.center.x, let centerY = sender.view?.center.y {
            sender.view?.center = CGPoint.init(x: centerX + translation.x , y: centerY + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
        */
        textfield2.text = "Pan detected"
    }
    
    @IBAction func handlePinch(_ gesture: UIPinchGestureRecognizer){
        /*
         guard let gestureView = gesture.view else {
         return
         }
           
        gestureView.transform = gestureView.transform.scaledBy(
            x: gesture.scale,
            y: gesture.scale
        )
         
        gesture.scale = 1.0
*/
    }
    
    
    @IBAction func handleRotate(_ gesture: UIRotationGestureRecognizer){
        /*
         guard let gestureView = gesture.view else {
         return
         }
         
         gestureView.transform = gestureView.transform.rotated(
         by: gesture.rotation
         )
         gesture.rotation = 0
         */
        
        textfield2.text = "Rotation detected"
    }
    
    @IBAction func handleTap(){
        
        textfield2.text = "Tap detected"
    }

    @IBAction func handleSwipe(_ gesture: UISwipeGestureRecognizer){
        if gesture.direction == .right {
            textfield2.text = "Swipe right detected"
        }
        else if gesture.direction == .left {
            textfield2.text = "Swipe left detected"
        }
        else if gesture.direction == .up {
            textfield2.text = "Swipe up detected"
        }
        else if gesture.direction == .down {
            textfield2.text = "Swipe down detected"
        }
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        let scale = min(scrollView.zoomScale * 2, scrollView.maximumZoomScale)

        if scale != scrollView.zoomScale { // zoom in
            let point = recognizer.location(in: imageView)

            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / scrollView.maximumZoomScale,
                              height: scrollSize.height / scrollView.maximumZoomScale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        } else if scrollView.zoomScale == 1 { //zoom out
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: imageView)), animated: true)
        }
    }
    
    @objc func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        print("test")
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = scrollView.convert(center, from: imageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    @objc func doubleTap(_ recognizer: UITapGestureRecognizer) {
        let scale = min(scrollView.zoomScale * 2, scrollView.maximumZoomScale)

        if scale != scrollView.zoomScale { // zoom in
            
            let point = recognizer.location(in: imageView)

            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / scrollView.maximumZoomScale,
                              height: scrollSize.height / scrollView.maximumZoomScale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print(scrollView.zoomScale)
        } else if scrollView.zoomScale == 2.0 { //zoom out
            let point = recognizer.location(in: imageView)

            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width,
                              height: scrollSize.height)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
    }
    
    @objc func twoFingerDoubleTap() {
        // do something here
        textfield2.text = "2 finger Double tap detected"
        if scrollView.maximumZoomScale == 2.0{
            scrollView.maximumZoomScale = 1.0
            scrollView.isScrollEnabled = false
            tts(input: "zoom disabled")
        }
        else if scrollView.maximumZoomScale == 1.0 {
            scrollView.maximumZoomScale = 2.0
            scrollView.isScrollEnabled = true
            tts(input: "zoom enabled")
        }
    }
    
    @objc func tripleTapped(){
        textfield2.text = "triple tap detected"
    }
    
    // image view
    @IBOutlet weak var imageView: UIImageView!
    
    func drawLines() {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))
        
        let img = renderer.image { ctx in
            // 2
            ctx.cgContext.move(to: CGPoint(x: 20.0, y: 20.0))
            ctx.cgContext.addLine(to: CGPoint(x: 260.0, y: 230.0))
            ctx.cgContext.addLine(to: CGPoint(x: 100.0, y: 200.0))
            ctx.cgContext.addLine(to: CGPoint(x: 20.0, y: 20.0))
            
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            
            // 3
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 280, height: 250)
            
            // 4
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.gray.cgColor)
            ctx.cgContext.setLineWidth(20)
            
            // 5
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))
        
        let img = renderer.image { ctx in
            let rect = CGRect(x: 5, y: 5, width: 270, height: 240)
            
            // 6
            ctx.cgContext.setFillColor(UIColor.blue.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawHouse(origin_x: Int, origin_y: Int) {
        let imgwidth = imageView.frame.width
        let imgheight = imageView.frame.height
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imgwidth, height: imgheight))
        
        let img = renderer.image{ctx in
            let rectangle = [CGRect(x:origin_x, y:origin_y, width: 100, height: 150), CGRect(x:100/2-6, y:100/2+6, width: 12, height: 12)]
        
            // 4
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(1)
            
            // 5
            ctx.cgContext.addRect(rectangle[0])
            ctx.cgContext.addRect(rectangle[1])
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        imageView.image = img
        
    }
    
    // objects
    @IBOutlet weak var house1: UIButton!
    @IBOutlet weak var flower1: UIButton!
    
    @IBOutlet weak var house2: UIButton!    
    @IBOutlet weak var flower2: UIButton!
    
    func tts(input: String){

        let utterance = AVSpeechUtterance(string: input)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    
}




