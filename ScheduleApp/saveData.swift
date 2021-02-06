//
//  saveData.swift
//  ScheduleApp
//
//  Created by Norihiro.Nakano on 2021/01/24.
//  Copyright © 2021 Norihiro.Nakano. All rights reserved.
//

import RealmSwift

class saveData:Object {
    @objc dynamic var date = Date()
    @objc dynamic var totalStudyTime_sec = 0
}
