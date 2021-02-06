//
//  ViewController.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/08.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startNowButton: UIButton!
    @IBOutlet weak var settingTimeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startNowButton.layer.borderColor = UIColor.black.cgColor
        startNowButton.layer.borderWidth = 2
        startNowButton.layer.cornerRadius = 5
        settingTimeButton.layer.borderColor = UIColor.black.cgColor
        settingTimeButton.layer.borderWidth = 2
        settingTimeButton.layer.cornerRadius = 5
    }


}

