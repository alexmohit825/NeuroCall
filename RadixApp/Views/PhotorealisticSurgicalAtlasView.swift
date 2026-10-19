import SwiftUI

// MARK: - Studio-Grade Photorealistic Surgical Atlas Suite (Option C)
// Featuring Authentic High-Definition Medical Artwork Plates & Operative Skull Base Corridors
// Synthesized from Albert Rhoton Jr. Cranial Anatomy and Operative Corridors.
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
    case retrosigmoid = "retrosigmoid"
    case endonasalSellar = "endonasal_sellar"
    case farLateral = "far_lateral"
    case hemicraniectomy = "hemicraniectomy"
    case kochersEVD = "kochers_evd"
    case acdf = "acdf"
    case orbitozygomatic = "orbitozygomatic"
    case tlif = "tlif"
    case chiariDecompression = "chiari_decompression"
    case harmsC1C2 = "harms_c1_c2"
    case csdhBurrHole = "csdh_burr_hole"
    
    public var assetImageName: String? {
        switch self {
        case .aneurysmClipping: return "plate_aneurysm"
        case .pterional: return "plate_pterional"
        case .retrosigmoid: return "plate_retrosigmoid"
        case .endonasalSellar: return "plate_endonasal_sellar"
        case .farLateral: return "plate_far_lateral"
        case .hemicraniectomy: return "plate_hemicraniectomy"
        case .kochersEVD: return "plate_kochers_evd"
        case .acdf: return "plate_acdf"
        case .orbitozygomatic: return "plate_orbitozygomatic"
        case .tlif: return "plate_tlif"
        case .chiariDecompression: return "plate_chiari_decompression"
        case .harmsC1C2: return "plate_harms_c1_c2"
        case .csdhBurrHole: return "plate_csdh_burr_hole"
        }
    }
    
    public var shortTitle: String {
        switch self {
        case .aneurysmClipping: return "Aneurysm Clip"
        case .pterional: return "Pterional"
        case .retrosigmoid: return "Retrosigmoid"
        case .endonasalSellar: return "Endonasal Sellar"
        case .farLateral: return "Far-Lateral"
        case .hemicraniectomy: return "Hemicraniectomy"
        case .kochersEVD: return "Kocher's EVD"
        case .acdf: return "ACDF"
        case .orbitozygomatic: return "FT-OZ"
        case .tlif: return "L4-5 TLIF"
        case .chiariDecompression: return "Chiari I"
        case .harmsC1C2: return "Goel-Harms"
        case .csdhBurrHole: return "Chronic SDH"
        }
    }
    
    public var title: String {
        switch self {
        case .aneurysmClipping: return "Anterior Circulation Aneurysm Clipping"
        case .pterional: return "Pterional Frontotemporosphenoidal Corridor"
        case .retrosigmoid: return "Retrosigmoid CPA Dissection"
        case .endonasalSellar: return "Endoscopic Endonasal Sellar Corridor"
        case .farLateral: return "Far-Lateral Suboccipital Transcondylar Approach"
        case .hemicraniectomy: return "Decompressive Hemicraniectomy & Duroplasty"
        case .kochersEVD: return "Kocher's Point Ventriculostomy & EVD"
        case .acdf: return "Anterior Cervical Discectomy & Fusion (ACDF)"
        case .orbitozygomatic: return "Frontotemporal Orbitozygomatic Approach (FT-OZ)"
        case .tlif: return "L4–L5 Transforaminal Lumbar Interbody Fusion (TLIF)"
        case .chiariDecompression: return "Chiari I Malformation Decompression & Duraplasty"
        case .harmsC1C2: return "Posterior C1–C2 Fixation (Goel-Harms Construct)"
        case .csdhBurrHole: return "Chronic Subdural Hematoma: Diagnostic CT & Burr Hole Evacuation"
        }
    }
    
    public var iconName: String {
        switch self {
        case .aneurysmClipping: return "bolt.horizontal.fill"
        case .pterional: return "brain.head.profile"
        case .retrosigmoid: return "ear"
        case .endonasalSellar: return "mouth"
        case .farLateral: return "arrow.triangle.turn.up.right.diamond.fill"
        case .hemicraniectomy: return "shield.slash.fill"
        case .kochersEVD: return "target"
        case .acdf: return "waveform.path.ecg"
        case .orbitozygomatic: return "eye.circle.fill"
        case .tlif: return "figure.walk"
        case .chiariDecompression: return "cross.fill"
        case .harmsC1C2: return "link"
        case .csdhBurrHole: return "drop.fill"
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
        case .harmsC1C2:
            return [
                SurgicalCallout(
                    id: "c1_screw",
                    title: "C1 Lateral Mass Screw",
                    structureType: "INSTRUMENTATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.35,
                    normalizedY: 0.38,
                    description: "Polyaxial 3.5 mm titanium screw inserted into midpoint of C1 lateral mass with ~10 deg medial convergence toward anterior C1 tubercle.",
                    surgicalPearl: "Mobilize or bipolar the C2 dorsal nerve root and venous plexus inferiorly to expose C1 lateral mass entry point safely."
                ),
                SurgicalCallout(
                    id: "c2_pedicle",
                    title: "C2 Pedicle Screw",
                    structureType: "INSTRUMENTATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.33,
                    normalizedY: 0.64,
                    description: "Polyaxial 3.5-4.0 mm screw entering superior-medial quadrant of C2 pars/isthmus, angled ~25 deg medially and 25 deg cephalad into C2 body.",
                    surgicalPearl: "High-riding vertebral artery (narrow C2 isthmus height < 5 mm) mandates switching from pedicle screw to C2 pars or laminar screw."
                ),
                SurgicalCallout(
                    id: "harms_rod",
                    title: "Longitudinal Titanium Rod",
                    structureType: "RIGID CONSTRUCT",
                    color: ObsidianTheme.neonMint,
                    normalizedX: 0.30,
                    normalizedY: 0.50,
                    description: "Contoured 3.5 mm titanium longitudinal rod rigidly bridging C1 lateral mass and C2 pedicle tulip heads, locked with threaded set screws.",
                    surgicalPearl: "Provides immediate rigid 3-column biomechanical stabilization, allowing high fusion rates without halo-vest immobilization."
                ),
                SurgicalCallout(
                    id: "v3_artery",
                    title: "V3 Vertebral Artery Loop",
                    structureType: "VASCULAR RISK",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.70,
                    normalizedY: 0.38,
                    description: "Vertebral artery V3 segment looping out of C2 transverse foramen and sweeping across the superior sulcus arteriosus groove on C1 posterior arch.",
                    surgicalPearl: "Drill strictly below the superior border of the C1 arch to prevent catastrophic laceration of the looped V3 vertebral artery."
                ),
                SurgicalCallout(
                    id: "c2_ganglion",
                    title: "C2 Nerve Root & Ganglion",
                    structureType: "NEURAL ELEMENT",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.76,
                    normalizedY: 0.55,
                    description: "Large C2 nerve root and extensive dorsal venous plexus crossing dorsal aspect of C1-C2 atlantoaxial joint space.",
                    surgicalPearl: "Gentle caudal mobilization avoids permanent occipital numbness or dysesthesia; coagulate perivertebral venous plexus with bipolar."
                )
            ]
        case .csdhBurrHole:
            return [
                SurgicalCallout(
                    id: "ct_csdh",
                    title: "Crescentic cSDH & Midline Shift",
                    structureType: "DIAGNOSTIC RADIOLOGY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.28,
                    normalizedY: 0.42,
                    description: "Axial non-contrast CT showing large hypodense (chronic) crescentic subdural fluid collection with subfalcine herniation and ventricular compression.",
                    surgicalPearl: "Internal membrane loculations or hyperdense acute re-bleeding on CT guide operative burr hole placement directly over thickest fluid pocket."
                ),
                SurgicalCallout(
                    id: "burr_hole_opening",
                    title: "14 mm Circular Burr Hole",
                    structureType: "OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.76,
                    normalizedY: 0.42,
                    description: "Neurosurgical circular burr hole (approximately 14 mm) placed over parietal boss / frontal convexity with cut cortical and cancellous diploic margins.",
                    surgicalPearl: "Inspect diploic cancellous marrow for hemostasis with bone wax before incising dura; avoid drilling directly over dural venous sinuses."
                ),
                SurgicalCallout(
                    id: "motor_oil_efflux",
                    title: "Liquefied 'Motor-Oil' Efflux",
                    structureType: "PATHOLOGY EVACUATION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.78,
                    normalizedY: 0.54,
                    description: "Classic dark reddish-black / mahogany liquefied chronic subdural hematoma fluid actively draining under pressure through cruciate durotomy.",
                    surgicalPearl: "Irrigate gently with warm physiological saline until effluent is crystal clear; never allow forceful jet irrigation into fragile brain parenchyma."
                ),
                SurgicalCallout(
                    id: "cruciate_dura",
                    title: "Cruciate Dural Incision",
                    structureType: "DURAL ARCHITECTURE",
                    color: ObsidianTheme.neonMint,
                    normalizedX: 0.74,
                    normalizedY: 0.36,
                    description: "Outer dural leaves coagulated with bipolar and opened in 4-quadrant cruciate pattern with outer neo-membrane unroofed.",
                    surgicalPearl: "Thoroughly bipolar dural edges to inner bone rim; ensure outer membrane is fenestrated so subdural fluid drains freely without valve effect."
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
        case .farLateral:
            return [
                SurgicalCallout(
                    id: "fl_va_mobilized",
                    title: "Mobilized Vertebral Artery (V3)",
                    structureType: "VASCULAR TRUNK MOBILIZATION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.50,
                    normalizedY: 0.62,
                    description: "V3 horizontal segment transposed and mobilized out of the unroofed C1 foramen transversarium with elastic vessel loop, creating an unobstructed corridor along the skull base.",
                    surgicalPearl: "Mobilize subperiosteally to avoid injuring muscular branches or tearing the dense suboccipital venous plexus."
                ),
                SurgicalCallout(
                    id: "fl_c1_mass",
                    title: "C1 Lateral Mass & Unroofed Foramen",
                    structureType: "BONY ANATOMY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.46,
                    description: "Posterior arch of atlas resected, transverse foramen unroofed with diamond burr down to the cancellous marrow.",
                    surgicalPearl: "Drill superior and posterior cortical edges of the foramen transversarium before peeling the fibrous periosteal ring from the artery."
                ),
                SurgicalCallout(
                    id: "fl_c2_edge",
                    title: "Trimmed C2 Superior Edge & Nerve Root",
                    structureType: "NEURAL & FACET MARGIN",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.56,
                    normalizedY: 0.72,
                    description: "C2 superior articular facet crest shaved flat and C2 nerve root passing beneath the transposed vertebral artery loop.",
                    surgicalPearl: "Trimming the superior edge of C2 prevents impingement on the mobilized vertebral artery when displacing it inferiorly."
                ),
                SurgicalCallout(
                    id: "fl_dura",
                    title: "Posterior Fossa Dura",
                    structureType: "DURAL ENVELOPE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.42,
                    normalizedY: 0.32,
                    description: "Suboccipital craniectomy exposing the posterior fossa dura mater down to the foramen magnum rim.",
                    surgicalPearl: "Maintain intact dural cuff around the vertebral artery dural entrance at the foramen magnum until ready for intradural exploration."
                )
            ]
        case .hemicraniectomy:
            return [
                SurgicalCallout(
                    id: "dc_duroplasty",
                    title: "Expansile Patch Duroplasty",
                    structureType: "TENSION-FREE DOME",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.35,
                    description: "Large collagen/pericranial substitute patch sewn with continuous running monofilament suture to create an expansile dome.",
                    surgicalPearl: "Duroplasty must be completely tension-free; tight closure converts a craniectomy into a tourniquet, worsening herniation."
                ),
                SurgicalCallout(
                    id: "dc_edema",
                    title: "Swollen Cerebral Hemisphere",
                    structureType: "HERNIATING BRAIN PARENCHYMA",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.45,
                    normalizedY: 0.45,
                    description: "Ischemic / contused swollen hemisphere with flattened gyri and effaced sulci herniating safely into the expanded dural compartment.",
                    surgicalPearl: "Do not attempt cortical resection unless non-viable, necrotic contusion is actively elevating ICP."
                ),
                SurgicalCallout(
                    id: "dc_mcf_floor",
                    title: "Flush Middle Fossa Floor Decompression",
                    structureType: "CRITICAL SKULL BASE MARGIN",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.65,
                    normalizedY: 0.55,
                    description: "Temporal bone drilled down flush to the middle cranial fossa floor and root of the zygoma.",
                    surgicalPearl: "A residual temporal bone ledge compresses the uncus against the tentorial incisura, defeating the purpose of the craniectomy."
                ),
                SurgicalCallout(
                    id: "dc_tack_ups",
                    title: "Perimeter Dural Tack-Up Sutures",
                    structureType: "HEMOSTATIC ANCHORS",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.30,
                    normalizedY: 0.28,
                    description: "Circumferential dural hitch sutures placed through drill holes along the entire cut bone perimeter.",
                    surgicalPearl: "Meticulous dural hitch sutures are mandatory to eliminate the epidural dead space and prevent fatal postoperative epidural hematomas."
                )
            ]
        case .kochersEVD:
            return [
                SurgicalCallout(
                    id: "evd_kochers_point",
                    title: "Kocher's Point Burr Hole",
                    structureType: "CRANIAL ENTRY SITE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.36,
                    normalizedY: 0.17,
                    description: "Burr hole 11–12 cm posterior to nasion, 1–2 cm anterior to coronal suture, 2.5–3 cm lateral to midline.",
                    surgicalPearl: "Never place burr hole posterior to coronal suture; entry into primary motor cortex causes irreversible contralateral hemiparesis."
                ),
                SurgicalCallout(
                    id: "evd_catheter",
                    title: "Graduated Ventricular Catheter",
                    structureType: "SILICONE DRAIN",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.40,
                    normalizedY: 0.30,
                    description: "Catheter passed strictly perpendicular to calvarium, aimed in sagittal plane toward ipsilateral tragus.",
                    surgicalPearl: "Catheter depth should not exceed 5.5–6.0 cm from outer calvarium; deeper insertion risks basilar or midbrain puncture."
                ),
                SurgicalCallout(
                    id: "evd_monro",
                    title: "Foramen of Monro & Frontal Horn",
                    structureType: "INTRAVENTRICULAR TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.45,
                    normalizedY: 0.40,
                    description: "Fenestrated catheter tip rests in frontal horn at Foramen of Monro anterior to choroid plexus.",
                    surgicalPearl: "Seating tip anterior to choroid plexus prevents catheter fenestration clogging and premature EVD failure."
                ),
                SurgicalCallout(
                    id: "evd_tragus_line",
                    title: "Tragus Trajectory Line",
                    structureType: "ANATOMICAL AIMING AXIS",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.54,
                    normalizedY: 0.62,
                    description: "Dotted aiming axis aligned with external auditory meatus in the lateral sagittal projection.",
                    surgicalPearl: "Keep catheter perpendicular to skull surface; tilting anteriorly risks hitting the skull base and optic apparatus."
                )
            ]
        case .acdf:
            return [
                SurgicalCallout(
                    id: "acdf_plate",
                    title: "Anterior Cervical Locking Plate",
                    structureType: "SURGICAL IMPLANT",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.54,
                    description: "Low-profile titanium locking plate spanning C5 to C6 vertebral bodies. Superior and inferior locking screws enter safely into vertebral bone without violating adjacent disc spaces (C4–C5 and C6–C7).",
                    surgicalPearl: "Plate must be centered flush on anterior cortex. Ensure screws do not violate adjacent unfused discs."
                ),
                SurgicalCallout(
                    id: "acdf_cage",
                    title: "Interbody Cage & Porous Graft",
                    structureType: "FUSION CONSTRUCT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Porous titanium / PEEK interbody spacer packed with cancellous autograft/allograft, providing immediate structural height restoration and parallel distraction.",
                    surgicalPearl: "Prepare endplates carefully with curettes to bleeding bone; avoid puncturing subchondral plate to prevent cage subsidence."
                ),
                SurgicalCallout(
                    id: "acdf_medial_retractor",
                    title: "Medial Retractor (Esophagus & Trachea)",
                    structureType: "SOFT TISSUE RETRACTION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.16,
                    normalizedY: 0.52,
                    description: "Smooth blunt medial retractor blade gently displacing the visceral axis (trachea, esophagus, and recurrent laryngeal nerve) across the midline.",
                    surgicalPearl: "Deflate and periodically release endotracheal tube cuff pressure during retraction to prevent recurrent laryngeal neuropraxia or mucosal ischemia."
                ),
                SurgicalCallout(
                    id: "acdf_lateral_retractor",
                    title: "Lateral Retractor (Carotid Sheath)",
                    structureType: "VASCULAR RETRACTION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.88,
                    normalizedY: 0.52,
                    description: "Lateral retractor blade placed safely beneath longus colli muscle to protect the common carotid artery, internal jugular vein, and vagus nerve.",
                    surgicalPearl: "Always seat lateral blades beneath the elevated longus colli muscle to avoid direct compression or laceration of the carotid sheath."
                )
            ]
        case .orbitozygomatic:
            return [
                SurgicalCallout(
                    id: "oz_crani_flap",
                    title: "Detached Frontotemporal Flap",
                    structureType: "CALVARIAL BONE FLAP",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Free frontotemporal calvarial bone flap resected first, exposing frontal and temporal opercular dura and sphenoid ridge.",
                    surgicalPearl: "Elevate carefully off the underlying dura; peel dura away from the sphenoid ridge to avoid tearing the middle meningeal artery."
                ),
                SurgicalCallout(
                    id: "oz_central_corridor",
                    title: "Subfrontal & Transbasal Corridor",
                    structureType: "SURGICAL EXPOSURE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.45,
                    description: "Central orbital rim and sphenoid ridge exposure. Unroofed orbital roof allows flat, direct transbasal access with minimal frontal lobe retraction.",
                    surgicalPearl: "Drill remaining orbital roof remnants and superior orbital fissure bone flush to maximize the flat skull base line of sight."
                ),
                SurgicalCallout(
                    id: "oz_fragment",
                    title: "Detached Orbitozygomatic Unit",
                    structureType: "OSTEOTOMY FRAGMENT",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.84,
                    normalizedY: 0.48,
                    description: "Detached one-piece orbitozygomatic fragment containing superior orbital rim, orbital roof, zygomatic arch, and lateral orbital wall.",
                    surgicalPearl: "Protect the periorbita meticulously during osteotomies; preserve supraorbital nerve within notch/foramen during rim mobilization."
                ),
                SurgicalCallout(
                    id: "oz_dura",
                    title: "Temporal Opercular Dura",
                    structureType: "DURAL ENVELOPE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.48,
                    normalizedY: 0.60,
                    description: "Exposed temporal dura at middle cranial fossa floor and subfrontal dura visible through the combined osteotomy defect.",
                    surgicalPearl: "Slack the brain early by opening the optico-carotid cistern to allow gentle gravitational brain fall without retractor pressure."
                )
            ]
        case .tlif:
            return [
                SurgicalCallout(
                    id: "tlif_screws",
                    title: "Bilateral Pedicle Screws (L4 & L5)",
                    structureType: "TITANIUM FIXATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.25,
                    normalizedY: 0.35,
                    description: "Four titanium pedicle screws inserted bilaterally into L4 and L5 pedicles, interconnected with contoured longitudinal titanium rods and set screws.",
                    surgicalPearl: "Confirm anatomic mammillary entry point at junction of transverse process and superior articular facet; verify medial angulation and bicortical purchase on fluoroscopy."
                ),
                SurgicalCallout(
                    id: "tlif_corridor",
                    title: "Unilateral Facetectomy Corridor",
                    structureType: "SURGICAL WINDOW",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.72,
                    normalizedY: 0.45,
                    description: "Complete resection of right L4 inferior articular process (IAP) and L5 superior articular process (SAP), opening Kambin's transforaminal corridor.",
                    surgicalPearl: "Resect bone flush with the superior border of the lower pedicle to create a clear, flat trajectory into the disc space."
                ),
                SurgicalCallout(
                    id: "tlif_cage",
                    title: "Porous Titanium TLIF Interbody Spacer",
                    structureType: "INTERBODY IMPLANT",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.62,
                    normalizedY: 0.58,
                    description: "Curved bullet-shaped 3D porous titanium spacer packed with autologous cancellous bone graft, seated stably across the anterior-middle disc space.",
                    surgicalPearl: "Prepare endplates down to bleeding subchondral bone without penetrating cortical endplates to prevent cage subsidence."
                ),
                SurgicalCallout(
                    id: "tlif_nerve_root",
                    title: "Traversing L5 Root & Thecal Sac",
                    structureType: "NEURAL ELEMENTS",
                    color: ObsidianTheme.neonPurple,
                    normalizedX: 0.48,
                    normalizedY: 0.52,
                    description: "Glistening thecal sac and traversing L5 root protected and gently retracted medially with a nerve root retractor during disc clearing and cage insertion.",
                    surgicalPearl: "Never apply prolonged, aggressive medial root traction; relax retractor frequently to avoid ischemic neurapraxia."
                )
            ]
        case .chiariDecompression:
            return [
                SurgicalCallout(
                    id: "chiari_tonsils",
                    title: "Herniated Cerebellar Tonsils",
                    structureType: "HERNIATED NEURAL ELEMENTS",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.25,
                    normalizedY: 0.28,
                    description: "Elongated, peg-like cerebellar tonsils extending caudal to the foramen magnum into the upper cervical canal, compressing the dorsal cervicomedullary junction.",
                    surgicalPearl: "Subpial tonsillar coagulation or aspiration is reserved for refractory compression; primary objective is restoring wide, pulsatile CSF flow across the foramen of Magendie."
                ),
                SurgicalCallout(
                    id: "chiari_dural_opening",
                    title: "Y-Shaped Dural Opening",
                    structureType: "SURGICAL INCISION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.16,
                    normalizedY: 0.22,
                    description: "Curvilinear/Y-shaped posterior fossa dural incision extending across the foramen magnum and C1 posterior arch, exposing the cerebellar vermis, tonsils, and PICA loops.",
                    surgicalPearl: "Carefully identify and divide the tight fibrous constricting dural band at the occipitoatlantal junction prior to dural reflection."
                ),
                SurgicalCallout(
                    id: "chiari_vertebral_artery",
                    title: "V3 Vertebral Artery Loops",
                    structureType: "CRITICAL VASCULAR CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.14,
                    normalizedY: 0.52,
                    description: "V3 segment of vertebral artery coursing laterally out of C2 transverse foramen, sweeping across C1 lateral mass sulcus arteriosus before piercing the atlanto-occipital membrane.",
                    surgicalPearl: "Keep suboccipital and C1 laminectomy strictly within the medial 1.5 cm of midline to maintain a generous safety buffer from the V3 loops."
                ),
                SurgicalCallout(
                    id: "chiari_duraplasty",
                    title: "Expansile Tan Duraplasty Patch",
                    structureType: "EXPANSION RECONSTRUCTION",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.74,
                    normalizedY: 0.35,
                    description: "Watertight expansile duraplasty using a tapered tan pericardial/collagen patch graft, broad superiorly and tapering over the C1 canal, secured with running monofilament sutures.",
                    surgicalPearl: "Ensure watertight running closure tested under Valsalva to 30 cm H2O to prevent postoperative pseudomeningocele or CSF fistulae."
                )
            ]
        case .harmsC1C2:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Craniocervical Exposure", detail: "Prone positioning in Mayfield pins with military tuck. Midline incision from inion to C3; subperiosteal exposure of C1 arch and C2 bifid spine."),
                ApproachSequentialStep(stepNumber: 2, title: "C1 Lateral Mass Screw Placement", detail: "Mobilize C2 nerve root caudally. Entry point at midpoint of C1 lateral mass (inferior border of C1 arch), trajectory 10 deg medial convergence toward anterior tubercle."),
                ApproachSequentialStep(stepNumber: 3, title: "C2 Pedicle / Pars Screw Placement", detail: "Expose superior-medial C2 pars. Entry in cranial-medial quadrant of C2 isthmus, trajectory 25 deg medial and 25 deg cephalad into C2 vertebral body."),
                ApproachSequentialStep(stepNumber: 4, title: "Rod Contouring & Posterior Fusion", detail: "Contour 3.5 mm titanium rods, lock set screws, decorticate dorsal arches of C1-C2, and pack autologous or demineralized bone matrix for solid arthrodesis.")
            ]
        case .csdhBurrHole:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Localization & Scalp Incision", detail: "Position supine with head turned. Correlate with CT maximum thickness; make a 3 cm linear scalp incision over parietal boss or pre-coronal frontal convexity."),
                ApproachSequentialStep(stepNumber: 2, title: "14 mm Burr Hole Craniostomy", detail: "Perforate skull with high-speed cranial perforator. Ensure outer table, cancellous diploic marrow, and inner cortical plate are cleanly unroofed."),
                ApproachSequentialStep(stepNumber: 3, title: "Cruciate Durotomy & Evacuation", detail: "Bipolar outer dura and incise in cruciate fashion. Open outer subdural pseudomembrane to trigger spontaneous dark liquefied 'motor-oil' hematoma evacuation."),
                ApproachSequentialStep(stepNumber: 4, title: "Saline Irrigation & Subdural Drain", detail: "Irrigate subdural space copiously with warm saline via soft catheter until effluent is clear. Pass clear silicone closed-system drain to gravity and close in layers.")
            ]
        }
    }
    
    public var steps: [ApproachSequentialStep] {
        switch self {
        case .aneurysmClipping:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Pterional Craniotomy & Proximal Control", detail: "Reflect scalp, perform craniotomy, flatten sphenoid ridge. Open carotid cistern early for proximal ICA control."),
                ApproachSequentialStep(stepNumber: 2, title: "Sylvian Fissure Dissection", detail: "Sharply unroof Sylvian fissure distal-to-proximal, releasing frontal from temporal operculum without brain retractors."),
                ApproachSequentialStep(stepNumber: 3, title: "Dissect Parent Vessels & Neck Circumference", detail: "Expose parent trunk and outflow branches. Dissect aneurysm neck 360 degrees, identifying perforators on back wall."),
                ApproachSequentialStep(stepNumber: 4, title: "Clip Application & Flow Validation", detail: "Apply permanent Yasargil clip across neck. Confirm parent vessel patency and complete dome occlusion via micro-Doppler or ICG.")
            ]
        case .pterional:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Scalp Flap & Frontal Bone Exposure", detail: "Reflect scalp flap anteriorly. Dissect interfascial plane over temporalis to preserve frontalis branch of CN VII."),
                ApproachSequentialStep(stepNumber: 2, title: "Frontotemporosphenoidal Craniotomy", detail: "Include extensive frontal bone across superior orbital rim and keyhole. Flatten sphenoid ridge down to meningo-orbital band."),
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
        case .endonasalSellar:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Nasal Stage & Binostril Access", detail: "Decongest nasal cavity, lateralize middle turbinates, harvest vascularized nasoseptal flap if high CSF leak risk."),
                ApproachSequentialStep(stepNumber: 2, title: "Sphenoidotomy & Mucosal Stripping", detail: "Identify sphenoid ostia, widely open anterior sphenoid wall, identify sellar floor, clival recess, and carotid prominences."),
                ApproachSequentialStep(stepNumber: 3, title: "Sellar Dural Opening & Tumor Resection", detail: "Thin sellar bone with micro-drill, unroof floor, cruciate dural opening, deliver pituitary adenoma using ring curettes."),
                ApproachSequentialStep(stepNumber: 4, title: "Multilayer Reconstruction", detail: "Inspect diaphragma sellae for CSF leaks. Reconstruct skull base with collagen sponge, fat graft, and nasoseptal flap.")
            ]
        case .farLateral:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Suboccipital Craniectomy & C1 Laminectomy", detail: "Perform retrosigmoid suboccipital craniectomy to foramen magnum rim. Execute lateral C1 hemilaminectomy to expose the transverse process."),
                ApproachSequentialStep(stepNumber: 2, title: "Unroofing Foramen Transversarium", detail: "Use a 2 mm diamond burr under continuous irrigation to thin and remove the posterior and superior bridge of the C1 foramen transversarium."),
                ApproachSequentialStep(stepNumber: 3, title: "Vertebral Artery Mobilization & C2 Trimming", detail: "Sharply release the fibrous dural-periosteal collar, sling the V3 loop with an elastic vessel loop, and shave the superior crest of C2 to mobilize the artery inferiorly."),
                ApproachSequentialStep(stepNumber: 4, title: "Partial Condylectomy & Dural Opening", detail: "Drill posterior 1/3 of the occipital condyle with diamond burr. Open dura in curvilinear fashion along the skull base floor.")
            ]
        case .hemicraniectomy:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Reverse Question-Mark Incision & Flap", detail: "Curvilinear Kempe incision originating at zygomatic arch, curving superiorly 2 cm off midline, and turning down behind ear. Elevate scalp and temporalis muscle."),
                ApproachSequentialStep(stepNumber: 2, title: "Massive Craniectomy (>=12x15 cm)", detail: "Multiple burr holes. Resect bone frontotemporoparietally, extending anterior to frontal pole, superior to sagittal sinus, posterior to parietal boss, and flush to middle fossa floor."),
                ApproachSequentialStep(stepNumber: 3, title: "Circumferential Dural Tack-Up Sutures", detail: "Drill perimeter bone holes at 2 cm intervals and place 4-0 Nurolon dural hitch sutures to obliterate epidural space."),
                ApproachSequentialStep(stepNumber: 4, title: "Stellate Dural Incision & Expansile Duroplasty", detail: "Cruciate or stellate dural incision radiating outward. Sew on-lay or inlay expansile collagen/pericranial patch graft tension-free.")
            ]
        case .kochersEVD:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Calvarial Landmark Measurement", detail: "Measure 11–12 cm posterior to nasion and 2.5–3.0 cm lateral to midline (mid-pupillary line), strictly 1–2 cm anterior to coronal suture."),
                ApproachSequentialStep(stepNumber: 2, title: "Scalp Incision & Cranial Burr Hole", detail: "Make 1.5 cm linear sagittal incision. Drill a single full-thickness burr hole through outer table, diploe, and inner table under saline irrigation."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Puncture & Pial Coagulation", detail: "Cauterize dura with bipolar forceps and perform a cruciate incision. Lightly coagulate the pia to prevent sulcal bleeding."),
                ApproachSequentialStep(stepNumber: 4, title: "Catheter Trajectory & CSF Flow", detail: "Aim toward medial canthus and tragus. Advance catheter perpendicular to calvarium to 5.5–6.0 cm depth. Remove stylet to confirm pulsatile CSF return.")
            ]
        case .acdf:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Smith-Robinson Anterolateral Approach", detail: "Transverse cervical incision in skin crease. Dissect medial to carotid sheath and lateral to visceral column (trachea/esophagus)."),
                ApproachSequentialStep(stepNumber: 2, title: "Complete Discectomy & PLL Decompression", detail: "Perform complete discectomy back to posterior longitudinal ligament (PLL). Open PLL to directly decompress the thecal sac and exit roots."),
                ApproachSequentialStep(stepNumber: 3, title: "Interbody Cage Insertion", detail: "Prepare subchondral endplates without violating cortex. Trial and insert porous cage packed with bone graft into interspace."),
                ApproachSequentialStep(stepNumber: 4, title: "Anterior Plate Fixation", detail: "Position low-profile cervical plate centered on C5–C6. Drill, tap, and lock dual screws into superior and inferior vertebral bodies.")
            ]
        case .orbitozygomatic:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Curvilinear Incision & Facial Nerve Protection", detail: "Modified pterional or bicoronal incision. Perform interfascial or subfascial dissection over zygomatic arch to safeguard the frontalis branch of CN VII."),
                ApproachSequentialStep(stepNumber: 2, title: "Frontotemporal Craniotomy", detail: "Place MacCarty keyhole exposing both frontal dura and periorbita. Complete frontotemporal craniotomy, leaving the orbital rim and zygoma intact initially."),
                ApproachSequentialStep(stepNumber: 3, title: "Orbitozygomatic Osteotomies", detail: "Perform cuts across posterior root of zygomatic arch, zygomaticofacial suture, orbital roof back to inferior orbital fissure, and supraorbital rim."),
                ApproachSequentialStep(stepNumber: 4, title: "Removal of OZ Unit & Skull Base Flattening", detail: "Mobilize and remove the one-piece orbitozygomatic bar. Flatten residual sphenoid ridge and orbital roof with a diamond drill flush with the skull base.")
            ]
        case .tlif:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Exposure & Pedicle Screws", detail: "Subperiosteal dissection out to transverse processes. Cannulate and insert 4 titanium pedicle screws into L4 and L5 bilaterally under fluoroscopy."),
                ApproachSequentialStep(stepNumber: 2, title: "Unilateral Facetectomy Corridor", detail: "Complete resection of right L4 inferior facet and L5 superior facet. Open ligamentum flavum to expose Kambin's triangle and exiting/traversing roots."),
                ApproachSequentialStep(stepNumber: 3, title: "Discectomy & Endplate Curettage", detail: "Incise disc annulus, thoroughly decompress disc space, and prepare endplates down to bleeding subchondral bone without penetrating cortex."),
                ApproachSequentialStep(stepNumber: 4, title: "Cage Insertion & Rod Compression", detail: "Trial and insert curved porous titanium cage packed with bone graft into anterior disc space. Secure longitudinal rods, compress for lordosis, and lock set screws.")
            ]
        case .chiariDecompression:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Suboccipital & C1 Exposure", detail: "Linear midline incision from inion to C2. Subperiosteally elevate paracervical musculature strictly in midline, identifying the posterior rim of foramen magnum and C1 posterior arch."),
                ApproachSequentialStep(stepNumber: 2, title: "Suboccipital Craniectomy & C1 Laminectomy", detail: "Perform a 3x3 cm suboccipital craniectomy incorporating the posterior foramen magnum rim. Re-sect the posterior arch of C1 out to the sulcus arteriosus, safeguarding V3 vertebral artery loops."),
                ApproachSequentialStep(stepNumber: 3, title: "Epidural Band Division & Y-Dural Opening", detail: "Sharply incise the thickened constricting fibrous band at the atlanto-occipital junction. Perform a Y-shaped dural incision, reflecting dural flaps to expose the herniated cerebellar tonsils, vermis, and PICA loops."),
                ApproachSequentialStep(stepNumber: 4, title: "Watertight Expansile Patch Duraplasty", detail: "Suture a tapered tan pericardial or collagen patch graft with continuous running monofilament suture to reconstruct a generous, non-restrictive posterior fossa cistern.")
            ]
        case .harmsC1C2:
            return [
                "Laceration of the V3 vertebral artery during C1 lateral mass exposure or high-speed drilling of the C2 pedicle",
                "Intraoperative injury to the C2 nerve root/ganglion causing intractable postoperative occipital neuralgia or neuropathic deafferentation",
                "Medial wall breech of the C2 pedicle screw into the cervical spinal canal causing direct spinal cord impingement"
            ]
        case .csdhBurrHole:
            return [
                "Aggressive plunge of perforator through inner table causing acute cortical laceration or intraparenchymal hemorrhage",
                "Rapid, precipitous intracranial decompression precipitating contralateral acute epidural hematoma or brainstem hemorrhage",
                "Tension pneumocephalus from introducing large air volumes during irrigation or improper drain reservoir priming"
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
        case .retrosigmoid:
            return [
                "Sigmoid sinus or transverse sinus laceration during high-speed craniectomy drilling",
                "Avulsion of petrosal vein of Dandy precipitating life-threatening cerebellar hemorrhagic venous infarction",
                "Excessive stretch or thermal coagulation near CN VII/VIII causing permanent facial palsy or deafness"
            ]
        case .endonasalSellar:
            return [
                "Internal carotid artery laceration at carotid protuberance / siphon with massive exsanguination",
                "High-flow CSF leak and pneumocephalus through violated diaphragma sellae",
                "Postoperative pituitary apoplexy or central diabetes insipidus from infundibular disruption"
            ]
        case .farLateral:
            return [
                "Laceration of the V3 vertebral artery during high-speed diamond unroofing of the C1 transverse foramen",
                "Craniocervical junction mechanical instability if condyle resection exceeds 50%, mandating occipitocervical fusion",
                "Injury to hypoglossal nerve (CN XII) within hypoglossal canal from overzealous anterior/medial condyle drilling"
            ]
        case .hemicraniectomy:
            return [
                "Failure to decompress flush to the middle cranial fossa floor, allowing residual bone edge to strangulate the herniating uncus",
                "Small bone window (<12x15 cm) causing cerebral venous compression against bone edges and secondary malignant brain herniation",
                "Omission of perimeter dural hitch sutures resulting in rapid epidural hematoma reaccumulation"
            ]
        case .kochersEVD:
            return [
                "Burr hole positioned posterior to coronal suture causing penetration of motor cortex with permanent contralateral hemiplegia",
                "Excessive catheter insertion depth (>6.5 cm) leading to lethal midbrain, basilar artery, or third ventricular floor laceration",
                "Excessively medial trajectory causing contralateral ventricular puncture and bilateral fornix disruption"
            ]
        case .acdf:
            return [
                "Esophageal perforation during medial retractor placement or aggressive dissection along the prevertebral fascia",
                "Carotid artery thrombosis or dissection from excessively vigorous lateral retraction without relaxing blade tension",
                "Recurrent laryngeal nerve traction injury leading to vocal cord paralysis and persistent postoperative hoarseness"
            ]
        case .orbitozygomatic:
            return [
                "Supraorbital nerve transection during superior orbital rim osteotomy causing permanent forehead sensory loss",
                "Thermal or traction injury to frontalis branch of facial nerve (CN VII) leading to permanent brow ptosis",
                "Violation of the periorbita leading to orbital fat herniation, postoperative enophthalmos, or diplopia"
            ]
        case .tlif:
            return [
                "Traversing L5 or exiting L4 nerve root laceration or over-traction resulting in permanent foot drop or radiculopathy",
                "Dural tear with persistent CSF leak / postoperative lumbar pseudomeningocele requiring direct repair",
                "Endplate violation causing titanium cage subsidence or retropulsion into the spinal canal"
            ]
        case .chiariDecompression:
            return [
                "Laceration of the V3 vertebral artery loops during lateral dissection on the superior arch of C1",
                "Postoperative CSF leak and lumbar pseudomeningocele or meningitis from non-watertight duraplasty closure",
                "Acute cerebellar ptosis or slump from an overly aggressive suboccipital craniectomy (>3.5 cm) breaching transverse sinus"
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
