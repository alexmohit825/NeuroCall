import SwiftUI

// MARK: - ER Neurosurgical Consults Suite (Cranial & Spinal)
// Synthesized from Brain Trauma Foundation (BTF) Guidelines, Congress of Neurological Surgeons (CNS) Guidelines,
// and Ellenbogen Principles of Neurosurgery.
// Featuring 8K-styled authentic clinical radiological plates, stepwise clinical triage,
// operative indications, catastrophic pitfalls, and attending SBAR briefing scripts.

public struct ERConsultsView: View {
    @State private var selectedCategory: ConsultCategory = .cranial
    @State private var selectedCranialConsult: CranialConsultType = .aneurysmalSAH
    @State private var selectedSpineConsult: SpineConsultType = .jumpedFacets
    @State private var isShowingSbarSheet: Bool = false
    @State private var isShowingReviewStation: Bool = false
    @State private var zoomScale: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Banner
                headerBanner
                
                // Cranial vs Spine Category Selector
                categorySelectorBar
                
                // Consult Case Pills Carousel
                consultPillsCarousel
                
                // Radiographic Viewport Canvas
                consultRadiographCanvas
                
                // Clinical Triage & Acuity Badge
                acuitySummaryCard
                
                // Stepwise Management Protocol (4 Phases)
                stepwiseProtocolCard
                
                // Catastrophic Pitfalls & Hazard Avoidance
                catastrophicPitfallsCard
                
                // SBAR Attending Call Briefing Trigger
                sbarCallBriefingButton
                
