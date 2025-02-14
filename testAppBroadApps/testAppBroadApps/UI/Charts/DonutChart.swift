//
//  DonutChart.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 13.02.2025.
//


import SwiftUI

struct DonutChart: View {
    // Общее количество челленджей
    var totalChallenges: Int
    // Количество завершённых челленджей
    var completedChallenges: Int
    
    // Вычисляем прогресс (от 0 до 1)
    var progress: Double {
        guard totalChallenges > 0 else { return 0 }
        return Double(completedChallenges) / Double(totalChallenges)
    }
    
    var body: some View {
        ZStack {
            // Фоновый круг (неактивная часть)
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 20)
            
            // Прогресс-дуга
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 20, lineCap: .butt)
                )
                .rotationEffect(.degrees(-90)) // Начало дуги сверху
                .animation(.easeOut(duration: 0.5), value: progress)
            
            // Текст с процентом выполнения в центре
            Text("\(Int(progress * 100))%")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(width: 150, height: 150)
    }
}

struct ContentView: View {
    var body: some View {
        // Пример: 10 челленджей, из которых завершено 6
        DonutChart(totalChallenges: 10, completedChallenges: 6)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
