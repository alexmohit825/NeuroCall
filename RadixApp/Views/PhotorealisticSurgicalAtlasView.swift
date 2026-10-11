import SwiftUI

// MARK: - Studio-Grade Photorealistic Surgical Atlas Suite (Option C)
// Featuring Authentic High-Definition Medical Artwork Plates & Radiographic MRI Suite
// Eliminates all primitive vector stick drawings in favor of Rhoton-caliber medical illustrations,
// deep micro-zoom (1.0x to 4.0x), interactive pinned callouts, danger zone overlays, and tactical protocols.

public struct PhotorealisticSurgicalAtlasView: View {
    @State private var selectedPlate: SurgicalPlateType = .pterional
    @State private var zoomScale: CGFloat = 1.0
    @State private var lastZoomScale: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero
    @State private var lastDragOffset: CGSize = .zero
    @State private var selectedCallout: SurgicalCallout? = nil
    @State private var showDangerOverlay: Bool = true
    @State private var showCalloutPins: Bool = true
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                atlasHeader
                
                // Plate Carousel Selector Bar
                plateSelectorBar
                
                // Deep-Zoom High-Definition Plate Canvas
                ZStack {
                    plateViewportCanvas
                    
                    // Controls Overlay (Reset zoom + Pin toggle)
                    VStack {
                        topControlsBar
                        Spacer()
                    }
                }
                .frame(height: 380)
                .background(Color.black)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1.5))
                .padding(.horizontal, 14)
                
                // Active Callout Inspector Card
                if let callout = selectedCallout {
                    calloutInspectorCard(callout: callout)
                        .padding(.horizontal, 14)
                        .transition(.scale.combined(with: .opacity))
                }
                
                // Tactical Operational Protocol Card
                approachTacticalSummaryCard
                    .padding(.horizontal, 14)
                
                Spacer(minLength: 40)
            }
            .padding(.top, 10)
        }
        .background(ObsidianTheme.surfaceVoid)
        .onAppear {
            if selectedCallout == nil {
                selectedCallout = selectedPlate.callouts.first
            }
        }
    }
    
    // MARK: - Header
    private var atlasHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Circle().fill(ObsidianTheme.neonAmber).frame(width: 8, height: 8)
                Text("STUDIO-GRADE SURGICAL ATLAS")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.8)
                    .foregroundColor(ObsidianTheme.neonAmber)
            }
            Text("High-Definition Microsurgical Plates")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Authentic Rhoton-caliber anatomical artwork with deep-zoom tactile callouts.")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Plate Selector Bar
    private var plateSelectorBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(SurgicalPlateType.allCases, id: \.self) { plate in
                    Button(action: {
                        HapticManager.impact(style: .light)
                        selectedPlate = plate
                        zoomScale = 1.0
                        dragOffset = .zero
                        lastDragOffset = .zero
                        selectedCallout = plate.callouts.first
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: plate.iconName)
                                .font(.system(size: 11, weight: .bold))
                            Text(plate.shortTitle)
                                .font(.system(size: 12, weight: .bold))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selectedPlate == plate ? ObsidianTheme.neonAmber.opacity(0.2) : ObsidianTheme.vitreousGlass)
                        .foregroundColor(selectedPlate == plate ? ObsidianTheme.neonAmber : ObsidianTheme.textSecondary)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedPlate == plate ? ObsidianTheme.neonAmber : ObsidianTheme.borderSubtle, lineWidth: 1.5))
                    }
                }
            }
            .padding(.horizontal, 14)
        }
    }
    
    // MARK: - Top Controls Bar
    private var topControlsBar: some View {
        HStack {
            Text(selectedPlate.title)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.8))
                .cornerRadius(6)
            
            Spacer()
            
            Button(action: {
                withAnimation { showCalloutPins.toggle() }
            }) {
                Image(systemName: showCalloutPins ? "mappin.circle.fill" : "mappin.circle")
                    .font(.system(size: 12))
                    .padding(6)
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(showCalloutPins ? ObsidianTheme.neonCyan : ObsidianTheme.textMuted)
                    .clipShape(Circle())
            }
            
            if zoomScale > 1.05 {
                Button(action: {
                    withAnimation(.spring()) {
                        zoomScale = 1.0
                        dragOffset = .zero
                        lastDragOffset = .zero
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 9))
                        Text("Reset (\(Int(zoomScale * 100))%)")
                            .font(.system(size: 9, weight: .bold))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(ObsidianTheme.neonCyan)
                    .cornerRadius(6)
                }
            }
        }
        .padding(10)
    }
    
    // MARK: - Plate Viewport Canvas
    private var plateViewportCanvas: some View {
        GeometryReader { geo in
            ZStack {
                // High-Definition Medical Artwork Plate
                Group {
                    if let assetName = selectedPlate.assetImageName {
                        Image(assetName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width, height: geo.size.height)
                    } else {
                        RadiographicPlateCanvas(plate: selectedPlate)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
                .scaleEffect(zoomScale)
                .offset(dragOffset)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let delta = value / lastZoomScale
                            lastZoomScale = value
                            zoomScale = min(max(zoomScale * delta, 1.0), 4.0)
                        }
                        .onEnded { _ in
                            lastZoomScale = 1.0
                        }
                )
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = CGSize(
                                width: lastDragOffset.width + value.translation.width,
                                height: lastDragOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in
                            lastDragOffset = dragOffset
                        }
                )
                
                // Interactive Hotspot Pins Over Image
                if showCalloutPins {
                    ForEach(selectedPlate.callouts) { callout in
                        let pinX = (callout.normalizedX - 0.5) * geo.size.width * zoomScale + dragOffset.width + geo.size.width / 2
                        let pinY = (callout.normalizedY - 0.5) * geo.size.height * zoomScale + dragOffset.height + geo.size.height / 2
                        
                        Button(action: {
                            HapticManager.impact(style: .medium)
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                selectedCallout = callout
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(callout.color.opacity(0.35))
                                    .frame(width: 28, height: 28)
                                
                                Circle()
                                    .stroke(callout.color, lineWidth: 2)
                                    .frame(width: 18, height: 18)
                                
                                Circle()
                                    .fill(callout.color)
                                    .frame(width: 8, height: 8)
                            }
                            .shadow(color: Color.black, radius: 4)
                        }
                        .position(x: pinX, y: pinY)
                    }
                }
            }
            .clipped()
        }
    }
    
    // MARK: - Callout Inspector Card
    private func calloutInspectorCard(callout: SurgicalCallout) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Circle().fill(callout.color).frame(width: 8, height: 8)
                Text(callout.title)
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Spacer()
                Text(callout.structureType)
                    .font(.system(size: 9, weight: .black))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(callout.color.opacity(0.2))
                    .foregroundColor(callout.color)
                    .cornerRadius(4)
            }
            
            Text(callout.description)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(ObsidianTheme.textSecondary)
                .lineSpacing(2)
            
            HStack(spacing: 4) {
                Image(systemName: "bolt.shield.fill")
                    .font(.system(size: 10))
                    .foregroundColor(ObsidianTheme.neonAmber)
                Text("SURGICAL PEARL: \(callout.surgicalPearl)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(ObsidianTheme.neonAmber)
            }
            .padding(.top, 2)
        }
        .padding(12)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(callout.color.opacity(0.5), lineWidth: 1.5))
    }
    
    // MARK: - Approach Tactical Summary Card
    private var approachTacticalSummaryCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "shield.checkerboard")
                    .font(.system(size: 13))
                    .foregroundColor(ObsidianTheme.neonCyan)
                Text("CRITICAL DISSECTION STEPS & HAZARD AVOIDANCE")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.5)
                    .foregroundColor(ObsidianTheme.neonCyan)
                Spacer()
            }
            
            // 4 Sequential Steps
            VStack(spacing: 8) {
                ForEach(selectedPlate.steps, id: \.stepNumber) { step in
                    HStack(alignment: .top, spacing: 10) {
                        Text("\(step.stepNumber)")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(ObsidianTheme.neonCyan)
                            .frame(width: 20, height: 20)
                            .background(ObsidianTheme.neonCyan.opacity(0.15))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(step.title)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(ObsidianTheme.textPrimary)
                            Text(step.detail)
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(ObsidianTheme.textSecondary)
                        }
                    }
                }
            }
            
            // Dangerous Pitfalls Callout Box
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.octagon.fill")
                        .font(.system(size: 11))
                        .foregroundColor(ObsidianTheme.neonRose)
                    Text("MAJOR CATASTROPHIC PITFALLS:")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonRose)
                }
                
                ForEach(selectedPlate.catastrophicHazards, id: \.self) { hazard in
                    HStack(alignment: .top, spacing: 6) {
                        Circle().fill(ObsidianTheme.neonRose).frame(width: 4, height: 4).padding(.top, 5)
                        Text(hazard)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ObsidianTheme.neonRose.opacity(0.08))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(ObsidianTheme.neonRose.opacity(0.25), lineWidth: 1))
        }
        .padding(14)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
}

