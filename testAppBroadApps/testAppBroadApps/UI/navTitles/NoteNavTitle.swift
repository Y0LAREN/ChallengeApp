//
//  NoteInfoView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 08.02.2025.
//


//
//  NoteInfoView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 02.02.2025.
//

import SwiftUI
import SwiftData

struct NoteNavTitle: View {
    let nameNote: String
    
    var body: some View {
            VStack{
                Elipse()
                    .padding(.top, 10)
                
                Text(nameNote)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 17, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
    }
}

