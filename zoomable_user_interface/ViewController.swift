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

    @IBOutlet weak var textfield2: UITextField!
    
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




