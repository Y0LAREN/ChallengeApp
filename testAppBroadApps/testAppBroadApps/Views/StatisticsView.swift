import SwiftUI
import Charts

struct StatisticsView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    private let statistics = StatisticsManager.shared.getStatistics()
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        Text("\(statistics.totalDays)")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 28, weight: .bold))
                        Text("days in the challenge")
                            .foregroundStyle(Color.grayDescriptionDiary)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .frame(height: 102)
                    .frame(maxWidth: .infinity)
                    .background(Color.textFieldBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(Color.grayDescriptionDiary, lineWidth: 20)
                                Circle()
                                    .trim(from: (1-progress), to: 1)
                                    .stroke(Color.buttonBlue, style: StrokeStyle(lineWidth: 20, lineCap: .butt))
                                    .rotationEffect(.degrees(-90))
                            }
                            .frame(width: 80, height: 80)
                            
                            Text("\(statistics.completedChallenges)/\(statistics.allChallenges)")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 28, weight: .bold))
                            Text("challenges completed")
                                .foregroundStyle(Color.grayDescriptionDiary)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .frame(height: 216)
                        .frame(maxWidth: .infinity)
                        .background(Color.textFieldBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.leading, 10)
                        
                        VStack {
                            VStack {
                                Text("\(statistics.totalNotes)")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 28, weight: .bold))
                                Text("entries added")
                                    .foregroundStyle(Color.grayDescriptionDiary)
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .frame(height: 102)
                            .frame(maxWidth: .infinity)
                            .background(Color.textFieldBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .padding(.trailing, 10)
                            
                            VStack {
                                Text("\(statistics.totalAchievements)")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 28, weight: .bold))
                                Text("achievements received")
                                    .foregroundStyle(Color.grayDescriptionDiary)
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .frame(height: 102)
                            .frame(maxWidth: .infinity)
                            .background(Color.textFieldBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .padding(.trailing, 10)
                        }
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
        }
    }
    
    private var progress: CGFloat {
        guard statistics.allChallenges > 0 else { return 0 }
        return CGFloat(statistics.completedChallenges) / CGFloat(statistics.allChallenges)
    }
}

struct CircleValue: Identifiable {
    let id = UUID()
    let name: String
    let value: Int
    
//    static var data: [CircleValue] = [
//        CircleValue(name: "All Challenges", value: StatisticsManager.shared.getStatistics().allChallenges),
//        CircleValue(name: "Completed Challenges", value: StatisticsManager.shared.getStatistics().completedChallenges)
//    ]    
    static var data: [CircleValue] = [
        CircleValue(name: "All Challenges", value: 12),
        CircleValue(name: "Completed Challenges", value: 4)
    ]
}

#Preview {
    StatisticsView()
}