                Spacer(minLength: 40)
            }
            .padding(.top, 10)
        }
        .background(ObsidianTheme.surfaceVoid)
        .sheet(isPresented: $isShowingReviewStation) {
            AnatomicReviewStationView()
        }
        .sheet(isPresented: $isShowingSbarSheet) {
            ERConsultSbarSheet(
                consultTitle: currentConsultTitle,
                category: selectedCategory.title,
                acuity: currentAcuityText,
                pearl: currentImagingPearl,
                operativeRecommendation: currentOperativePlan
            )
        }
    }
    
    // MARK: - Computed Properties
    private var currentConsultTitle: String {
        selectedCategory == .cranial ? selectedCranialConsult.title : selectedSpineConsult.title
    }
    
    private var currentImageName: String {
        selectedCategory == .cranial ? selectedCranialConsult.assetImageName : selectedSpineConsult.assetImageName
    }
    
    private var currentAcuityText: String {
        selectedCategory == .cranial ? selectedCranialConsult.acuityLabel : selectedSpineConsult.acuityLabel
    }
    
    private var currentAcuityColor: Color {
        selectedCategory == .cranial ? selectedCranialConsult.acuityColor : selectedSpineConsult.acuityColor
    }
    
    private var currentImagingPearl: String {
        selectedCategory == .cranial ? selectedCranialConsult.imagingPearl : selectedSpineConsult.imagingPearl
    }
    
    private var currentClinicalTriad: [String] {
        selectedCategory == .cranial ? selectedCranialConsult.clinicalTriad : selectedSpineConsult.clinicalTriad
    }
    
    private var currentProtocolPhases: [ConsultPhase] {
        selectedCategory == .cranial ? selectedCranialConsult.protocolPhases : selectedSpineConsult.protocolPhases
    }
    
    private var currentPitfalls: [String] {
        selectedCategory == .cranial ? selectedCranialConsult.pitfalls : selectedSpineConsult.pitfalls
    }
    
    private var currentOperativePlan: String {
        selectedCategory == .cranial ? selectedCranialConsult.operativePlan : selectedSpineConsult.operativePlan
    }
    
    // MARK: - Header Banner
    private var headerBanner: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                HStack(spacing: 6) {
                    Circle().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 8)
                    Text("ON-CALL EMERGENCY ROOM CONSULTS")
                        .font(.system(size: 10, weight: .black))
                        .tracking(1.8)
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                Spacer()
                Button(action: {
                    HapticManager.impact(style: .medium)
                    isShowingReviewStation = true
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 11))
                        Text("Audit Studio")
                            .font(.system(size: 11, weight: .bold))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(ObsidianTheme.neonCyan.opacity(0.18))
                    .foregroundColor(ObsidianTheme.neonCyan)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(ObsidianTheme.neonCyan.opacity(0.4), lineWidth: 1))
                }
            }
            Text("Frontline Neurosurgical Decision Engine")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Definitive triage, imaging plates, operative thresholds, and bedside attending briefing scripts.")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Category Selector Bar (Cranial vs Spine)
    private var categorySelectorBar: some View {
        HStack(spacing: 12) {
            ForEach(ConsultCategory.allCases, id: \.self) { cat in
                Button(action: {
                    HapticManager.impact(style: .medium)
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedCategory = cat
                        zoomScale = 1.0
                        dragOffset = .zero
                    }
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: cat.icon)
                            .font(.system(size: 12, weight: .bold))
                        Text(cat.title)
                            .font(.system(size: 12, weight: .black))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(selectedCategory == cat ? cat.accentColor.opacity(0.25) : ObsidianTheme.surfaceElevated)
                    .foregroundColor(selectedCategory == cat ? cat.accentColor : ObsidianTheme.textSecondary)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCategory == cat ? cat.accentColor : ObsidianTheme.borderSubtle, lineWidth: 1.5)
                    )
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Consult Pills Carousel
    private var consultPillsCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                if selectedCategory == .cranial {
                    ForEach(CranialConsultType.allCases, id: \.self) { item in
                        consultPillButton(
                            title: item.shortTitle,
                            isSelected: selectedCranialConsult == item,
                            accent: item.acuityColor
                        ) {
                            HapticManager.impact(style: .light)
                            selectedCranialConsult = item
                            zoomScale = 1.0
                            dragOffset = .zero
                        }
                    }
                } else {
                    ForEach(SpineConsultType.allCases, id: \.self) { item in
                        consultPillButton(
                            title: item.shortTitle,
                            isSelected: selectedSpineConsult == item,
                            accent: item.acuityColor
                        ) {
                            HapticManager.impact(style: .light)
                            selectedSpineConsult = item
                            zoomScale = 1.0
                            dragOffset = .zero
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func consultPillButton(title: String, isSelected: Bool, accent: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(isSelected ? accent : ObsidianTheme.surfaceElevated)
                .foregroundColor(isSelected ? .black : ObsidianTheme.textPrimary)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? accent : ObsidianTheme.borderSubtle, lineWidth: 1)
                )
        }
    }
    
    // MARK: - Radiographic Viewport Canvas
    private var consultRadiographCanvas: some View {
        ZoomablePlateImageView(imageName: currentImageName, contentHeight: 340)
            .background(Color.black)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1.5))
            .padding(.horizontal, 16)
    }
    
    // MARK: - Acuity Summary Card
    private var acuitySummaryCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle().fill(currentAcuityColor).frame(width: 8, height: 8)
                Text(currentConsultTitle)
                    .font(.system(size: 15, weight: .heavy))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Spacer()
                Text(currentAcuityText)
                    .font(.system(size: 9, weight: .black))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(currentAcuityColor.opacity(0.18))
                    .foregroundColor(currentAcuityColor)
                    .cornerRadius(6)
            }
            
            // Imaging Pearl
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "viewfinder")
                    .font(.system(size: 11))
                    .foregroundColor(ObsidianTheme.neonCyan)
                    .padding(.top, 2)
                Text("IMAGING PEARL: " + currentImagingPearl)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(ObsidianTheme.neonCyan)
                    .lineSpacing(2)
            }
            
            Divider().background(ObsidianTheme.borderSubtle)
            
            // Clinical Triad
            VStack(alignment: .leading, spacing: 4) {
                Text("HALLMARK CLINICAL PRESENTATION:")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(ObsidianTheme.neonAmber)
                
                ForEach(currentClinicalTriad, id: \.self) { triad in
                    HStack(alignment: .top, spacing: 6) {
                        Circle().fill(ObsidianTheme.neonAmber).frame(width: 4, height: 4).padding(.top, 5)
                        Text(triad)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
            }
        }
        .padding(14)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(currentAcuityColor.opacity(0.35), lineWidth: 1.5))
        .padding(.horizontal, 16)
    }
    
    // MARK: - Stepwise Emergency Protocol Card
    private var stepwiseProtocolCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "list.number")
                    .foregroundColor(ObsidianTheme.neonCyan)
                Text("STEPWISE EMERGENCY MANAGEMENT PROTOCOL")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.4)
                    .foregroundColor(ObsidianTheme.neonCyan)
                Spacer()
            }
            
            VStack(spacing: 10) {
                ForEach(currentProtocolPhases, id: \.phaseNumber) { phase in
                    PhaseRowView(phase: phase)
                }
            }
        }
        .padding(14)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
        .padding(.horizontal, 16)
    }
    
    // MARK: - Catastrophic Pitfalls Card
    private var catastrophicPitfallsCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 5) {
                Image(systemName: "exclamationmark.octagon.fill")
                    .foregroundColor(ObsidianTheme.neonRose)
                Text("CATASTROPHIC PITFALLS & FATAL ERRORS:")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(ObsidianTheme.neonRose)
                Spacer()
            }
            
            ForEach(currentPitfalls, id: \.self) { pitfall in
                HStack(alignment: .top, spacing: 6) {
                    Circle().fill(ObsidianTheme.neonRose).frame(width: 4, height: 4).padding(.top, 5)
                    Text(pitfall)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                        .lineSpacing(2)
                }
            }
        }
        .padding(12)
        .background(ObsidianTheme.neonRose.opacity(0.08))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.neonRose.opacity(0.3), lineWidth: 1))
        .padding(.horizontal, 16)
    }
    
    // MARK: - SBAR Button
    private var sbarCallBriefingButton: some View {
        Button(action: {
            HapticManager.impact(style: .medium)
            isShowingSbarSheet = true
        }) {
            HStack {
                Image(systemName: "phone.fill")
                Text("Generate Attending Call Script (SBAR)")
                    .font(.system(size: 13, weight: .heavy))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    colors: [ObsidianTheme.neonCyan, ObsidianTheme.neonBlue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.black)
            .cornerRadius(14)
            .shadow(color: ObsidianTheme.neonCyan.opacity(0.3), radius: 8, y: 3)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Supporting Subviews
struct PhaseRowView: View {
    let phase: ConsultPhase
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(phase.phaseTitle)
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(ObsidianTheme.neonAmber)
                Spacer()
                Text("PHASE " + String(phase.phaseNumber))
                    .font(.system(size: 9, weight: .black))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 1)
                    .background(ObsidianTheme.neonAmber.opacity(0.2))
                    .foregroundColor(ObsidianTheme.neonAmber)
                    .cornerRadius(4)
            }
            
            Text(phase.actionInstructions)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(ObsidianTheme.textSecondary)
                .lineSpacing(2)
        }
        .padding(10)
        .background(Color.white.opacity(0.03))
        .cornerRadius(8)
    }
}

