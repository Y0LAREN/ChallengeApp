//
//  CellForChallengesModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 01.02.2025.
//

import SwiftUI
import SwiftData

struct CellForNote: View {
    private var model: NoteModel
    
    init(model: NoteModel) {
        self.model = model
    }
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image(model.emojiNote)
                        .resizable()
                        .frame(width: 22, height: 22)
                    
                    Text(model.nameNote)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 17, weight: .bold))
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13))
                
                HStack {
                    Text(model.textNote)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.grayDescriptionDiary)
                        .padding(EdgeInsets(top: 0, leading: 13, bottom: 5, trailing: 13))
                    Spacer()
                }
                
                
                Spacer()
            }
            .frame(height: 124)
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .background(Color.cellBackground)
            .cornerRadius(20)
                }
            .onTapGesture {
                coordinator.present(sheet: .noteInfo(model: model))
            }
    }
}

#Preview {
    CellForNote(
        model: NoteModel(
            textNote: "Good news",
            nameNote: "Sport Achive",
            emojiNote: "emojiLove"))
}
