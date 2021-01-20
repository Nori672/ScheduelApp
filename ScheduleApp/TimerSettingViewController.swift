//
//  TimerSettingViewController.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/10.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit

class TimerSettingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var studyTime: UITextField!
    @IBOutlet weak var breakTime: UITextField!
    @IBOutlet weak var setCount: UITextField!
    @IBOutlet weak var studyTimerSettingLabel: UILabel!
    @IBOutlet weak var breakTimerSettingLabel: UILabel!
    @IBOutlet weak var setCountLabel: UILabel!
    @IBOutlet weak var startStop: UIButton!
    
    
    var setPickerView:UIPickerView = UIPickerView()
    var timePickerView:UIPickerView = UIPickerView()
    
    let hourTime:[Int] = Array(0...23)
    let minutesTime:[Int] = Array(0...59)
    let dataList:[Int] = Array(1...20)
    
    var timer:Timer! = nil
    var studytimer_sec = 0
    var breaktimer_sec = 0
    var set = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createPickerView()
    }
    
    func createPickerView() {
        setPickerView.delegate = self
        setPickerView.dataSource = self
        setPickerView.showsLargeContentViewer = true
        timePickerView.delegate = self
        timePickerView.dataSource = self
        studyTime.inputView = timePickerView
        breakTime.inputView = timePickerView
        setCount.inputView = setPickerView
        
        //toolbarの作成
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([doneButton], animated: true)
        studyTime.inputAccessoryView = toolbar
        breakTime.inputAccessoryView = toolbar
        setCount.inputAccessoryView = toolbar
        
    }
    
    @objc func donePicker() {
        studyTime.endEditing(true)
        breakTime.endEditing(true)
        setCount.endEditing(true)
    }
    
    //コンポーネントの個数を返す
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == timePickerView {
            return 2
        }
        return 1
    }
    
    //コンポーネントに含まれるデータの個数を返す
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == timePickerView{
            switch component {
            case 0:
                return hourTime.count
            case 1:
                return minutesTime.count
            default:
                return 0
            }
        }
        return dataList.count
    }
    
    //PickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == timePickerView {
            switch component {
            case 0:
                return String(hourTime[row]) + "時間"
            case 1:
                return String(minutesTime[row]) + "分"
            default:
                return ""
            }
        }
        return String(dataList[row]) + "セット"
    }
    
    //pickerViewのrowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var hourSelect = 0
        var minutesSelect = 0
        
        //それぞれのpickerViewで設定した内容をtextFieldに表示させる
        if pickerView == timePickerView{
            //timePickerViewのうち、どっちのtextFieldの設定を変更しているのかを判断(isFirstResponderで判断)
            if studyTime.isFirstResponder {
                switch component {
                case 0:
                    hourSelect = hourTime[row]
                    //時間をpickerで選んでいる時、現時点での分の値を取得(selectedRow)
                    minutesSelect = timePickerView.selectedRow(inComponent: 1)
                case 1:
                    //分をpickerで選んでいる時は、現時点での時間の値を取得
                    hourSelect = timePickerView.selectedRow(inComponent: 0)
                    minutesSelect = minutesTime[row]
                default:
                    print("取り組み時間が表示できません")
                }
                self.studyTime.text = String(format: "%02d:%02d:00", hourSelect, minutesSelect)
                self.studytimer_sec = timePickerView.selectedRow(inComponent: 0) * 3600 + timePickerView.selectedRow(inComponent: 1) * 60
            }else if breakTime.isFirstResponder {
                switch component {
                case 0:
                    hourSelect = hourTime[row]
                    minutesSelect = timePickerView.selectedRow(inComponent: 1)
                case 1:
                    hourSelect = timePickerView.selectedRow(inComponent: 0)
                    minutesSelect = minutesTime[row]
                default:
                    print("休憩時間が表示できません")
                }
                self.breakTime.text = String(format: "%02d:%02d:00", hourSelect, minutesSelect)
                self.breaktimer_sec = timePickerView.selectedRow(inComponent: 0) * 3600 + timePickerView.selectedRow(inComponent: 1) * 60
            }
        }else{
            //セット数の設定
            setCount.text = String(dataList[row])
            setCountLabel.text = String(dataList[row]) + "セット"
            set = setPickerView.selectedRow(inComponent: 0) + 1
        }
        
        self.studyTimerSettingLabel.text = self.studyTime.text
        self.breakTimerSettingLabel.text = self.breakTime.text
        
        print("取り組み")
        print(studytimer_sec)
        print("休憩")
        print(breaktimer_sec)
        print("セット数")
        print(set)
        print("おしまい")
    }
    
    @objc func studyTimer(_ timer:Timer){
        
        let studySecond = studytimer_sec % 60
        let studyMinutes = studytimer_sec / 60 % 60
        let studyHour = studytimer_sec / 3600
        
        let breakTimeSecond = breaktimer_sec % 60
        let brekTimeMinutes = breaktimer_sec / 60 % 60
        let breakTimeHour = breaktimer_sec / 3600
        
        print(studytimer_sec)
        
        if set > 0{
            self.studytimer_sec -= 1
            self.studyTimerSettingLabel.text = String(format: "%02d:%02d:%02d", studyHour, studyMinutes, studySecond)
            //残り時間と休憩時間が共に0になった時、セット数を減らす＆タイマーの時間を再セット
            if studytimer_sec <= 0 && breaktimer_sec <= 0{
                breaktimer_sec = 0
                self.breakTimerSettingLabel.text = "00:00:00"
                self.set -= 1
                setCountLabel.text = "\(self.set)" + "セット"
                
                self.studytimer_sec = timePickerView.selectedRow(inComponent: 0) * 3600 + timePickerView.selectedRow(inComponent: 1) * 60
                self.breaktimer_sec = timePickerView.selectedRow(inComponent: 0) * 3600 + timePickerView.selectedRow(inComponent: 1) * 60
                self.breakTimerSettingLabel.text = String(format: "%02d:%02d:%02d", breakTimeHour, brekTimeMinutes, breakTimeSecond)
            //残り時間が0になった時に休憩時間を減らす
            }else if studytimer_sec <= 0{
                self.studytimer_sec = 0
                self.breaktimer_sec -= 1
                self.studyTimerSettingLabel.text = "00:00:00"
                self.breakTimerSettingLabel.text = String(format: "%02d:%02d:%02d", breakTimeHour, brekTimeMinutes, breakTimeSecond)
            }
        }else if studytimer_sec == 0 && breaktimer_sec == 0 && set == 0 {
            self.timer.invalidate()
            self.timer = nil
            startStop.setTitle("開始", for: .normal)
        }
    }
    
    @IBAction func startStopButton(_ sender: Any) {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(studyTimer(_:)), userInfo: nil, repeats: true)
            startStop.setTitle("一時停止", for: .normal)
        }else{
            self.timer.invalidate()
            self.timer = nil
            startStop.setTitle("再開", for: .normal)
        }
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