// MARK: - Attending SBAR Sheet
struct ERConsultSbarSheet: View {
    let consultTitle: String
    let category: String
    let acuity: String
    let pearl: String
    let operativeRecommendation: String
    @Environment(\.dismiss) var dismiss
    @State private var copied: Bool = false
    
    var scriptText: String {
        return """
        SITUATION:
        "Dr. Mohit, I am calling from the Emergency Department with an acute \(category.lowercased()) consult for \(consultTitle). The patient's status is \(acuity)."

        BACKGROUND:
        "Emergency imaging demonstrates: \(pearl)."

        ASSESSMENT:
        "Based on acute neurosurgical guidelines, this patient requires immediate neurosurgical intervention: \(operativeRecommendation)."

        RECOMMENDATION:
        "I recommend securing the airway, administering emergency pharmacotherapy, drawing baseline type & screen and coags, and mobilizing the operating room team immediately."
        """
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Spoken Script for On-Call Attending Call")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .padding(.top)
                
                ScrollView {
                    Text(scriptText)
                        .font(.system(size: 13, design: .monospaced))
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(ObsidianTheme.textPrimary)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    UIPasteboard.general.string = scriptText
                    copied = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        copied = false
                    }
                }) {
                    HStack {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        Text(copied ? "Copied Script to Clipboard!" : "Copy Script to Clipboard")
                    }
                    .font(.system(size: 13, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(ObsidianTheme.neonCyan)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(ObsidianTheme.surfaceVoid)
            .navigationTitle("Attending SBAR Briefing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Enums & Models
public enum ConsultCategory: String, CaseIterable {
    case cranial = "cranial"
    case spine = "spine"
    
    public var title: String {
        switch self {
        case .cranial: return "CRANIAL ER CONSULTS"
        case .spine: return "SPINE ER CONSULTS"
        }
    }
    
    public var icon: String {
        switch self {
        case .cranial: return "brain.head.profile"
        case .spine: return "figure.walk"
        }
    }
    
    public var accentColor: Color {
        switch self {
        case .cranial: return ObsidianTheme.neonCyan
        case .spine: return ObsidianTheme.neonAmber
        }
    }
}

public struct ConsultPhase: Identifiable {
    public let id = UUID()
    public let phaseNumber: Int
    public let phaseTitle: String
    public let actionInstructions: String
}

// MARK: - Cranial Consult Types (6 Cases)
public enum CranialConsultType: String, CaseIterable {
    case aneurysmalSAH = "sah"
    case epiduralHematoma = "edh"
    case subduralHematoma = "sdh"
    case intracerebralHemorrhage = "ich"
    case vpShuntObstruction = "shunt_obs"
    case shuntProxVsDistal = "shunt_prox_dist"
    
    public var shortTitle: String {
        switch self {
        case .aneurysmalSAH: return "Aneurysmal SAH"
        case .epiduralHematoma: return "Epidural (EDH)"
        case .subduralHematoma: return "Subdural (SDH)"
        case .intracerebralHemorrhage: return "Intracerebral (ICH)"
        case .vpShuntObstruction: return "Shunt Obstruction"
        case .shuntProxVsDistal: return "Prox vs Distal Shunt"
        }
    }
    
    public var title: String {
        switch self {
        case .aneurysmalSAH: return "Aneurysmal Subarachnoid Hemorrhage (SAH)"
        case .epiduralHematoma: return "Acute Epidural Hematoma (EDH)"
        case .subduralHematoma: return "Acute Subdural Hematoma (SDH)"
        case .intracerebralHemorrhage: return "Acute Intracerebral Hemorrhage (ICH)"
        case .vpShuntObstruction: return "Ventriculoperitoneal (VP) Shunt Obstruction"
        case .shuntProxVsDistal: return "VP Shunt Failure: Proximal vs Distal Differentiation"
        }
    }
    
    public var assetImageName: String {
        switch self {
        case .aneurysmalSAH: return "plate_cranial_sah_aneurysm"
        case .epiduralHematoma: return "plate_ct_edh"
        case .subduralHematoma: return "plate_ct_sdh"
        case .intracerebralHemorrhage: return "plate_cranial_ich_lobar"
        case .vpShuntObstruction: return "plate_cranial_vp_shunt"
        case .shuntProxVsDistal: return "plate_cranial_shunt_prox_distal"
        }
    }
    
    public var acuityLabel: String {
        switch self {
        case .aneurysmalSAH: return "CRITICAL EMERGENCY (<24H SECURING)"
        case .epiduralHematoma: return "STAT OR MANDATE (>30 CC / COMA)"
        case .subduralHematoma: return "STAT OR MANDATE (>10 MM / SHIFT >5 MM)"
        case .intracerebralHemorrhage: return "EMERGENT SBP 140 & CRANIOTOMY IF >30 CC"
        case .vpShuntObstruction: return "URGENT SHUNT TAP & REVISION"
        case .shuntProxVsDistal: return "DIAGNOSTIC TAP & DIFFERENTIAL"
        }
    }
    
    public var acuityColor: Color {
        switch self {
        case .aneurysmalSAH: return ObsidianTheme.neonRose
        case .epiduralHematoma: return ObsidianTheme.neonRed
        case .subduralHematoma: return ObsidianTheme.neonRed
        case .intracerebralHemorrhage: return ObsidianTheme.neonAmber
        case .vpShuntObstruction: return ObsidianTheme.neonAmber
        case .shuntProxVsDistal: return ObsidianTheme.neonCyan
        }
    }
    
    public var imagingPearl: String {
        switch self {
        case .aneurysmalSAH:
            return "Star-shaped hyperdense acute blood in suprasellar/ambient cisterns & Sylvian fissures. Modified Fisher 3. Dilated temporal horns reflect acute hydrocephalus."
        case .epiduralHematoma:
            return "Biconvex / lenticular hyperdensity confined by cranial sutures. MMA arterial laceration with skull fracture. 'Swirl sign' indicates active extravasation."
        case .subduralHematoma:
            return "Crescentic extra-axial hyperdensity crossing cranial sutures over the cerebral convexity. Bridging cortical vein rupture with hemispheric mass effect."
        case .intracerebralHemorrhage:
            return "Hyperdense parenchymal hematoma with hypodense perihematomal edema rim. Posterior fossa cerebellar ICH >3cm compressing 4th ventricle mandates STAT evacuation."
        case .vpShuntObstruction:
            return "Marked enlargement of lateral ventricles compared to baseline prior scan. Periventricular halo reflects transependymal CSF resorption."
        case .shuntProxVsDistal:
            return "Proximal failure shows slow/no tap refill and normal opening pressure; distal failure shows rapid refill, high opening pressure (>25 cm H2O), or abdominal pseudocyst."
        }
    }
    
    public var clinicalTriad: [String] {
        switch self {
        case .aneurysmalSAH:
            return [
                "Sudden-onset explosive 'worst headache of life' (thunderclap headache)",
                "Meningismus (nuchal rigidity, photophobia, Kernig/Brudzinski signs)",
                "Transient loss of consciousness or focal CN III palsy (PCom aneurysm)"
            ]
        case .epiduralHematoma:
            return [
                "Classic 'lucid interval' following traumatic loss of consciousness",
                "Rapid neurological deterioration into coma with ipsilateral blown pupil",
                "Contralateral hemiparesis (Kernohan notch phenomenon if false localizing)"
            ]
        case .subduralHematoma:
            return [
                "Progressive obtundation following high-energy trauma or elderly ground-level fall",
                "Unilateral sluggish or fixed dilated pupil indicating uncal herniation",
                "Contralateral motor weakness and Cushing triad (hypertension, bradycardia, irregular respirations)"
            ]
        case .intracerebralHemorrhage:
            return [
                "Acute focal neurological deficit during exertion with severe hypertension",
                "Decreased level of consciousness and nausea/vomiting",
                "Posterior fossa: acute ataxia, gaze palsy, occipital headache, rapid coma"
            ]
        case .vpShuntObstruction:
            return [
                "Morning headache, projectile nausea/vomiting, and increasing lethargy",
                "Sunsetting eyes or abducens (CN VI) palsy from elevated ICP",
                "Subcutaneous fluid collection along the shunt tubing tract"
            ]
        case .shuntProxVsDistal:
            return [
                "Proximal: Flat, non-refilling reservoir; severe lethargy; slit vs dilated ventricles",
                "Distal: Tense or rapidly rebounding reservoir; elevated opening pressure (>25 cm H2O)",
                "Abdominal tenderness, distension, or palpable pseudocyst mass"
            ]
        }
    }
    
    public var protocolPhases: [ConsultPhase] {
        switch self {
        case .aneurysmalSAH:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Resuscitation & BP Goal", actionInstructions: "Intubate if GCS ≤ 8. Strictly maintain SBP < 140 mmHg with IV nicardipine infusion to prevent fatal aneurysm re-rupture."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "EVD & Nimodipine", actionInstructions: "Place emergent frontal EVD at 10-15 cm H2O above tragus if acute hydrocephalus is present. Start oral/NG Nimodipine 60 mg q4h immediately."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Vascular Mapping", actionInstructions: "Obtain emergent CTA head & neck, followed by catheter DSA to evaluate aneurysm dome, neck, and geometry."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Aneurysm Securing (<24h)", actionInstructions: "Definitive aneurysm securing within 24 hours via endovascular coiling or microsurgical clipping (Pterional/Orbitozygomatic corridor).")
            ]
        case .epiduralHematoma:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Emergency Triage", actionInstructions: "Surgical evacuation indicated if volume > 30 cc, or GCS < 9, clot thickness > 15 mm, or midline shift > 5 mm."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Medical Decompression", actionInstructions: "Administer 3% hypertonic saline (250 cc IV bolus) or 20% Mannitol (1 g/kg IV) over 15 minutes while rolling directly to OR."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Craniotomy Evacuation", actionInstructions: "Perform emergent trauma craniotomy centered over clot; coagulate bleeding MMA trunk or occlude foramen spinosum with bone wax."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Dural Tenting & Closure", actionInstructions: "Place circumferential and central dural hitch sutures to inner table to prevent postoperative extradural reaccumulation.")
            ]
        case .subduralHematoma:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "BTF Operative Threshold", actionInstructions: "Evacuate if clot thickness > 10 mm OR midline shift > 5 mm, or GCS drop by ≥2 points from injury, or asymmetric pupils."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Anticoagulation Reversal", actionInstructions: "Immediately administer 4F-PCC (Kcentra) for warfarin/DOACs and infuse platelets if on antiplatelet therapy."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Large Decompressive Flap", actionInstructions: "Perform wide 12x15 cm decompressive hemicraniectomy down to the middle fossa floor to prevent brain herniation over bone edges."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "ICU Management", actionInstructions: "Place parenchymal ICP monitor; target ICP < 20-22 mmHg, CPP 60-70 mmHg, serum Na 145-150 mEq/L, and 7 days levetiracetam.")
            ]
        case .intracerebralHemorrhage:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Aggressive SBP Reduction", actionInstructions: "Titrate IV nicardipine to SBP 140 mmHg within 1 hour (INTERACT-2 protocol) to arrest ongoing hematoma expansion."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Coagulopathy Reversal", actionInstructions: "Check stat INR/TEG; administer 4F-PCC + Vitamin K 10mg IV for warfarin; Idarucizumab 5g IV for dabigatran; 4F-PCC for factor Xa inhibitors."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Posterior Fossa Mandate", actionInstructions: "Cerebellar ICH > 3 cm diameter, or 4th ventricle compression, or hydrocephalus requires STAT suboccipital craniectomy evacuation."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Supratentorial Criteria", actionInstructions: "Lobar hematoma > 30 cc within 1 cm of cortical surface with deterioration: consider minimally invasive or open evacuation.")
            ]
        case .vpShuntObstruction:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Baseline Scan Comparison", actionInstructions: "Compare current CT with previous baseline scan; subtle increase in ventricular caliber in a shunted patient indicates hydrocephalus."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Radiographic Shunt Series", actionInstructions: "Obtain AP/lateral skull, neck, chest, and abdomen radiographs to identify tubing fracture, disconnection, or migration."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Sterile Shunt Tap", actionInstructions: "Perform sterile reservoir tap with 25G butterfly needle; measure opening pressure; evaluate spontaneous flow rate; send CSF for cells/culture."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Operative Revision", actionInstructions: "Urgent surgical revision of occluded ventricular catheter (Kocher's point) or distal peritoneal catheter based on tap findings.")
            ]
        case .shuntProxVsDistal:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Physical Reservoir Exam", actionInstructions: "Depress reservoir: failure to refill or slow refill (>15-30s) indicates proximal blockage; normal rapid refill indicates distal issue."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Manometer Pressure Test", actionInstructions: "On sterile tap: opening pressure > 25 cm H2O with free-flowing fluid confirms distal peritoneal/valve obstruction."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Abdominal Evaluation", actionInstructions: "Obtain ultrasound or CT of abdomen to identify peritoneal pseudocyst, fluid collection, or catheter kinking."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Tailored Surgical Action", actionInstructions: "Proximal: Stereotactic/endoscopic ventricular catheter revision. Distal: Laparoscopic repositioning, externalization, or conversion to VA shunt.")
            ]
        }
    }
    
    public var pitfalls: [String] {
        switch self {
        case .aneurysmalSAH:
            return [
                "Uncontrolled systolic hypertension precipitating catastrophic re-rupture (70% mortality)",
                "Over-draining EVD below 10 cm H2O, causing transmural pressure gradient spike and rebleeding",
                "Holding nimodipine for mild asymptomatic blood pressure drop without attending discussion"
            ]
        case .epiduralHematoma:
            return [
                "Delaying the OR for secondary imaging in a deteriorating patient with pupillary asymmetry",
                "Failing to place dural tenting/hitch sutures to the inner table, allowing postoperative rebleeding",
                "Missing a contralateral subdural or epidural hematoma that expands after rapid decompression"
            ]
        case .subduralHematoma:
            return [
                "Performing a small, restricted 'keyhole' craniotomy leading to brain strangulation through bone edges",
                "Aggressive hyperventilation inducing severe cerebral vasoconstriction and secondary ischemia",
                "Failure to identify and immediately reverse oral anticoagulation before skin incision"
            ]
        case .intracerebralHemorrhage:
            return [
                "PERFORMING LUMBAR PUNCTURE IN POSTERIOR FOSSA ICH (causes immediate fatal tonsillar coning)",
                "Allowing systolic blood pressure to remain >160 mmHg during the first 6 critical hours",
                "Delaying cerebellar evacuation while waiting for the patient to 'wake up'"
            ]
        case .vpShuntObstruction:
            return [
                "Dismissing ventricles as 'normal size' without comparing to baseline prior slit-ventricle CT",
                "Non-sterile shunt tap technique introducing bacterial colonization into the central nervous system",
                "Pumping the shunt reservoir forcefully, which can suck choroid plexus permanently into catheter holes"
            ]
        case .shuntProxVsDistal:
            return [
                "Replacing the ventricular catheter when the actual failure is a distal peritoneal pseudocyst",
                "Missing an asymptomatic catheter disconnection on plain radiographs at the clavicle or rib cage",
                "Over-aspirating a proximal catheter and causing intraventricular hemorrhage from choroid plexus avulsion"
            ]
        }
    }
    
    public var operativePlan: String {
        switch self {
        case .aneurysmalSAH: return "Emergent EVD placement + Catheter DSA & Aneurysm Coiling or Clipping within 24 hours"
        case .epiduralHematoma: return "Emergent Trauma Craniotomy, MMA Coagulation, and Hemispheric Evacuation"
        case .subduralHematoma: return "Emergent 12x15 cm Decompressive Hemicraniectomy and Expansile Duraplasty"
        case .intracerebralHemorrhage: return "STAT Suboccipital Decompression (Posterior Fossa) or MIS Clot Evacuation (Lobar)"
        case .vpShuntObstruction: return "Urgent Shunt Tap & Operative Catheter Revision via Kocher's Point"
        case .shuntProxVsDistal: return "Targeted Proximal Ventricular or Distal Peritoneal Laparoscopic Revision"
        }
    }
}

