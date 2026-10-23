import SwiftUI

// MARK: - Universal Spotlight / Command-K Quick-Launcher
// Provides instant omnipresent neurosurgical search across all 13 Atlas Plates,
// 6 ER Consults, 10 Clinical Calculators, 5 Reversal Protocols, and BTF Crisis Workflows.

public enum SpotlightCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case atlas = "Atlas Plates"
    case consults = "ER Consults"
    case calculators = "Calculators"
    case reversal = "Reversal"
    case protocols = "Crisis Protocols"
    
    public var id: String { self.rawValue }
    
    public var icon: String {
        switch self {
        case .all: return "sparkles"
        case .atlas: return "book.pages.fill"
        case .consults: return "stethoscope.circle.fill"
        case .calculators: return "function"
        case .reversal: return "cross.vial.fill"
        case .protocols: return "cross.case.fill"
        }
    }
}

public struct SpotlightItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let category: SpotlightCategory
    public let icon: String
    public let accentColor: Color
    public let destination: SpotlightDestination
    
    public init(title: String, subtitle: String, category: SpotlightCategory, icon: String, accentColor: Color, destination: SpotlightDestination) {
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.icon = icon
        self.accentColor = accentColor
        self.destination = destination
    }
}

public enum SpotlightDestination {
    case atlasPlate(String)
    case erConsult(String)
    case caliperEngine
    case reversalEngine
    case icpLadder
    case sbarTeleprompter
    case calculator(String)
}

