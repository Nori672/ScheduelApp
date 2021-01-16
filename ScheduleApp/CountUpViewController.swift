//
//  CountUpViewController.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/10.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit

class CountUpViewController: UIViewController,backgroundTimerDelegate {
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStop: UIButton!
    
    
    var timer:Timer!
    var timer_sec = 0
    
    //SceneDelegateに追加したプロトコルに批准させる
    var timerIsBackground = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //SceneDelegateを取得
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                return
        }
        
        sceneDelegate.delegate = self
    }
    
    //バックグラウンドへの移行を確認
    func checkBackground() {
        if let _ = timer {
            timerIsBackground = true
        }
    }
    
    func setCurrentTimer(_ elapsedTime: Int) {
        //一時停止してから(timerをnilになったとき)バックグラウンドに移行した時にはタイマーは動かさない
        if self.timer != nil {
            //バックグラウンドでの経過時間を加算
            self.timer_sec += elapsedTime
            
            let second = timer_sec % 60
            let minutes = timer_sec / 60 % 60
            let hour = timer_sec / 3600
            
            self.TimerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, second)
            
            //再びタイマー起動
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            
        }
        
    }
    
    //起動中のタイマー破棄
    func deleteTimer() {
        if let _ = timer{
            timer.invalidate()
        }
    }
    
    @objc func updateTimer(_ timer:Timer){
        self.timer_sec += 1

        let second = timer_sec % 60
        let minutes = timer_sec / 60 % 60
        let hour = timer_sec / 3600
        
        self.TimerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, second)
    }
    
    
    //タイマーの開始と一時停止のボタン
    @IBAction func startStopButton(_ sender: Any) {
        if self.timer == nil {
            //動作するタイマーを一つに保つため、timerが存在しない時だけ、タイマーを生成し動作させる
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
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
