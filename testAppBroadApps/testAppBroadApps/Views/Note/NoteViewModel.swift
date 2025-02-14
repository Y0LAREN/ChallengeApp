//
//  NoteCreateViewModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 07.02.2025.
//


import Foundation
import SwiftData

final class NoteViewModel: ObservableObject {
    @Published var noteModel: NoteModel

    init(noteModel: NoteModel) {
        self.noteModel = noteModel
    }
}
