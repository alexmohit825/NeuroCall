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
    
    public var assetImageName: String? {
        switch self {
        case .aneurysmClipping: return "plate_aneurysm"
        case .pterional: return "plate_pterional"
        case .retrosigmoid: return "plate_retrosigmoid"
        case .endonasalSellar: return "plate_endonasal_sellar"
        case .farLateral: return "plate_far_lateral"
        }
    }
    
    public var shortTitle: String {
        switch self {
        case .aneurysmClipping: return "Aneurysm Clip"
        case .pterional: return "Pterional"
        case .retrosigmoid: return "Retrosigmoid"
        case .endonasalSellar: return "Endonasal Sellar"
        case .farLateral: return "Far-Lateral"
        }
    }
    
    public var title: String {
        switch self {
        case .aneurysmClipping: return "Anterior Circulation Aneurysm Clipping"
        case .pterional: return "Pterional Frontotemporosphenoidal Corridor"
        case .retrosigmoid: return "Retrosigmoid CPA Dissection"
        case .endonasalSellar: return "Endoscopic Endonasal Sellar Corridor"
        case .farLateral: return "Far-Lateral Suboccipital Transcondylar Approach"
        }
    }
    
    public var iconName: String {
        switch self {
        case .aneurysmClipping: return "bolt.horizontal.fill"
        case .pterional: return "brain.head.profile"
        case .retrosigmoid: return "ear"
        case .endonasalSellar: return "mouth"
        case .farLateral: return "arrow.triangle.turn.up.right.diamond.fill"
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
