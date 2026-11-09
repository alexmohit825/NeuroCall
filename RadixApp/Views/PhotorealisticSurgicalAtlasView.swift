import SwiftUI

// MARK: - Studio-Grade Photorealistic Surgical Atlas Suite (Option C)
// Featuring Authentic High-Definition Medical Artwork Plates & Operative Skull Base Corridors
// Synthesized from Albert Rhoton Jr. Cranial Anatomy and Operative Corridors.
// Deep micro-zoom (1.0x to 4.0x), interactive pinned callouts, danger zone overlays, and tactical protocols.

public struct PhotorealisticSurgicalAtlasView: View {
    @State private var selectedCategory: AtlasCategory = .all
    @State private var selectedPlate: SurgicalPlateType = .aneurysmClipping
    @State private var zoomScale: CGFloat = 1.0
    @State private var lastZoomScale: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero
    @State private var lastDragOffset: CGSize = .zero
    @State private var selectedCallout: SurgicalCallout? = nil
    @State private var showDangerOverlay: Bool = true
    @State private var showCalloutPins: Bool = true
    
    public init() {}
    
    private func selectAdjacentPlate(direction: Int) {
        let all = SurgicalPlateType.allCases
        guard let idx = all.firstIndex(of: selectedPlate) else { return }
        let nextIdx = (idx + direction + all.count) % all.count
        HapticManager.impact(style: .light)
        withAnimation(.easeInOut(duration: 0.22)) {
            selectedPlate = all[nextIdx]
            zoomScale = 1.0
            dragOffset = .zero
            lastDragOffset = .zero
            selectedCallout = all[nextIdx].callouts.first
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                atlasHeader
                
                // Atlas Pillar Category Selector
                categorySelectorBar
                
                // Plate Carousel Selector Bar
                plateSelectorBar
                
                // Deep-Zoom High-Definition Plate Canvas
                ZStack {
                    plateViewportCanvas
                    
                    // Controls Overlay (Reset zoom + Pin toggle + Swipe Nav)
                    VStack {
                        topControlsBar
                        Spacer()
                        bottomSwipeHintBar
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
                if let idx = SurgicalPlateType.allCases.firstIndex(of: selectedPlate) {
                    Text("PLATE \(idx + 1) / \(SurgicalPlateType.allCases.count) • SWIPE ◀ ▶")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(ObsidianTheme.neonCyan)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(ObsidianTheme.neonCyan.opacity(0.14))
                        .cornerRadius(6)
                }
            }
            Text("High-Definition Microsurgical & MRI Plates")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Authentic Rhoton-caliber anatomical artwork and clinical MRI scans. Slide left or right on any plate to advance.")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Category Selector Bar
    private var categorySelectorBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(AtlasCategory.allCases, id: \.self) { cat in
                    Button(action: {
                        HapticManager.impact(style: .light)
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCategory = cat
                            let filtered = cat.filteredPlates
                            if !filtered.contains(selectedPlate), let first = filtered.first {
                                selectedPlate = first
                                zoomScale = 1.0
                                dragOffset = .zero
                                lastDragOffset = .zero
                                selectedCallout = first.callouts.first
                            }
                        }
                    }) {
                        Text(cat.rawValue)
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedCategory == cat ? ObsidianTheme.neonAmber : ObsidianTheme.surfaceGlass)
                            .foregroundColor(selectedCategory == cat ? .black : ObsidianTheme.textSecondary)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(selectedCategory == cat ? ObsidianTheme.neonAmber : ObsidianTheme.borderSubtle, lineWidth: 1))
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    // MARK: - Plate Selector Bar
    private var plateSelectorBar: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(selectedCategory.filteredPlates, id: \.self) { plate in
                        Button(action: {
                            HapticManager.impact(style: .light)
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedPlate = plate
                                zoomScale = 1.0
                                dragOffset = .zero
                                lastDragOffset = .zero
                                selectedCallout = plate.callouts.first
                            }
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
                        .id(plate)
                    }
                }
                .padding(.horizontal, 14)
            }
            .onChange(of: selectedPlate) { newPlate in
                withAnimation(.easeInOut(duration: 0.25)) {
                    proxy.scrollTo(newPlate, anchor: .center)
                }
            }
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
    
    // MARK: - Bottom Swipe Navigation Bar
    private var bottomSwipeHintBar: some View {
        HStack {
            Button(action: { selectAdjacentPlate(direction: -1) }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 11, weight: .bold))
                    Text("Prev")
                        .font(.system(size: 10, weight: .bold))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.black.opacity(0.75))
                .foregroundColor(ObsidianTheme.textSecondary)
                .cornerRadius(8)
            }
            Spacer()
            Text(zoomScale <= 1.05 ? "Slide left / right for next plate • Pinch to zoom" : "Drag to pan • Tap reset to swipe plates")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(ObsidianTheme.textMuted)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.65))
                .cornerRadius(6)
            Spacer()
            Button(action: { selectAdjacentPlate(direction: 1) }) {
                HStack(spacing: 4) {
                    Text("Next")
                        .font(.system(size: 10, weight: .bold))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .bold))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.black.opacity(0.75))
                .foregroundColor(ObsidianTheme.textSecondary)
                .cornerRadius(8)
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 8)
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
                DragGesture(minimumDistance: 20)
                    .onChanged { val in
                        if zoomScale > 1.05 {
                            dragOffset = CGSize(
                                width: lastDragOffset.width + val.translation.width,
                                height: lastDragOffset.height + val.translation.height
                            )
                        }
                    }
                    .onEnded { val in
                        if zoomScale > 1.05 {
                            lastDragOffset = dragOffset
                        } else {
                            let dx = val.translation.width
                            let dy = val.translation.height
                            if abs(dx) > 45 && abs(dx) > abs(dy) * 1.2 {
                                if dx < 0 {
                                    selectAdjacentPlate(direction: 1)
                                } else {
                                    selectAdjacentPlate(direction: -1)
                                }
                            }
                        }
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

public enum AtlasCategory: String, CaseIterable {
    case all = "All Plates"
    case cranial = "Craniotomies & Trauma"
    case skullBase = "Skull Base & Vascular"
    case spine = "Spine & CVJ"
    
    public var filteredPlates: [SurgicalPlateType] {
        switch self {
        case .all: return SurgicalPlateType.allCases
        case .cranial: return [
            .pterional, .craniotomyFTOZO, .craniotomyParietal, .craniotomyTemporal,
            .craniotomySupraorbital, .craniotomyLateralSupraorbital, .craniotomyRetrosigmoidKeyhole,
            .craniotomyInterhemispheric, .craniotomyMiniPterional, .hemicraniectomy,
            .kochersEVD, .csdhBurrHole
        ]
        case .skullBase: return [
            .aneurysmClipping, .retrosigmoid, .endonasalSellar, .farLateral,
            .orbitozygomatic, .chiariDecompression
        ]
        case .spine: return [
            .acdf, .tlif, .harmsC1C2, .lumbarFusionApproaches, .tlifSurgicalCorridor,
            .c7t1Junction, .shuntFailureMatrix, .lumbarPseudomeningocele,
            .distalShuntPseudocyst, .craniocervicalJunction
        ]
        }
    }
}

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
    // MARK: - Master Craniotomy Bone Maps
    case craniotomyFTOZO = "craniotomy_ft_ozo"
    case craniotomyParietal = "craniotomy_parietal"
    case craniotomyTemporal = "craniotomy_temporal"
    case craniotomySupraorbital = "craniotomy_supraorbital"
    case craniotomyLateralSupraorbital = "craniotomy_lateral_supraorbital"
    case craniotomyRetrosigmoidKeyhole = "craniotomy_retrosigmoid_keyhole"
    case craniotomyInterhemispheric = "craniotomy_interhemispheric"
    case craniotomyMiniPterional = "craniotomy_mini_pterional"
    // MARK: - Master Spine, CVJ & Shunts
    case lumbarFusionApproaches = "lumbar_fusion_approaches"
    case tlifSurgicalCorridor = "tlif_surgical_corridor"
    case c7t1Junction = "c7_t1_junction"
    case shuntFailureMatrix = "shunt_failure_matrix"
    case lumbarPseudomeningocele = "lumbar_pseudomeningocele"
    case distalShuntPseudocyst = "distal_shunt_pseudocyst"
    case craniocervicalJunction = "craniocervical_junction"
    
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
        case .craniotomyFTOZO: return "plate_craniotomy_ft_ozo"
        case .craniotomyParietal: return "plate_craniotomy_parietal"
        case .craniotomyTemporal: return "plate_craniotomy_temporal"
        case .craniotomySupraorbital: return "plate_craniotomy_supraorbital"
        case .craniotomyLateralSupraorbital: return "plate_craniotomy_lateral_supraorbital"
        case .craniotomyRetrosigmoidKeyhole: return "plate_craniotomy_retrosigmoid"
        case .craniotomyInterhemispheric: return "plate_craniotomy_interhemispheric"
        case .craniotomyMiniPterional: return "plate_craniotomy_mini_pterional"
        case .lumbarFusionApproaches: return "plate_spine_lumbar_fusion_approaches"
        case .tlifSurgicalCorridor: return "plate_spine_tlif_surgical_corridor"
        case .c7t1Junction: return "plate_spine_c7_t1_junction"
        case .shuntFailureMatrix: return "plate_shunt_failure_matrix"
        case .lumbarPseudomeningocele: return "plate_lumbar_pseudomeningocele"
        case .distalShuntPseudocyst: return "plate_distal_shunt_pseudocyst"
        case .craniocervicalJunction: return "plate_craniocervical_junction_atlas"
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
        case .craniotomyFTOZO: return "FT-OZO Bone"
        case .craniotomyParietal: return "Parietal Map"
        case .craniotomyTemporal: return "Temporal Map"
        case .craniotomySupraorbital: return "Eyebrow Keyhole"
        case .craniotomyLateralSupraorbital: return "Lat Supraorbital"
        case .craniotomyRetrosigmoidKeyhole: return "Retrosig Map"
        case .craniotomyInterhemispheric: return "Interhemispheric"
        case .craniotomyMiniPterional: return "Minipterional"
        case .lumbarFusionApproaches: return "Fusion Approaches"
        case .tlifSurgicalCorridor: return "TLIF Corridor"
        case .c7t1Junction: return "C7–T1 Biomechanics"
        case .shuntFailureMatrix: return "Shunt Matrix"
        case .lumbarPseudomeningocele: return "Pseudomeningocele"
        case .distalShuntPseudocyst: return "Distal Pseudocyst"
        case .craniocervicalJunction: return "CCJ Ligaments"
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
        case .craniotomyFTOZO: return "Frontotemporal Orbitozygomatic (FT-OZO) 2-Piece Osteotomy"
        case .craniotomyParietal: return "Parietal Craniotomy & Sagittal Sinus Safety Margins"
        case .craniotomyTemporal: return "Subtemporal Flush Skull Base Exposure & Zygomatic Root"
        case .craniotomySupraorbital: return "Supraorbital Eyebrow Minicraniotomy & Frontal Sinus Margins"
        case .craniotomyLateralSupraorbital: return "Lateral Supraorbital Fronto-Sphenoid Keyhole"
        case .craniotomyRetrosigmoidKeyhole: return "Retrosigmoid Keyhole & Transverse-Sigmoid Sinus Junction"
        case .craniotomyInterhemispheric: return "Anterior Interhemispheric Parasagittal Corridor"
        case .craniotomyMiniPterional: return "Minipterional Sphenoid Ridge Decompression Window"
        case .lumbarFusionApproaches: return "Comparative Lumbar Fusion Corridors: PLIF vs TLIF vs ALIF vs XLIF vs OLIF"
        case .tlifSurgicalCorridor: return "TLIF Surgical Corridor, Kambin's Triangle & Root Safety Zones"
        case .c7t1Junction: return "Cervicothoracic (C7–T1) Junction Biomechanics & Instrumentation"
        case .shuntFailureMatrix: return "Ventriculoperitoneal Shunt Diagnostic Algorithm & Failure Matrix"
        case .lumbarPseudomeningocele: return "Lumbar Post-Op Pseudomeningocele & Dural Tear Fistula"
        case .distalShuntPseudocyst: return "Distal Peritoneal Catheter Shunt Pseudocyst & Malfunction"
        case .craniocervicalJunction: return "Craniocervical Junction (CCJ) Ligamentous Anatomy & Odontoid Complex"
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
        case .craniotomyFTOZO: return "eye.circle.fill"
        case .craniotomyParietal: return "brain.head.profile"
        case .craniotomyTemporal: return "ear"
        case .craniotomySupraorbital: return "eye"
        case .craniotomyLateralSupraorbital: return "arrow.up.right.diamond.fill"
        case .craniotomyRetrosigmoidKeyhole: return "target"
        case .craniotomyInterhemispheric: return "rectangle.split.2x1.fill"
        case .craniotomyMiniPterional: return "shield.fill"
        case .lumbarFusionApproaches: return "square.split.2x2.fill"
        case .tlifSurgicalCorridor: return "figure.walk"
        case .c7t1Junction: return "link.circle.fill"
        case .shuntFailureMatrix: return "arrow.triangle.branch"
        case .lumbarPseudomeningocele: return "drop.triangle.fill"
        case .distalShuntPseudocyst: return "bandage.fill"
        case .craniocervicalJunction: return "shield.checkered"
        }
    }
    
    public var callouts: [SurgicalCallout] {
        switch self {
        case .aneurysmClipping:
            return [
                SurgicalCallout(
                    id: "aneurysm_pcoma",
                    title: "PComA Aneurysm & Dome",
                    structureType: "VASCULAR LESION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.55,
                    normalizedY: 0.44,
                    description: "Saccular aneurysm originating from the posterolateral wall of the supraclinoid ICA at the PComA origin. The permanent titanium Yasargil clip blades occlude the neck while sparing the parent vessel.",
                    surgicalPearl: "Always dissect the neck 360 degrees to confirm the oculomotor nerve (CN III) is free from the posterior dome and PComA patency is preserved."
                ),
                SurgicalCallout(
                    id: "aneurysm_clip",
                    title: "Yasargil Titanium Clip",
                    structureType: "SURGICAL IMPLANT",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.59,
                    normalizedY: 0.49,
                    description: "Permanent mini-clip with parallel opposing blades across the aneurysm neck. The distal portion of the upper blade passes behind the neck while the lower blade crosses in front.",
                    surgicalPearl: "Inspect both blade tips with a dental mirror or 30-degree endoscope to ensure no perforating branches or CN III are entrapped."
                ),
                SurgicalCallout(
                    id: "aneurysm_ica",
                    title: "Internal Carotid Artery (ICA)",
                    structureType: "PARENT ARTERIAL TRUNK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.47,
                    description: "Supraclinoid ICA trunk coursing through the carotid cistern, giving rise to PComA before bifurcating into A1 and M1.",
                    surgicalPearl: "Establish early proximal control in the neck or at the clinoidal segment before mobilizing an unclipped PComA aneurysm."
                ),
                SurgicalCallout(
                    id: "aneurysm_cn2",
                    title: "Optic Nerve (CN II)",
                    structureType: "CRANIAL NERVE",
                    color: ObsidianTheme.textPrimary,
                    normalizedX: 0.45,
                    normalizedY: 0.47,
                    description: "Courses anteromedial to the supraclinoid ICA. Forms the medial border of the opticocarotid triangle.",
                    surgicalPearl: "Sharply open the optico-carotid arachnoid to release CSF and minimize the need for fixed frontal lobe retraction."
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
                    id: "rs_cn5",
                    title: "CN V (Trigeminal Nerve)",
                    structureType: "UPPER NEUROVASCULAR COMPLEX",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.550,
                    normalizedY: 0.388,
                    description: "Courses across the rostral cerebellopontine angle beneath the superior petrosal sinus and Dandy's vein toward Meckel's cave.",
                    surgicalPearl: "Look for superior cerebellar artery (SCA) loops compressing the trigeminal root entry zone (REZ) during microvascular decompression."
                ),
                SurgicalCallout(
                    id: "rs_cn78",
                    title: "CN VII & CN VIII Complex",
                    structureType: "MIDDLE NEUROVASCULAR COMPLEX",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.623,
                    normalizedY: 0.409,
                    description: "Facial and vestibulocochlear nerve bundle traversing the middle CPA cistern toward the internal acoustic meatus.",
                    surgicalPearl: "CN VII (facial) lies anterior/ventral to CN VIII. Avoid bipolar coagulation or direct traction on the bundle."
                ),
                SurgicalCallout(
                    id: "rs_aica",
                    title: "AICA (Anterior Inferior Cerebellar Artery)",
                    structureType: "ARTERIAL MEATAL LOOP",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.562,
                    normalizedY: 0.560,
                    description: "Prominent bifurcating arterial loop coursing between and across the CN VII/VIII complex, giving rise to the labyrinthine (internal auditory) artery.",
                    surgicalPearl: "Spasm or avulsion of the labyrinthine branch causes immediate, irreversible sensorineural hearing loss."
                ),
                SurgicalCallout(
                    id: "rs_cn9_11",
                    title: "CN IX, X, XI (Jugular Foramen Complex)",
                    structureType: "LOWER NEUROVASCULAR COMPLEX",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.442,
                    normalizedY: 0.457,
                    description: "Glossopharyngeal, vagus, and accessory nerve rootlets ascending from the post-olivary sulcus to exit the jugular foramen.",
                    surgicalPearl: "Traction or thermal injury to the lower cranial nerves causes postoperative dysphagia, vocal cord paralysis, and aspiration."
                ),
                SurgicalCallout(
                    id: "rs_pica",
                    title: "PICA & Vertebral Artery (VA)",
                    structureType: "CAUDAL ARTERIAL LOOP",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.317,
                    normalizedY: 0.826,
                    description: "Intradural V4 vertebral artery trunk coursing ventral to CN XII rootlets and giving rise to the caudal loop of PICA among the lower cranial nerves.",
                    surgicalPearl: "Identify PICA origin and hypoglossal (CN XII) rootlets early when dissecting caudal CPA and foramen magnum lesions."
                ),
                SurgicalCallout(
                    id: "rs_spv",
                    title: "Superior Petrosal Vein (Dandy's Vein)",
                    structureType: "BRIDGING VENOUS DRAINAGE",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.576,
                    normalizedY: 0.317,
                    description: "Major bridging venous complex draining the petrosal surface of the cerebellum and brainstem into the superior petrosal sinus.",
                    surgicalPearl: "Preserve Dandy's vein whenever possible; sacrifice of a large dominant petrosal vein can precipitate fatal cerebellar venous infarction."
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
                    color: ObsidianTheme.neonGreen,
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
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.74,
                    normalizedY: 0.36,
                    description: "Outer dural leaves coagulated with bipolar and opened in 4-quadrant cruciate pattern with outer neo-membrane unroofed.",
                    surgicalPearl: "Thoroughly bipolar dural edges to inner bone rim; ensure outer membrane is fenestrated so subdural fluid drains freely without valve effect."
                )
            ]
        case .craniotomyFTOZO:
            return [
                SurgicalCallout(
                    id: "ftozo_orbit",
                    title: "Orbitozygomatic 2-Piece Bar",
                    structureType: "OSTEOTOMY BOUNDARY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.52,
                    description: "Detached orbital rim and zygomatic arch providing unobstructed sub-frontal and trans-sylvian viewing angle with zero brain retraction.",
                    surgicalPearl: "Protect the supraorbital neurovascular bundle and reconstruct the orbital roof during closure to avoid pulsating enophthalmos."
                ),
                SurgicalCallout(
                    id: "ftozo_sphenoid",
                    title: "Sphenoid Ridge Flattening",
                    structureType: "SKULL BASE BONE DECOMPRESSION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.62,
                    normalizedY: 0.45,
                    description: "High-speed diamond burr drilling of the lesser sphenoid wing down to the meningo-orbital band.",
                    surgicalPearl: "Copious irrigation prevents thermal injury to the underlying optic nerve inside the optic canal."
                )
            ]
        case .craniotomyParietal:
            return [
                SurgicalCallout(
                    id: "parietal_bone",
                    title: "Parietal Bone Window",
                    structureType: "BONE CRANIOTOMY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.46,
                    description: "Rectangular or horse-shoe craniotomy centered over the angular/supramarginal gyri or parietal lobe mass.",
                    surgicalPearl: "Maintain a 1.5 cm safe clearance from the superior sagittal sinus unless intentional sinus exposure is planned."
                )
            ]
        case .craniotomyTemporal:
            return [
                SurgicalCallout(
                    id: "temporal_craniotomy",
                    title: "Subtemporal Corridor",
                    structureType: "SKULL BASE BONE WINDOW",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.52,
                    normalizedY: 0.55,
                    description: "Low temporal craniotomy flush with the middle cranial fossa floor, unroofing the petrous apex.",
                    surgicalPearl: "Avoid excessive upward temporal lobe retraction to prevent tearing of the vein of Labbé."
                )
            ]
        case .craniotomySupraorbital:
            return [
                SurgicalCallout(
                    id: "supraorbital_keyhole",
                    title: "Eyebrow Minicraniotomy",
                    structureType: "KEYHOLE APPROACH",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "2.0 x 2.5 cm bone window through eyebrow incision for anterior circulation and sellar pathology.",
                    surgicalPearl: "Seal any entered frontal air sinus immediately with vascularized pericranial graft or muscle patch."
                )
            ]
        case .craniotomyLateralSupraorbital:
            return [
                SurgicalCallout(
                    id: "lat_supraorbital",
                    title: "Lateral Supraorbital Bone Flap",
                    structureType: "MINIMAL ACCESS CRANIOTOMY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.46,
                    description: "Tailored fronto-sphenoidal window exposing the anterior sylvian fissure without full pterional temporalis mobilization.",
                    surgicalPearl: "Preserves the frontalis branch of CN VII while offering direct microscopic trajectory to ACoA and PCoA."
                )
            ]
        case .craniotomyRetrosigmoidKeyhole:
            return [
                SurgicalCallout(
                    id: "retrosig_keyhole",
                    title: "Asterion Craniectomy",
                    structureType: "POSTERIOR FOSSA ENTRY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.54,
                    normalizedY: 0.52,
                    description: "Trephination placed inferomedial to the asterion exposing the transverse-sigmoid sinus knee.",
                    surgicalPearl: "Wax mastoid air cells meticulously to eliminate post-operative CSF rhinorrhea via middle ear air cells."
                )
            ]
        case .craniotomyInterhemispheric:
            return [
                SurgicalCallout(
                    id: "interhemispheric_flap",
                    title: "Parasagittal Bifrontal Window",
                    structureType: "INTERHEMISPHERIC CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.42,
                    description: "Crossing midline safely to unroof the falx and access the pericallosal arteries and corpus callosum.",
                    surgicalPearl: "Preserve all anterior bridging veins draining into the superior sagittal sinus to avoid bifrontal venous infarction."
                )
            ]
        case .craniotomyMiniPterional:
            return [
                SurgicalCallout(
                    id: "minipterional_flap",
                    title: "Sylvian Keyhole Window",
                    structureType: "MINIMALLY INVASIVE CRANIOTOMY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.52,
                    normalizedY: 0.48,
                    description: "Compact 3 cm craniotomy focused over the sphenoid ridge and anterior sylvian point.",
                    surgicalPearl: "Minimizes temporalis muscle atrophy and mastication pain compared to traditional full pterional craniotomies."
                )
            ]
        case .lumbarFusionApproaches:
            return [
                SurgicalCallout(
                    id: "lumbar_approaches_grid",
                    title: "Comparative Fusion Corridors",
                    structureType: "SPINE SURGICAL PLANES",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "Axial plane visualization of PLIF (posterior), TLIF (transforaminal), ALIF (retroperitoneal), XLIF/LLIF (trans-psoas), and OLIF (ante-psoas).",
                    surgicalPearl: "In XLIF/LLIF, continuous neuromonitoring of the lumbosacral plexus inside the psoas is mandatory to avoid femoral neuropathy."
                )
            ]
        case .tlifSurgicalCorridor:
            return [
                SurgicalCallout(
                    id: "kambin_triangle",
                    title: "Kambin's Safe Triangle",
                    structureType: "ANATOMICAL SAFE ZONE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.45,
                    normalizedY: 0.52,
                    description: "Hypotenuse = exiting root; Base = superior border of lower pedicle; Height = traversing root / dural sac.",
                    surgicalPearl: "Never retract the traversing nerve root medially beyond the midline of the dural tube to avoid traction radiculopathy."
                )
            ]
        case .c7t1Junction:
            return [
                SurgicalCallout(
                    id: "c7_t1_transition",
                    title: "C7 Pedicle vs T1 Pedicle Screws",
                    structureType: "SPINE INSTRUMENTATION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.48,
                    normalizedY: 0.48,
                    description: "High-stress transition zone from mobile lordotic cervical spine to rigid kyphotic thoracic cage.",
                    surgicalPearl: "C7 lateral masses are thin; pedicle screw placement or C7–T1 cross-connector construct provides 300% greater pullout strength."
                )
            ]
        case .shuntFailureMatrix:
            return [
                SurgicalCallout(
                    id: "shunt_matrix_card",
                    title: "Proximal vs Valve vs Distal Obstruction",
                    structureType: "DIAGNOSTIC ALGORITHM",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.50,
                    normalizedY: 0.46,
                    description: "Systematic differential evaluation: slit ventricles vs ventricular catheter choroid plexus ingrowth vs abdominal pseudocyst.",
                    surgicalPearl: "A sluggishly refilling shunt reservoir confirms proximal obstruction; an uncompressible reservoir indicates valve or distal obstruction."
                )
            ]
        case .lumbarPseudomeningocele:
            return [
                SurgicalCallout(
                    id: "pseudomeningocele_sac",
                    title: "Extradural CSF Fistula Collection",
                    structureType: "POST-OP COMPLICATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.52,
                    normalizedY: 0.50,
                    description: "Encapsulated subfascial CSF fluid collection following incidental durotomy without primary water-tight repair.",
                    surgicalPearl: "Surgical re-exploration with direct primary 5-0 Prolene dural closure, muscle graft, and subarachnoid drain diversion."
                )
            ]
        case .distalShuntPseudocyst:
            return [
                SurgicalCallout(
                    id: "distal_pseudocyst_sac",
                    title: "Peritoneal Catheter Pseudocyst",
                    structureType: "ABDOMINAL CT PATHOLOGY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.48,
                    normalizedY: 0.54,
                    description: "Fibrous encapsulation around the peritoneal catheter tip causing distal outflow blockage and recurrent hydrocephalus.",
                    surgicalPearl: "Requires externalization of distal shunt tubing, CSF culture analysis, and conversion to ventriculoatrial (VA) or pleural shunt."
                )
            ]
        case .craniocervicalJunction:
            return [
                SurgicalCallout(
                    id: "ccj_ligaments",
                    title: "Transverse & Alar Ligament Complex",
                    structureType: "CRANIAL-CERVICAL STABILITY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "Primary biomechanical restraints preventing atlantoaxial subluxation and brainstem compression by the odontoid peg.",
                    surgicalPearl: "Anterior Atlantodental Interval (AADI) > 3 mm in adults (> 5 mm in children) confirms transverse ligament disruption requiring posterior C1-C2 fusion."
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
        case .craniotomyFTOZO:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Bicoronal Scalp Flap", detail: "Bicoronal incision from root of zygoma to contralateral hairline. Subfascial temporalis dissection to protect facial nerve."),
                ApproachSequentialStep(stepNumber: 2, title: "Orbitozygomatic Osteotomies", detail: "Cut 1: Zygomatic arch posterior root. Cut 2: Zygoma body. Cut 3: Orbital roof and lateral orbital rim. Free 2-piece bone flap."),
                ApproachSequentialStep(stepNumber: 3, title: "Sphenoid Wing & Clinoid Decompression", detail: "Drill lesser sphenoid wing flush with orbital roof down to superior orbital fissure. Execute anterior clinoidectomy if needed."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Opening & Corridor Exploration", detail: "C-shaped dural flap hinged on orbit. Direct flat viewing angle to basilar apex, opticocarotid triangle, and upper clivus.")
            ]
        case .craniotomyParietal:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Stereotactic Navigation", detail: "Position patient with head neutral or slightly rotated. Register neuronavigation and map superior sagittal sinus."),
                ApproachSequentialStep(stepNumber: 2, title: "Scalp Flap & Burr Holes", detail: "Horseshoe or linear scalp incision. Place burr holes 1.5 cm off midline to prevent sinus injury."),
                ApproachSequentialStep(stepNumber: 3, title: "Parietal Bone Elevation", detail: "Turn craniotomy flap with craniotome. Wax bleeding diploic channels and place peripheral dural tack-up sutures."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Incision & Cortical Navigation", detail: "U-shaped dural flap reflected toward sinus. Identify sulcal anatomy and execute lesionectomy.")
            ]
        case .craniotomyTemporal:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Question-Mark Scalp Incision", detail: "Curve incision from zygomatic arch, over ear, ending in temporal hairline. Incise temporalis muscle."),
                ApproachSequentialStep(stepNumber: 2, title: "Temporal Bone Window", detail: "Low craniotomy with base flush to the zygomatic root and middle cranial fossa floor."),
                ApproachSequentialStep(stepNumber: 3, title: "Subtemporal Elevation", detail: "Elevate temporal lobe extradurally or intradurally. Identify petrous ridge, arcuate eminence, and tentorial incisura."),
                ApproachSequentialStep(stepNumber: 4, title: "Corridor Dissection", detail: "Aspirate CSF from basal cisterns to gain slack. Inspect basilar artery, PCA, and superior cerebellar artery.")
            ]
        case .craniotomySupraorbital:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Eyebrow Incision & Soft Tissue Release", detail: "Careful incision within eyebrow hairs. Preserve supraorbital and supratrochlear nerves."),
                ApproachSequentialStep(stepNumber: 2, title: "Keyhole Trephination & Window", detail: "Burr hole at the keyhole / temporal line. Cut a 2.0 x 2.5 cm bone flap directly above orbital rim."),
                ApproachSequentialStep(stepNumber: 3, title: "Anterior Skull Base Flattening", detail: "Drill orbital roof jugum ridges flush. Open dura in curvilinear shape along anterior skull base."),
                ApproachSequentialStep(stepNumber: 4, title: "Subfrontal Navigation", detail: "Slack brain by opening chiasmatic cistern. Gain direct visualization of optic nerve, ICA, and anterior communicating complex.")
            ]
        case .craniotomyLateralSupraorbital:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Lateral Hairline Scalp Incision", detail: "Curvilinear frontotemporal incision just behind hairline, avoiding extensive facial nerve risk."),
                ApproachSequentialStep(stepNumber: 2, title: "Fronto-Sphenoid Osteotomy", detail: "Compact craniotomy focused over the anterior sylvian fissure and sphenoid ridge."),
                ApproachSequentialStep(stepNumber: 3, title: "Sphenoid Ridge Flattening", detail: "Drill lesser sphenoid wing to expand the corridor without orbital osteotomy."),
                ApproachSequentialStep(stepNumber: 4, title: "Sylvian Fissure Dissection", detail: "Targeted opening of carotid and chiasmatic cisterns for aneurysm clipping or sellar lesion access.")
            ]
        case .craniotomyRetrosigmoidKeyhole:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retromastoid Linear Incision", detail: "Vertical incision 2 cm behind mastoid notch. Dissect suboccipital muscles down to bone."),
                ApproachSequentialStep(stepNumber: 2, title: "Asterion Trephine", detail: "Burr hole placed inferomedial to asterion. Enlarge craniectomy until transverse and sigmoid sinuses are delineated."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & Arachnoid Release", detail: "C-shaped dural incision hinged on the sigmoid sinus. Open lateral cerebello-medullary cistern to drain CSF."),
                ApproachSequentialStep(stepNumber: 4, title: "CPA Inspection", detail: "Gently mobilize cerebellum. Dissect acousticofacial bundle, trigeminal nerve, and lower cranial nerves.")
            ]
        case .craniotomyInterhemispheric:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Coronal Scalp Incision", detail: "Bicoronal incision behind hairline. Reflect scalp anteriorly preserving pericranium."),
                ApproachSequentialStep(stepNumber: 2, title: "Parasagittal Craniotomy", detail: "Bone flap centered across midline with burr holes directly over or flanking the superior sagittal sinus."),
                ApproachSequentialStep(stepNumber: 3, title: "Falx & Dural Reflection", detail: "Open dura in bilateral or unilateral flaps hinged on the sinus. Place dural tacking sutures."),
                ApproachSequentialStep(stepNumber: 4, title: "Interhemispheric Dissection", detail: "Sharply open arachnoid between frontal lobes, identifying callosomarginal and pericallosal arteries down to corpus callosum.")
            ]
        case .craniotomyMiniPterional:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Curvilinear Mini-Hairline Incision", detail: "Short 6 cm incision centered above zygomatic arch and anterior pterion."),
                ApproachSequentialStep(stepNumber: 2, title: "3 cm Bone Window", detail: "Single burr hole at MacCarty keyhole. Turn a 3 cm bone flap centered over sphenoid ridge."),
                ApproachSequentialStep(stepNumber: 3, title: "Focused Sphenoid Drilling", detail: "Drill lateral sphenoid wing to unroof anterior sylvian point."),
                ApproachSequentialStep(stepNumber: 4, title: "Trans-Sylvian Access", detail: "Minimal dural opening; sharply split proximal sylvian fissure to clip MCA and ICA aneurysms.")
            ]
        case .lumbarFusionApproaches:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior (PLIF / TLIF)", detail: "Prone position. Direct bilateral (PLIF) or unilateral (TLIF) facetectomy to enter disc space."),
                ApproachSequentialStep(stepNumber: 2, title: "Anterior (ALIF)", detail: "Supine retroperitoneal or transperitoneal exposure of L5-S1 or L4-5 between great vessels."),
                ApproachSequentialStep(stepNumber: 3, title: "Lateral Trans-Psoas (XLIF/LLIF)", detail: "Lateral decubitus. Retroperitoneal corridor splitting psoas muscle under real-time EMG neuromonitoring."),
                ApproachSequentialStep(stepNumber: 4, title: "Oblique Anterior-to-Psoas (OLIF)", detail: "Corridor between aorta / IVC and psoas muscle, sparing lumbar plexus and psoas disruption.")
            ]
        case .tlifSurgicalCorridor:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Unilateral Facetectomy", detail: "Remove inferior and superior articular processes to expose the exiting root and disc annulus."),
                ApproachSequentialStep(stepNumber: 2, title: "Identify Traversing & Exiting Roots", detail: "Delineate Kambin's triangle. Mobilize epidural veins and bipolar coagulate safely."),
                ApproachSequentialStep(stepNumber: 3, title: "Annulotomy & Complete Discectomy", detail: "Incise disc annulus with #11 blade. Curette cartilaginous endplates completely down to bleeding bone."),
                ApproachSequentialStep(stepNumber: 4, title: "Interbody Cage Insertion", detail: "Pack anterior disc space with autograft / DBM. Insert bulleted peek / titanium interbody cage obliquely across midline.")
            ]
        case .c7t1Junction:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Cervicothoracic Incision", detail: "Expose spinous processes and laminae from C5 down to T3. Identify C7 prominent spinous process."),
                ApproachSequentialStep(stepNumber: 2, title: "C7 Pedicle Cannulation", detail: "Entry at junction of superior facet and lateral mass. Aim 25-30 degrees medial, parallel to superior endplate."),
                ApproachSequentialStep(stepNumber: 3, title: "T1-T2 Thoracic Pedicle Screws", detail: "Entry at junction of superior facet and transverse process. Straight-forward or anatomical trajectory."),
                ApproachSequentialStep(stepNumber: 4, title: "Rod Linkage & Reduction", detail: "Contour robust titanium rods matching cervical lordosis to thoracic kyphosis. Lock construct with cross-link.")
            ]
        case .shuntFailureMatrix:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Clinical & Radiological Evaluation", detail: "Assess for headache, lethargy, sunsetting eyes. Perform non-contrast head CT and shunt series radiographs."),
                ApproachSequentialStep(stepNumber: 2, title: "Shunt Reservoir Puncture & Manometry", detail: "Aseptic prep. Tap reservoir with 25G butterfly needle. Measure opening pressure and send CSF for cells, protein, culture."),
                ApproachSequentialStep(stepNumber: 3, title: "Flow & Patency Test", detail: "Compress distal limb to evaluate proximal ventricular backflow. Compress proximal limb to test distal abdominal outflow."),
                ApproachSequentialStep(stepNumber: 4, title: "Targeted Surgical Revision", detail: "Ventricular catheter replacement for proximal failure; valve upgrade for overdrainage; laparoscopy for peritoneal pseudocyst.")
            ]
        case .lumbarPseudomeningocele:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Re-Exploration of Wound", detail: "Open prior incision. Evacuate subfascial CSF fluid collection and debride fibrous pseudocapsule."),
                ApproachSequentialStep(stepNumber: 2, title: "Identify Dural Defect", detail: "Perform Valsalva maneuver to locate dural tear site. Carefully dissect any herniated cauda equina nerve rootlets."),
                ApproachSequentialStep(stepNumber: 3, title: "Water-Tight Primary Dural Repair", detail: "Close defect primarily with running locking 5-0 or 6-0 Prolene or Nurolon suture. Apply muscle graft patch if needed."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Sealant & Temporary Diversion", detail: "Cover suture line with polyethylene glycol hydrogel sealant (DuraSeal). Place lumbar subarachnoid drain for 72 hours.")
            ]
        case .distalShuntPseudocyst:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Abdominal Ultrasound & CT", detail: "Confirm encapsulated fluid collection surrounding peritoneal catheter tip."),
                ApproachSequentialStep(stepNumber: 2, title: "Catheter Exteriorization", detail: "Make small abdominal incision, withdraw distal catheter from pseudocyst, and exteriorize to external drainage bag."),
                ApproachSequentialStep(stepNumber: 3, title: "CSF Inoculation & Antibiotic Clearance", detail: "Send multiple CSF samples to rule out Cutibacterium acnes or Staphylococcus epidermidis infection."),
                ApproachSequentialStep(stepNumber: 4, title: "Surgical Re-Routing", detail: "Once CSF is sterile, reposition catheter in opposite abdominal quadrant, pleural cavity (VP to VPL), or right atrium (VA shunt).")
            ]
        case .craniocervicalJunction:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Concorde Positioning", detail: "Fix head in Mayfield skull clamp with slight cervical flexion to optimize atlantoaxial alignment."),
                ApproachSequentialStep(stepNumber: 2, title: "Expose C1 Posterior Arch & C2 Lamina", detail: "Subperiosteal dissection of occiput, C1 posterior arch, and C2 lamina. Identify vertebral artery groove on C1."),
                ApproachSequentialStep(stepNumber: 3, title: "Goel-Harms C1 Lateral Mass & C2 Pedicle Screws", detail: "Place C1 lateral mass screws through posterior arch or below arch. Insert C2 pedicle or pars screws."),
                ApproachSequentialStep(stepNumber: 4, title: "Reduction & Autologous Bone Grafting", detail: "Reduce atlantoaxial subluxation under fluoroscopy. Decorticate bone and pack autologous cancellous bone graft.")
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
        case .craniotomyFTOZO:
            return [
                "Superior orbital fissure syndrome or blindness from excessive bone drilling heat",
                "Permanent frontalis nerve palsy if failing interfascial dissection over temporalis",
                "Orbital hematoma causing proptosis and acute optic nerve ischemia"
            ]
        case .craniotomyParietal:
            return [
                "Superior sagittal sinus laceration or air embolism during parasagittal drilling",
                "Eloquent somatosensory / motor cortex infarction from venous congestion",
                "Post-operative acute epidural hematoma under retracted bone edges"
            ]
        case .craniotomyTemporal:
            return [
                "Tearing of the vein of Labbé with catastrophic hemorrhagic temporal lobe venous infarction",
                "Trigeminal ganglion or petrosal nerve injury causing severe facial numbness or dry eye",
                "Middle meningeal artery avulsion at the foramen spinosum"
            ]
        case .craniotomySupraorbital:
            return [
                "Unrecognized frontal air sinus breach causing refractory CSF leak and meningitis",
                "Supraorbital nerve transection causing permanent forehead numbness and neuralgia",
                "Olfactory nerve avulsion from excessive anterior cranial fossa retraction"
            ]
        case .craniotomyLateralSupraorbital:
            return [
                "Lacrimal gland injury or orbital fat herniation obscuring surgical corridor",
                "Optic canal or internal carotid artery injury during deep clinoid dissection",
                "Dural laceration over thin sphenoid wing with uncontrollable venous oozing"
            ]
        case .craniotomyRetrosigmoidKeyhole:
            return [
                "Sigmoid sinus or transverse sinus tear during asterion burr hole drilling",
                "Petrosal vein (Dandy) avulsion precipitating cerebellar hemorrhagic stroke",
                "Facial nerve (CN VII) thermal or traction injury during acoustic tumor dissection"
            ]
        case .craniotomyInterhemispheric:
            return [
                "Bridging vein thrombosis causing bilateral venous infarction of motor cortex",
                "Superior sagittal sinus tear with acute massive blood loss and air embolism",
                "Pericallosal artery spasm or occlusion during distal ACA dissection"
            ]
        case .craniotomyMiniPterional:
            return [
                "Inadequate visualization of distal aneurysm neck due to narrow keyhole corridor",
                "Middle cerebral artery (MCA) branch injury during tight sylvian split",
                "Frontal branch facial nerve weakness from aggressive scalp retraction"
            ]
        case .lumbarFusionApproaches:
            return [
                "Lumbar plexus injury (femoral nerve) during trans-psoas lateral approach (XLIF/LLIF)",
                "Iliac vessel laceration during anterior lumbar exposure (ALIF) causing exsanguination",
                "Exiting nerve root injury in the foramen during transforaminal interbody placement (TLIF)"
            ]
        case .tlifSurgicalCorridor:
            return [
                "Conjoined nerve root anomaly transection mistaken for herniated disc fragment",
                "Dural tear at exiting root axilla leading to refractory CSF fistula",
                "Interbody cage migration into spinal canal causing acute cauda equina syndrome"
            ]
        case .c7t1Junction:
            return [
                "Vertebral artery injury during C7 pedicle cannulation (enters at C6 transverse foramen in 90%)",
                "Construct pullout and junctional kyphosis if failing to extend fixation to rigid thoracic spine",
                "T1 root injury causing intrinsic hand muscle weakness and claw deformity"
            ]
        case .shuntFailureMatrix:
            return [
                "Slit ventricle syndrome and low-pressure state leading to bilateral chronic subdural hematomas",
                "Ascending meningitis or ventriculitis from colonized shunt hardware",
                "Delayed catastrophic intracranial hypertension from unrecognized acute shunt obstruction"
            ]
        case .lumbarPseudomeningocele:
            return [
                "Cauda equina root entrapment within dural defect causing acute neurological deficit",
                "Infected pseudomeningocele progressing to epidural abscess and meningitis",
                "Tension pseudomeningocele with skin dehiscence and frank cutaneous CSF drainage"
            ]
        case .distalShuntPseudocyst:
            return [
                "Intra-abdominal sepsis or peritonitis from indolent low-virulence shunt infection",
                "Intestinal perforation during peritoneal catheter placement or revision",
                "Refractory hydrocephalus causing uncal or tonsillar herniation"
            ]
        case .craniocervicalJunction:
            return [
                "Brainstem or cervical cord transection during atlantoaxial reduction",
                "Vertebral artery V3 segment injury during C1 lateral mass screw placement",
                "Construct failure and cranial-cervical dislocation if transverse ligament is non-functional"
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
