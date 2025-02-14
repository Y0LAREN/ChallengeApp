//
//  BadgesView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 29.01.2025.
//
import SwiftUI

struct BadgesView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    private let statistics = StatisticsManager.shared.getStatistics()
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            ScrollView{
                VStack(spacing: 20) {
                    NavTitle(
                        title: "Badges",
                        leadingButtonModel: NavTitleButtonModel(
                            buttonImageColor: "grayDescription",
                            buttonBackgroundColor: "textFieldBackground",
                            buttonImage: "xmark",
                            buttonAction: {
                                coordinator.popToRoot()
                            }),
                        trailingButtonModel: nil)
                    
                    HStack{
                        Spacer()
                        
                        CellForBadges(
                            model: Badges.firstVictory,
                            buttonAction: {
                                self.coordinator.present(sheet: .badgeInfo(
                                    model: Badges.firstVictory, isCompleted: statistics.totalAchievements >= 1))
                            },
                            isCompleted: statistics.totalAchievements >= 1)
                        
                        CellForBadges(
                            model: Badges.fiveStepsToSuccess,
                            buttonAction: {
                                self.coordinator.present(sheet: .badgeInfo(
                                    model: Badges.fiveStepsToSuccess, isCompleted: statistics.totalAchievements >= 5))
                            }, isCompleted: statistics.totalAchievements >= 5)
                        
                        Spacer()
                    }
                    .frame(height: 208)
                    .frame(maxWidth: .infinity)
                    HStack{
                        Spacer()
                        
                        CellForBadges(
                            model: Badges.middleOfTheRoad,
                            buttonAction: {
                                self.coordinator.present(sheet: .badgeInfo(
                                    model: Badges.middleOfTheRoad, isCompleted: statistics.totalAchievements >= 10))
                            }, isCompleted: statistics.totalAchievements >= 10)
                        
                        CellForBadges(
                            model: Badges.fifteenthMilestone,
                            buttonAction: {
                                self.coordinator.present(sheet: .badgeInfo(
                                    model: Badges.fifteenthMilestone, isCompleted: statistics.totalAchievements >= 15))
                            }, isCompleted: statistics.totalAchievements >= 15)
                        
                        Spacer()
                    }
                    .frame(height: 208)
                    .frame(maxWidth: .infinity)
                    HStack{
                        Spacer()
                        
                        CellForBadges(
                            model: Badges.experiencedSeeker,
                            buttonAction: {
                                self.coordinator.present(sheet: .badgeInfo(
                                    model: Badges.experiencedSeeker, isCompleted: statistics.totalAchievements >= 20))
                            }, isCompleted: statistics.totalAchievements >= 20)
                        
                        CellForBadges(
                            model: Badges.conquerorOfPeaks,
                            buttonAction: {
                                self.coordinator.present(sheet: .badgeInfo(
                                    model: Badges.conquerorOfPeaks, isCompleted: statistics.totalAchievements >= 25))
                            }, isCompleted: statistics.totalAchievements >= 25)
                        
                        Spacer()
                    }
                    .frame(height: 208)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .onAppear{
            print("statistics.totalAchievements: \(statistics.totalAchievements)")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BadgesView()
}