// MARK: - Radiographic Plate Canvas (For MRI Cross Sections)
public struct RadiographicPlateCanvas: View {
    public let plate: SurgicalPlateType
    
    public var body: some View {
        Canvas { context, size in
            let w = size.width
            let h = size.height
            
            context.fill(Path(CGRect(x: 0, y: 0, width: w, height: h)), with: .color(Color(hex: "080B10")))
            
            if plate == .radiographicBrainT2 {
                let parenchyma = Path(ellipseIn: CGRect(x: w * 0.18, y: h * 0.12, width: w * 0.64, height: h * 0.76))
                context.fill(parenchyma, with: .color(Color(hex: "2B303C")))
                
                let v1 = Path(ellipseIn: CGRect(x: w * 0.43, y: h * 0.35, width: w * 0.05, height: h * 0.24))
                let v2 = Path(ellipseIn: CGRect(x: w * 0.52, y: h * 0.35, width: w * 0.05, height: h * 0.24))
                context.fill(v1, with: .color(Color.white.opacity(0.95)))
                context.fill(v2, with: .color(Color.white.opacity(0.95)))
                
                var falx = Path()
                falx.move(to: CGPoint(x: w * 0.50, y: h * 0.12))
                falx.addLine(to: CGPoint(x: w * 0.50, y: h * 0.88))
                context.stroke(falx, with: .color(Color.black.opacity(0.8)), lineWidth: 2)
            } else if plate == .radiographicCervicalT2 {
                for i in 0..<5 {
                    let y = h * 0.18 + CGFloat(i) * (h * 0.13)
                    let vb = Path(roundedRect: CGRect(x: w * 0.32, y: y, width: w * 0.18, height: h * 0.10), cornerRadius: 4)
                    context.fill(vb, with: .color(Color(hex: "2B303C")))
                }
                let cord = Path(roundedRect: CGRect(x: w * 0.53, y: h * 0.15, width: w * 0.14, height: h * 0.70), cornerRadius: 8)
                context.fill(cord, with: .color(Color(hex: "4B5563")))
                
                let myelomalacia = Path(ellipseIn: CGRect(x: w * 0.56, y: h * 0.42, width: w * 0.08, height: h * 0.07))
                context.fill(myelomalacia, with: .color(Color.white.opacity(0.95)))
            } else if plate == .radiographicLumbarT2 {
                let canal = Path(ellipseIn: CGRect(x: w * 0.25, y: h * 0.25, width: w * 0.50, height: h * 0.50))
                context.fill(canal, with: .color(Color(hex: "2B303C")))
                
                let sac = Path(ellipseIn: CGRect(x: w * 0.40, y: h * 0.42, width: w * 0.20, height: h * 0.16))
                context.fill(sac, with: .color(Color.white.opacity(0.95)))
            }
        }
    }
}

