//
//  Option.swift
//  zoomable_user_interface
//
//  Created by kwon on 2020/07/18.
//  Copyright © 2020 NahyunKwon. All rights reserved.
//

import Foundation
import UIKit

var mode = ""
var PID = ""
var condition = ""
var imgID = ""
var objectTarget = ""
var zoomLevel = ""
var centerPoint = ""
var objHi = false
var centerZoom = false
var swipeEnabled = false

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
    
    @IBAction func startButton(_ sender: Any) {
        PID = DropdownPID.optionArray[DropdownPID.selectedIndex!]
        mode = DropdownMode.optionArray[DropdownMode.selectedIndex!]
        condition = DropdownCondition.optionArray[DropdownCondition.selectedIndex!]
        imgID = DropdownImgID.optionArray[DropdownImgID.selectedIndex!]
        objectTarget = DropdownTarget.optionArray[DropdownTarget.selectedIndex!]
        zoomLevel = DropdownZoomLV.optionArray[DropdownZoomLV.selectedIndex!]
        centerPoint = DropdownCenterPoint.optionArray[DropdownCenterPoint.selectedIndex!]
        
        objHi = UserDefaults.standard.bool(forKey: "mySwitchValue")
        centerZoom = UserDefaults.standard.bool(forKey: "mySwitchValue2")
        swipeEnabled = UserDefaults.standard.bool(forKey: "SwipeIsEnabled")
        
    }
    
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
        
        DropdownPID.optionArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        DropdownMode.optionArray = ["None", "Pan-Only", "Zoom-Only", "All(Pan+RegularZoom)", "Pan+SpecialZoom"]
        DropdownCondition.optionArray = ["Continuous", "Pixel", "Object"]
        DropdownImgID.optionArray = ["0", "1", "2", "3"]
        DropdownTarget.optionArray = ["None", "Random"] // add objects
        DropdownZoomLV.optionArray = ["100", "200", "300", "400", "500", "600", "700", "800", "900"]
        DropdownCenterPoint.optionArray = ["Random", "TopLeft", "ImgCenter"] // add objects
        
        DropdownPID.selectedIndex = 0
        DropdownMode.selectedIndex = 0
        DropdownCondition.selectedIndex = 0
        DropdownImgID.selectedIndex = 0
        DropdownTarget.selectedIndex = 0
        DropdownZoomLV.selectedIndex = 0
        DropdownCenterPoint.selectedIndex = 0
        
    }
}
