//
//  Option.swift
//  zoomable_user_interface
//
//  Created by kwon on 2020/07/18.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import Foundation
import UIKit

class Option: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var option1: UISwitch!
    @IBOutlet weak var option2: UISwitch!
    @IBOutlet weak var SwipeIsEnabled: UISwitch!
    @IBOutlet weak var DropdownPID: DropDown!
    @IBOutlet weak var DropdownCondition: DropDown!
    @IBOutlet weak var DropdownMode: DropDown!
    @IBOutlet weak var DropdownImgID: DropDown!
    @IBOutlet weak var DropdownTarget: DropDown!
    @IBOutlet weak var DropdownZoomLV: DropDown!
    @IBOutlet weak var DropdownCenterPoint: DropDown!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "mySwitchValue")
    }
    
    @IBAction func switchAction2(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "mySwitchValue2")
    }

    @IBAction func switchAction3(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "SwipeIsEnabled")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        option1.isOn = userDefaults.bool(forKey: "mySwitchValue")
        option2.isOn = userDefaults.bool(forKey: "mySwitchValue2")
        SwipeIsEnabled.isOn = userDefaults.bool(forKey: "SwipeIsEnabled")
        
         DropdownPID.optionArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        
         DropdownPID.optionIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        
    }
}
