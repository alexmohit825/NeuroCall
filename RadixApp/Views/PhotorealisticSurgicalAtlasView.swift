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
                
                // Persistent Primary Deck Navigation Bar (Never Falls Off)
                primaryDeckNavBar
                    .padding(.horizontal, 14)
                
                // Deep-Zoom High-Definition Plate Canvas
                ZStack {
                    plateViewportCanvas
                    
                    // Persistent Floating Side Chevron Navigation Buttons
                    HStack {
                        Button(action: { selectAdjacentPlate(direction: -1) }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(Color.black.opacity(0.75))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(ObsidianTheme.neonAmber.opacity(0.5), lineWidth: 1))
                        }
                        .padding(.leading, 8)
                        
                        Spacer()
                        
                        Button(action: { selectAdjacentPlate(direction: 1) }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(Color.black.opacity(0.75))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(ObsidianTheme.neonAmber.opacity(0.5), lineWidth: 1))
                        }
                        .padding(.trailing, 8)
                    }
                    
                    // Controls Overlay (Top title & pin toggle + Bottom swipe hint)
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
    
    // MARK: - Persistent Deck Navigation Bar
    private var primaryDeckNavBar: some View {
        HStack(spacing: 12) {
            Button(action: { selectAdjacentPlate(direction: -1) }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12, weight: .black))
                    Text("PREV")
                        .font(.system(size: 11, weight: .black))
                }
                .foregroundColor(ObsidianTheme.neonAmber)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(ObsidianTheme.surfaceElevated)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.neonAmber.opacity(0.4), lineWidth: 1.5))
            }
            
            VStack(spacing: 2) {
                if let idx = SurgicalPlateType.allCases.firstIndex(of: selectedPlate) {
                    Text("PLATE \(idx + 1) OF \(SurgicalPlateType.allCases.count)")
                        .font(.system(size: 12, weight: .black, design: .monospaced))
                        .foregroundColor(ObsidianTheme.textPrimary)
                }
                Text("SWIPE ◀ ▶")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(ObsidianTheme.neonCyan)
            }
            .frame(width: 110)
            
            Button(action: { selectAdjacentPlate(direction: 1) }) {
                HStack(spacing: 6) {
                    Text("NEXT")
                        .font(.system(size: 11, weight: .black))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .black))
                }
                .foregroundColor(ObsidianTheme.neonAmber)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(ObsidianTheme.surfaceElevated)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.neonAmber.opacity(0.4), lineWidth: 1.5))
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
                SimultaneousGesture(
                    MagnificationGesture()
                        .onChanged { val in
                            let delta = val / lastZoomScale
                            lastZoomScale = val
                            let newScale = zoomScale * delta
                            zoomScale = min(max(newScale, 1.0), 5.0)
                        }
                        .onEnded { _ in
                            lastZoomScale = 1.0
                            if zoomScale <= 1.05 {
                                withAnimation(.spring()) {
                                    zoomScale = 1.0
                                    dragOffset = .zero
                                    lastDragOffset = .zero
                                }
                            }
                        },
                    DragGesture(minimumDistance: 10)
                        .onChanged { val in
                            if zoomScale > 1.05 {
                                // 2-finger or 1-finger smooth panning of zoomed image
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
                                // Horizontal side-to-side swipe navigation
                                let dx = val.translation.width
                                let dy = val.translation.height
                                if abs(dx) > 35 && abs(dx) > abs(dy) * 1.1 {
                                    if dx < 0 {
                                        selectAdjacentPlate(direction: 1)
                                    } else {
                                        selectAdjacentPlate(direction: -1)
                                    }
                                }
                            }
                        }
                )
            )
            .onTapGesture(count: 2) {
                // Double tap resets zoom and pan
                HapticManager.impact(style: .medium)
                withAnimation(.spring()) {
                    zoomScale = 1.0
                    dragOffset = .zero
                    lastDragOffset = .zero
                }
            }
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
            .craniotomyBifrontal, .craniotomyParietal, .craniotomyTemporal,
            .retrosigmoid3D, .hemicraniectomy, .csdhBurrHole
        ]
        case .skullBase: return [
            .aneurysmClipping, .pterionalFissure, .retrosigmoidDissection,
            .endonasalSellar, .farLateral
        ]
        case .spine: return [
            .chiariDecompression, .craniocervicalJunction, .harmsC1C2,
            .c7t1Junction, .lumbarFusionApproaches, .tlifCorridor,
            .tlif, .acdf
        ]
        }
    }
}

public enum SurgicalPlateType: String, CaseIterable {
    case aneurysmClipping = "aneurysm_clipping"
    case pterionalFissure = "pterional_fissure"
    case craniotomyBifrontal = "craniotomy_bifrontal"
    case craniotomyParietal = "craniotomy_parietal"
    case craniotomyTemporal = "craniotomy_temporal"
    case retrosigmoid3D = "retrosigmoid_3d"
    case retrosigmoidDissection = "retrosigmoid_dissection"
    case hemicraniectomy = "hemicraniectomy"
    case csdhBurrHole = "csdh_burr_hole"
    case endonasalSellar = "endonasal_sellar"
    case farLateral = "far_lateral"
    case chiariDecompression = "chiari_decompression"
    case craniocervicalJunction = "craniocervical_junction"
    case harmsC1C2 = "harms_c1_c2"
    case c7t1Junction = "c7_t1_junction"
    case lumbarFusionApproaches = "lumbar_fusion_approaches"
    case tlifCorridor = "tlif_corridor"
    case tlif = "tlif"
    case acdf = "acdf"

