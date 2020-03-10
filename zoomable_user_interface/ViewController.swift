//
//  ViewController.swift
//  zoomable_user_interface
//
//  Created by kwon on 03/03/2020.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //drawHouse(origin_x: 0, origin_y: 0)
        
        // triple tap
        let tripletap = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
        tripletap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripletap)
        
        // double tap
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubletap.numberOfTapsRequired = 2
        doubletap.require(toFail: tripletap)
        view.addGestureRecognizer(doubletap)
        
        // tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.require(toFail: doubletap)
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
        
        // pan
        let pan = UIPanGestureRecognizer(target:self, action: #selector(handlePan))
        pan.require(toFail: swipeLeft)
        pan.require(toFail: swipeRight)
        pan.require(toFail: swipeUp)
        pan.require(toFail: swipeDown)
        pan.minimumNumberOfTouches = 3
        pan.maximumNumberOfTouches = 3
        view.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target:self, action: #selector(handlePinch))
        
        view.addGestureRecognizer(pinch)
        
        house1.accessibilityLabel = "test"
        house1.accessibilityHint = "Your current score"
    }

    @IBAction func B1Clicked(_ sender: Any) {
        textfield.text = "B1 cliked"
    }
    
    @IBAction func B2Clicked(_ sender: Any) {
        textfield.text = "B2 cliked"
    }
    
    @IBAction func B3Clicked(_ sender: Any) {
        textfield.text = "B3 cliked"
    }
    
    @IBAction func B4Clicked(_ sender: Any) {
        textfield.text = "B4 cliked"
    }
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var textfield2: UITextField!
    
    @IBAction func handlePan(_ gesture: UIPanGestureRecognizer){
        
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
        
        
        textfield2.text = "Pan detected"
    }
    
    @IBAction func handlePinch(_ gesture: UIPinchGestureRecognizer){

         guard let gestureView = gesture.view else {
         return
         }
         
         gestureView.transform = gestureView.transform.scaledBy(
         x: gesture.scale,
         y: gesture.scale
         )
         gesture.scale = 1
        
        textfield2.text = "Pinch detected"

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
    
    
    @objc func doubleTapped() {
        // do something here
        textfield2.text = "Double tap detected"
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
    
    @IBAction func handleHouse1(_ sender: Any) {
        textfield2.text = "house1 touched"
        
        let string = "Hello, World!"
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)

    }
    
    
}


