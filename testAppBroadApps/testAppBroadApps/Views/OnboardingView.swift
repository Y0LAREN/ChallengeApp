import SwiftUI

struct OnboardingView: View {
    @State private var index: Int = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    let isReviewer: Bool

    @EnvironmentObject private var coordinator: Coordinator

    private let pages: [PageModel]

    init(isReviewer: Bool) {
        self.isReviewer = isReviewer
        self.pages = isReviewer ? PageModel.pagesForReviewers : PageModel.pagesForUsers
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack {
                PageControl(index: $index)

                TabView(selection: $index) {
                    ForEach(0..<pages.count, id: \.self) { i in
                        PageView(model: pages[i])
                            .tag(i)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Spacer()

                Button(action: {
                    if index < pages.count - 1 {
                        index += 1
                        if index == 1 {
                            AppReviewManager.requestReview()
                        }
                    }
                    else {
                        hasSeenOnboarding = true
//                        coordinator.push(.main)
                    }
                }, label: {
                    Text(index < pages.count - 1 ? "Next" : "Finish")
                })
                .buttonStyle(MainButton(frameWidth: 358, frameHeight: 56, buttonColor: .buttonBlue))
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    OnboardingView(isReviewer: false)
}
