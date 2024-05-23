//
//  Alarm.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/17/24.
//

import Foundation

struct Alarm {
    var isMissionEnabled: Bool
    var amPm: String
    var hour: Int
    var minute: Int
    var selectedDays: [String]
    var selectedSound: String?
    var memo: String?
    var isReminderEnabled: Bool
    var isAlarmOn: Bool
    
    var formattedTime: String {
        return String(format: "%02d:%02d", hour, minute)
    }
}
