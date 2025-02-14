//
//  CustomSegmentView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 01.02.2025.
//

import SwiftUI
import SwiftData

struct CustomSegmentView: View {
    @Binding var index: Int
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        
        VStack{
            
            CustomSegment(index: $index)
            
            switch self.index{
                case 0:
                    coordinator.build(page: .notesList)
                case 1:
                    coordinator.build(page: .statistics)
                default:
                    VStack{}
            }
        }
    }
}

#Preview {
    DiaryView()
}
