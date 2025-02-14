//
//  CellForBadges 2.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 29.01.2025.
//


import SwiftUI

struct CellForChallenges: View {
    private var model: ChallengeModel
    
    init(model: ChallengeModel){
        self.model = model
    }
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
            VStack{
                Image(model.imageForCell)
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 10)
                
                Text(model.goalName)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 17, weight: .bold))
                    .padding(.bottom, 15)
                
                ProgressView(value: model.dayProgress, total: model.dayTotal)
                    .frame(width: 328)
                    .tint(Color.buttonGreen)
                    .scaleEffect(x: 1, y: 2.5, anchor: .center)
                
                Spacer()
            }
            .padding(.top, 20)
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(Color.cellBackground)
            .cornerRadius(20)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .onTapGesture {
                coordinator.push(.challengeInfo(model: model))
            }
    }
}

#Preview {
    CellForChallenges(
        model: ChallengeModel(
            imageForCell: "badge1",
            goalName: "Running",
            dayTotal: 30,
            dayProgress: 12))
}
