//
//  Option.swift
//  zoomable_user_interface
//
//  Created by kwon on 2020/07/18.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import Foundation
import UIKit

var objHi = false
var centerZoom = false

class Option: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    let userDefaults2 = UserDefaults.standard
    
    @IBOutlet weak var option1: UISwitch!
    @IBOutlet weak var option2: UISwitch!
       
    @IBAction func switchAction(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "mySwitchValue")
        if sender.isOn == true {
            objHi = true
        }
        else {
            objHi = false
        }
    }
    
    @IBAction func switchAction2(_ sender: UISwitch) {
        userDefaults2.set(sender.isOn, forKey: "mySwitchValue2")
        if sender.isOn == true {
            centerZoom = true
        }
        else {
            centerZoom = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if option1.isOn == true {
            objHi = true
        }
        if option2.isOn == true {
            centerZoom = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        option1.isOn = userDefaults.bool(forKey: "mySwitchValue")
        option2.isOn = userDefaults2.bool(forKey: "mySwitchValue2")
        
    }
}
