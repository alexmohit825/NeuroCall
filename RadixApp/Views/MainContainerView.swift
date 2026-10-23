import SwiftUI

public struct MainContainerView: View {
    @State private var selectedTab = 0
    @State private var isShowingSpotlight = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                
                // Tab 2: 2 AM Crisis Triage & Red Flag Emergencies (Photorealistic CT Atlas + Dynamic Calipers)
                NavigationStack {
                    EmergencyProtocolsView()
                        .navigationTitle("2 AM Crisis")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("2 AM Crisis", systemImage: "cross.case.fill")
                }
                .tag(1)
                
                // Tab 3: Frontline ER Neurosurgical Consults Suite (Cranial & Spinal)
                NavigationStack {
                    ERConsultsView()
                        .navigationTitle("ER Consults")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("ER Consults", systemImage: "stethoscope.circle.fill")
                }
                .tag(2)
                
                // Tab 4: Resident Clinical Calculators & Decision Support Hub
                NavigationStack {
                    NeurosurgeryCalculatorsView()
                        .navigationTitle("Calculators")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Calculators", systemImage: "function")
                }
                .tag(3)
                
                // Tab 5: Studio-Grade Photorealistic Surgical Atlas (Option C)
                NavigationStack {
                    PhotorealisticSurgicalAtlasView()
                        .navigationTitle("Surgical Atlas")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Surgical Atlas", systemImage: "book.pages.fill")
                }
                .tag(4)
            }
            .tint(ObsidianTheme.neonCyan)
            
            // Universal Spotlight Floating Button
            FloatingSpotlightButton(isPresented: $isShowingSpotlight)
                .padding(.trailing, 18)
                .padding(.bottom, 64)
        }
        .sheet(isPresented: $isShowingSpotlight) {
            UniversalSpotlightModal()
        }
    }
}
