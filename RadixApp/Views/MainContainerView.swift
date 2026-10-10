import SwiftUI

public struct MainContainerView: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: 2 AM Acute Emergencies Triage
            NavigationStack {
                EmergencyProtocolsView()
                    .navigationTitle("Radix Crisis")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("2 AM Triage", systemImage: "cross.case.fill")
            }
            .tag(0)
            
            // Tab 2: Neurosurgical Emergencies ("Cannot Miss")
            NavigationStack {
                NeurosurgicalEmergenciesView()
                    .navigationTitle("Emergencies")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Red Flags", systemImage: "exclamationmark.triangle.fill")
            }
            .tag(1)
            
            // Tab 3: Procedural Atlas (EVD, Lumbar Drain, Camino, ICP)
            NavigationStack {
                NeurosurgicalProceduresView()
                    .navigationTitle("Procedures")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Procedures", systemImage: "syringe.fill")
            }
            .tag(2)
            
            // Tab 4: 60-Second Systematic Neuroimaging
            NavigationStack {
                ScanNavigatorView()
                    .navigationTitle("Scan Navigator")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("CT / MRI", systemImage: "brain.head.profile")
            }
            .tag(3)
            
            // Tab 5: Decoupler (Root vs Peripheral Nerve)
            NavigationStack {
                ConflictSolverView()
                    .navigationTitle("Arbitrator")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Root vs. Nerve", systemImage: "figure.walk")
            }
            .tag(4)
        }
        .tint(.indigo)
    }
}