public struct UniversalSpotlightModal: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var selectedCategory: SpotlightCategory = .all
    @State private var activeDestination: SpotlightDestination? = nil
    
    public init() {}
    
    // Master Registry of NeuroCall Features & Knowledge
    private var allItems: [SpotlightItem] {
        return [
            // Atlas Plates
            SpotlightItem(
                title: "Goel-Harms C1–C2 Posterior Construct",
                subtitle: "Ghosted intraosseous corridor, fully threaded C2 screw, blue tulips, Torx set screws",
                category: .atlas,
                icon: "lock.shield.fill",
                accentColor: ObsidianTheme.neonCyan,
                destination: .atlasPlate("Harms")
            ),
            SpotlightItem(
                title: "Odontoid Fractures Classification & Fusion",
                subtitle: "Type I, II, and III dens fractures with fusion rates and non-union risk factors",
                category: .atlas,
                icon: "figure.walk",
                accentColor: ObsidianTheme.neonAmber,
                destination: .atlasPlate("Odontoid")
            ),
            SpotlightItem(
                title: "Chiari I Suboccipital Decompression",
                subtitle: "Y-shaped dural incision, tonsillar herniation, and expansile patch duraplasty",
                category: .atlas,
                icon: "brain.head.profile",
                accentColor: ObsidianTheme.neonPurple,
                destination: .atlasPlate("Chiari")
            ),
            SpotlightItem(
                title: "Chronic Subdural Hematoma (cSDH) Burr Hole",
                subtitle: "Dual-panel CT and true-scale 14 mm burr hole craniostomy with motor-oil drainage",
                category: .atlas,
                icon: "circle.grid.cross.fill",
                accentColor: ObsidianTheme.neonRose,
                destination: .atlasPlate("cSDH")
            ),
            SpotlightItem(
                title: "L4–L5 TLIF Interbody Fusion & Pedicle Fixation",
                subtitle: "Posterior transforaminal corridor, facetectomy, cage placement, and nerve retraction",
                category: .atlas,
                icon: "link",
                accentColor: ObsidianTheme.neonGreen,
                destination: .atlasPlate("TLIF")
            ),
            SpotlightItem(
                title: "Cervical Jumped / Locked Facets (C5–C6)",
                subtitle: "Sagittal CT showing facet dislocation, cord shearing, and reduction protocol",
                category: .atlas,
                icon: "arrow.triangle.swap",
                accentColor: ObsidianTheme.neonRed,
                destination: .atlasPlate("JumpedFacets")
            ),
            SpotlightItem(
                title: "Post-Op Lumbar Pseudomeningocele & CSF Fistula",
                subtitle: "Sagittal T2 MRI showing laminectomy defect and dural tear tract",
                category: .atlas,
                icon: "drop.triangle.fill",
                accentColor: ObsidianTheme.neonBlue,
                destination: .atlasPlate("Pseudomeningocele")
            ),
            SpotlightItem(
                title: "Proximal VP Shunt Failure & Ventriculomegaly",
                subtitle: "Axial CT brain with transependymal interstitial edema and catheter position",
                category: .atlas,
                icon: "arrow.up.and.down.circle.fill",
                accentColor: ObsidianTheme.neonCyan,
                destination: .atlasPlate("Shunt")
            ),
            
            // Frontline ER Consults
            SpotlightItem(
                title: "ER Consult: Aneurysmal SAH & Hydrocephalus",
                subtitle: "WFNS / Fisher grading, emergent EVD placement, and nimodipine protocol",
                category: .consults,
                icon: "drop.fill",
                accentColor: ObsidianTheme.neonRed,
                destination: .erConsult("SAH")
            ),
            SpotlightItem(
                title: "ER Consult: Traumatic Acute SDH & Contusions",
                subtitle: "BTF surgical criteria, coagulopathy reversal, and craniectomy mandate",
                category: .consults,
                icon: "brain",
                accentColor: ObsidianTheme.neonAmber,
                destination: .erConsult("SDH")
            ),
            SpotlightItem(
                title: "ER Consult: Depressed & Open Skull Fracture",
                subtitle: "Inner table displacement > thickness of skull, dural laceration debridement",
                category: .consults,
                icon: "shield.slash.fill",
                accentColor: ObsidianTheme.neonPurple,
                destination: .erConsult("SkullFracture")
            ),
            SpotlightItem(
                title: "ER Consult: Acute Cauda Equina Syndrome",
                subtitle: "Saddle anesthesia, post-void residual >200 mL, emergent decompression within 24-48h",
                category: .consults,
                icon: "bolt.heart.fill",
                accentColor: ObsidianTheme.neonRose,
                destination: .erConsult("CaudaEquina")
            ),
            
            // Calculators & Engines
            SpotlightItem(
                title: "Bedside Radiologic Caliper Engine",
                subtitle: "Interactive touch calipers for ABC/2 volume, Midline Shift (mm), and Evans Index",
                category: .calculators,
                icon: "ruler.fill",
                accentColor: ObsidianTheme.neonCyan,
                destination: .caliperEngine
            ),
            SpotlightItem(
                title: "CPP & Intracranial Hemodynamics Target",
                subtitle: "Cerebral perfusion pressure calculation (MAP - ICP) with 60-70 mmHg target zone",
                category: .calculators,
                icon: "waveform.path.ecg",
                accentColor: ObsidianTheme.neonBlue,
                destination: .calculator("cpp")
            ),
            SpotlightItem(
                title: "ICH Score & 30-Day Mortality Estimator",
                subtitle: "GCS, volume >30cc, intraventricular extension, infratentorial, age >80",
                category: .calculators,
                icon: "percent",
                accentColor: ObsidianTheme.neonRed,
                destination: .calculator("ich")
            ),
            SpotlightItem(
                title: "TLICS Thoracolumbar Spine Injury Score",
                subtitle: "Morphology, posterior ligamentous complex (PLC), and neurological status",
                category: .calculators,
                icon: "shield.fill",
                accentColor: ObsidianTheme.neonGreen,
                destination: .calculator("tlics")
            ),
            SpotlightItem(
                title: "SLIC Subaxial Cervical Spine Injury Score",
                subtitle: "Morphology, disco-ligamentous complex (DLC), and continuous cord compression",
                category: .calculators,
                icon: "link",
                accentColor: ObsidianTheme.neonCyan,
                destination: .calculator("slic")
            ),
            
            // Reversal Engines
            SpotlightItem(
                title: "Emergency Anticoagulant Reversal Cockpit",
                subtitle: "Live weight-adjusted Kcentra 4F-PCC, Andexxa, Praxbind, Protamine, and DDAVP",
                category: .reversal,
                icon: "cross.vial.fill",
                accentColor: ObsidianTheme.neonAmber,
                destination: .reversalEngine
            ),
            SpotlightItem(
                title: "Warfarin (Coumadin) & Kcentra Dosing",
                subtitle: "INR-stratified units/kg calculator with mandatory Vitamin K1 co-administration",
                category: .reversal,
                icon: "drop.triangle.fill",
                accentColor: ObsidianTheme.neonAmber,
                destination: .reversalEngine
            ),
            SpotlightItem(
                title: "DOACs (Eliquis / Xarelto) & Andexxa Regimen",
                subtitle: "Low-dose vs high-dose IV bolus + 120-min continuous infusion calculator",
                category: .reversal,
                icon: "cross.fill",
                accentColor: ObsidianTheme.neonCyan,
                destination: .reversalEngine
            ),
            SpotlightItem(
                title: "Dabigatran (Pradaxa) & Praxbind Monoclonal",
                subtitle: "Idarucizumab 5g IV rapid reversal and hemodialysis clearance kinetics",
                category: .reversal,
                icon: "shield.lefthalf.filled",
                accentColor: ObsidianTheme.neonPurple,
                destination: .reversalEngine
            ),
            
            // Crisis Protocols
            SpotlightItem(
                title: "BTF Tiered ICP Escalation Stepladder",
                subtitle: "Tier 0 baseline to Tier 3 hemicraniectomy / pentobarbital coma with hyperosmolar dosing",
                category: .protocols,
                icon: "ladder",
                accentColor: ObsidianTheme.neonRed,
                destination: .icpLadder
            ),
            SpotlightItem(
                title: "Attending SBAR Teleprompter & Generator",
                subtitle: "Structured 30-second spoken call script with 1-tap copy to Epic Haiku / iMessage",
                category: .protocols,
                icon: "phone.fill",
                accentColor: ObsidianTheme.neonCyan,
                destination: .sbarTeleprompter
            ),
            SpotlightItem(
                title: "Bedside EVD Placement Checklist",
                subtitle: "Kocher's point anatomical coordinates, trajectory angles, and depth limits",
                category: .protocols,
                icon: "list.clipboard.fill",
                accentColor: ObsidianTheme.neonGreen,
                destination: .atlasPlate("EVD")
            )
        ]
    }
    
    // Filtered Items based on search and category
    private var filteredItems: [SpotlightItem] {
        allItems.filter { item in
            let matchesCategory = (selectedCategory == .all) || (item.category == selectedCategory)
            if searchText.isEmpty {
                return matchesCategory
            }
            let query = searchText.lowercased()
            let matchesText = item.title.lowercased().contains(query) ||
                              item.subtitle.lowercased().contains(query) ||
                              item.category.rawValue.lowercased().contains(query)
            return matchesCategory && matchesText
        }
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Field Bar
                searchHeaderField
                
                // Category Filter Pills
                categoryFilterCarousel
                
                // Results List
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(filteredItems) { item in
                            Button(action: {
                                HapticManager.impact(style: .medium)
                                activeDestination = item.destination
                            }) {
                                spotlightRowView(item)
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(ObsidianTheme.surfaceVoid)
            .navigationTitle("Neurosurgical Spotlight")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(ObsidianTheme.neonCyan)
                }
            }
            .sheet(item: Binding<DestinationWrapper?>(
                get: { activeDestination.map { DestinationWrapper(dest: $0) } },
                set: { activeDestination = $0?.dest }
            )) { wrapper in
                destinationView(for: wrapper.dest)
            }
        }
    }
    
    // MARK: - Search Field
    private var searchHeaderField: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(ObsidianTheme.neonCyan)
                .font(.system(size: 16, weight: .bold))
            
            TextField("Search plates, consults, calipers, reversals...", text: $searchText)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(ObsidianTheme.textPrimary)
                .autocorrectionDisabled()
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(ObsidianTheme.textTertiary)
                }
            }
        }
        .padding(12)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.neonCyan.opacity(0.4), lineWidth: 1))
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    // MARK: - Category Pills
    private var categoryFilterCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(SpotlightCategory.allCases) { cat in
                    Button(action: {
                        HapticManager.impact(style: .light)
                        selectedCategory = cat
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: cat.icon)
                            Text(cat.rawValue)
                                .font(.system(size: 11, weight: .bold))
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(selectedCategory == cat ? ObsidianTheme.neonCyan : ObsidianTheme.surfaceElevated)
                        .foregroundColor(selectedCategory == cat ? .black : ObsidianTheme.textSecondary)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(selectedCategory == cat ? ObsidianTheme.neonCyan : ObsidianTheme.glassBorder, lineWidth: 1))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
    
    // MARK: - Item Row
    private func spotlightRowView(_ item: SpotlightItem) -> some View {
        HStack(spacing: 12) {
            Image(systemName: item.icon)
                .font(.system(size: 16))
                .foregroundColor(item.accentColor)
                .frame(width: 36, height: 36)
                .background(item.accentColor.opacity(0.14))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(ObsidianTheme.textPrimary)
                    Spacer()
                    Text(item.category.rawValue.uppercased())
                        .font(.system(size: 8, weight: .heavy))
                        .foregroundColor(item.accentColor)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(item.accentColor.opacity(0.12))
                        .cornerRadius(4)
                }
                
                Text(item.subtitle)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .lineLimit(2)
            }
        }
        .padding(12)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
    }
    
    // MARK: - Destination Routing
    @ViewBuilder
    private func destinationView(for destination: SpotlightDestination) -> some View {
        switch destination {
        case .atlasPlate:
            PhotorealisticSurgicalAtlasView()
        case .erConsult:
            ERConsultsView()
        case .caliperEngine:
            NavigationStack {
                RadiologicCaliperEngineView(imageName: "plate_ct_edh", emergencyTitle: "Acute Epidural Hematoma")
                    .navigationTitle("Radiologic Caliper Engine")
                    .navigationBarTitleDisplayMode(.inline)
            }
        case .reversalEngine:
            NavigationStack {
                EmergencyReversalEngineView()
                    .navigationTitle("Anticoagulation Reversal")
                    .navigationBarTitleDisplayMode(.inline)
            }
        case .icpLadder:
            NavigationStack {
                TieredICPLadderView()
                    .navigationTitle("BTF ICP Escalation Ladder")
                    .navigationBarTitleDisplayMode(.inline)
            }
        case .sbarTeleprompter:
            SbarTeleprompterSheet()
        case .calculator:
            NeurosurgeryCalculatorsView()
        }
    }
}

// Wrapper to make SpotlightDestination Identifiable for sheet presentation
struct DestinationWrapper: Identifiable {
    let id = UUID()
    let dest: SpotlightDestination
}

// MARK: - Floating Spotlight Launch Button View
public struct FloatingSpotlightButton: View {
    @Binding var isPresented: Bool
    
    public init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    public var body: some View {
        Button(action: {
            HapticManager.impact(style: .medium)
            isPresented = true
        }) {
            HStack(spacing: 6) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14, weight: .black))
                Text("Command-K")
                    .font(.system(size: 11, weight: .black, design: .rounded))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(LinearGradient(colors: [ObsidianTheme.neonCyan, ObsidianTheme.neonBlue], startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.black)
            .clipShape(Capsule())
            .shadow(color: ObsidianTheme.neonCyan.opacity(0.4), radius: 8, y: 3)
        }
    }
}
