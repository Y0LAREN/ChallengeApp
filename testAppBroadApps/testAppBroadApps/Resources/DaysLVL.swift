//
//  DaysLVL.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 01.02.2025.
//


import SwiftUI

struct DaysLVL{
    let lvl: String
    let daysString: String
    let daysFloat: Float
    
    static let data: [DaysLVL] = [
        DaysLVL(lvl: "Easy", daysString: "10 days", daysFloat: 10),
        DaysLVL(lvl: "Medium", daysString: "20 days", daysFloat: 20),
        DaysLVL(lvl: "Hard", daysString: "30 days", daysFloat: 30)]
}
