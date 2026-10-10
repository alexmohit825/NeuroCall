import SwiftUI

@main
struct RadixApp: App {
    var body: some Scene {
        WindowGroup {
            MainContainerView()
                .preferredColorScheme(.light) // Elegant, light aesthetic standard
        }
    }
}
