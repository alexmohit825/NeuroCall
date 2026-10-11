import SwiftUI

public struct MainContainerView: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: 2 AM Acute Crisis Triage (EDH, SDH, Uncal, SBAR Briefing)
            NavigationStack {
                EmergencyProtocolsView()
                    .navigationTitle("Trephine Crisis")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("2 AM Triage", systemImage: "cross.case.fill")
            }
            .tag(0)
            
            // Tab 2: Neurosurgical Emergencies ("Cannot Miss" + Shunt Obstruction)
            NavigationStack {
                NeurosurgicalEmergenciesView()
                    .navigationTitle("Emergencies")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Emergencies", systemImage: "exclamationmark.triangle.fill")
            }
            .tag(1)
            
            // Tab 3: Essential Surgical Atlas (Laminectomy, Discectomy, Screws, Craniotomies, Shunt)
            NavigationStack {
                SurgicalAtlasView()
                    .navigationTitle("Surgical Atlas")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Surgical Atlas", systemImage: "scalpel")
            }
            .tag(2)
            
            // Tab 4: Normal Neuroradiology (Cranial & Spinal Anatomy)
            NavigationStack {
                NeuroradiologyAtlasView()
                    .navigationTitle("Neuroradiology")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Neuroradiology", systemImage: "brain.head.profile")
            }
            .tag(3)
            
            // Tab 5: Bedside Procedures & Hardware (EVD Kocher's, Lumbar Drain, Camino, ICP)
            NavigationStack {
                NeurosurgicalProceduresView()
                    .navigationTitle("Bedside & ICP")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Bedside ICP", systemImage: "syringe.fill")
            }
            .tag(4)
        }
        .tint(.blue)
    }
}
