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

class ViewController2: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var rect1: UIButton!
    @IBOutlet weak var rect2: UIButton!
    @IBOutlet weak var rect3: UIButton!
    @IBOutlet weak var rect4: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var button_3: UIButton!
    @IBOutlet weak var button_4: UIButton!
    @IBOutlet weak var button_5: UIButton!
    
    var flag = "none"
    var current = "none"
    var previous = "none"
    
    let synth = AVSpeechSynthesizer()
    //var flag = String(innerView.accessibilityLabel!)
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
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
        scrollView.maximumZoomScale = 200.0
        scrollView.delegate = self
    
        scrollView.isScrollEnabled = false
        //scrollView.isUserInteractionEnabled = false
        
        button_1.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button_2.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button_3.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button_4.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button_5.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        innerView.addGestureRecognizer(pan)
        
    }
   
    @objc func isInsideView(){
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
    
    @objc func imageViewTap(_ gesture: UITapGestureRecognizer){
        print("imageview touched")
    }
    
    @objc func buttonTap(_ sender: UIButton){
        //print(sender.tag)
        print("imageview touched")
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
    
    @objc func doubleTap(_ recognizer: UITapGestureRecognizer) {
      
        print("doubleTap zoomout")
        print(scrollView.zoomScale)
            if scrollView.zoomScale != 1.0{
            let point = recognizer.location(in: innerView)

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
    
    func tts(input: String){

        let utterance = AVSpeechUtterance(string: input)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
        
}
