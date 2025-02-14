//
//  Loader.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 17.02.2025.
//

import SwiftUI

struct LoaderView: View {
    @State private var progress: CGFloat = 0.0
    @Binding var isLoaded: Bool
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            
            VStack{
                ZStack{
                    Image("elipseLoader")
                    Image("cupWithoutElipse")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 210, height: 210)
                }
                .frame(width: 371, height: 371)
                .padding(.top, 80)
                
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                    .frame(width: 205)
                    .padding(.top, 140)

                Text("Loading \(Int(progress * 100))%")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.top, 10)

                Spacer()

            }
        }
        .onAppear {
            startLoading()
        }
    }
    
    private func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if progress < 1.0 {
                progress += 0.05
                progress = min(progress, 1.0)
            } else {
                isLoaded = true
                timer.invalidate()
            }
        }
    }

    
}
