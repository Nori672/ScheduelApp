//
//  SceneDelegate.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/08.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import UIKit

protocol backgroundTimerDelegate {
    func setCurrentTimer(_ elapsedTime:Int) //バックグラウンドの経過時間をタイマーに渡す
    func deleteTimer() //バックグラウンド時にタイマー破棄
    func checkBackground() //バックグラウンドへの移行を検知
    var timerIsBackground: Bool {set get} //バックグラウンド中かどうかを示す
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let ud = UserDefaults.standard
    var delegate: backgroundTimerDelegate?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    //バックグラウンドからアプリ画面に復帰した時の処理を追加
    //復帰する際に現在の時刻を取得し、一時保存した時刻との差分を算出（今回は秒）
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        //タイマー起動中にバックグラウンドへ移行した時
        if delegate?.timerIsBackground == true{
            let calender = Calendar(identifier: .gregorian)
            let date1 = ud.value(forKey: "date1") as! Date
            let date2 = Date()
            let elapsedTime = calender.dateComponents([.second], from: date1, to: date2).second!
            //ここで経過時間(elapsedTime)をタイマーに渡す
            delegate?.setCurrentTimer(elapsedTime)
        }
    }

    //アプリ画面から離れる時の処理を追加
    //UserDefaultでバックグラウンド移行時の時刻を一時保存
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        ud.set(Date(), forKey: "date1")
        //ここでバックグラウンドへの移行を検知＆タイマーを破棄
        delegate?.checkBackground()
        delegate?.deleteTimer()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

