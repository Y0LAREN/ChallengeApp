//
//  NoteEditView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 09.02.2025.
//

import SwiftUI
import SwiftData

struct NoteEditView: View {
    @State private var nameNote: String = ""
    @State private var textNote: String = ""
    @State private var selectedEmoji: Int? = nil
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.createCachedDataHandler) private var createDataHandler
    
    private var model: NoteModel
    
    init(model: NoteModel) {
        self.model = model
    }
    
    @EnvironmentObject private var coordinator: Coordinator
    
    private var isButtonEnabled: Bool {
        !model.nameNote.isEmpty && !model.textNote.isEmpty && selectedEmoji != nil
    }
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                NoteNavTitle(nameNote: "New entry")
                                
                HStack{
                    Text("Title:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                CustomTextField(
                    inputText: $nameNote,
                    placeholder: "Text")
                
                HStack{
                    Text("Description:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                }
                .padding(.top, 10)
                
                CustomTextEditor(
                    inputText: $textNote,
                    placeholder: "Text")
                .padding(.top, 10)
                
                SelectEmoji(
                    selectedEmoji: $selectedEmoji,
                    getEmoji: {index in
                        model.emojiNote = Emoji.data[index]
                    })
                    .padding(.top, 10)
                
                Spacer()
                
                Button(action: {
                    model.nameNote = nameNote
                    model.textNote = textNote
                    
                    changeNote(afterSave: {
                        coordinator.dismissSheet()
//                        coordinator.present(sheet: .noteInfo(model: coordinator.fetchNoteModel(modelContext: modelContext) ?? NoteModel(
//                            textNote: "",
//                            nameNote: "",
//                            emojiNote: ""),
//                                                    id: ))
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
            .frame(width: 358)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            nameNote = model.nameNote
            textNote = model.textNote
            
            switch model.emojiNote {
                case "emojiLove":
                    selectedEmoji = 0
                case "emojiNormal":
                    selectedEmoji = 1
                case "emojiSad":
                    selectedEmoji = 2
                case "emojiCry":
                    selectedEmoji = 3
                default:
                    selectedEmoji = nil
            }
            
            coordinator.modelContext = modelContext
        }
    }
    
    private func changeNote(afterSave: @escaping () -> Void) {
        let cache = CachedDataHandler(modelContainer: modelContext.container)
        Task {
            do {
                try await cache.changeNote(
                    noteModel: model,
                    nameNote: model.nameNote,
                    textNote: model.textNote,
                    emojiNote: model.emojiNote)
                afterSave()
            } catch {
                debugPrint("ERROR OCCURRED WHILE SAVING DIARY ENTRY - \(error)")
            }
        }
    }
}

#Preview {
    NoteEditView(
        model: NoteModel(
            textNote: "",
            nameNote: "",
            emojiNote: ""))
}