// MARK: - Spine Consult Types (5 Cases)
public enum SpineConsultType: String, CaseIterable {
    case jumpedFacets = "jumped_facets"
    case cordCompressionTumor = "tumor_cord_comp"
    case burstFracture = "burst_fracture"
    case caudaEquina = "cauda_equina"
    case csfLeakSpine = "csf_leak_spine"
    
    public var shortTitle: String {
        switch self {
        case .jumpedFacets: return "Jumped Facets"
        case .cordCompressionTumor: return "Tumor Cord Comp"
        case .burstFracture: return "Burst Fracture"
        case .caudaEquina: return "Cauda Equina"
        case .csfLeakSpine: return "Post-Op CSF Leak"
        }
    }
    
    public var title: String {
        switch self {
        case .jumpedFacets: return "Jumped / Locked Cervical Facets (C5-C6 Dislocation)"
        case .cordCompressionTumor: return "Epidural Spinal Cord Compression from Tumor (ESCC)"
        case .burstFracture: return "Thoracolumbar Burst Fracture with Canal Retropulsion"
        case .caudaEquina: return "Cauda Equina Syndrome (CES) from Lumbar Disc Extrusion"
        case .csfLeakSpine: return "Management of Postoperative Spinal CSF Leak / Pseudomeningocele"
        }
    }
    
