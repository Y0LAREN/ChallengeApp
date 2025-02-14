//
//  NoteInfoView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 02.02.2025.
//

import SwiftUI
import SwiftData
import Foundation

struct NoteInfoView: View {
    @StateObject private var model: NoteModel
    
    @State private var isDisappear: Bool = false
    
    init(model: NoteModel) {
        _model = StateObject(wrappedValue: model)
    }
    
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.createCachedDataHandler) private var createDataHandler
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                NoteNavTitle(nameNote: model.nameNote)
                
                HStack{
                    Text(model.textNote)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Image(model.emojiNote)
                }
                .frame(width: 358, height: 32)
                
                Spacer()
                
                HStack{
                    Button(action: {
                        
                        deleteNote(actionAfterDelete: {
                            coordinator.dismissSheet()
                        })
                        StatisticsManager.shared.decreaseNotes()
                        
                    }, label: {
                        Text("Delete")
                    })
                    .buttonStyle(MainButton(frameWidth: 174, frameHeight: 56, buttonColor: .buttonRed))
                    
                    Button(action: {
                        coordinator.dismissSheet()
                        coordinator.present(sheet: .noteEdit(model: model))
                    }, label: {
                        Text("Edit")
                    })
                    .buttonStyle(MainButton(frameWidth: 174, frameHeight: 56, buttonColor: .buttonBlue))
                }
                .frame(height: 88)
            }
            .frame(width: 358)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func deleteNote(actionAfterDelete: @escaping () -> Void) {
        Task {
            if let dataHandler = await createDataHandler() {
                    do {
                        try await dataHandler.delete(
                            id: model.persistentModelID,
                            ofType: NoteModel.self)
                        actionAfterDelete()
                    } catch {
                        debugPrint("ERROR OCCURRED WHILE DELETING DIARY ENTRY - \(error)")
                    }
            }
        }
    }
}
