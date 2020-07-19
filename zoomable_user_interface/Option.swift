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
    let userDefaults2 = UserDefaults.standard
    
    @IBOutlet weak var option1: UISwitch!
    @IBOutlet weak var option2: UISwitch!
       
    @IBAction func switchAction(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "mySwitchValue")
    }
    
    @IBAction func switchAction2(_ sender: UISwitch) {
        userDefaults2.set(sender.isOn, forKey: "mySwitchValue2")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        option1.isOn = userDefaults.bool(forKey: "mySwitchValue")
        option2.isOn = userDefaults2.bool(forKey: "mySwitchValue2")
        
    }
}