    public var assetImageName: String {
        switch self {
        case .jumpedFacets: return "plate_spine_jumped_facets"
        case .cordCompressionTumor: return "plate_spine_tumor_compression"
        case .burstFracture: return "plate_spine_burst_fracture"
        case .caudaEquina: return "plate_spine_cauda_equina"
        case .csfLeakSpine: return "plate_spine_csf_leak"
        }
    }
    
    public var acuityLabel: String {
        switch self {
        case .jumpedFacets: return "EMERGENT CLOSED REDUCTION OR ACDF"
        case .cordCompressionTumor: return "STAT DEXAMETHASONE & SURGICAL SEPARATION"
        case .burstFracture: return "TLICS >= 5: OPERATIVE STABILIZATION"
        case .caudaEquina: return "STAT SURGICAL DECOMPRESSION (<24-48H)"
        case .csfLeakSpine: return "STEPWISE DIVERSION VS RE-EXPLORATION"
        }
    }
    
    public var acuityColor: Color {
        switch self {
        case .jumpedFacets: return ObsidianTheme.neonRed
        case .cordCompressionTumor: return ObsidianTheme.neonRose
        case .burstFracture: return ObsidianTheme.neonAmber
        case .caudaEquina: return ObsidianTheme.neonRed
        case .csfLeakSpine: return ObsidianTheme.neonCyan
        }
    }
    
