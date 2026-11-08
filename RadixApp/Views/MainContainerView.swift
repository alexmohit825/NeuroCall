import SwiftUI

public struct MainContainerView: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: 2 AM Crisis Triage & Red Flag Emergencies (Landing Page)
            NavigationStack {
                EmergencyProtocolsView()
                    .navigationTitle("2 AM Crisis")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("2 AM Crisis", systemImage: "cross.case.fill")
            }
            .tag(0)
            
            // Tab 2: Frontline ER Neurosurgical Consults Suite (Cranial & Spinal)
            NavigationStack {
                ERConsultsView()
                    .navigationTitle("ER Consults")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("ER Consults", systemImage: "stethoscope.circle.fill")
            }
            .tag(1)
            
            // Tab 3: Procedural Atlas & Bedside Hardware (Kocher's EVD, Camino Bolt, Lumbar Drain)
            NavigationStack {
                NeurosurgicalProceduresView()
                    .navigationTitle("Bedside")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Bedside", systemImage: "target")
            }
            .tag(2)
            
            // Tab 4: Clinical Grading, Evidence Scores & Dosing Calculators Hub
            NavigationStack {
                NeurosurgeryCalculatorsView()
                    .navigationTitle("Calculators")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Calculators", systemImage: "function")
            }
            .tag(3)
            
            // Tab 5: Surgical Anatomy & Atlas (Craniotomies, Operative Corridors, Spine Anatomy)
            NavigationStack {
                PhotorealisticSurgicalAtlasView()
                    .navigationTitle("Surgical Anatomy & Atlas")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Surgical Anatomy & Atlas", systemImage: "book.pages.fill")
            }
            .tag(4)
        }
        .tint(ObsidianTheme.neonCyan)
        .onChange(of: selectedTab) { _ in
            HapticManager.impact(style: .light)
        }
    }
}
