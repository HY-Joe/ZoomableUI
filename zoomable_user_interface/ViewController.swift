//
//  ViewController.swift
//  zoomable_user_interface
//
//  Created by kwon on 03/03/2020.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubletap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubletap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.require(toFail: doubletap)
        view.addGestureRecognizer(tap)
        
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
         gesture.scale = 1
        */
        
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
            textfield.text = "Swipe right detected"
        }
        else if gesture.direction == .left {
            textfield.text = "Swipe left detected"
        }
        else if gesture.direction == .up {
            textfield.text = "Swipe up detected"
        }
        else if gesture.direction == .down {
            textfield.text = "Swipe down detected"
        }
    }
    
    
    @objc func doubleTapped() {
        // do something here
        textfield2.text = "Double tap detected"
    }
    
}


