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
var initialZoomLevel = ""
var centerPoint = ""
var objHi = false
var centerZoom = false
var swipeEnabled = false

var objectGroups = [[String]]([["house1", "window1", "window2", "petal1", "petal2", "petal3", "flowerpot1"],
                    ["house2", "window3", "window4", "petal4", "petal5", "petal6", "flowerpot2", "roof1"],
                    ["house3", "window5", "window6", "door1", "petal11", "petal12", "petal13", "flowerpot4", "roof2"],
                    ["house4", "window7", "window8", "door2", "petal7", "petal8", "petal9", "petal10", "flowerpot3"],
                    ["house5", "window9", "window10", "door3", "petal14", "petal15", "petal16", "petal17", "flowerpot5", "roof3"]])

var selectedGroup = [String] ()

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
 
    // save imageID -> add selected object group to optionArray of Target and Center Point
    @IBAction func saveButton(_ sender: Any) {
        
        imgID = DropdownImgID.optionArray[DropdownImgID.selectedIndex!]
        
        selectedGroup = [String] ()
        
        getSelectedGroup(imgID: imgID)
        
        DropdownTarget.optionArray.append(contentsOf: selectedGroup)
        DropdownCenterPoint.optionArray.append(contentsOf: selectedGroup)
        
        outputAlert(title: "Image ID saved", message: "Selected Objects were added to Target and Center Point list", text: "Enter")
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        PID = DropdownPID.optionArray[DropdownPID.selectedIndex!]
        mode = DropdownMode.optionArray[DropdownMode.selectedIndex!]
        condition = DropdownCondition.optionArray[DropdownCondition.selectedIndex!]
        imgID = DropdownImgID.optionArray[DropdownImgID.selectedIndex!]
        objectTarget = DropdownTarget.optionArray[DropdownTarget.selectedIndex!]
        initialZoomLevel = DropdownZoomLV.optionArray[DropdownZoomLV.selectedIndex!]
        centerPoint = DropdownCenterPoint.optionArray[DropdownCenterPoint.selectedIndex!]
        
        objHi = UserDefaults.standard.bool(forKey: "mySwitchValue")
        centerZoom = UserDefaults.standard.bool(forKey: "mySwitchValue2")
        swipeEnabled = UserDefaults.standard.bool(forKey: "SwipeIsEnabled")
        
        selectedGroup = [String] ()
        
        getSelectedGroup(imgID: imgID)
        
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
        
        DropdownPID.optionArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        DropdownMode.optionArray = ["None", "Pan-Only", "Zoom-Only", "All(Pan+RegularZoom)", "Pan+SpecialZoom"]
        DropdownCondition.optionArray = ["Continuous", "Pixel", "Object"]
        DropdownImgID.optionArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        DropdownTarget.optionArray = ["None", "Random"] // should add objects
        DropdownZoomLV.optionArray = ["100", "200", "300", "400", "500", "600", "700", "800", "900"]
        DropdownCenterPoint.optionArray = ["Random", "TopLeft", "ImgCenter"] // should add objects
        
        DropdownPID.selectedIndex = 0
        DropdownMode.selectedIndex = 0
        DropdownCondition.selectedIndex = 0
        DropdownImgID.selectedIndex = 0
        DropdownTarget.selectedIndex = 0
        DropdownZoomLV.selectedIndex = 0
        DropdownCenterPoint.selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        option1.isOn = userDefaults.bool(forKey: "mySwitchValue")
        option2.isOn = userDefaults.bool(forKey: "mySwitchValue2")
        SwipeIsEnabled.isOn = userDefaults.bool(forKey: "SwipeIsEnabled")
        
    }
    
    func outputAlert(title : String, message : String, text : String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let okButton = UIAlertAction(title: text, style: UIAlertAction.Style.cancel, handler: nil)

        alertController.addAction(okButton)

        return self.present(alertController, animated: true, completion: nil)

    }
    
    func getSelectedGroup(imgID: String) {
         if imgID == "0" { // 0 1
             selectedGroup.append(contentsOf: objectGroups[0])
             selectedGroup.append(contentsOf: objectGroups[1])
         }
         else if imgID == "1" { // 0 2
             selectedGroup.append(contentsOf: objectGroups[0])
             selectedGroup.append(contentsOf: objectGroups[2])
         }
         else if imgID == "2" { // 0 3
             selectedGroup.append(contentsOf: objectGroups[0])
             selectedGroup.append(contentsOf: objectGroups[3])
         }
         else if imgID == "3" { // 0 4
             selectedGroup.append(contentsOf: objectGroups[0])
             selectedGroup.append(contentsOf: objectGroups[4])
         }
         else if imgID == "4" { // 1 2
             selectedGroup.append(contentsOf: objectGroups[1])
             selectedGroup.append(contentsOf: objectGroups[2])
         }
         else if imgID == "5" { // 1 3
             selectedGroup.append(contentsOf: objectGroups[1])
             selectedGroup.append(contentsOf: objectGroups[3])
         }
         else if imgID == "6" { // 1 4
             selectedGroup.append(contentsOf: objectGroups[1])
             selectedGroup.append(contentsOf: objectGroups[4])
         }
         else if imgID == "7" { // 2 3
             selectedGroup.append(contentsOf: objectGroups[2])
             selectedGroup.append(contentsOf: objectGroups[3])
         }
         else if imgID == "8" { // 2 4
             selectedGroup.append(contentsOf: objectGroups[2])
             selectedGroup.append(contentsOf: objectGroups[4])
         }
         else if imgID == "9" { // 3 4
             selectedGroup.append(contentsOf: objectGroups[3])
             selectedGroup.append(contentsOf: objectGroups[4])
         }
        
    }

}
