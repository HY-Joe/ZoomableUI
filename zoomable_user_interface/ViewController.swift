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
    
    @IBAction func handleTap(_ gesture: UITapGestureRecognizer){
        
        textfield2.text = "Tap detected"
    }

    @IBAction func handleSwipe(_ gesture: UISwipeGestureRecognizer){
        
        textfield2.text = "Swipe detected"
    }
    
}

