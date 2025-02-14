//
//  ChallengeSuccessView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 30.01.2025.
//

import SwiftUI
import SwiftData

struct ChallengeSuccessView: View {
    let dayTotal: Float
    let goalName: String
    let modelID: PersistentIdentifier
    
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.createCachedDataHandler) private var createDataHandler
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack{
                NavTitle(
                    title: "Challenge",
                    leadingButtonModel: NavTitleButtonModel(
                        buttonImageColor: "grayDescription",
                        buttonBackgroundColor: "textFieldBackground",
                        buttonImage: "xmark",
                        buttonAction: {
                            StatisticsManager.shared.incrementCompletedChallenges()
                            StatisticsManager.shared.incrementAchievements()
                            deleteChallengeModel(actionAfterDelete: {
                                coordinator.popToRoot()
                            })
                        }),
                    trailingButtonModel: nil)
                .frame(width: 390)
                
                ZStack{
                    Image(.maskParticulars)
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                    Image(.elipseDark)
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                    Image(.elipseLightBlue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                    Image(.cupSolo)
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                }
                .padding(40)
                Spacer()
            }
            
            VStack(spacing: 0){
                
//                Text("\(Int(model.dayTotal))/\(Int(model.dayTotal))")
//                    .foregroundStyle(Color.white)
//                    .font(.system(size: 52, weight: .bold))
//                    .padding(.top, 20)
                
                Text("\(Int(dayTotal))/\(Int(dayTotal))")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 52, weight: .bold))
                    .padding(.top, 20)
                
                Text("The goal: \(goalName)")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 15)
                
                ProgressView(value: 100, total: 100)
                    .frame(width: 328)
                    .tint(Color.buttonBlue)
                    .scaleEffect(x: 1, y: 2.5, anchor: .center)
                    .padding(.top, 50)
                
                Text("Congratulations! Your goal has been successfully completed!")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.top, 60)
                    .frame(width: 326)
                
                Spacer()
                
                Button(action: {
                    restartChallenge(actionAfterDelete: {
                        StatisticsManager.shared.incrementCompletedChallenges()
                        StatisticsManager.shared.incrementAchievements()
                        coordinator.popToRoot()
                    })
                }, label: {
                    HStack{
                        Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
                        Text("Restart")
                    }
                })
                .buttonStyle(MainButton(frameWidth: 358, frameHeight: 56, buttonColor: .buttonRed))
            }
            .padding(.top, 360)
        }
        .onAppear{
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func restartChallenge(actionAfterDelete: @escaping () -> Void) {
        Task {
            if let dataHandler = await createDataHandler() {
                do {
                    guard let model = try await dataHandler.getFreshChallenge(by: modelID) else { return }
                    try await dataHandler.restartChallenge(
                        challengeModel: model)
                    actionAfterDelete()
                } catch {
                    debugPrint("ERROR OCCURRED WHILE SAVING DIARY ENTRY - \(error)")
                }
            }
        }
    }
    
    func deleteChallengeModel(actionAfterDelete: @escaping () -> Void) {
        Task {
            if let dataHandler = await createDataHandler() {
                do {
                    try await dataHandler.delete(
                        id: modelID,
                        ofType: ChallengeModel.self)
                    actionAfterDelete()
                } catch {
                    debugPrint("ERROR OCCURRED WHILE DELETING DIARY ENTRY - \(error)")
                }
            }
        }
    }
    
}

//#Preview {
//    ChallengeSuccessView(
//        model: ChallengeModel(
//            imageForCell: "badge1",
//            goalName: "Running",
//            dayTotal: 30))
//}
