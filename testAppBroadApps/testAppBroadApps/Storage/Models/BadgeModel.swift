//
//  BadgeInfoModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 05.02.2025.
//


import SwiftUI
import SwiftData

//@Model
//final class BadgeModel{
//    var imageBadge: String
//    var imageBadgeMask: String
//    var labelText: String
//    var descriptionText: String
//    
//    init(imageBadge: String, imageBadgeMask: String, labelText: String, descriptionText: String) {
//        self.imageBadge = imageBadge
//        self.imageBadgeMask = imageBadgeMask
//        self.labelText = labelText
//        self.descriptionText = descriptionText
//    }
//}

struct BadgeModel{
    let imageBadge: String
    let imageBadgeMask: String
    let labelText: String
    let descriptionText: String
}

struct Badges{
    static let firstVictory = BadgeModel(
        imageBadge: "badge1",
        imageBadgeMask: "badge1Mask",
        labelText: "First victory",
        descriptionText: "Exercise: complete 1 challenge!")
    
    static let fiveStepsToSuccess = BadgeModel(
        imageBadge: "badgeCup",
        imageBadgeMask: "badgeCupMask",
        labelText: "Five steps to success",
        descriptionText: "Exercise: complete 5 challenge!")
    
    static let middleOfTheRoad = BadgeModel(
        imageBadge: "badgeTarget",
        imageBadgeMask: "badgeTargetMask",
        labelText: "Middle of the road",
        descriptionText: "Exercise: complete 10 challenge!")
    
    static let fifteenthMilestone = BadgeModel(
        imageBadge: "badge15",
        imageBadgeMask: "badge15Mask",
        labelText: "Fifteenth milestone",
        descriptionText: "Exercise: complete 15 challenge!")
    
    static let experiencedSeeker = BadgeModel(
        imageBadge: "badgeSeeker",
        imageBadgeMask: "badgeSeekerMask",
        labelText: "Experienced Seeker",
        descriptionText: "Exercise: complete 20 challenge!")
    
    static let conquerorOfPeaks = BadgeModel(
        imageBadge: "badgeConqueror",
        imageBadgeMask: "badgeConquerorMask",
        labelText: "Conqueror of peaks",
        descriptionText: "Exercise: complete 25 challenge!")
}
