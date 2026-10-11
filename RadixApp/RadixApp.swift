import SwiftUI

@main
struct NeuroCallApp: App {
    var body: some Scene {
        WindowGroup {
            MainContainerView()
                .preferredColorScheme(.light) // Crisp high-contrast light clinical aesthetic
        }
    }
}
