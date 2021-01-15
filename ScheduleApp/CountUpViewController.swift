//
//  CountUpViewController.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/10.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit

class CountUpViewController: UIViewController {
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStop: UIButton!
    
    
    var nowTime = Date() //現時点での日時・時刻を習得
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    @objc func updateTimer(_ timer:Timer){
        //タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(nowTime)
        
        print(currentTime)
        
        let second = Int(currentTime) % 60
        let minutes = Int(currentTime) / 60 % 60
        let hour = Int(currentTime) / 3600 
        
        self.TimerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, second)
    }
    
    
    //タイマーの開始と一時停止のボタン
    @IBAction func startStopButton(_ sender: Any) {
        if self.timer == nil {
            //動作するタイマーを一つに保つため、timerが存在しない時だけ、タイマーを生成し動作させる
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            startStop.setTitle("一時停止", for: .normal)
        }else{
            //一時停止した時のアクション
            self.timer.invalidate() //タイマー停止
            self.timer = nil //timerをnilに戻す
            startStop.setTitle("開始", for: .normal)
        }
    }
    
    
    //計測終了ボタン
    @IBAction func finishButton(_ sender: Any) {
        self.timer.invalidate()
        self.timer = nil
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