    public var assetImageName: String? {
        switch self {
        case .aneurysmClipping: return "plate_aneurysm"
        case .pterionalFissure: return "plate_pterional_fissure"
        case .craniotomyBifrontal: return "plate_bifrontal_3d"
        case .craniotomyParietal: return "plate_craniotomy_parietal"
        case .craniotomyTemporal: return "plate_craniotomy_temporal"
        case .retrosigmoid3D: return "plate_retrosigmoid_3d"
        case .retrosigmoidDissection: return "plate_retrosigmoid_dissection"
        case .hemicraniectomy: return "plate_hemicraniectomy"
        case .csdhBurrHole: return "plate_csdh_burr_hole"
        case .endonasalSellar: return "plate_endonasal_sellar"
        case .farLateral: return "plate_far_lateral"
        case .chiariDecompression: return "plate_chiari_decompression"
        case .craniocervicalJunction: return "plate_craniocervical_junction_atlas"
        case .harmsC1C2: return "plate_harms_c1_c2"
        case .c7t1Junction: return "plate_spine_c7_t1_junction"
        case .lumbarFusionApproaches: return "plate_spine_lumbar_fusion_approaches"
        case .tlifCorridor: return "plate_spine_tlif_surgical_corridor"
        case .tlif: return "plate_tlif"
        case .acdf: return "plate_acdf"
        }
    }

    public var shortTitle: String {
        switch self {
        case .aneurysmClipping: return "Aneurysm Clip"
        case .pterionalFissure: return "Sylvian Fissure"
        case .craniotomyBifrontal: return "Bifrontal 3D"
        case .craniotomyParietal: return "Parietal Map"
        case .craniotomyTemporal: return "Temporal Map"
        case .retrosigmoid3D: return "Retrosig 3D"
        case .retrosigmoidDissection: return "Retrosig Dissection"
        case .hemicraniectomy: return "Hemicraniectomy"
        case .csdhBurrHole: return "Chronic SDH"
        case .endonasalSellar: return "Endonasal Sellar"
        case .farLateral: return "Far-Lateral"
        case .chiariDecompression: return "Chiari I"
        case .craniocervicalJunction: return "CCJ Ligaments"
        case .harmsC1C2: return "Goel-Harms"
        case .c7t1Junction: return "C7–T1 Biomechanics"
        case .lumbarFusionApproaches: return "Fusion Approaches"
        case .tlifCorridor: return "TLIF Corridor"
        case .tlif: return "L4-5 TLIF"
        case .acdf: return "ACDF"
        }
    }

    public var title: String {
        switch self {
        case .aneurysmClipping: return "Anterior Circulation Aneurysm Clipping"
        case .pterionalFissure: return "Pterional Sylvian Fissure Dissection & Opercular Planes"
        case .craniotomyBifrontal: return "Bifrontal 3D Skull Model & Anterior Cranial Fossa"
        case .craniotomyParietal: return "Parietal Craniotomy & Sagittal Sinus Safety Margins"
        case .craniotomyTemporal: return "Subtemporal Flush Skull Base Exposure & Zygomatic Root"
        case .retrosigmoid3D: return "Retrosigmoid 3D Skull Model & Sinus Topography"
        case .retrosigmoidDissection: return "Retrosigmoid CPA Dissection & Acousticofacial Bundle"
        case .hemicraniectomy: return "Decompressive Hemicraniectomy & Expansile Duroplasty"
        case .csdhBurrHole: return "Chronic Subdural Hematoma: Diagnostic CT & Burr Hole Evacuation"
        case .endonasalSellar: return "Endoscopic Endonasal Sellar Corridor"
        case .farLateral: return "Far-Lateral Suboccipital Transcondylar Approach"
        case .chiariDecompression: return "Chiari I Malformation Decompression & Duraplasty"
        case .craniocervicalJunction: return "Craniocervical Junction (CCJ) Ligamentous Anatomy & Odontoid Complex"
        case .harmsC1C2: return "Posterior C1–C2 Fixation (Goel-Harms Construct)"
        case .c7t1Junction: return "Cervicothoracic (C7–T1) Junction Biomechanics & Instrumentation"
        case .lumbarFusionApproaches: return "Comparative Lumbar Fusion Corridors: PLIF vs TLIF vs ALIF vs XLIF vs OLIF"
        case .tlifCorridor: return "TLIF Surgical Corridor, Kambin's Triangle & Root Safety Zones"
        case .tlif: return "L4–L5 Transforaminal Lumbar Interbody Fusion (TLIF)"
        case .acdf: return "Anterior Cervical Discectomy & Fusion (ACDF)"
        }
    }

