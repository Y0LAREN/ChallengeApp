//
//  NotesListView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 01.02.2025.
//

import SwiftUI
import SwiftData

struct NotesListView: View {
    @Query private var notes: [NoteModel]
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.createCachedDataHandler) private var createDataHandler
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            if notes.isEmpty {
                VStack{
                    CellWithSilverCup(
                        textForCell: "Create an entry",
                        descriptionForCell: "There are no records here")
                    Spacer()
                }
            }
            else {
                List(notes) { note in
                    CellForNote(model: note)
                        .listRowBackground(Color.background)
                }
                .listStyle(.plain)
            }
            
            VStack{
                Spacer()
                Button(action: {
                    coordinator.present(sheet: .noteCreate)
                }, label: {
                    HStack{
                        Image(systemName: "plus.circle")
                        Text("Add a new entry")
                    }
                })
                .buttonStyle(MainButton(frameWidth: 358, frameHeight: 56, buttonColor: .buttonBlue))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NotesListView()
}
