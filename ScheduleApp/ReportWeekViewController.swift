//
//  ReportWeekViewController.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/23.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Charts
import RealmSwift

class ReportWeekViewController: UIViewController, IndicatorInfoProvider {
    
    var iteminfo:IndicatorInfo = "週" //ボタンのタイトルに使われる

    @IBOutlet weak var barChart: BarChartView!
    
    var data = saveData()
    let realm = try!Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarChartData()
        settingBarChartData()

        // Do any additional setup after loading the view.
    }
    
    func settingBarChartData(){
        let Data = realm.objects(saveData.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "y/MM/dd/HH/mm", options: 0, locale: Locale(identifier: "ja_JP"))
        
    }
    
    func setupBarChartData(){
        let pickUpData = realm.objects(saveData.self).sorted(byKeyPath: "date", ascending: true)
        print(pickUpData)
        let testData:[Int] = [10,pickUpData[0].totalStudyTime_sec,30,40,50,60,70]
        let entry = testData.enumerated().map{BarChartDataEntry(x: Double($0.offset), y: Double($0.element))}
        let dataset = BarChartDataSet(entries: entry)
        let data = BarChartData(dataSet: dataset)
        barChart.data = data
        
        let xAxis = barChart.xAxis
        xAxis.valueFormatter = weekAxisFormatter()
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 7
    }
    
    class weekAxisFormatter:NSObject, IAxisValueFormatter{
        let week = ["日", "月", "火", "水", "木", "金", "土"]
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return week[Int(value)]
        }
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