    public var imagingPearl: String {
        switch self {
        case .jumpedFacets:
            return "Sagittal CT/MRI shows >50% anterolisthesis (bilateral locked facets) or ~25% (unilateral), perched articular processes, wide interspinous gap (PLC rupture), and focal cord edema."
        case .cordCompressionTumor:
            return "Sagittal and axial T2/T1+C MRI demonstrates metastatic vertebral body destruction and epidural tumor mass invading the spinal canal. Bilsky Grade 3 reflects complete CSF effacement and cord distortion."
        case .burstFracture:
            return "CT shows Denis anterior and middle column comminution, posterosuperior vertebral fragment retropulsed into spinal canal with >60% stenosis, and splaying of pedicles on axial view."
        case .caudaEquina:
            return "Sagittal and axial T2 MRI demonstrates massive central/subarticular extruded disc herniation (L4-L5) completely filling the canal and obliterating all descending cauda equina nerve roots."
        case .csfLeakSpine:
            return "Sagittal T2 MRI reveals large hyperintense dorsal subcutaneous fluid collection (pseudomeningocele) tracking through laminectomy defect and communicating with the intrathecal space."
        }
    }
    
    public var clinicalTriad: [String] {
        switch self {
        case .jumpedFacets:
            return [
                "High-energy flexion-distraction injury with severe cervical pain and rigid torticollis",
                "Acute sensory level (e.g., C5 deltoid vs C6 wrist extensor weakness)",
                "Anterior cord syndrome or incomplete quadriplegia (variable sacral sparing)"
            ]
        case .cordCompressionTumor:
            return [
                "Progressive localized nocturnal spine pain worsening when recumbent",
                "Bilateral progressive lower extremity weakness and sensory ataxia",
                "Late autonomic bowel/bladder dysfunction indicating advanced myelopathy"
            ]
        case .burstFracture:
            return [
                "Axial loading or high-speed collision with localized thoracolumbar tenderness",
                "Palpable gap or step-off at interspinous process indicating PLC disruption",
                "Conus medullaris or cauda equina motor/sensory deficit (or neurologically intact)"
            ]
        case .caudaEquina:
            return [
                "Saddle anesthesia over the perineum and buttocks (S3-S5 dermatomes)",
                "Urinary retention with overflow incontinence (Post-void residual > 200 cc)",
                "Lax anal sphincter tone and absent bulbocavernosus reflex"
            ]
        case .csfLeakSpine:
            return [
                "Clear fluid draining through surgical wound margins or fluctuant dorsal mass",
                "Positional orthostatic headache worsening on standing and relieved when flat",
                "Nausea, tinnitus, or neck stiffness with positive beta-2 transferrin test"
            ]
        }
    }
    