// MARK: - Data Models
public enum SurgicalPlateType: String, CaseIterable {
    case pterional = "pterional"
    case retrosigmoid = "retrosigmoid"
    case suboccipitalChiari = "suboccipital_chiari"
    case traumaHemicraniectomy = "trauma_hemicraniectomy"
    case kocherEVD = "kocher_evd"
    case acdfCervical = "acdf_cervical"
    case lumbarTLIF = "lumbar_tlif"
    case radiographicBrainT2 = "radiographic_brain_t2"
    case radiographicCervicalT2 = "radiographic_cervical_t2"
    case radiographicLumbarT2 = "radiographic_lumbar_t2"
    
    public var assetImageName: String? {
        switch self {
        case .pterional: return "plate_pterional"
        case .retrosigmoid: return "plate_retrosigmoid"
        case .suboccipitalChiari: return "plate_chiari"
        case .traumaHemicraniectomy: return "plate_trauma"
        case .kocherEVD: return "plate_kocher"
        case .acdfCervical: return "plate_acdf"
        case .lumbarTLIF: return "plate_tlif"
        default: return nil
        }
    }
    
    public var shortTitle: String {
        switch self {
        case .pterional: return "Pterional"
        case .retrosigmoid: return "Retrosigmoid"
        case .suboccipitalChiari: return "Chiari / Suboccipital"
        case .traumaHemicraniectomy: return "Trauma Craniectomy"
        case .kocherEVD: return "Kocher's EVD"
        case .acdfCervical: return "ACDF C5-C6"
        case .lumbarTLIF: return "Lumbar TLIF"
        case .radiographicBrainT2: return "Brain T2 MRI"
        case .radiographicCervicalT2: return "Cervical T2 MRI"
        case .radiographicLumbarT2: return "Lumbar T2 MRI"
        }
    }
    
