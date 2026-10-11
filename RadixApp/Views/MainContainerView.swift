import SwiftUI

public struct MainContainerView: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: Call Command Center & Census (Acuity, Tasks, Sickest Patients)
            NavigationStack {
                CallDashboardView()
                    .navigationTitle("Census & Tasks")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Dashboard", systemImage: "checklist")
            }
            .tag(0)
            
            // Tab 2: 2 AM Crisis Triage & Red Flag Emergencies (TBI, EDH, SDH, Uncal, Shunt, SEA, CES)
            NavigationStack {
                EmergencyProtocolsView()
                    .navigationTitle("Crisis & Triage")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("2 AM Crisis", systemImage: "cross.case.fill")
            }
            .tag(1)
            
            // Tab 3: Consult Intake & Auto-SBAR Note Generator
            NavigationStack {
                ConsultManagerView()
                    .navigationTitle("Consults")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Consult Intake", systemImage: "doc.text.fill")
            }
            .tag(2)
            
            // Tab 4: Calculators & Drug Reversals (ABC/2, CPP, WFNS, SINS + DOAC Reversals)
            NavigationStack {
                NeurosurgeryCalculatorsView()
                    .navigationTitle("Calculators")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Calculators", systemImage: "function")
            }
            .tag(3)
            
            // Tab 5: Surgical & Neuroradiology Atlas (Procedures, Cranial/Spinal Normal Anatomy, EVD)
            NavigationStack {
                SurgicalAtlasView()
                    .navigationTitle("Atlas & Anatomy")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Atlas", systemImage: "brain.head.profile")
            }
            .tag(4)
        }
        .tint(.blue)
    }
}
