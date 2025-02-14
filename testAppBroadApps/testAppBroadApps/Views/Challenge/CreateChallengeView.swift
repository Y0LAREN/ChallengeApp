//
//  CreateChallengeView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 31.01.2025.
//

import SwiftUI
import SwiftData

struct CreateChallengeView: View {
    @State private var selectedLVL: Int? = nil
    @State private var selectedEmotion: Int? = nil
    @State private var goalName: String = ""
    @State private var model: ChallengeModel = ChallengeModel(
        imageForCell: "",
        goalName: "",
        dayTotal: 0)
    
//    @Environment(\.createCachedDataHandler) private var createDataHandler
    
    @EnvironmentObject private var viewModel: ChallengeViewModel
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.modelContext) private var modelContext
    
    private var isButtonEnabled: Bool {
        selectedLVL != nil && selectedEmotion != nil && !goalName.isEmpty
    }
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
//MARK: - TextField input your goal
            VStack(spacing: 0){
                
                NoteNavTitle(nameNote: "New challenge")
                
                HStack{
                    Text("Your goal: ")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                }
                .frame(width: 358)
                .padding(.top, 20)
                
                CustomTextField(
                    inputText: $goalName,
                    placeholder: "Enter the name of the challenge")
                    .padding(.top, 20)
                
//MARK: - LVL
                SelectDaysLVL(
                    selectedLVL: $selectedLVL,
                    getDaysLVL: {index in
                        viewModel.challengeModel.dayTotal = DaysLVL.data[index].daysFloat
                    })
                .padding(.top, 60)
                
//MARK: - Emotion
                SelectEmotion(
                    selectedEmotion: $selectedEmotion,
                    getEmotion: { index in
                        viewModel.challengeModel.imageForCell = Emotion.data[index]
                    })
                .padding(.top, 60)
                
                
                Spacer()
                
                Button(action: {
                    viewModel.challengeModel.goalName = goalName
                    
                    model = viewModel.challengeModel
                    
                    saveChallengeModel(afterSave: {
                        coordinator.dismissSheet()
                    })
                }, label: {
                    HStack{
                        Image(systemName: "checkmark")
                        Text("Save")
                    }
                })
                .buttonStyle(MainButton(
                    frameWidth: 358,
                    frameHeight: 56,
                    buttonColor: Color.buttonBlue))
                .disabled(!isButtonEnabled)
                .opacity(isButtonEnabled ? 1.0 : 0.5)
                .allowsHitTesting(isButtonEnabled)

            }
        }
        .onAppear{
            model = viewModel.challengeModel
            coordinator.modelContext = modelContext
        }
    }
    
    private func saveChallengeModel(afterSave: @escaping () -> Void) {
        let cache = CachedDataHandler(modelContainer: modelContext.container)
        Task {
            do {
                try await cache.persist(challengeModel: viewModel.challengeModel)
                afterSave()
            } catch {
                debugPrint("ERROR OCCURRED WHILE SAVING DIARY ENTRY - \(error)")
            }
        }
    }
}

#Preview {
    CreateChallengeView()
}