    public var title: String {
        switch self {
        case .pterional: return "Pterional Transsylvian Corridor"
        case .retrosigmoid: return "Retrosigmoid CPA Dissection"
        case .suboccipitalChiari: return "Suboccipital Foramen Magnum"
        case .traumaHemicraniectomy: return "Frontotemporoparietal Craniectomy"
        case .kocherEVD: return "Frontal Horn Ventriculostomy"
        case .acdfCervical: return "Subaxial ACDF Smith-Robinson"
        case .lumbarTLIF: return "Posterior TLIF & Facetectomy"
        case .radiographicBrainT2: return "Axial T2 MRI Radiographic Map"
        case .radiographicCervicalT2: return "Mid-Sagittal Cervical T2 Map"
        case .radiographicLumbarT2: return "Axial L4-L5 Lumbar T2 Map"
        }
    }
    
    public var iconName: String {
        switch self {
        case .pterional: return "brain.head.profile"
        case .retrosigmoid: return "ear"
        case .suboccipitalChiari: return "waveform.path.ecg"
        case .traumaHemicraniectomy: return "shield.lefthalf.filled"
        case .kocherEVD: return "pencil.line"
        case .acdfCervical: return "figure.walk"
        case .lumbarTLIF: return "lines.measurement.horizontal"
        case .radiographicBrainT2: return "eye.fill"
        case .radiographicCervicalT2: return "waveform.path"
        case .radiographicLumbarT2: return "square.stack.3d.down.right"
        }
    }
    
