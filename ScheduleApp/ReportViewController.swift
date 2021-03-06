//
//  ReportViewController.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/10.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ReportViewController: SegmentedPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let weekVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weekGraph")
        let monthVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "monthGraph")
        let childViewControllers:[UIViewController] = [weekVC, monthVC]
        return childViewControllers
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