    public var iconName: String {
        switch self {
        case .aneurysmClipping: return "bolt.horizontal.fill"
        case .pterionalFissure: return "brain.head.profile"
        case .craniotomyBifrontal: return "face.dashed"
        case .craniotomyParietal: return "cross.case.fill"
        case .craniotomyTemporal: return "ear"
        case .retrosigmoid3D: return "circle.grid.cross"
        case .retrosigmoidDissection: return "waveform.path.ecg"
        case .hemicraniectomy: return "shield.slash.fill"
        case .csdhBurrHole: return "target"
        case .endonasalSellar: return "mouth"
        case .farLateral: return "tortoiseshell.fill"
        case .chiariDecompression: return "brain"
        case .craniocervicalJunction: return "link"
        case .harmsC1C2: return "wrench.and.screwdriver.fill"
        case .c7t1Junction: return "point.topleft.down.curvedto.point.bottomright.up"
        case .lumbarFusionApproaches: return "square.stack.3d.down.right.fill"
        case .tlifCorridor: return "triangle.fill"
        case .tlif: return "cube.transparent.fill"
        case .acdf: return "arrow.up.and.down.circle.fill"
        }
    }

    public var callouts: [SurgicalCallout] {
        switch self {
        case .aneurysmClipping:
            return [
                SurgicalCallout(
                    id: "aneurysm_clipping_1",
                    title: "PComA Aneurysm & Dome",
                    structureType: "VASCULAR LESION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.55,
                    normalizedY: 0.44,
                    description: "Saccular aneurysm originating from supraclinoid ICA posterolateral wall.",
                    surgicalPearl: "Dissect neck 360 degrees to preserve PComA patency and free CN III."
                ),
                SurgicalCallout(
                    id: "aneurysm_clipping_2",
                    title: "Yasargil Titanium Clip",
                    structureType: "SURGICAL IMPLANT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.59,
                    normalizedY: 0.49,
                    description: "Permanent mini-clip with parallel opposing blades across aneurysm neck.",
                    surgicalPearl: "Inspect both blade tips to verify no perforator entrapment."
                ),
                SurgicalCallout(
                    id: "aneurysm_clipping_3",
                    title: "Internal Carotid Artery (ICA)",
                    structureType: "PARENT ARTERY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.48,
                    normalizedY: 0.47,
                    description: "Supraclinoid ICA trunk providing proximal control before aneurysm manipulation.",
                    surgicalPearl: "Establish early proximal control in carotid cistern before dome dissection."
                )
            ]
        case .pterionalFissure:
            return [
                SurgicalCallout(
                    id: "pterional_fissure_1",
                    title: "Sylvian Stem & Superficial Sylvian Veins",
                    structureType: "MICROSURGICAL ARACNOID PLANE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.52,
                    normalizedY: 0.46,
                    description: "Division between pars triangularis/orbitalis and superior temporal gyrus.",
                    surgicalPearl: "Dissect strictly on the frontal side of the superficial Sylvian vein to avoid temporal venous infarction."
                )
            ]
        case .craniotomyBifrontal:
            return [
                SurgicalCallout(
                    id: "craniotomy_bifrontal_1",
                    title: "Bifrontal Osteotomy & Midline Sinus Clearance",
                    structureType: "CRANIAL MAP",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.42,
                    description: "Extended bifrontal craniotomy crossing midline with unroofed superior sagittal sinus ligation.",
                    surgicalPearl: "Seal frontal sinus mucosa meticulously with pericranial flap to eliminate CSF rhinorrhea."
                )
            ]
        case .craniotomyParietal:
            return [
                SurgicalCallout(
                    id: "craniotomy_parietal_1",
                    title: "Parietal Bone Window",
                    structureType: "BONE CRANIOTOMY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.50,
                    normalizedY: 0.46,
                    description: "Rectangular or horseshoe craniotomy centered over parietal lobe mass.",
                    surgicalPearl: "Maintain 1.5 cm safe clearance from superior sagittal sinus unless sinus exposure planned."
                )
            ]
        case .craniotomyTemporal:
            return [
                SurgicalCallout(
                    id: "craniotomy_temporal_1",
                    title: "Subtemporal Corridor",
                    structureType: "SKULL BASE BONE WINDOW",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.52,
                    normalizedY: 0.55,
                    description: "Low temporal craniotomy flush with middle cranial fossa floor, unroofing petrous apex.",
                    surgicalPearl: "Avoid excessive upward temporal lobe retraction to prevent tearing vein of Labbé."
                )
            ]
        case .retrosigmoid3D:
            return [
                SurgicalCallout(
                    id: "retrosigmoid_3d_1",
                    title: "Transverse-Sigmoid Junction Knee",
                    structureType: "VENOUS SINUS BOUNDARY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.52,
                    normalizedY: 0.48,
                    description: "Posterior-superior bony margins defining the safe limits of the retrosigmoid craniotomy.",
                    surgicalPearl: "Skeletonize but do not compress the sinuses; maintain continuous irrigation."
                )
            ]
        case .retrosigmoidDissection:
            return [
                SurgicalCallout(
                    id: "retrosigmoid_dissection_1",
                    title: "Acousticofacial Bundle (CN VII/VIII)",
                    structureType: "CRANIAL NERVES",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.54,
                    normalizedY: 0.48,
                    description: "Facial nerve anterior and cochleovestibular nerve posterior entering internal auditory meatus.",
                    surgicalPearl: "Stimulate facial nerve with monopolar probe before tumor capsule debulking."
                )
            ]
        case .hemicraniectomy:
            return [
                SurgicalCallout(
                    id: "hemicraniectomy_1",
                    title: "Decompressed Brain Herniation",
                    structureType: "DECOMPRESSION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "Edematous hemisphere expanding outward into duraplasty space relieving tentorial shift.",
                    surgicalPearl: "Minimum 12 x 15 cm bone window; bone must be drilled flush to middle cranial fossa floor."
                )
            ]
        case .csdhBurrHole:
            return [
                SurgicalCallout(
                    id: "csdh_burr_hole_1",
                    title: "Hypodense CSDH Fluid",
                    structureType: "SUBDURAL HEMATOMA FLUID",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.30,
                    normalizedY: 0.40,
                    description: "Liquefied chronic motor-oil subdural fluid collection exerting mass effect on hemisphere.",
                    surgicalPearl: "Gentle warm saline irrigation without excessive pressure prevents acute rebleeding from neomembranes."
                ),
                SurgicalCallout(
                    id: "csdh_burr_hole_2",
                    title: "14 mm Circular Burr Hole",
                    structureType: "OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.76,
                    normalizedY: 0.42,
                    description: "Neurosurgical circular burr hole placed over parietal boss / frontal convexity.",
                    surgicalPearl: "Inspect diploic cancellous marrow for hemostasis with bone wax before incising dura."
                )
            ]
        case .endonasalSellar:
            return [
                SurgicalCallout(
                    id: "endonasal_sellar_1",
                    title: "Sellar Floor & Pituitary",
                    structureType: "SELLA TURCICA",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Sellar dura unroofed exposing pituitary gland and adenoma capsule.",
                    surgicalPearl: "Identify carotid prominences and opticocarotid recesses with Doppler prior to durotomy."
                )
            ]
        case .farLateral:
            return [
                SurgicalCallout(
                    id: "far_lateral_1",
                    title: "Vertebral Artery V3 Segment",
                    structureType: "VASCULAR CORRIDOR",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.52,
                    normalizedY: 0.54,
                    description: "Vertebral artery V3 segment elevated and mobilized medially using Penfield #4 probe over C1 groove.",
                    surgicalPearl: "Drill posterior 1/3 of occipital condyle for flat skull base trajectory without brainstem retraction."
                )
            ]
        case .chiariDecompression:
            return [
                SurgicalCallout(
                    id: "chiari_decompression_1",
                    title: "Herniated Cerebellar Tonsils",
                    structureType: "PATHOLOGY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.45,
                    description: "Peg-like tonsillar descent >5 mm below foramen magnum into cervical canal.",
                    surgicalPearl: "C1 laminectomy and foramen magnum decompression restore CSF flow at obex."
                )
            ]
        case .craniocervicalJunction:
            return [
                SurgicalCallout(
                    id: "craniocervical_junction_1",
                    title: "Transverse & Alar Ligament Complex",
                    structureType: "CRANIAL-CERVICAL STABILITY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "Primary biomechanical restraints preventing atlantoaxial subluxation and brainstem compression by odontoid peg.",
                    surgicalPearl: "Anterior Atlantodental Interval (AADI) > 3 mm in adults (> 5 mm in children) confirms transverse ligament disruption requiring posterior C1-C2 fusion."
                )
            ]
        case .harmsC1C2:
            return [
                SurgicalCallout(
                    id: "harms_c1_c2_1",
                    title: "C1 Lateral Mass Screws",
                    structureType: "SPINE FIXATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.48,
                    normalizedY: 0.44,
                    description: "Polyaxial screws placed directly into C1 lateral mass below posterior arch.",
                    surgicalPearl: "Protect C2 ganglion and venous plexus; control bleeding with bipolar and hemostatic matrix."
                )
            ]
        case .c7t1Junction:
            return [
                SurgicalCallout(
                    id: "c7_t1_junction_1",
                    title: "C7 Pedicle vs T1 Pedicle Screws",
                    structureType: "SPINE INSTRUMENTATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.48,
                    normalizedY: 0.48,
                    description: "High-stress transition zone from mobile lordotic cervical spine to rigid kyphotic thoracic cage.",
                    surgicalPearl: "C7 lateral masses are thin; pedicle screw placement or C7–T1 cross-connector construct provides 300% greater pullout strength."
                )
            ]
        case .lumbarFusionApproaches:
            return [
                SurgicalCallout(
                    id: "lumbar_fusion_approaches_1",
                    title: "Comparative Fusion Corridors",
                    structureType: "SPINE SURGICAL PLANES",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "Axial plane visualization of PLIF, TLIF, ALIF, XLIF/LLIF, and OLIF.",
                    surgicalPearl: "In XLIF/LLIF, continuous neuromonitoring of lumbosacral plexus inside psoas is mandatory."
                )
            ]
        case .tlifCorridor:
            return [
                SurgicalCallout(
                    id: "tlif_corridor_1",
                    title: "Kambin's Safe Triangle",
                    structureType: "ANATOMICAL SAFE ZONE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.45,
                    normalizedY: 0.52,
                    description: "Hypotenuse = exiting root; Base = lower pedicle; Height = traversing root / dural sac.",
                    surgicalPearl: "Never retract traversing nerve root medially beyond midline of dural tube."
                )
            ]
        case .tlif:
            return [
                SurgicalCallout(
                    id: "tlif_1",
                    title: "Interbody Fusion Cage",
                    structureType: "IMPLANT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.52,
                    normalizedY: 0.50,
                    description: "Bulleted PEEK cage packed with autologous bone placed across anterior disc space.",
                    surgicalPearl: "Thoroughly curette endplates without violating subchondral bone to prevent cage subsidence."
                )
            ]
        case .acdf:
            return [
                SurgicalCallout(
                    id: "acdf_1",
                    title: "Cervical Interbody Cage & Plate",
                    structureType: "ANTERIOR IMPLANT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.48,
                    description: "Interbody spacer in disc space backed by anterior cervical locking plate.",
                    surgicalPearl: "Maintain medial esophagus and trachea retraction; avoid uncal lateral drift near vertebral artery."
                )
            ]
        }
    }

