//
//  Constants.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 07.02.2025.
//


//
//  Constants.swift
//  Diary
//
//  Created by Dhruv Saraswat on 26/02/24.
//

import SwiftUI
import SwiftData

struct Constants {
    enum FetchChallengeDescriptors {
        case fetchAllChallenges
        
        var descriptor: FetchDescriptor<ChallengeModel> {
            switch self {
                case .fetchAllChallenges:
                    let descriptor = FetchDescriptor<ChallengeModel>(
                        sortBy: [.init(\.goalName, order: .reverse)]
                    )
                    return descriptor
            }
        }
    }
    
    enum FetchNoteDescriptors {
        case fetchAllNotes
        
        var descriptor: FetchDescriptor<NoteModel> {
            switch self {
                case .fetchAllNotes:
                    let sortDescriptor = SortDescriptor(\NoteModel.id, order: .reverse)
                    let fetchDescriptor = FetchDescriptor<NoteModel>(sortBy: [sortDescriptor])
                    return fetchDescriptor
            }
        }
    }
}
