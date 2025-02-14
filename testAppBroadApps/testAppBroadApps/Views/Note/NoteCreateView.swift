//
//  NoteCreateView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 02.02.2025.
//

import SwiftUI
import SwiftData

struct NoteCreateView: View {
    @State private var selectedEmoji: Int? = nil
    @State private var nameNote: String = ""
    @State private var textNote: String = ""
    @State private var model: NoteModel = NoteModel(
        textNote: "",
        nameNote: "",
        emojiNote: "")
    
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var viewModel: NoteViewModel
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.createCachedDataHandler) private var createDataHandler
    
    private var isButtonEnabled: Bool {
        !nameNote.isEmpty && !textNote.isEmpty && selectedEmoji != nil
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
                        viewModel.noteModel.emojiNote = Emoji.data[index]
                    })
                .padding(.top, 10)
                
                Spacer()
                
                Button(action: {
                    viewModel.noteModel.nameNote = nameNote
                    viewModel.noteModel.textNote = textNote
                    
                    saveNoteModel(afterSave: {
                        coordinator.dismissSheet()})
                    
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
    }
    
    private func saveNoteModel(afterSave: @escaping () -> Void) {
        Task {
            if let dataHandler = await createDataHandler() {
                do {
                    try await dataHandler.persist(noteModel: viewModel.noteModel)
                    afterSave()
                } catch {
                    debugPrint("ERROR OCCURRED WHILE SAVING DIARY ENTRY - \(error)")
                }
            }
        }
    }
    
    private func changeNote(afterSave: @escaping () -> Void) {
        let cache = CachedDataHandler(modelContainer: modelContext.container)
        Task {
            do {
                try await cache.changeNote(
                    noteModel: viewModel.noteModel,
                    nameNote: viewModel.noteModel.nameNote,
                    textNote: viewModel.noteModel.textNote,
                    emojiNote: viewModel.noteModel.emojiNote)
                afterSave()
            } catch {
                debugPrint("ERROR OCCURRED WHILE SAVING DIARY ENTRY - \(error)")
            }
        }
    }
}

#Preview {
    NoteCreateView()
}
