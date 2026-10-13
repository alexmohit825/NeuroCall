import SwiftUI

@main
struct NeuroCallApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            Group {
                if hasCompletedOnboarding {
                    MainContainerView()
                } else {
                    OnboardingFlowView(isOnboardingComplete: $hasCompletedOnboarding)
                }
            }
            .preferredColorScheme(.light) // Ceramic light aesthetic standard
        }
    }
}
