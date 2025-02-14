//
//  ContentView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 27.01.2025.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.createCachedDataHandler) private var createDataHandler
    private let userDefaults = UserDefaults.standard
    @State private var completedChallenge: ChallengeModel?
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
            ZStack{
                Color.background
                    .ignoresSafeArea()
                VStack{
                    VStack {
                        ZStack{
                            Image("elipse")
                            Image("cupWithoutElipse")
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 144, height: 141)
                        }
                        .frame(width: 183, height: 183)
                        Text("Create a challenge")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 28, weight: .bold))
                            .padding(.top, 10)
                            .padding(.bottom, 2)
                        Text("Add goals, complete them and achieve\nsuccess")
                            .foregroundStyle(Color.grayDescription)
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        Button(action: {
                            coordinator.present(sheet: .createChallenge)
                        }, label: {
                            HStack{
                                Text("Start")
                            }
                        })
                        .buttonStyle(MainButton(
                            frameWidth: 244,
                            frameHeight: 50,
                            buttonColor: Color.buttonBlue))
                        .padding(.top, 10)
                    }
                    .frame(width: 358, height: 408)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .background(Color.cellBackground)
                    .cornerRadius(20)
                    HStack{
                        CellSquare(
                            imageForCell: "growthPath",
                            textForCell: "My challenges",
                            buttonAction: {
                                coordinator.push(.challengesList)
                            })
                        CellSquare(
                            imageForCell: "medals",
                            textForCell: "Budges",
                            buttonAction: {
                                coordinator.push(.badges)
                            })
                        .padding(.leading, 6)
                    }
                    .padding(.top, 6)
                    .frame(width: 358)
                    VStack(spacing: 12, content: {
                        
                        LargeCell(
                            imageForCell: "book",
                            textForCell: "Diary",
                            buttonAction: {
                                coordinator.push(.diary)
                            })
                        LargeCell(
                            imageForCell: "gearWheel",
                            textForCell: "Settings",
                            buttonAction: {
                                coordinator.push(.settings)
                            })
                    })
                    .padding(.top, 6)
                    Spacer()
                }
                .padding(.top)
            }
            .onAppear{
                updateChallengeProgressIfNeeded(afterSaveModel: {
                    if let completedChallenge = completedChallenge {
                        coordinator.push(.challengeSuccess(dayTotal: completedChallenge.dayTotal, goalName: completedChallenge.goalName, modelID: completedChallenge.persistentModelID))
                    }
                })
        }
    }
    
    @MainActor
    private func checkCompletedChallenges() {
        Task {
            if let dataHandler = await createDataHandler() {
                do{
                    let challenges = try await dataHandler.fetchActiveChallenges()
                    if let completed = challenges.first(where: { $0.isCompleted == true }) {
                        self.completedChallenge = completed
                    }
                } catch {
                    print("Ошибка обновления челленджа \(error)")
                }
            }
            
        }
    }
    
    @MainActor
    private func updateChallengeProgress(actionForCompletedChallenges: @escaping (ChallengeModel) -> Void) {
        Task {
            if let dataHandler = await createDataHandler() {
                do{
                    try await dataHandler.updateChallengeProgressIfNeeded(actionForCompletedChallenges: { model in
                        actionForCompletedChallenges(model)
                        
                    })
                } catch {
                    print("Ошибка обновления челленджа \(error)")
                }
            }
        }
    }
    
    @MainActor
    private func updateChallengeProgressIfNeeded(afterSaveModel: @escaping () -> Void) {
        
        let lastUpdate = userDefaults.object(forKey: "lastProgressUpdate") as? Date ?? Date.distantPast
        print("lastUpdate: \(lastUpdate)")
        let calendar = Calendar.current
        
        Task {
            if let dataHandler = await createDataHandler() {
                do{
                    let activeChallenges = try await dataHandler.fetchActiveChallenges()
                    
                    guard !(calendar.isDateInToday(lastUpdate)) else {
                        print("Челленджи уже обновлены сегодня, пропускаем обновление.")
                        for challenge in activeChallenges {
                            if challenge.isCompleted {
                                print("Челлендж найден.")
                                completedChallenge = challenge
                                afterSaveModel()
                            }
                        }
                        return
                    }
                    
                    for challenge in activeChallenges {
                        if !challenge.isCompleted {
                            challenge.dayProgress += daysBetween(lastUpdate, Date())
                            if challenge.dayProgress >= challenge.dayTotal {
                                challenge.isCompleted = true
                                completedChallenge = challenge
                                print("Челлендж найден.")
                                afterSaveModel()
                            }
                        }
                    }
                    
                    try await dataHandler.saveContext()
                    userDefaults.set(Date(), forKey: "lastProgressUpdate")
                    print("`dayProgress` успешно обновлён у всех активных челленджей!")
                    
                } catch {
                    print("Ошибка обновления челленджа \(error)")
                }
            }
        }
        
//        let activeChallenges = try modelContext.fetch(FetchDescriptor<ChallengeModel>())
    }
    
    private func daysBetween(_ startDate: Date, _ endDate: Date) -> Float {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return Float(components.day ?? 0)
    }
    
}

#Preview {
    MainView()
}
