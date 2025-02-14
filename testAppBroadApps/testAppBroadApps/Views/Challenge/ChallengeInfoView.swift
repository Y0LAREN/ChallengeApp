//
//  ChallengeInfoModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 30.01.2025.
//

import SwiftUI
import SwiftData

struct ChallengeInfoView: View {
    @Bindable private var model: ChallengeModel
    
    init(model: ChallengeModel) {
        self.model = model
    }
    
    @EnvironmentObject private var coordinator: Coordinator
    
    let columns: [GridItem] =
    [.init(.fixed(56)),
     .init(.fixed(56)),
     .init(.fixed(56)),
     .init(.fixed(56)),
     .init(.fixed(56))]
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 0){
                
                NavTitle(
                    title: "Challenges",
                    leadingButtonModel: NavTitleButtonModel(
                        buttonImageColor: "grayDescription",
                        buttonBackgroundColor: "textFieldBackground",
                        buttonImage: "xmark",
                        buttonAction: {
                            coordinator.pop()
                        }),
                    trailingButtonModel: nil)
                
                Text("\(Int(model.dayProgress))/\(Int(model.dayTotal))")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 52, weight: .bold))
                    .padding(.top, 20)
                
                Text("The goal: \(model.goalName)")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 15)
                
                ProgressView(value: model.dayProgress, total: model.dayTotal)
                    .frame(width: 328)
                    .tint(Color.buttonBlue)
                    .scaleEffect(x: 1, y: 2.5, anchor: .center)
                    .padding(.top, 50)
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach((0..<Int(model.dayTotal)), id: \.self){ index in
                        if index < Int(model.dayProgress) {
                            Image(.stateOn)
                        } else {
                            Image(.stateOff)
                        }
                    }
                }
                .padding(.top, 30)
                
                Spacer()
                Button(action: {
                    coordinator.dismissSheet()
                    coordinator.push(.editChallenge(model: model))
                }, label: {
                    HStack{
                        Image(systemName: "pencil.line")
                        Text("Edit")
                    }
                })
                .buttonStyle(MainButton(frameWidth: 358, frameHeight: 56, buttonColor: .buttonBlue))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChallengeInfoView(
        model: ChallengeModel(
            imageForCell: "badge1",
            goalName: "Running",
            dayTotal: 30,
            dayProgress: 12))
}
