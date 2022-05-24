//
//  Alert.swift
//  14_WaterDrink
//
//  Created by 이윤수 on 2022/05/24.
//

import Foundation

struct Alert : Codable {
    var id : String = UUID().uuidString
    var date : Date
    var isOn : Bool
    
    var time : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
    
    var apm : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        formatter.locale = Locale(identifier: "ko")
        return formatter.string(from: date)
    }
}
