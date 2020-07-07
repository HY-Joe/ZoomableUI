//
//  FirstViewController.swift
//  zoomable_user_interface
//
//  Created by kwon on 2020/03/17.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreGraphics

var mode = ""
var PID = ""

class FirstViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var PIDTextField: UITextField! {
        didSet {
            PIDTextField.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        PIDTextField.resignFirstResponder()
        PID = PIDTextField.text!
        
        return true
    }
    
    @IBAction func pinch(_ sender: UIButton) {
        mode = "pinch"
        PID = PIDTextField.text!
    }
    
    @IBAction func functional(_ sender: UIButton) {
        mode = "functional"
        PID = PIDTextField.text!
    }
    
    @IBAction func fixed(_ sender: UIButton) {
        mode = "fixed"
        PID = PIDTextField.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PIDTextField.text = "test"
        
    }
    
}

