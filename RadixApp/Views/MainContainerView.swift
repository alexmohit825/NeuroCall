import SwiftUI

public struct MainContainerView: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: Call Command Cockpit (Acuity, Tasks, Sickest Patients, Radar)
            NavigationStack {
                CallDashboardView()
                    .navigationTitle("Census & Radar")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Radar", systemImage: "waveform.path.ecg")
            }
            .tag(0)
            
            // Tab 2: 2 AM Crisis Triage & Red Flag Emergencies
            NavigationStack {
                EmergencyProtocolsView()
                    .navigationTitle("Crisis & Triage")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("2 AM Crisis", systemImage: "cross.case.fill")
            }
            .tag(1)
            
            // Tab 3: Consult Intake & Auto-SBAR Triage Engine
            NavigationStack {
                ConsultManagerView()
                    .navigationTitle("Consults")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Consults", systemImage: "doc.text.fill")
            }
            .tag(2)
            
            // Tab 4: 3D Spatial Simulator & HD Microsurgical Atlas Amalgam
            NavigationStack {
                AtlasAmalgamHubView()
                    .navigationTitle("3D Spatial & Atlas")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("3D & Atlas", systemImage: "rotate.3d.fill")
            }
            .tag(3)
            
            // Tab 5: Frontline On-Call Field Manual
            NavigationStack {
                OnCallFieldManualView()
                    .navigationTitle("On-Call Manual")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Field Manual", systemImage: "shield.lefthalf.filled")
            }
            .tag(4)
        }
        .tint(ObsidianTheme.neonCyan)
    }
}
