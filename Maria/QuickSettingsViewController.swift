//
//  QuickSettingsViewController.swift
//  Maria
//
//  Created by ShinCurry on 2016/10/6.
//  Copyright © 2016年 ShinCurry. All rights reserved.
//

import Cocoa
import Aria2RPC
import SwiftyUserDefaults

class QuickSettingsViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        userDefaultsInit()
    }
    
    let defaults = MariaUserDefault.auto
    let maria = Maria.shared
    
    @IBOutlet weak var limitModeDownloadRate: NSTextField!
    @IBOutlet weak var limitModeUploadRate: NSTextField!
}

extension QuickSettingsViewController {
    
    @IBAction func finishEditing(_ sender: NSTextField) {
        var key = DefaultsKeys.limitModeDownloadRate
        switch sender {
        case limitModeDownloadRate:
            key = .limitModeDownloadRate
        case limitModeUploadRate:
            key = .limitModeUploadRate
        default:
            break
        }
        
        if let intValue = Int(sender.stringValue) {
            defaults[key] = intValue
            defaults.synchronize()
        } else {
            sender.stringValue = "\(defaults[key])"
        }
        
        if defaults[.enableLowSpeedMode] {
            if sender == limitModeDownloadRate || sender == limitModeUploadRate {
                let downloadSpeed = defaults[.limitModeDownloadRate]
                let uploadSpeed = defaults[.limitModeUploadRate]
                maria.rpc?.lowSpeedLimit(download: downloadSpeed, upload: uploadSpeed)
            }
        }
    }
}

extension QuickSettingsViewController {
    func userDefaultsInit() {
        limitModeDownloadRate.stringValue = "\(defaults[.limitModeDownloadRate])"
        limitModeUploadRate.stringValue = "\(defaults[.limitModeUploadRate])"
    }
}
