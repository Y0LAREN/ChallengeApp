//
//  NoteModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 05.02.2025.
//


import SwiftUI
import SwiftData

@Model
final class NoteModel: Hashable, Identifiable, ObservableObject{
    var textNote: String
    var nameNote: String
    var emojiNote: String
    
    init(textNote: String, nameNote: String, emojiNote: String) {
        self.textNote = textNote
        self.nameNote = nameNote
        self.emojiNote = emojiNote
    }
}
