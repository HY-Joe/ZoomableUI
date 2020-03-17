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

class ViewController2: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var rect1: UIButton!
    
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
            
    
            scrollView.alwaysBounceVertical = false
            scrollView.alwaysBounceHorizontal = false
            
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 2.0
            scrollView.delegate = self
        
            scrollView.isScrollEnabled = false
        
            rect1.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        }
        
        @objc func buttonTap(_ sender: UIButton){
            //print(sender.tag)
            let scale = sender.frame.width

            if scale != scrollView.zoomScale { // zoom in
                
                let point = sender.frame.origin
                
                let point_x = point.x + sender.frame.width/2
                let point_y = point.y + sender.frame.height/2
            
                let scrollSize = scrollView.frame.size
                let size = CGSize(width: scrollSize.width / scale,
                                  height: scrollSize.height / scale)
                let origin = CGPoint(x: point_x - size.width / 2,
                                     y: point_y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
                
                print("buttonTap zoom in")
                print(scrollView.zoomScale)
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
                print("buttonTap zoom out")
                print(scrollView.zoomScale)
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

        @IBAction func handlePan(_ sender: UIPanGestureRecognizer){
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
            } else if scrollView.zoomScale == scrollView.maximumZoomScale { //zoom out
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
                print("doubleTap zoomin")
                print(scrollView.zoomScale)
            } else if scrollView.zoomScale != 1.0 { //zoom out
                print("doubleTap zoomout")
                print(scrollView.zoomScale)
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
         
        }
        
        // image view
        @IBOutlet weak var imageView: UIImageView!
        
        func tts(input: String){

            let utterance = AVSpeechUtterance(string: input)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
        }
        
}
