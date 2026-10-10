import SwiftUI

public struct MainContainerView: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: 2 AM Acute Emergencies
            NavigationStack {
                EmergencyProtocolsView()
                    .navigationTitle("Radix Crisis")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("2 AM Triage", systemImage: "cross.case.fill")
            }
            .tag(0)
            
            // Tab 2: 60-Second Systematic Neuroimaging
            NavigationStack {
                ScanNavigatorView()
                    .navigationTitle("Scan Navigator")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("CT / MRI", systemImage: "brain.head.profile")
            }
            .tag(1)
            
            // Tab 3: Decoupler (Root vs Peripheral Nerve)
            NavigationStack {
                ConflictSolverView()
                    .navigationTitle("Radix Arbitrator")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Root vs. Nerve", systemImage: "figure.walk")
            }
            .tag(2)
        }
        .tint(.indigo)
    }
}
