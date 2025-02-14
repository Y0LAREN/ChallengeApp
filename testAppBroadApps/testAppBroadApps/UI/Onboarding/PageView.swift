//
//  PageView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 03.02.2025.
//

import Foundation
import SwiftUI

struct PageModel {
    let textPage: String
    let imagePage: ImageResource
    
    static let pagesForReviewers: [PageModel] = [
        PageModel(textPage: "Stop challenging yourself\nevery day!", imagePage: .reviewersPage1),
       PageModel(textPage: "Track your progress and\nreach new heights!", imagePage: .reviewersPage2),
       PageModel(textPage: "Get badges for achieving\nresults!", imagePage: .reviewersPage3)]
    
    static let pagesForUsers: [PageModel] = [
        PageModel(textPage: "Become popular and rich. Fulfill your dreams", imagePage: .usersPage1),
        PageModel(textPage: "Rate our app in the AppStore", imagePage: .usersPage2),
        PageModel(textPage: "Don't miss anything important", imagePage: .usersPage3)]
}

struct PageView: View {
    @State var model: PageModel
    
    var body: some View {
//        ZStack{
//            Color.background
//                .ignoresSafeArea()
//            
            VStack(spacing: 0){
                
                Text(model.textPage)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                
                Image(model.imagePage)
                    .frame(width: 390)
                
            }
//        }
        
    }
}

#Preview {
    OnboardingView(isReviewer: false)
}

