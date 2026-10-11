import SwiftUI

@main
struct TrephineApp: App {
    var body: some Scene {
        WindowGroup {
            MainContainerView()
                .preferredColorScheme(.light) // Ceramic light aesthetic standard
        }
    }
}
