//
//  EditChallengeView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 30.01.2025.
//


import SwiftUI
import SwiftData

struct EditChallengeView: View {
    @Bindable private var model: ChallengeModel
    
    @ObservedObject private var challengeInfoModel: ChallengeInfoModel = ChallengeInfoModel(dayProgress: 0)
    
    var columns: [GridItem] =
    [.init(.fixed(56)),
     .init(.fixed(56)),
     .init(.fixed(56)),
     .init(.fixed(56)),
     .init(.fixed(56))]
    
    init(model: ChallengeModel) {
        self.model = model
    }
    
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.modelContext) private var modelContext
    
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
                    trailingButtonModel: NavTitleButtonModel(
                        buttonImageColor: "buttonRed",
                        buttonBackgroundColor: "trashBackground",
                        buttonImage: "trash",
                        buttonAction: {
                            deleteChallengeModel(actionAfterDelete: {
                                coordinator.pop()
                                coordinator.pop()
                            })
                            StatisticsManager.shared.removeDays(Int(model.dayProgress))
                            StatisticsManager.shared.decreaseChallenges()
                        }))
                
                Text("\(Int(challengeInfoModel.dayProgress))/\(Int(model.dayTotal))")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 52, weight: .bold))
                    .padding(.top, 20)
                
                Text("The goal: \(model.goalName)")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 15)
                
                Slider(
                    value: $challengeInfoModel.dayProgress,
                    in: 0...model.dayTotal,
                    step: 1)
                    .tint(.blue)
                    .padding()

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach((0...Int(model.dayTotal-1)), id: \.self){ index in
                        if index < Int(challengeInfoModel.dayProgress) {
                            Image(.stateOn)
                        } else {
                            Image(.stateOff)
                        }
                    }
                }
                .padding(.top, 30)
                
                Spacer()
                Button(action: {
                    changeChallengeProgress()
                    coordinator.pop()
                }, label: {
                    HStack{
                        Image(systemName: "checkmark")
                        Text("Save")
                    }
                })
                .buttonStyle(MainButton(frameWidth: 358, frameHeight: 56, buttonColor: .buttonGreen))
            }
        }
        .onAppear{
            challengeInfoModel.dayProgress = model.dayProgress
            coordinator.modelContext = modelContext
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func changeChallengeProgress() {
        let cache = CachedDataHandler(modelContainer: modelContext.container)
        Task {
            do {
                try await cache.changeChallengeProgress(
                    challengeModel: model,
                    dayProgress: challengeInfoModel.dayProgress)
            } catch {
                debugPrint("ERROR OCCURRED WHILE SAVING CHALLENGE MODEL - \(error)")
            }
        }
    }
    
    @MainActor
    func deleteChallengeModel(actionAfterDelete: @escaping () -> Void) {
        let cache = CachedDataHandler(modelContainer: modelContext.container)
        Task {
            do {
                try await cache.delete(
                    id: model.persistentModelID,
                    ofType: ChallengeModel.self)
                actionAfterDelete()
            } catch {
                debugPrint("ERROR OCCURRED WHILE DELETING CHALLENGE MODEL - \(error)")
            }
        }
    }
    
}

#Preview {
    EditChallengeView(
        model: ChallengeModel(
            imageForCell: "badge1",
            goalName: "Running",
            dayTotal: 30,
            dayProgress: 12))
}
