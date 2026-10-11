import SwiftUI

// MARK: - Studio-Grade Photorealistic Surgical Atlas Suite (Option C)
// Featuring Authentic High-Definition Medical Artwork Plates & Authentic Radiographic MRI Suite
// Synthesized from Albert Rhoton Jr., Greenberg Handbook of Neurosurgery, and Kaloostian Neurosurgery Outlines.
// Deep micro-zoom (1.0x to 4.0x), interactive pinned callouts, danger zone overlays, and tactical protocols.

public struct PhotorealisticSurgicalAtlasView: View {
    @State private var selectedPlate: SurgicalPlateType = .aneurysmClipping
    @State private var zoomScale: CGFloat = 1.0
    @State private var lastZoomScale: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero
    @State private var lastDragOffset: CGSize = .zero
    @State private var selectedCallout: SurgicalCallout? = nil
    @State private var showDangerOverlay: Bool = true
    @State private var showCalloutPins: Bool = true
    @State private var isShowingReviewStation: Bool = false
    
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
        .sheet(isPresented: $isShowingReviewStation) {
            AnatomicReviewStationView()
        }
        .onAppear {
            if selectedCallout == nil {
                selectedCallout = selectedPlate.callouts.first
            }
        }
    }
    
    // MARK: - Header
    private var atlasHeader: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                HStack(spacing: 6) {
                    Circle().fill(ObsidianTheme.neonAmber).frame(width: 8, height: 8)
                    Text("STUDIO-GRADE SURGICAL ATLAS")
                        .font(.system(size: 10, weight: .black))
                        .tracking(1.8)
                        .foregroundColor(ObsidianTheme.neonAmber)
                }
                Spacer()
                Button(action: {
                    HapticManager.impact(style: .medium)
                    isShowingReviewStation = true
                }) {
                    HStack(spacing: 5) {
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
            Text("High-Definition Microsurgical & MRI Plates")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Authentic Rhoton-caliber anatomical artwork and clinical MRI scans with deep-zoom tactile callouts.")
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
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 12))
                        .padding(6)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(ObsidianTheme.neonAmber)
                        .clipShape(Circle())
                }
            }
        }
        .padding(10)
    }
    
    // MARK: - Plate Viewport Canvas
    private var plateViewportCanvas: some View {
        GeometryReader { geo in
            ZStack {
                // If it's a photorealistic image plate from Assets.xcassets
                if let assetName = selectedPlate.assetImageName {
                    Image(assetName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                // Interactive Callout Pins
                if showCalloutPins {
                    ForEach(selectedPlate.callouts) { callout in
                        calloutPinView(callout: callout, in: geo.size)
                    }
                }
            }
            .scaleEffect(zoomScale)
            .offset(dragOffset)
            .gesture(
                MagnificationGesture()
                    .onChanged { val in
                        let delta = val / lastZoomScale
                        lastZoomScale = val
                        let newScale = zoomScale * delta
                        zoomScale = min(max(newScale, 1.0), 4.0)
                    }
                    .onEnded { _ in
                        lastZoomScale = 1.0
                    }
            )
            .simultaneousGesture(
                DragGesture()
                    .onChanged { val in
                        if zoomScale > 1.05 {
                            dragOffset = CGSize(
                                width: lastDragOffset.width + val.translation.width,
                                height: lastDragOffset.height + val.translation.height
                            )
                        }
                    }
                    .onEnded { _ in
                        lastDragOffset = dragOffset
                    }
            )
            .clipped()
        }
    }
    
    // MARK: - Callout Pin View
    private func calloutPinView(callout: SurgicalCallout, in size: CGSize) -> some View {
        let pinX = size.width * callout.normalizedX
        let pinY = size.height * callout.normalizedY
        let isSelected = selectedCallout?.id == callout.id
        
        return Button(action: {
            HapticManager.impact(style: .medium)
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedCallout = callout
            }
        }) {
            ZStack {
                Circle()
                    .fill(callout.color.opacity(isSelected ? 0.35 : 0.2))
                    .frame(width: isSelected ? 32 : 22, height: isSelected ? 32 : 22)
                
                Circle()
                    .stroke(callout.color, lineWidth: isSelected ? 2.5 : 1.5)
                    .frame(width: isSelected ? 24 : 16, height: isSelected ? 24 : 16)
                
                Circle()
                    .fill(callout.color)
                    .frame(width: isSelected ? 10 : 7, height: isSelected ? 10 : 7)
            }
        }
        .position(x: pinX, y: pinY)
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
                Text("SURGICAL PEARL: " + callout.surgicalPearl)
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

// MARK: - Data Models
public enum SurgicalPlateType: String, CaseIterable {
    case aneurysmClipping = "aneurysm_clipping"
    case pterional = "pterional"
    case orbitozygomatic = "orbitozygomatic"
    case retrosigmoid = "retrosigmoid"
    case farLateral = "far_lateral"
    case endonasalSellar = "endonasal_sellar"
    case suboccipitalChiari = "suboccipital_chiari"
    case traumaHemicraniectomy = "trauma_hemicraniectomy"
    case kocherEVD = "kocher_evd"
    case c1C2Harms = "c1_c2_harms"
    case acdfCervical = "acdf_cervical"
    case lumbarTLIF = "lumbar_tlif"
    case radiographicBrainT2 = "radiographic_brain_t2"
    
    public var assetImageName: String? {
        switch self {
        case .aneurysmClipping: return "plate_aneurysm"
        case .pterional: return "plate_pterional"
        case .orbitozygomatic: return "plate_orbitozygomatic"
        case .retrosigmoid: return "plate_retrosigmoid"
        case .farLateral: return "plate_far_lateral"
        case .endonasalSellar: return "plate_endonasal_sellar"
        case .suboccipitalChiari: return "plate_chiari"
        case .traumaHemicraniectomy: return "plate_trauma"
        case .kocherEVD: return "plate_kocher"
        case .c1C2Harms: return "plate_c1_c2_harms"
        case .acdfCervical: return "plate_acdf"
        case .lumbarTLIF: return "plate_tlif"
        case .radiographicBrainT2: return "plate_mri_axial_brain"
        }
    }
    
    public var shortTitle: String {
        switch self {
        case .aneurysmClipping: return "Aneurysm Clip"
        case .pterional: return "Pterional"
        case .orbitozygomatic: return "Orbitozygomatic"
        case .retrosigmoid: return "Retrosigmoid"
        case .farLateral: return "Far-Lateral"
        case .endonasalSellar: return "Endonasal Sellar"
        case .suboccipitalChiari: return "Chiari / Suboccipital"
        case .traumaHemicraniectomy: return "Trauma Craniectomy"
        case .kocherEVD: return "Kocher's EVD"
        case .c1C2Harms: return "C1-C2 Harms"
        case .acdfCervical: return "ACDF C5-C6"
        case .lumbarTLIF: return "Lumbar TLIF"
        case .radiographicBrainT2: return "Axial Brain T2 MRI"
        }
    }
    
    public var title: String {
        switch self {
        case .aneurysmClipping: return "Anterior Circulation Aneurysm Clipping"
        case .pterional: return "Pterional Frontotemporosphenoidal Corridor"
        case .orbitozygomatic: return "Orbitozygomatic Skull Base Corridor"
        case .retrosigmoid: return "Retrosigmoid CPA Dissection"
        case .farLateral: return "Far-Lateral Suboccipital Transcondylar"
        case .endonasalSellar: return "Endoscopic Endonasal Sellar Corridor"
        case .suboccipitalChiari: return "Suboccipital Foramen Magnum"
        case .traumaHemicraniectomy: return "Decompressive Hemicraniectomy (12x15 cm)"
        case .kocherEVD: return "Frontal Horn Ventriculostomy"
        case .c1C2Harms: return "C1 Lateral Mass & C2 Pedicle Fixation"
        case .acdfCervical: return "Subaxial ACDF Smith-Robinson (C5-C6)"
        case .lumbarTLIF: return "Posterior TLIF & Facetectomy"
        case .radiographicBrainT2: return "Axial T2 MRI: Central Sulcus & Motor Strip"
        }
    }
    
    public var iconName: String {
        switch self {
        case .aneurysmClipping: return "bolt.horizontal.fill"
        case .pterional: return "brain.head.profile"
        case .orbitozygomatic: return "eye.fill"
        case .retrosigmoid: return "ear"
        case .farLateral: return "arrow.triangle.turn.up.right.diamond"
        case .endonasalSellar: return "mouth"
        case .suboccipitalChiari: return "waveform.path.ecg"
        case .traumaHemicraniectomy: return "shield.lefthalf.filled"
        case .kocherEVD: return "pencil.line"
        case .c1C2Harms: return "link"
        case .acdfCervical: return "figure.walk"
        case .lumbarTLIF: return "lines.measurement.horizontal"
        case .radiographicBrainT2: return "circle.grid.cross"
        }
    }
    
    public var callouts: [SurgicalCallout] {
        switch self {
        case .aneurysmClipping:
            return [
                SurgicalCallout(
                    id: "aneurysm_sac",
                    title: "Aneurysm Dome & Neck",
                    structureType: "VASCULAR LESION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.50,
                    normalizedY: 0.44,
                    description: "Aneurysm sac at arterial bifurcation. Permanent Yasargil clip must seat precisely across neck without residual dog-ear or parent artery compromise.",
                    surgicalPearl: "Always achieve 360-degree proximal and distal parent artery visualization before attempting clip application."
                ),
                SurgicalCallout(
                    id: "aneurysm_clip",
                    title: "Yasargil Micro-Clip",
                    structureType: "SURGICAL IMPLANT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.54,
                    normalizedY: 0.36,
                    description: "Titanium aneurysm clip applied across aneurysm neck parallel to the parent arterial axis.",
                    surgicalPearl: "Verify absence of parent artery stenosis and complete obliteration using micro-Doppler or indocyanine green (ICG) angiography."
                ),
                SurgicalCallout(
                    id: "aneurysm_ica",
                    title: "ICA Bifurcation & A1/M1",
                    structureType: "PARENT ARTERIAL TRUNK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.48,
                    normalizedY: 0.62,
                    description: "Terminal internal carotid bifurcating into anterior cerebral (A1) and middle cerebral (M1) arteries.",
                    surgicalPearl: "Keep temporary clip readily available. Limit warm brain ischemia to under 10 minutes under burst suppression / neuroprotection."
                ),
                SurgicalCallout(
                    id: "aneurysm_cn2",
                    title: "Optic Nerve (CN II)",
                    structureType: "CRANIAL NERVE",
                    color: ObsidianTheme.textPrimary,
                    normalizedX: 0.38,
                    normalizedY: 0.52,
                    description: "Courses medial to carotid bifurcation. Opticocarotid triangle provides the classic window to precommunicating A1.",
                    surgicalPearl: "Avoid aggressive retraction against optic nerve; gentle CSF drainage from optico-carotid cistern relaxes the nerve."
                )
            ]
        case .pterional:
            return [
                SurgicalCallout(
                    id: "pt_frontal_bone",
                    title: "Frontal Bone Craniotomy Window",
                    structureType: "OSTEOTOMY EXTENSION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.65,
                    normalizedY: 0.28,
                    description: "Rhoton's frontotemporosphenoidal trephination: Extensive frontal bone removal across superior orbital rim provides an unobstructed subfrontal corridor.",
                    surgicalPearl: "Carry the anterior bone cut to unroof the orbit and drill the sphenoid ridge down to the meningo-orbital band to minimize brain retraction."
                ),
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
                )
            ]
        case .orbitozygomatic:
            return [
                SurgicalCallout(
                    id: "oz_rim",
                    title: "Orbitozygomatic Osteotomy",
                    structureType: "SKULL BASE OSTEOTOMY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.72,
                    normalizedY: 0.32,
                    description: "Two-piece osteotomy mobilizing superior and lateral orbital rim plus zygomatic arch downward.",
                    surgicalPearl: "Provides flush subfrontal and transsylvian trajectory to basilar apex and high carotid bifurcation with minimal brain retraction."
                ),
                SurgicalCallout(
                    id: "oz_basilar",
                    title: "Basilar Apex & P1 Branches",
                    structureType: "POSTERIOR CIRCULATION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.48,
                    normalizedY: 0.40,
                    description: "Basilar artery bifurcation situated between cerebral peduncles, supplying posterior cerebral (P1) and superior cerebellar (SCA) arteries.",
                    surgicalPearl: "Preserve posterior thalamoperforating vessels springing from posterior wall of basilar tip; avulsion causes coma."
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
                )
            ]
        case .farLateral:
            return [
                SurgicalCallout(
                    id: "fl_v3_va",
                    title: "Vertebral Artery (V3/V4)",
                    structureType: "VASCULAR TRUNK",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.42,
                    normalizedY: 0.46,
                    description: "Suboccipital horizontal V3 segment mobilized from C1 groove, piercing dura at dural ring to become intradural V4.",
                    surgicalPearl: "Subperiosteal dissection of V3 from sulcus arteriosus of atlas prevents severe arterial laceration and pseudoaneurysm."
                ),
                SurgicalCallout(
                    id: "fl_pica",
                    title: "PICA & Medulla",
                    structureType: "PERFORATING ARTERY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.66,
                    normalizedY: 0.64,
                    description: "Posterior inferior cerebellar artery emerging from V4, looping between hypoglossal rootlets.",
                    surgicalPearl: "Preserve PICA perforators to lateral medulla; occlusion precipitates Wallenberg lateral medullary syndrome."
                )
            ]
        case .endonasalSellar:
            return [
                SurgicalCallout(
                    id: "ee_sellar",
                    title: "Sellar Floor & Pituitary",
                    structureType: "SURGICAL TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Sphenoid sinus wide opening, anterior sellar wall bone removed and dura opened to access adenoma.",
                    surgicalPearl: "Distinguish normal anterior gland (yellow-orange, firm) from adenoma (grayish, friable, non-organized)."
                ),
                SurgicalCallout(
                    id: "ee_carotid",
                    title: "Carotid Protuberances & OCR",
                    structureType: "CRITICAL ARTERIAL BOUNDARY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.28,
                    normalizedY: 0.46,
                    description: "Cavernous/paraclival internal carotid artery impressions and medial optico-carotid recess (mOCR).",
                    surgicalPearl: "Never drill lateral to medial optico-carotid recess; cavernous ICA injury in endoscopic cavity is catastrophic."
                )
            ]
        case .suboccipitalChiari:
            return [
                SurgicalCallout(
                    id: "so_c1_lam",
                    title: "C1 Posterior Arch Complete Resection",
                    structureType: "LAMINECTOMY MARGINS",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.72,
                    description: "The C1 posterior arch bone has been completely resected (C1 laminectomy), removing bony constriction and allowing decompression of the descending tonsils and cervicomedullary junction.",
                    surgicalPearl: "Ensure lateral decompression of C1 arch spans 15-18 mm total to prevent residual ring impingement on the dura while staying medial to the vertebral artery grooves."
                ),
                SurgicalCallout(
                    id: "so_tonsils",
                    title: "Ectopic Cerebellar Tonsils",
                    structureType: "PATHOLOGY / HERNIATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.58,
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
                    id: "tr_frontal_bone",
                    title: "Frontal Bone Decompressive Extension",
                    structureType: "EXTENSIVE BONE REMOVAL",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.68,
                    normalizedY: 0.22,
                    description: "The anterior bone cut MUST carry aggressively across the frontal bone (frontal boss) to within 2-3 cm of midline, preventing frontal lobe mushrooming.",
                    surgicalPearl: "A decompressive hemicraniectomy must measure at least 12x15 cm; inadequate frontal bone removal causes severe subfalcine and frontal contusional incarceration."
                ),
                SurgicalCallout(
                    id: "tr_middle_fossa",
                    title: "Middle Fossa Floor Flattening",
                    structureType: "BONE DECOMPRESSION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.45,
                    normalizedY: 0.65,
                    description: "Squamous temporal bone rongeured completely flush with middle cranial fossa floor.",
                    surgicalPearl: "Flush temporal floor decompression directly relieves uncal pressure on the brainstem and tentorial incisura."
                ),
                SurgicalCallout(
                    id: "tr_mma",
                    title: "Middle Meningeal Artery & Dural Hitching",
                    structureType: "HEMOSTASIS & RETENTION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.58,
                    normalizedY: 0.35,
                    description: "Arborizes on the outer dural surface across the frontoparietal vault.",
                    surgicalPearl: "Place peripheral dural hitching sutures every 2 cm along the entire bone margin to prevent epidural hematoma accumulation."
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
        case .c1C2Harms:
            return [
                SurgicalCallout(
                    id: "harms_va_outside",
                    title: "Vertebral Artery (V3 Segment)",
                    structureType: "EXTRA-CANAL ARTERIAL ANATOMY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.24,
                    normalizedY: 0.28,
                    description: "The vertebral artery ascends laterally through C2 and C1 foramina transversaria strictly OUTSIDE the neural canal, then loops into the sulcus arteriosus on the superior surface of C1 posterior arch before piercing the atlanto-occipital membrane.",
                    surgicalPearl: "Never dissect laterally on the superior surface of the C1 arch beyond 12 mm from midline; stay on the inferior border to protect the vertebral artery."
                ),
                SurgicalCallout(
                    id: "harms_c1_mass",
                    title: "C1 Lateral Mass Screws",
                    structureType: "ATLANTOAXIAL IMPLANT",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.34,
                    normalizedY: 0.38,
                    description: "Entry at junction of C1 posterior arch and lateral mass midpoint, angled 10-15° medial toward anterior tubercle.",
                    surgicalPearl: "Avoid cephalad angulation which risks penetrating atlanto-occipital joint or occipital condyle."
                ),
                SurgicalCallout(
                    id: "harms_c2_pedicle",
                    title: "C2 Pedicle / Pars Screws",
                    structureType: "AXIS IMPLANT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.66,
                    normalizedY: 0.62,
                    description: "Entry at superior-medial quadrant of C2 lamina, angled 20-30° medial and 20-30° cephalad.",
                    surgicalPearl: "Preoperative CTA is mandatory to rule out high-riding transverse foramen (vertebral artery high riding)."
                )
            ]
        case .acdfCervical:
            return [
                SurgicalCallout(
                    id: "acdf_disc",
                    title: "C5-C6 Intervertebral Disc Space",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.49,
                    description: "Target disc space evacuated down to posterior longitudinal ligament (PLL). Cartilaginous endplates prepared with ring curettes to bleeding bone.",
                    surgicalPearl: "Resect PLL to visualize dura and bilateral exiting nerve roots before interbody cage placement."
                ),
                SurgicalCallout(
                    id: "acdf_pll",
                    title: "Posterior Longitudinal Ligament (PLL) & Dura",
                    structureType: "DECOMPRESSION TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.50,
                    normalizedY: 0.52,
                    description: "Complete transverse resection of the PLL exposes pristine thecal sac and bilateral C6 neural foramina.",
                    surgicalPearl: "A blunt hook must confirm free passage of nerve hooks into bilateral C6 neuroforamina without residual osteophytic ridge."
                ),
                SurgicalCallout(
                    id: "acdf_uncinates",
                    title: "Uncinate Processes & Lateral Margin",
                    structureType: "CRITICAL BOUNDARY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.48,
                    description: "Bilateral uncinate processes mark the absolute lateral boundary of safe disc decompression (15-18 mm total width).",
                    surgicalPearl: "Never drill or curette lateral to the uncinate process; the vertebral artery in the foramen transversarium lies immediately lateral."
                )
            ]
        case .lumbarTLIF:
            return [
                SurgicalCallout(
                    id: "tlif_corridor",
                    title: "Unilateral Facetectomy Corridor (Kambin's Triangle)",
                    structureType: "SURGICAL APERTURE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.64,
                    normalizedY: 0.50,
                    description: "Complete unilateral facetectomy (inferior and superior articular processes resected) opens Kambin's safe surgical triangle.",
                    surgicalPearl: "Bipolar coagulation of the epidural venous plexus prior to anulotomy prevents brisk venous bleeding into the interspace."
                ),
                SurgicalCallout(
                    id: "tlif_exiting",
                    title: "Exiting L4 Nerve Root",
                    structureType: "SUPERIOR NEURAL BORDER",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.62,
                    normalizedY: 0.36,
                    description: "Exits anterolaterally beneath the L4 pedicle, defining the cephalad border of Kambin's triangle.",
                    surgicalPearl: "Avoid excessive cephalad retraction or high cage placement which directly impinges the dorsal root ganglion of L4."
                ),
                SurgicalCallout(
                    id: "tlif_traversing",
                    title: "Traversing L5 Root (Medially Retracted)",
                    structureType: "MEDIAL NEURAL BORDER",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.56,
                    normalizedY: 0.54,
                    description: "Traversing root mobilized and protected medially across midline using a smooth nerve root retractor blade.",
                    surgicalPearl: "Never retract traversing thecal sac beyond midline; keep retractor tension intermittent to prevent root neuropraxia."
                ),
                SurgicalCallout(
                    id: "tlif_cage",
                    title: "TLIF Interbody Cage & Graft Window",
                    structureType: "FUSION CONSTRUCT",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.64,
                    normalizedY: 0.49,
                    description: "Bulleted PEEK/Titanium interbody cage packed with autograft placed obliquely across anterior third of disc space.",
                    surgicalPearl: "Crossing the anterior midline restores lumbar lordosis and achieves 360-degree load-bearing fusion."
                )
            ]
        case .radiographicBrainT2:
            return [
                SurgicalCallout(
                    id: "mri_central_sulcus",
                    title: "Central Sulcus (Rolandic Fissure)",
                    structureType: "PRIMARY ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.52,
                    normalizedY: 0.48,
                    description: "Axial T2 MRI identifying the Central Sulcus dividing frontal motor cortex from parietal sensory cortex.",
                    surgicalPearl: "Use the 'pars marginalis' sign (the ascending branch of cingulate sulcus immediately posterior to central sulcus) to confirm location with 100% fidelity."
                ),
                SurgicalCallout(
                    id: "mri_motor_strip",
                    title: "Precentral Gyrus (Motor Strip - BA 4)",
                    structureType: "PRIMARY MOTOR CORTEX",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.42,
                    normalizedY: 0.42,
                    description: "Primary motor strip lying anterior to the central sulcus, thicker than sensory cortex (up to 4.5 mm).",
                    surgicalPearl: "Identify the 'Hand Knob' (inverted omega sign) in the motor strip, which localizes contralateral hand and finger motor control."
                ),
                SurgicalCallout(
                    id: "mri_sensory_strip",
                    title: "Postcentral Gyrus (Sensory Strip - BA 3,1,2)",
                    structureType: "PRIMARY SOMATOSENSORY CORTEX",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.58,
                    normalizedY: 0.56,
                    description: "Primary somatosensory strip lying immediately posterior to central sulcus in parietal lobe.",
                    surgicalPearl: "Intraoperative phase reversal somatosensory evoked potentials (SSEPs) across central sulcus identify boundary."
                )
            ]
        }
    }
    
    public var steps: [ApproachSequentialStep] {
        switch self {
        case .aneurysmClipping:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Pterional / OZ Craniotomy & Proximal Control", detail: "Reflect scalp, perform craniotomy, flatten sphenoid ridge. Open carotid cistern early for proximal ICA control."),
                ApproachSequentialStep(stepNumber: 2, title: "Sylvian Fissure Dissection", detail: "Sharply unroof Sylvian fissure distal-to-proximal, releasing frontal from temporal operculum without brain retractors."),
                ApproachSequentialStep(stepNumber: 3, title: "Dissect Parent Vessels & Neck Circumference", detail: "Expose parent trunk and outflow branches. Dissect aneurysm neck 360 degrees, identifying perforators on back wall."),
                ApproachSequentialStep(stepNumber: 4, title: "Clip Application & ICG Validation", detail: "Apply permanent Yasargil clip across neck. Confirm parent vessel patency and complete dome occlusion via micro-Doppler or ICG.")
            ]
        case .pterional:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Scalp Flap & Frontal Bone Exposure", detail: "Reflect scalp flap anteriorly. Dissect interfascial plane over temporalis to preserve frontalis branch of CN VII."),
                ApproachSequentialStep(stepNumber: 2, title: "Frontotemporosphenoidal Craniotomy", detail: "Include extensive frontal bone across superior orbital rim and keyhole. Flatten sphenoid ridge down to meningo-orbital band."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & CSF Release", detail: "Open dura in curvilinear C-shape facing sphenoid ridge. Open optico-carotid cistern early to slacken brain."),
                ApproachSequentialStep(stepNumber: 4, title: "Sylvian Fissure Dissection", detail: "Sharply open arachnoid from distal to proximal, mobilizing frontal lobe away from temporal lobe.")
            ]
        case .orbitozygomatic:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Two-Piece Osteotomy", detail: "Execute frontotemporal craniotomy followed by orbital rim and zygomatic arch cuts; mobilize bone flap."),
                ApproachSequentialStep(stepNumber: 2, title: "Orbital Flattening & Extradural Exposure", detail: "Drill orbital roof and sphenoid ridge completely flat down to superior orbital fissure while preserving periorbita."),
                ApproachSequentialStep(stepNumber: 3, title: "Subfrontal / Transsylvian Dural Opening", detail: "Open dura along orbital margin; drain basal cisterns (carotid, chiasmatic) to achieve brain relaxation."),
                ApproachSequentialStep(stepNumber: 4, title: "Basilar Apex & Interpeduncular Access", detail: "Advance between optic nerve and carotid or through carotid-oculomotor window to reach high basilar bifurcation.")
            ]
        case .retrosigmoid:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retromastoid Incision", detail: "Curvilinear incision 2 cm posterior to mastoid groove. Strip suboccipital musculature subperiosteally."),
                ApproachSequentialStep(stepNumber: 2, title: "Asterion Craniectomy", detail: "Burr hole inferomedial to asterion. Unroof transverse and sigmoid sinus edges with Kerrison rongeurs."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Flap & Cisterna Magna Release", detail: "Open dura with base on sigmoid sinus. Aspirate cisterna magna CSF to relax cerebellum completely."),
                ApproachSequentialStep(stepNumber: 4, title: "CPA Inspection", detail: "Place gentle cerebellar retractor. Identify acousticofacial bundle, AICA loop, and petrosal vein.")
            ]
        case .farLateral:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Hockey-Stick / Inverted L Incision", detail: "Midline incision curving laterally past mastoid tip. Subperiosteally dissect suboccipital musculature."),
                ApproachSequentialStep(stepNumber: 2, title: "Suboccipital Craniectomy & C1 Hemilaminectomy", detail: "Perform lateral suboccipital craniectomy, unroof sigmoid sinus to jugular bulb, resect C1 posterior arch."),
                ApproachSequentialStep(stepNumber: 3, title: "Vertebral Artery V3 Mobilization & Condylectomy", detail: "Dissect V3 segment from C1 groove. Drill posterior 1/3 of occipital condyle under microscope."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Opening & Premedullary Exposure", detail: "Incise dura medially around dural ring. Access anterior lower brainstem, PICA, and vertebrobasilar junction.")
            ]
        case .endonasalSellar:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Nasal Stage & Binostril Access", detail: "Decongest nasal cavity, lateralize middle turbinates, harvest vascularized nasoseptal flap if high CSF leak risk."),
                ApproachSequentialStep(stepNumber: 2, title: "Sphenoidotomy & Mucosal Stripping", detail: "Identify sphenoid ostia, widely open anterior sphenoid wall, identify sellar floor, clival recess, and carotid prominences."),
                ApproachSequentialStep(stepNumber: 3, title: "Sellar Dural Opening & Tumor Resection", detail: "Thin sellar bone with micro-drill, unroof floor, cruciate dural opening, deliver pituitary adenoma using ring curettes."),
                ApproachSequentialStep(stepNumber: 4, title: "Multilayer Reconstruction", detail: "Inspect diaphragma sellae for CSF leaks. Reconstruct skull base with collagen sponge, fat graft, and nasoseptal flap.")
            ]
        case .suboccipitalChiari:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Suboccipital Exposure", detail: "Linear midline incision from inion to C2 spinous process. Expose foramen magnum and C1 posterior arch."),
                ApproachSequentialStep(stepNumber: 2, title: "Suboccipital Craniectomy & Complete C1 Laminectomy", detail: "Perform 3x3 cm suboccipital craniectomy unroofing foramen magnum rim and completely resecting C1 posterior arch."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & Arachnoid Preservation", detail: "Y-shaped dural incision. Inspect tonsillar descent and fourth ventricular outlet (obex)."),
                ApproachSequentialStep(stepNumber: 4, title: "Expansile Duraplasty", detail: "Suture collagen or pericranial patch graft to expand posterior fossa CSF reservoir.")
            ]
        case .traumaHemicraniectomy:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Large Question-Mark Incision", detail: "Begin 1 cm anterior to tragus at zygoma, arch superiorly and posteriorly around ear, curving across midline frontal boss."),
                ApproachSequentialStep(stepNumber: 2, title: "12x15 cm Craniectomy with Extensive Frontal Cut", detail: "Elevate massive bone flap extending aggressively across frontal bone to within 2-3 cm of midline sagittal sinus."),
                ApproachSequentialStep(stepNumber: 3, title: "Flush Temporal Fossa Decompression", detail: "Rongeur temporal bone flush with middle cranial fossa floor to relieve uncal brainstem herniation."),
                ApproachSequentialStep(stepNumber: 4, title: "Expansile Duraplasty & Peripheral Hitching", detail: "Stellate dural incision with onlay duraplasty; place peripheral dural hitching sutures to prevent epidural hematoma.")
            ]
        case .kocherEVD:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Anatomical Landmarks", detail: "Measure 11 cm posterior from nasion and 3 cm lateral from midline along pupillary line."),
                ApproachSequentialStep(stepNumber: 2, title: "Trephination & Dura Incision", detail: "Linear scalp stab, drill bone perpendicular to calvaria, cauterize and punctate dura."),
                ApproachSequentialStep(stepNumber: 3, title: "Cannulation Trajectory", detail: "Aim toward medial canthus in coronal plane and tragus in sagittal plane."),
                ApproachSequentialStep(stepNumber: 4, title: "Confirmation of CSF", detail: "Enter frontal horn at 5.5 to 6.5 cm; remove stylet, observe spontaneous CSF pulsation, secure.")
            ]
        case .c1C2Harms:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Exposure & Lateral VA Awareness", detail: "Expose C1 posterior arch and C2 lamina. The vertebral artery runs outside the neural canal in foramen transversarium and loops into C1 superior sulcus."),
                ApproachSequentialStep(stepNumber: 2, title: "C2 Nerve Root Mobilization", detail: "Mobilize C2 nerve root inferiorly; coagulate venous plexus to expose C1 lateral mass entry point below arch."),
                ApproachSequentialStep(stepNumber: 3, title: "C1 Lateral Mass Screw Insertion", detail: "Entry point at inferior edge of C1 arch, trajectory 10-15° medial toward anterior arch tubercle; bicortical purchase."),
                ApproachSequentialStep(stepNumber: 4, title: "C2 Pedicle Screw Insertion & Fixation", detail: "Angled 20-30° medial and cephalad through C2 pedicle axis; connect with titanium rods and crosslink.")
            ]
        case .acdfCervical:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Smith-Robinson Midline Exposure", detail: "Dissect plane between carotid sheath and trachea/esophagus; expose longus colli muscles and midline disc space."),
                ApproachSequentialStep(stepNumber: 2, title: "Longus Colli Mobilization & Annulotomy", detail: "Elevate medial longus colli bilaterally; perform complete transverse annulotomy between uncinate processes."),
                ApproachSequentialStep(stepNumber: 3, title: "Complete Discectomy & PLL Resection", detail: "Evacuate disc down to posterior longitudinal ligament; resect PLL to decompress thecal sac and bilateral C6 roots."),
                ApproachSequentialStep(stepNumber: 4, title: "Interbody Cage & Anterior Plate", detail: "Insert lordotic interbody cage packed with autograft; secure anterior cervical plate flush with vertebral bodies.")
            ]
        case .lumbarTLIF:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Muscle Stripping", detail: "Expose spinous processes, lamina, and facet joints bilaterally at target segment."),
                ApproachSequentialStep(stepNumber: 2, title: "Unilateral Complete Facetectomy (Kambin's Triangle)", detail: "Resect inferior and superior articular processes to expose Kambin's safe surgical corridor."),
                ApproachSequentialStep(stepNumber: 3, title: "Traversing Root Retraction & Annulotomy", detail: "Gently mobilize traversing nerve root medially. Incise disc annulus in safe triangle."),
                ApproachSequentialStep(stepNumber: 4, title: "Interbody Cage Delivery & Compression", detail: "Deliver bulleted TLIF spacer into anterior third of disc space with autograft; lock screws under compression.")
            ]
        case .radiographicBrainT2:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Locate Pars Marginalis & Bracket Sign", detail: "Identify ascending branch of cingulate sulcus; the sulcus immediately anterior is the Central Sulcus."),
                ApproachSequentialStep(stepNumber: 2, title: "Identify Precentral Gyrus Motor Strip", detail: "Confirm motor strip thickness and evaluate inverted omega 'Hand Knob' in middle third of precentral gyrus."),
                ApproachSequentialStep(stepNumber: 3, title: "Identify Postcentral Gyrus Sensory Strip", detail: "Confirm primary sensory strip running parallel and posterior to the central sulcus."),
                ApproachSequentialStep(stepNumber: 4, title: "Surgical Corridor Planning", detail: "Ensure planned corticectomy or trans-sulcal approach avoids primary motor cortex (BA 4) and pyramidal tract.")
            ]
        }
    }
    
    public var catastrophicHazards: [String] {
        switch self {
        case .aneurysmClipping:
            return [
                "Premature intraoperative aneurysm rupture prior to gaining proximal vascular control",
                "Inadvertent occlusion of critical branching perforators (e.g. Heubner's artery or anterior choroidal artery)",
                "Residual aneurysm neck dog-ear resulting in catastrophic delayed subarachnoid hemorrhage rebleed"
            ]
        case .pterional:
            return [
                "Inadequate frontal bone removal causing excessive brain retraction and contusion",
                "Frontalis branch facial nerve transection if failing to execute interfascial temporalis dissection",
                "Middle meningeal artery trunk avulsion with uncontrollable epidural bleeding under sphenoid ridge"
            ]
        case .orbitozygomatic:
            return [
                "Perforator avulsion from posterior basilar apex causing irreversible brainstem stroke",
                "Inadvertent optic nerve injury during anterior clinoidectomy or orbital unroofing",
                "Enophthalmos or diplopia from improper anatomical reconstruction of orbital rim osteotomy"
            ]
        case .retrosigmoid:
            return [
                "Sigmoid sinus or transverse sinus laceration during high-speed craniectomy drilling",
                "Avulsion of petrosal vein of Dandy precipitating life-threatening cerebellar hemorrhagic venous infarction",
                "Excessive stretch or thermal coagulation near CN VII/VIII causing permanent facial palsy or deafness"
            ]
        case .farLateral:
            return [
                "Vertebral artery V3/V4 laceration or thrombosis from traction or aggressive mobilization",
                "Occipital condyle hyper-resection (>50%) causing craniocervical junction instability",
                "Hypoglossal (CN XII) nerve rootlet transection causing permanent ipsilateral tongue paralysis and airway compromise"
            ]
        case .endonasalSellar:
            return [
                "Internal carotid artery laceration at carotid protuberance / siphon with massive exsanguination",
                "High-flow CSF leak and pneumocephalus through violated diaphragma sellae",
                "Postoperative pituitary apoplexy or central diabetes insipidus from infundibular disruption"
            ]
        case .suboccipitalChiari:
            return [
                "Vertebral artery V3 loop laceration at lateral groove of C1 posterior arch",
                "Pseudomeningocele or CSF leak from inadequate watertight duraplasty seal"
            ]
        case .traumaHemicraniectomy:
            return [
                "Inadequate frontal bone removal causing frontal lobe strangulation and mushrooming over bone edge",
                "Superior sagittal sinus laceration while taking bone cut too close to midline (<2 cm)",
                "External brain herniation with cortical venous infarction over sharp temporal bone margins"
            ]
        case .kocherEVD:
            return [
                "Advancing catheter beyond 7.0 cm resulting in fatal brainstem or thalamic injury",
                "Trajectory directed too medial crossing septum pellucidum with fornix disruption",
                "Intraventricular hemorrhage from blind laceration of choroid plexus"
            ]
        case .c1C2Harms:
            return [
                "Vertebral artery injury during C2 screw placement in patient with high-riding transverse foramen",
                "Dissecting >12 mm lateral on superior border of C1 arch where vertebral artery loops in sulcus arteriosus",
                "Medial breach of spinal canal resulting in direct spinal cord injury or CSF leak"
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
                "Confusing precentral sulcus with central sulcus resulting in iatrogenic primary motor cortex resection",
                "Overlooking the hand knob inverted omega sign during parasagittal tumor resection"
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
