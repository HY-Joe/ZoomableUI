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
    
    static var objHi: Bool = false
    static var centerZoom: Bool = false
    
    @objc func switchStateDidChange1(_ sender:UISwitch!)
    {
        if (sender?.isOn == true){
            Option.objHi = true
        }
        else {
            Option.objHi = false
        }
    }
    
    @objc func switchStateDidChange2(_ sender:UISwitch!)
    {
        if (sender?.isOn == true){
            Option.centerZoom = true
        }
        else {
            Option.centerZoom = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        option1?.addTarget(self, action: #selector(switchStateDidChange1(_:)), for: .touchUpInside)
        option2?.addTarget(self, action: #selector(switchStateDidChange2(_:)), for: .touchUpInside)
    }
}