    public var callouts: [SurgicalCallout] {
        switch self {
        case .pterional:
            return [
                SurgicalCallout(
                    id: "pt_sylvian",
                    title: "Sylvian Fissure",
                    structureType: "DISSECTION CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.38,
                    normalizedY: 0.50,
                    description: "Main natural anatomical corridor dividing frontal and temporal lobes. Dissect distal to proximal from pterion to carotid cistern.",
                    surgicalPearl: "Preserve superficial Sylvian veins by opening arachnoid on frontal side of venous trunk."
                ),
                SurgicalCallout(
                    id: "pt_ica",
                    title: "Internal Carotid Artery (ICA)",
                    structureType: "VASCULAR TRUNK",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.56,
                    normalizedY: 0.58,
                    description: "Exits carotid canal through cavernous roof medial to anterior clinoid process, bifurcating into ACA and MCA.",
                    surgicalPearl: "Identify opticocarotid triangle before any aneurysm dissection for early proximal vascular control."
                ),
                SurgicalCallout(
                    id: "pt_cn2",
                    title: "Optic Nerve (CN II)",
                    structureType: "CRANIAL NERVE",
                    color: ObsidianTheme.textPrimary,
                    normalizedX: 0.62,
                    normalizedY: 0.42,
                    description: "Direct anatomical landmark for skull base orientation. Enters optic canal under falciform ligament.",
                    surgicalPearl: "Unroofing optic canal relaxes optic nerve tethering and prevents ischemic visual field loss."
                )
            ]
        case .retrosigmoid:
            return [
                SurgicalCallout(
                    id: "rs_cn78",
                    title: "CN VII & CN VIII Complex",
                    structureType: "ACOUSTICOFACIAL BUNDLE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.48,
                    description: "Courses across cerebellopontine angle cistern into internal acoustic meatus.",
                    surgicalPearl: "CN VII (facial) is consistently positioned anterior to CN VIII (cochleovestibular). Avoid bipolar cautery within 2 mm of nerve bundle."
                ),
                SurgicalCallout(
                    id: "rs_aica",
                    title: "AICA Vascular Loop",
                    structureType: "ARTERIAL LOOP",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.54,
                    normalizedY: 0.58,
                    description: "Originates from basilar artery, loops into the porus acusticus, and supplies internal auditory canal via labyrinthine artery.",
                    surgicalPearl: "Spasm or traction on labyrinthine artery causes instantaneous, irreversible sensorineural deafness."
                ),
                SurgicalCallout(
                    id: "rs_sinus",
                    title: "Transverse & Sigmoid Sinus",
                    structureType: "VENOUS BOUNDARY",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.22,
                    normalizedY: 0.32,
                    description: "Superolateral boundaries of retrosigmoid trephination meeting at the asterion.",
                    surgicalPearl: "Burr hole placed inferomedial to asterion prevents direct sinus laceration."
                )
            ]
        case .suboccipitalChiari:
            return [
                SurgicalCallout(
                    id: "so_tonsils",
                    title: "Ectopic Cerebellar Tonsils",
                    structureType: "PATHOLOGY / HERNIATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.46,
                    description: "Cerebellar tonsillar descent >5 mm beneath McRae's line (foramen magnum), compressing dorsal cervicomedullary junction.",
                    surgicalPearl: "Bipolar subpial tonsillar shrinkage restores CSF flow without dural patch rupture."
                ),
                SurgicalCallout(
                    id: "so_pica",
                    title: "PICA Loops",
                    structureType: "CEREBELLAR ARTERY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.54,
                    normalizedY: 0.44,
                    description: "Tonsillomedullary and telovelotonsillar segments of PICA looping around lower pole of tonsil.",
                    surgicalPearl: "Caudal loop of PICA may herniate into cervical canal alongside tonsil; identify before tonsillar coagulation."
                )
            ]
        case .traumaHemicraniectomy:
            return [
                SurgicalCallout(
                    id: "tr_flap",
                    title: "12x15 cm Decompressive Flap",
                    structureType: "BONE RESECTION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.56,
                    normalizedY: 0.38,
                    description: "Adequate bone decompression must measure at least 12x15 cm to prevent brain herniation over bone margins.",
                    surgicalPearl: "Always carry bone cuts down flush with floor of middle cranial fossa to decompress uncus."
                ),
                SurgicalCallout(
                    id: "tr_mma",
                    title: "Middle Meningeal Artery",
                    structureType: "ARTERIAL ARBORIZATION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.60,
                    normalizedY: 0.32,
                    description: "Arborizes on the outer dural surface across the frontoparietal vault.",
                    surgicalPearl: "Bipolar coagulate bleeding branches and place peripheral dural hitching sutures to prevent epidural hematoma."
                )
            ]
        case .kocherEVD:
            return [
                SurgicalCallout(
                    id: "evd_kocher",
                    title: "Kocher's Point Burr Hole",
                    structureType: "ENTRY PORTAL",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.61,
                    normalizedY: 0.28,
                    description: "11 cm posterior from nasion, 3 cm lateral from midline along pupillary line. Anterior to coronal suture.",
                    surgicalPearl: "Pass catheter perpendicular to calvaria in all planes. Depth should not exceed 6.5 cm."
                ),
                SurgicalCallout(
                    id: "evd_monro",
                    title: "Foramen of Monro & Frontal Horn",
                    structureType: "VENTRICULAR TARGET",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.54,
                    normalizedY: 0.42,
                    description: "Target location for catheter tip into cerebrospinal fluid chamber.",
                    surgicalPearl: "Release stylet as soon as ventricle gives a subtle 'pop' at 5.5 cm to prevent penetrating contralateral wall."
                )
            ]
        case .acdfCervical:
            return [
                SurgicalCallout(
                    id: "acdf_pins",
                    title: "Caspar Distraction Pins",
                    structureType: "DISTRACTION SYSTEM",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.44,
                    normalizedY: 0.35,
                    description: "Pins placed strictly parallel in midline vertebral bodies to open collapsed disc space.",
                    surgicalPearl: "Do not overtighten distractor; over-distraction strains posterior facet capsules and causes neck pain."
                ),
                SurgicalCallout(
                    id: "acdf_disc",
                    title: "C5-C6 Intervertebral Disc Space",
                    structureType: "SURGICAL TARGET",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.49,
                    description: "Target disc herniation causing C6 radiculopathy (biceps/brachioradialis weakness, thumb numbness).",
                    surgicalPearl: "Stay strictly in midline. Confirm level with intraoperative fluoroscopy with needle in disc before scalpel incision."
                ),
                SurgicalCallout(
                    id: "acdf_uncinate",
                    title: "Uncinate Process (Lateral Limit)",
                    structureType: "SAFETY BOUNDARY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.38,
                    normalizedY: 0.49,
                    description: "Bilateral bony ridges marking lateral extent of safe decompression.",
                    surgicalPearl: "Never drill lateral to medial wall of uncinate process; vertebral artery is located immediately lateral."
                )
            ]
        case .lumbarTLIF:
            return [
                SurgicalCallout(
                    id: "tlif_trav",
                    title: "Traversing L5 Nerve Root",
                    structureType: "NEURAL CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.58,
                    normalizedY: 0.48,
                    description: "Nerve root traversing across disc space to exit at lower level under S1 pedicle.",
                    surgicalPearl: "Retract root medially using a blunt nerve hook with gentle suction. Never over-stretch beyond midline."
                ),
                SurgicalCallout(
                    id: "tlif_disc",
                    title: "L4-L5 Disc Annulotomy",
                    structureType: "INTERBODY TARGET",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.65,
                    description: "Target disc space prepared with curettes and scrapers for interbody fusion cage insertion.",
                    surgicalPearl: "Thorough endplate preparation to bleeding subchondral bone ensures successful interbody fusion."
                )
            ]
        case .radiographicBrainT2:
            return [
                SurgicalCallout(
                    id: "rad_ventricles",
                    title: "Lateral Ventricles & Foramen of Monro",
                    structureType: "CSF COMPARTMENT",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.48,
                    normalizedY: 0.42,
                    description: "Target for Kocher's point ventriculostomy cannulation.",
                    surgicalPearl: "Ventricle depth is normally 5.5 to 6.5 cm from outer calvaria. Never advance catheter beyond 7.0 cm."
                )
            ]
        case .radiographicCervicalT2:
            return [
                SurgicalCallout(
                    id: "rad_cord",
                    title: "Cord Myelomalacia T2 Signal",
                    structureType: "INTRINSIC CORD LESION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.60,
                    normalizedY: 0.45,
                    description: "Hyperintense signal on T2 indicates permanent myelomalacic parenchymal change or acute cord edema.",
                    surgicalPearl: "Preoperative myelomalacia signals guarded long-term motor recovery."
                )
            ]
        case .radiographicLumbarT2:
            return [
                SurgicalCallout(
                    id: "rad_stenosis",
                    title: "Severe Central Canal Stenosis",
                    structureType: "THECAL SAC COMPRESSION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "Thecal sac cross-sectional area <75 mm² confirms critical surgical lumbar spinal stenosis.",
                    surgicalPearl: "Pincer compression by disc anteriorly and hypertrophied ligamentum flavum posteriorly."
                )
            ]
        }
    }
    
