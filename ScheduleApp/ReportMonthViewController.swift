//
//  ReportMonthViewController.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/23.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ReportMonthViewController: UIViewController, IndicatorInfoProvider {
    
    var iteminfo:IndicatorInfo = "月" //ボタンのタイトルに使われる

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return iteminfo
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