    public var protocolPhases: [ConsultPhase] {
        switch self {
        case .jumpedFacets:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Mental Status Triaging", actionInstructions: "If awake, alert, and reliable: proceed to emergent closed reduction. IF OBTUNDED OR UNEXAMINABLE: CLOSED REDUCTION CONTRAINDICATED WITHOUT MRI."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Closed Tong Traction", actionInstructions: "Place Gardner-Wells tongs (1 cm above pinna); start 10-15 lbs, add 5-10 lbs per disc level (max 10 lbs/level) with serial lateral X-rays and neuro exams q5-10min."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Traction Stopping Criteria", actionInstructions: "Stop immediately if: reduction achieved, neurological decline occurs, or overdistraction (>10 mm disc height widening) appears."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Operative Fixation", actionInstructions: "If closed reduction fails or MRI shows large herniated disc: perform anterior cervical discectomy (ACDF) with open reduction + plate +/- posterior fusion.")
            ]
        case .cordCompressionTumor:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Stat Dexamethasone", actionInstructions: "Administer immediate Dexamethasone 10-16 mg IV bolus, followed by 4 mg IV q6h with PPI gastroprotection to reduce vasogenic cord edema."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "SINS Score Assessment", actionInstructions: "Calculate Spine Instability Neoplastic Score (SINS); score 7-12 is potentially unstable; score 13-18 requires mandatory surgical stabilization."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Patchell Surgical Separation", actionInstructions: "Direct circumferential surgical decompression (separation surgery) + posterolateral fusion indicated for deficits, radioresistant histology, or mechanical instability."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Post-Op SBRT", actionInstructions: "Follow surgical separation with Stereotactic Body Radiation Therapy (SBRT); reserve primary radiation alone for radiosensitive tumors (lymphoma/myeloma) without instability.")
            ]
        case .burstFracture:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "TLICS Classification", actionInstructions: "Score Morphology (Burst = 2), PLC integrity (intact = 0, suspected = 2, injured = 3), and Neuro status (intact = 0, incomplete = 3, complete = 2)."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Operative Threshold", actionInstructions: "TLICS <= 3: Non-operative (TLSO brace). TLICS 4: Surgeon discretion. TLICS >= 5: MANDATORY SURGICAL DECOMPRESSION & STABILIZATION."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Posterior Instrumentation", actionInstructions: "Perform posterior pedicle screw fixation 1-2 levels above and below; laminectomy; transpedicular impaction/reduction of retropulsed fragment."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Anterior Reconstruction", actionInstructions: "If severe anterior column collapse or middle column comminution: perform anterior corpectomy with expandable cage reconstruction.")
            ]
        case .caudaEquina:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Bladder Scan Triaging", actionInstructions: "Perform immediate post-void residual (PVR) bladder scan. PVR > 200 cc confirms acute neurogenic bladder and triggers emergent surgical pathway."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Time Window (<24-48h)", actionInstructions: "Emergency surgical decompression within <24-48 hours from onset of autonomic symptoms dramatically improves long-term micturition and sexual recovery."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Wide Bilateral Decompression", actionInstructions: "Perform emergent wide bilateral laminectomy, flavectomy, bilateral foraminotomy, and complete discectomy at the involved level."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Gentle Thecal Handling", actionInstructions: "Avoid aggressive lateral traction on ischemic cauda equina nerve roots; achieve complete decompression by bone removal rather than force.")
            ]
        case .csfLeakSpine:
            return [
                ConsultPhase(phaseNumber: 1, phaseTitle: "Bedside Conservative Trial", actionInstructions: "Strict flat bed rest for 48-72h, pressure dressing, and oversew leaking skin edges at bedside with horizontal mattress non-absorbable sutures (2-0 silk/nylon)."),
                ConsultPhase(phaseNumber: 2, phaseTitle: "Subarachnoid Diversion", actionInstructions: "Place lumbar subarachnoid drain (LSD) at L3-L4 or L4-L5; titrate drainage to 10-15 cc/hr (max 150-200 cc/24h) for 4-5 days to decompress durotomy site."),
                ConsultPhase(phaseNumber: 3, phaseTitle: "Operative Re-Exploration", actionInstructions: "Mandatory if persistent cutaneous fistula, high-volume leak, or failed lumbar drain: open wound under microscope for direct repair."),
                ConsultPhase(phaseNumber: 4, phaseTitle: "Watertight Dural Closure", actionInstructions: "Primary 5-0/6-0 Prolene running suture, DuraGen onlay, DuraSeal hydrogel, intraoperative Valsalva challenge (30-40 cm H2O), watertight running 0-Vicryl fascia, drain to gravity without suction.")
            ]
        }
    }
    
    public var pitfalls: [String] {
        switch self {
        case .jumpedFacets:
            return [
                "ATTEMPTING CLOSED REDUCTION ON AN OBTUNDED PATIENT WITHOUT PRE-REDUCTION MRI (can crush herniated disc into cord and cause permanent quadriplegia)",
                "Continuing closed traction despite neurological deterioration or overdistraction (>10 mm widening)",
                "Placing Gardner-Wells tongs too low or anterior, causing skull penetration or pin slippage"
            ]
        case .cordCompressionTumor:
            return [
                "Withholding high-dose intravenous dexamethasone while waiting for scheduled MRI imaging",
                "Failing to recognize mechanical spinal instability (SINS >= 13) and treating with radiation alone, leading to sudden vertebral collapse",
                "Attempting anterior resection in poor-prognosis patients when posterolateral separation surgery suffices"
            ]
        case .burstFracture:
            return [
                "Underestimating posterior ligamentous complex (PLC) disruption on CT alone (MRI required if indeterminate)",
                "Treating TLICS >= 5 burst fractures non-operatively leading to progressive kyphotic deformity and late myelopathy",
                "Failing to log-roll and clear the entire spinal axis (10-15% incidence of non-contiguous secondary fractures)"
            ]
        case .caudaEquina:
            return [
                "Discharging a patient with severe back pain without measuring post-void residual bladder volume",
                "Delaying operative decompression past the 48-hour window, resulting in permanent neurogenic bladder and erectile dysfunction",
                "Forceful retraction of ischemic cauda equina rootlets causing irreversible iatrogenic neurological deficit"
            ]
        case .csfLeakSpine:
            return [
                "PLACING SUBFASCIAL CLOSED-SUCTION DRAINS TO ACTIVE NEGATIVE PRESSURE (creates continuous suction pulling CSF and nerve roots through dural defect)",
                "Over-draining lumbar subarachnoid drain (>200 cc/day) precipitating intracranial subdural hematoma or tonsillar herniation",
                "Dismissing clear fluid drainage as a 'seroma' without testing for beta-2 transferrin, leading to bacterial meningitis"
            ]
        }
    }
    
    public var operativePlan: String {
        switch self {
        case .jumpedFacets: return "Emergent Gardner-Wells Closed Traction vs ACDF Open Reduction & Plating"
        case .cordCompressionTumor: return "Stat IV Dexamethasone + Direct Circumferential Separation Surgery & Posterolateral Fusion"
        case .burstFracture: return "Posterior Instrumented Fusion (1-2 above/below) + Transpedicular Fragment Reduction"
        case .caudaEquina: return "STAT Wide Lumbar Laminectomy, Flavectomy, and Discectomy (<24-48h)"
        case .csfLeakSpine: return "Lumbar Subarachnoid Drain (10-15 cc/hr) vs Operative Re-exploration with Primary Dural Repair"
        }
    }
}