    public var steps: [ApproachSequentialStep] {
        switch self {
        case .aneurysmClipping:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Pterional Craniotomy & Proximal Control",
                    detail: "Reflect scalp, turn craniotomy, flatten sphenoid ridge. Open carotid cistern early for proximal ICA control."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Sylvian Fissure Dissection",
                    detail: "Sharply unroof Sylvian fissure distal-to-proximal, releasing frontal from temporal operculum without brain retractors."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Dissect Parent Vessels & Neck",
                    detail: "Expose parent trunk and outflow branches. Dissect aneurysm neck 360 degrees, identifying perforators on back wall."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Clip Application & Flow Validation",
                    detail: "Apply permanent Yasargil clip across neck. Confirm parent vessel patency and complete dome occlusion via micro-Doppler or ICG."
                )
            ]
        case .pterionalFissure:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Identify Distal Sylvian Fissure",
                    detail: "Locate anterior ascending and horizontal rami of Sylvian fissure under high magnification."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Arachnoid Release",
                    detail: "Sharply split arachnoid using micro-scissors, following frontal operculum."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Cisternal CSF Aspiration",
                    detail: "Aspirate CSF from carotid and chiasmatic cisterns to achieve spontaneous brain slack."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Deep MCA Bifurcation Exposure",
                    detail: "Expose M1 trunk, bifurcation, and M2 branches without self-retaining blade pressure."
                )
            ]
        case .craniotomyBifrontal:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Coronal Scalp Flap & Pericranial Harvest",
                    detail: "Bicoronal skin incision with subgaleal dissection, harvesting long vascularized pericranium for skull base repair."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Bifrontal Craniotomy",
                    detail: "Place burr holes flanking sagittal sinus and at bilateral keyholes. Turn single or bilateral frontal flap flush with orbital roofs."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Frontal Sinus Cranialization",
                    detail: "Exenterate all mucosa from frontal sinus with diamond burr. Seal sinus ducts with muscle and fibrin glue, covered by pericranial flap."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Dural Reflection & Subfrontal Access",
                    detail: "Ligate sagittal sinus rostrally. Divide falx cerebri for expansive bilateral access to tuberculum sellae and olfactory groove."
                )
            ]
        case .craniotomyParietal:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Positioning & Neuronavigation",
                    detail: "Register neuronavigation and map superior sagittal sinus and motor strip."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Scalp Flap & Burr Holes",
                    detail: "Horseshoe or linear scalp incision. Place burr holes 1.5 cm off midline to prevent sinus injury."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Parietal Bone Elevation",
                    detail: "Turn craniotomy flap with craniotome. Wax bleeding diploic channels and place peripheral dural tack-up sutures."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Dural Incision & Cortical Navigation",
                    detail: "U-shaped dural flap reflected toward sinus. Identify sulcal anatomy and execute lesionectomy."
                )
            ]
        case .craniotomyTemporal:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Question-Mark Scalp Incision",
                    detail: "Curve incision from zygomatic arch, over ear, ending in temporal hairline. Incise temporalis muscle."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Temporal Bone Window",
                    detail: "Low craniotomy with base flush to zygomatic root and middle cranial fossa floor."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Subtemporal Elevation",
                    detail: "Elevate temporal lobe extradurally or intradurally. Identify petrous ridge, arcuate eminence, and tentorial incisura."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Corridor Dissection",
                    detail: "Aspirate CSF from basal cisterns to gain slack. Inspect basilar artery, PCA, and superior cerebellar artery."
                )
            ]
        case .retrosigmoid3D:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Bony Landmarks",
                    detail: "Identify asterion, inion, and mastoid tip under 3D anatomical guidance."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Burr Hole & Kerf",
                    detail: "Place burr hole below transverse sinus; trace craniectomy along sinus edges."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Mastoid Waxing",
                    detail: "Bone wax all opened mastoid air cells to ensure zero CSF fistula pathway."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Dural Margin Tack-up",
                    detail: "Place perimeter dural sutures to prevent epidural hematoma accumulation."
                )
            ]
        case .retrosigmoidDissection:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Cisterna Magna Drainage",
                    detail: "Open arachnoid over lateral cisterna magna to release CSF and allow spontaneous cerebellar relaxation."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Identify CN VII/VIII Complex",
                    detail: "Follow brainstem lateral surface to root exit zone of facial and vestibulocochlear nerves."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Internal Auditory Canal Unroofing",
                    detail: "Drill posterior lip of IAC under saline cooling, preserving labyrinth."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Microsurgical Tumor Separation",
                    detail: "Sharp dissection in the arachnoid plane between tumor capsule and neural bundles."
                )
            ]
        case .hemicraniectomy:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Reverse Question-Mark Incision",
                    detail: "Large Kempe incision originating at zygoma, curving 2 cm off midline, turning behind ear."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Large Craniectomy (>12x15 cm)",
                    detail: "Turn large fronto-temporo-parietal bone flap. Nibble temporal squama flush to middle cranial fossa floor."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Expansile Duroplasty",
                    detail: "Open dura in stellate or C-shaped fashion. Sew generous patch graft (pericranium, bovine, or synthetic)."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Closure & Bone Storage",
                    detail: "Store bone flap in sub-zero freezer or abdominal pocket. Close galea and skin without tension."
                )
            ]
        case .csdhBurrHole:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Localization & Scalp Incision",
                    detail: "Position supine with head turned. Make a 3 cm linear scalp incision over parietal boss."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "14 mm Burr Hole Craniostomy",
                    detail: "Perforate skull with high-speed cranial perforator. Ensure outer table, diploe, and inner plate are unroofed."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Cruciate Durotomy & Evacuation",
                    detail: "Bipolar outer dura and incise in cruciate fashion. Motor-oil subdural fluid egresses under pressure."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Saline Irrigation & Subdural Drain",
                    detail: "Irrigate subdural space copiously with warm saline until effluent is clear. Pass closed drain to gravity."
                )
            ]
        case .endonasalSellar:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Nasal Stage & Binostril Access",
                    detail: "Decongest nasal cavity, lateralize middle turbinates, harvest vascularized nasoseptal flap if high CSF leak risk."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Sphenoidotomy & Mucosal Stripping",
                    detail: "Identify sphenoid ostia, widely open anterior sphenoid wall, identify sellar floor, clival recess, and carotid prominences."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Sellar Dural Opening & Tumor Resection",
                    detail: "Thin sellar bone with micro-drill, unroof floor, cruciate dural opening, deliver pituitary adenoma using ring curettes."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Multilayer Reconstruction",
                    detail: "Inspect diaphragma sellae for CSF leaks. Reconstruct skull base with collagen sponge, fat graft, and nasoseptal flap."
                )
            ]
        case .farLateral:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Suboccipital Craniectomy & C1 Laminectomy",
                    detail: "Perform retrosigmoid suboccipital craniectomy to foramen magnum rim. Execute lateral C1 hemilaminectomy."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Unroofing Foramen Transversarium",
                    detail: "Use a 2 mm diamond burr under continuous irrigation to thin and remove bridge of C1 foramen transversarium."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Vertebral Artery Mobilization",
                    detail: "Sharply release fibrous collar and gently mobilize V3 loop medially with Penfield #4 dissector."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Partial Condylectomy & Dural Opening",
                    detail: "Drill posterior 1/3 of occipital condyle. Open dura along skull base floor."
                )
            ]
        case .chiariDecompression:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Midline Suboccipital Incision",
                    detail: "Incision from inion down to C2 spinous process. Dissect suboccipital muscles down to occiput and C1 arch."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Suboccipital Craniectomy & C1 Laminectomy",
                    detail: "Remove 3x3 cm suboccipital bone window including foramen magnum posterior rim. Excise C1 posterior arch."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Y-Shaped Dural Opening",
                    detail: "Open dura in Y-shape with base inferior. Inspect arachnoid over tonsils and foramen of Magendie."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Water-Tight Patch Duraplasty",
                    detail: "Suture generous pericardial or collagen duraplasty patch with running locked 5-0 suture to enlarge cisterna magna."
                )
            ]
        case .craniocervicalJunction:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Prone Concorde Positioning",
                    detail: "Fix head in Mayfield skull clamp with slight cervical flexion to optimize atlantoaxial alignment."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Expose C1 Posterior Arch & C2 Lamina",
                    detail: "Subperiosteal dissection of occiput, C1 posterior arch, and C2 lamina. Identify vertebral artery groove on C1."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Goel-Harms C1 Lateral Mass & C2 Pedicle Screws",
                    detail: "Place C1 lateral mass screws through posterior arch or below arch. Insert C2 pedicle or pars screws."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Reduction & Autologous Bone Grafting",
                    detail: "Reduce atlantoaxial subluxation under fluoroscopy. Decorticate bone and pack autologous cancellous bone graft."
                )
            ]
        case .harmsC1C2:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Exposure of C1-C2 Complex",
                    detail: "Expose posterior arch of C1, C2 lamina, and bilateral atlantoaxial facet joints under fluoroscopy."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "C1 Lateral Mass Screw Placement",
                    detail: "Retract C2 nerve root inferiorly. Cannulate C1 lateral mass targeting anterior arch under lateral fluoro."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "C2 Pedicle or Pars Screws",
                    detail: "Entry at superior medial quadrant of C2 pars/pedicle, aimed 25-30 degrees medial and 20 degrees cephalad."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Rod Assembly & Bone Grafting",
                    detail: "Connect polyaxial screw heads with pre-contoured titanium rods. Decorticate bone and pack autograft."
                )
            ]
        case .c7t1Junction:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Posterior Cervicothoracic Incision",
                    detail: "Expose spinous processes and laminae from C5 down to T3. Identify C7 prominent spinous process."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "C7 Pedicle Cannulation",
                    detail: "Entry at junction of superior facet and lateral mass. Aim 25-30 degrees medial, parallel to superior endplate."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "T1-T2 Thoracic Pedicle Screws",
                    detail: "Entry at junction of superior facet and transverse process. Straight-forward or anatomical trajectory."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Rod Linkage & Reduction",
                    detail: "Contour robust titanium rods matching cervical lordosis to thoracic kyphosis. Lock construct with cross-link."
                )
            ]
        case .lumbarFusionApproaches:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Posterior (PLIF / TLIF)",
                    detail: "Prone position. Direct bilateral (PLIF) or unilateral (TLIF) facetectomy to enter disc space."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Anterior (ALIF)",
                    detail: "Supine retroperitoneal or transperitoneal exposure of L5-S1 or L4-5 between great vessels."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Lateral Trans-Psoas (XLIF/LLIF)",
                    detail: "Lateral decubitus. Retroperitoneal corridor splitting psoas muscle under real-time EMG neuromonitoring."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Oblique Anterior-to-Psoas (OLIF)",
                    detail: "Corridor between aorta / IVC and psoas muscle, sparing lumbar plexus and psoas disruption."
                )
            ]
        case .tlifCorridor:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Unilateral Facetectomy",
                    detail: "Remove inferior and superior articular processes to expose exiting root and disc annulus."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Identify Traversing & Exiting Roots",
                    detail: "Delineate Kambin's triangle. Mobilize epidural veins and bipolar coagulate safely."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Annulotomy & Complete Discectomy",
                    detail: "Incise disc annulus with #11 blade. Curette cartilaginous endplates completely down to bleeding bone."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Interbody Cage Insertion",
                    detail: "Pack anterior disc space with autograft / DBM. Insert bulleted peek / titanium interbody cage obliquely across midline."
                )
            ]
        case .tlif:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Pedicle Screw Placement",
                    detail: "Cannulate L4 and L5 pedicles with standard open or percutaneous MIS techniques under fluoroscopy."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Unilateral Facetectomy",
                    detail: "Resect inferior articular process of L4 and superior articular process of L5 exposing foramen."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Discectomy & Endplate Preparation",
                    detail: "Incise annulus in Kambin's triangle. Completely evacuate disc with pituitary rongeurs and curettes."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Interbody Cage Insertion & Rod Fixation",
                    detail: "Insert PEEK/titanium cage into anterior disc space. Place bilateral rods and compress for lordosis."
                )
            ]
        case .acdf:
            return [
                ApproachSequentialStep(
                    stepNumber: 1,
                    title: "Smith-Robinson Transverse Incision",
                    detail: "Skin crease incision over target disc. Dissect plane between sternocleidomastoid and visceral sheath."
                ),
                ApproachSequentialStep(
                    stepNumber: 2,
                    title: "Longus Colli Elevation & Retractor Placement",
                    detail: "Elevate longus colli bilaterally. Seat toothed Cloward retractor blades under muscle bellies."
                ),
                ApproachSequentialStep(
                    stepNumber: 3,
                    title: "Complete Discectomy & PLL Resection",
                    detail: "Evacuate disc down to posterior longitudinal ligament (PLL). Resect PLL to decompress thecal sac."
                ),
                ApproachSequentialStep(
                    stepNumber: 4,
                    title: "Interbody Cage & Anterior Plate Fixation",
                    detail: "Insert interbody spacer packed with allograft. Apply anterior titanium cervical plate with locking screws."
                )
            ]
        }
    }

    public var catastrophicHazards: [String] {
        switch self {
        case .aneurysmClipping:
            return [
                "Premature intraoperative rupture prior to gaining proximal vascular control",
                "Inadvertent occlusion of critical branching perforators (e.g. Heubner's or anterior choroidal)",
                "Residual aneurysm neck dog-ear resulting in catastrophic delayed rebleed"
            ]
        case .pterionalFissure:
            return [
                "Avulsion of superficial Sylvian vein draining into sphenoparietal sinus",
                "Overzealous bipolar coagulation on MCA bifurcations causing hemispheric stroke",
                "Brain retraction ischemia if arachnoid cisternal drainage is incomplete"
            ]
        case .craniotomyBifrontal:
            return [
                "Frontal sinus mucosal breach leading to late mucocele and intracranial abscess",
                "Bilateral olfactory nerve transection with permanent anosmia",
                "Superior sagittal sinus laceration with catastrophic air embolism or exsanguination"
            ]
        case .craniotomyParietal:
            return [
                "Superior sagittal sinus laceration or air embolism during parasagittal drilling",
                "Eloquent somatosensory / motor cortex infarction from venous congestion",
                "Post-operative acute epidural hematoma under retracted bone edges"
            ]
        case .craniotomyTemporal:
            return [
                "Tearing of vein of Labbé with catastrophic hemorrhagic temporal lobe venous infarction",
                "Trigeminal ganglion or petrosal nerve injury causing severe facial numbness or dry eye",
                "Middle meningeal artery avulsion at the foramen spinosum"
            ]
        case .retrosigmoid3D:
            return [
                "Direct laceration of sigmoid sinus during mastoid emissary vein coagulation",
                "Venous air embolism if bone edges are not waxed immediately upon exposure"
            ]
        case .retrosigmoidDissection:
            return [
                "Avulsion of petrosal vein of Dandy precipitating life-threatening cerebellar hemorrhagic venous infarction",
                "Excessive stretch or thermal coagulation near CN VII/VIII causing permanent facial palsy or deafness"
            ]
        case .hemicraniectomy:
            return [
                "Inadequate bone flap (<12 cm) causing brain herniation against rigid bone edges and venous infarction",
                "Superior sagittal sinus or transverse sinus tear during rapid flap elevation",
                "Delayed sinking skin flap syndrome / trephined syndrome requiring early cranioplasty"
            ]
        case .csdhBurrHole:
            return [
                "Acute epidural or tension pneumocephalus following rapid evacuation without irrigation",
                "Bridging vein rupture or neomembrane tear causing catastrophic acute-on-chronic subdural bleeding",
                "Subdural empyema or bacterial seeding from unsterile closed drainage systems"
            ]
        case .endonasalSellar:
            return [
                "Internal carotid artery laceration at carotid protuberance / siphon with massive exsanguination",
                "High-flow CSF leak and pneumocephalus from diaphragma sellae tear",
                "Optic chiasm thermal injury or devascularization causing bilateral temporal hemianopia"
            ]
        case .farLateral:
            return [
                "Vertebral artery V3 laceration or dissection causing brainstem stroke",
                "Lower cranial nerve (CN IX, X, XI, XII) injury causing vocal cord paralysis or dysphagia",
                "Craniocervical instability if >50% of occipital condyle is removed"
            ]
        case .chiariDecompression:
            return [
                "PICA loop or vertebral artery injury during suboccipital foramen magnum rim drilling",
                "Refractory pseudomeningocele or CSF leak from inadequate water-tight duraplasty closure",
                "Aseptic or chemical meningitis from blood breakdown products in cisterna magna"
            ]
        case .craniocervicalJunction:
            return [
                "Brainstem or cervical cord transection during atlantoaxial reduction",
                "Vertebral artery V3 segment injury during C1 lateral mass screw placement",
                "Construct failure and cranial-cervical dislocation if transverse ligament is non-functional"
            ]
        case .harmsC1C2:
            return [
                "Vertebral artery injury at C1 groove or C2 transverse foramen causing cerebellum/brainstem stroke",
                "C2 nerve root injury causing severe intractable occipital neuralgia",
                "Spinal cord contusion or quadriparesis during reduction of displaced odontoid fracture"
            ]
        case .c7t1Junction:
            return [
                "Vertebral artery injury during C7 pedicle cannulation (enters at C6 transverse foramen in 90%)",
                "Construct pullout and junctional kyphosis if failing to extend fixation to rigid thoracic spine",
                "T1 root injury causing intrinsic hand muscle weakness and claw deformity"
            ]
        case .lumbarFusionApproaches:
            return [
                "Lumbar plexus injury (femoral nerve) during trans-psoas lateral approach (XLIF/LLIF)",
                "Iliac vessel laceration during anterior lumbar exposure (ALIF) causing exsanguination",
                "Exiting nerve root injury in foramen during transforaminal interbody placement (TLIF)"
            ]
        case .tlifCorridor:
            return [
                "Conjoined nerve root anomaly transection mistaken for herniated disc fragment",
                "Dural tear at exiting root axilla leading to refractory CSF fistula",
                "Interbody cage migration into spinal canal causing acute cauda equina syndrome"
            ]
        case .tlif:
            return [
                "Exiting nerve root injury in neural foramen from overzealous cranial retraction or cage impact",
                "Dural tear at lateral thecal sac margin resulting in refractory CSF leak and postural headache",
                "Anterior vascular injury (iliac vessels / aorta) from plunging discectomy instruments"
            ]
        case .acdf:
            return [
                "Esophageal perforation from aggressive blunt or sharp blade retractor placement",
                "Recurrent laryngeal nerve traction injury causing permanent vocal cord paralysis and hoarseness",
                "Vertebral artery injury from lateral drilling beyond the uncinate processes"
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
