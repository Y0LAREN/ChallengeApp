//
//  ChallengesListView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 29.01.2025.
//

import SwiftUI
import SwiftData

struct ChallengesListView: View {
    @Query private var challenges: [ChallengeModel]
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack{
                NavTitle(
                    title: "My challenges",
                    leadingButtonModel: NavTitleButtonModel(
                        buttonImageColor: "grayDescription",
                        buttonBackgroundColor: "textFieldBackground",
                        buttonImage: "xmark",
                        buttonAction: {
                            coordinator.popToRoot()
                        }),
                    trailingButtonModel: nil)
                
                if challenges.isEmpty {
                    VStack{
                        CellWithSilverCup(
                            textForCell: "Create a challenge",
                            descriptionForCell: "Your list of challenges is currently empty")
                        .padding(.top, 10)
                        Spacer()
                    }
                }
                else {
                    List(challenges) { challenge in
                            CellForChallenges(model: challenge)
                                .listRowBackground(Color.background)
                    }
                    .listStyle(.plain)
                    .padding(.top, 10)
                }
                
            }
            
            VStack{
                Spacer()
                Button(action: {
                    coordinator.present(sheet: .createChallenge)
                }, label: {
                    HStack{
                        Image(systemName: "plus.circle")
                        Text("Add new challenge")
                    }
                })
                .buttonStyle(MainButton(frameWidth: 358, frameHeight: 56, buttonColor: .buttonBlue))
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChallengesListView()
}