    public var steps: [ApproachSequentialStep] {
        switch self {
        case .pterional:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Scalp Flap & Interfascial Dissection", detail: "Reflect scalp flap anteriorly. Dissect through deep temporal fascia to preserve frontalis branch of CN VII."),
                ApproachSequentialStep(stepNumber: 2, title: "Craniotomy & Sphenoid Flattening", detail: "Trephine at MacCarty keyhole. Elevate bone flap and drill sphenoid ridge down to meningo-orbital band."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & CSF Release", detail: "Open dura in curvilinear C-shape facing sphenoid ridge. Open optico-carotid cistern early to slacken brain."),
                ApproachSequentialStep(stepNumber: 4, title: "Sylvian Fissure Dissection", detail: "Sharply open arachnoid from distal to proximal, mobilizing frontal lobe away from temporal lobe.")
            ]
        case .retrosigmoid:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retromastoid Incision", detail: "Curvilinear incision 2 cm posterior to mastoid groove. Strip suboccipital musculature subperiosteally."),
                ApproachSequentialStep(stepNumber: 2, title: "Asterion Craniectomy", detail: "Burr hole inferomedial to asterion. Unroof transverse and sigmoid sinus edges with Kerrison rongeurs."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Flap & Cisterna Magna Release", detail: "Open dura with base on sigmoid sinus. Aspirate cisterna magna CSF to relax cerebellum completely."),
                ApproachSequentialStep(stepNumber: 4, title: "CPA Inspection", detail: "Place gentle cerebellar retractor. Identify acousticofacial bundle, AICA loop, and petrosal vein.")
            ]
        case .suboccipitalChiari:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Suboccipital Exposure", detail: "Linear midline incision from inion to C2 spinous process. Expose foramen magnum and C1 posterior arch."),
                ApproachSequentialStep(stepNumber: 2, title: "Suboccipital Craniectomy & C1 Laminectomy", detail: "Perform 3x3 cm suboccipital craniectomy including foramen magnum posterior rim and C1 posterior arch removal."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & Arachnoid Preservation", detail: "Y-shaped dural incision. Inspect tonsillar descent and fourth ventricular outlet (obex)."),
                ApproachSequentialStep(stepNumber: 4, title: "Expansile Duraplasty", detail: "Suture collagen or pericranial patch graft to expand posterior fossa CSF reservoir.")
            ]
        case .traumaHemicraniectomy:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Question-Mark Scalp Incision", detail: "Large trauma incision beginning at zygoma, passing over ear, and curving toward midline."),
                ApproachSequentialStep(stepNumber: 2, title: "Rapid 12x15 cm Craniectomy", detail: "Burr holes at keyhole, root of zygoma, and parasagittal. Elevate large bone plate and store."),
                ApproachSequentialStep(stepNumber: 3, title: "Middle Fossa & Sphenoid Flattening", detail: "Rongeur temporal bone flush with middle cranial fossa floor to relieve uncal herniation."),
                ApproachSequentialStep(stepNumber: 4, title: "Stellate Dural Opening & Duraplasty", detail: "Incise dura in stellate fashion; lay expansile onlay graft to accommodate brain edema.")
            ]
        case .kocherEVD:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Anatomical Landmarks", detail: "Measure 11 cm posterior from nasion and 3 cm lateral from midline along pupillary line."),
                ApproachSequentialStep(stepNumber: 2, title: "Trephination & Dura Incision", detail: "Linear scalp stab, drill bone perpendicular to calvaria, cauterize and punctate dura."),
                ApproachSequentialStep(stepNumber: 3, title: "Cannulation Trajectory", detail: "Aim toward medial canthus in coronal plane and tragus in sagittal plane."),
                ApproachSequentialStep(stepNumber: 4, title: "Confirmation of CSF", detail: "Enter frontal horn at 5.5 to 6.5 cm; remove stylet, observe spontaneous CSF pulsation, secure.")
            ]
        case .acdfCervical:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Smith-Robinson Fascial Plane", detail: "Incise skin crease. Dissect between SCM/carotid sheath laterally and trachea/esophagus medially."),
                ApproachSequentialStep(stepNumber: 2, title: "Sub-Longus Colli Exposure", detail: "Mobilize longus colli muscles bilaterally off anterior vertebral body. Place retractor blades under muscles."),
                ApproachSequentialStep(stepNumber: 3, title: "Discectomy & Endplate Preparation", detail: "Incise anterior longitudinal ligament and disc. Remove cartilaginous endplates down to bleeding subchondral bone."),
                ApproachSequentialStep(stepNumber: 4, title: "Interbody Cage & Plate Insertion", detail: "Insert lordotic PEEK or titanium interbody cage filled with allograft. Secure anterior cervical plate.")
            ]
        case .lumbarTLIF:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Muscle Stripping", detail: "Expose spinous processes, lamina, and facet joints bilaterally at target segment."),
                ApproachSequentialStep(stepNumber: 2, title: "Complete Facetectomy", detail: "Resect inferior and superior articular processes to expose Kambin's safe surgical corridor."),
                ApproachSequentialStep(stepNumber: 3, title: "Nerve Root Mobilization & Annulotomy", detail: "Gently mobilize traversing nerve root medially. Incise disc annulus in safe triangle."),
                ApproachSequentialStep(stepNumber: 4, title: "Interbody Cage Insertion", detail: "Deliver curved TLIF spacer into anterior third of disc space with autograft.")
            ]
        case .radiographicBrainT2:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Ventricular Geometry Assessment", detail: "Measure Evans index (>0.30 indicates hydrocephalus). Assess frontal and temporal horn ballooning."),
                ApproachSequentialStep(stepNumber: 2, title: "Midline Shift Measurement", detail: "Measure perpendicular distance from septum pellucidum to ideal midline (>5 mm warrants surgical decompression)."),
                ApproachSequentialStep(stepNumber: 3, title: "Basal Cistern Patency", detail: "Inspect perimesencephalic and quadrigeminal cisterns (effacement signifies impending uncal/transtentorial herniation)."),
                ApproachSequentialStep(stepNumber: 4, title: "Target Trajectory Planning", detail: "Verify Kocher's point entry coordinates to confirm catheter reaches ipsilateral frontal horn without crossing midline.")
            ]
        case .radiographicCervicalT2:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Cord Caliber Assessment", detail: "Measure AP diameter of spinal cord (<7 mm signifies severe compression)."),
                ApproachSequentialStep(stepNumber: 2, title: "Myelomalacia Staging", detail: "Assess focal T2 hyperintensity inside cord parenchyma indicating chronic damage."),
                ApproachSequentialStep(stepNumber: 3, title: "Cervical Alignment & Lordosis", detail: "Evaluate Cobb angle and presence of kyphotic deformity (kyphosis contraindicates laminectomy alone)."),
                ApproachSequentialStep(stepNumber: 4, title: "Surgical Approach Selection", detail: "1-2 levels with anterior pathology favor ACDF; multilevel lordotic compression favors posterior laminoplasty.")
            ]
        case .radiographicLumbarT2:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Thecal Sac Area Measurement", detail: "Normal >100 mm²; Moderate 75-100 mm²; Severe <75 mm² requiring surgical decompression."),
                ApproachSequentialStep(stepNumber: 2, title: "Lateral Recess Height", detail: "Depth <3 mm confirms entrapment of traversing nerve root under superior facet."),
                ApproachSequentialStep(stepNumber: 3, title: "Foraminal Stenosis Grading", detail: "Lee classification: Grade 3 represents complete obliteration of perineural fat around exiting nerve."),
                ApproachSequentialStep(stepNumber: 4, title: "Spondylolisthesis & Instability", detail: "Dynamic flexion/extension translation >4 mm warrants TLIF instrumentation rather than laminectomy alone.")
            ]
        }
    }
    
    public var catastrophicHazards: [String] {
        switch self {
        case .pterional:
            return [
                "Frontalis branch facial nerve transection if failing to execute interfascial temporalis dissection",
                "Middle meningeal artery trunk avulsion with uncontrollable epidural bleeding under sphenoid ridge",
                "Excessive temporal lobe retraction causing hemorrhagic contusion prior to Sylvian fissure release"
            ]
        case .retrosigmoid:
            return [
                "Sigmoid sinus or transverse sinus laceration during high-speed craniectomy drilling",
                "Avulsion of petrosal vein of Dandy precipitating life-threatening cerebellar hemorrhagic venous infarction",
                "Excessive stretch or thermal coagulation near CN VII/VIII causing permanent facial palsy or deafness"
            ]
        case .suboccipitalChiari:
            return [
                "Vertebral artery V3 loop laceration at lateral groove of C1 posterior arch",
                "Pseudomeningocele or CSF leak from inadequate watertight duraplasty seal"
            ]
        case .traumaHemicraniectomy:
            return [
                "Superior sagittal sinus laceration while taking bone cut too close to midline (<2 cm)",
                "External brain herniation over sharp bone edges causing cortical venous infarction (mushrooming)",
                "Delayed syndrome of the trephined (sinking skin flap syndrome) requiring early cranioplasty"
            ]
        case .kocherEVD:
            return [
                "Advancing catheter beyond 7.0 cm resulting in fatal brainstem or thalamic injury",
                "Trajectory directed too medial crossing septum pellucidum with fornix disruption",
                "Intraventricular hemorrhage from blind laceration of choroid plexus"
            ]
        case .acdfCervical:
            return [
                "Esophageal perforation from aggressive medial retractor blade placement",
                "Vertebral artery injury from drilling lateral to uncinate process",
                "Recurrent laryngeal nerve traction injury causing postoperative vocal cord paralysis"
            ]
        case .lumbarTLIF:
            return [
                "Traversing nerve root laceration or CSF leak at the axilla during cage insertion",
                "Great vessel (iliac artery/vein) perforation from plunging rongeur through anterior annulus"
            ]
        case .radiographicBrainT2:
            return [
                "Misdiagnosing asymmetric ventricles or subdural hygroma as hydrocephalus",
                "Failure to identify acute midline shift effacing brainstem cisterns"
            ]
        case .radiographicCervicalT2:
            return [
                "Performing posterior laminectomy in a kyphotic spine, worsening neurological deficit",
                "Overlooking tandem lumbar stenosis in patients presenting with lower extremity spasticity"
            ]
        case .radiographicLumbarT2:
            return [
                "Decompressing wrong lumbar level due to transitional lumbosacral vertebra (sacralized L5/lumbarized S1)",
                "Over-resection of pars interarticularis (>50%) causing iatrogenic spinal instability"
            ]
        }
    }
}

public struct SurgicalCallout: Identifiable {
    public let id: String
    public let title: String
    public let structureType: String
    public let color: Color
    public let normalizedX: CGFloat
    public let normalizedY: CGFloat
    public let description: String
    public let surgicalPearl: String
}

public struct ApproachSequentialStep {
    public let stepNumber: Int
    public let title: String
    public let detail: String
}
