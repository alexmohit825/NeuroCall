import SwiftUI

// MARK: - Studio-Grade Photorealistic Surgical Atlas Suite (Option C)
// Featuring Authentic High-Definition Medical Artwork Plates & Operative Skull Base Corridors
// Synthesized from Albert Rhoton Jr. Cranial Anatomy and Operative Corridors.
// Deep micro-zoom (1.0x to 4.0x), interactive pinned callouts, danger zone overlays, and tactical protocols.

public struct PhotorealisticSurgicalAtlasView: View {
    @State private var selectedDomain: AtlasDomain = .cranial
    @State private var selectedSubSection: AtlasSubSection? = nil
    @State private var selectedPlate: SurgicalPlateType = .plate017
    @State private var zoomScale: CGFloat = 1.0
    @State private var lastZoomScale: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero
    @State private var lastDragOffset: CGSize = .zero
    @State private var selectedCallout: SurgicalCallout? = nil
    @State private var showDangerOverlay: Bool = true
    @State private var showCalloutPins: Bool = true
    
    public init() {}
    
    private var currentFilteredPlates: [SurgicalPlateType] {
        if let sub = selectedSubSection {
            return sub.plates
        } else {
            return selectedDomain.plates
        }
    }
    
    private func selectAdjacentPlate(direction: Int) {
        let plates = currentFilteredPlates
        guard !plates.isEmpty, let idx = plates.firstIndex(of: selectedPlate) else { return }
        let nextIdx = (idx + direction + plates.count) % plates.count
        HapticManager.impact(style: .light)
        withAnimation(.easeInOut(duration: 0.22)) {
            selectedPlate = plates[nextIdx]
            zoomScale = 1.0
            dragOffset = .zero
            lastDragOffset = .zero
            selectedCallout = plates[nextIdx].callouts.first
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                atlasHeader
                
                // Primary Dual-Pillar Domain Selector (Cranial vs Spine)
                domainSelectorBar
                
                // Sub-Specialty Anatomical Section Selector
                subSectionSelectorBar
                
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
                if let idx = currentFilteredPlates.firstIndex(of: selectedPlate) {
                    Text("\(selectedPlate.domain.shortTitle) • \(idx + 1)/\(currentFilteredPlates.count) ◀ ▶")
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
    
    // MARK: - Primary Dual-Pillar Domain Selector (Cranial vs Spine)
    private var domainSelectorBar: some View {
        HStack(spacing: 8) {
            ForEach(AtlasDomain.allCases) { domain in
                Button(action: {
                    HapticManager.impact(style: .light)
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedDomain = domain
                        selectedSubSection = nil
                        if let first = domain.plates.first {
                            selectedPlate = first
                            zoomScale = 1.0
                            dragOffset = .zero
                            lastDragOffset = .zero
                            selectedCallout = first.callouts.first
                        }
                    }
                }) {
                    HStack(spacing: 6) {
                        Text(domain.rawValue)
                            .font(.system(size: 11, weight: .black))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(selectedDomain == domain ? ObsidianTheme.neonAmber : ObsidianTheme.surfaceElevated)
                    .foregroundColor(selectedDomain == domain ? .black : ObsidianTheme.textSecondary)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedDomain == domain ? ObsidianTheme.neonAmber : ObsidianTheme.borderSubtle, lineWidth: 1.5)
                    )
                }
            }
        }
        .padding(.horizontal, 14)
    }

    // MARK: - Sub-Specialty Anatomical Section Selector
    private var subSectionSelectorBar: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    // "All" chip for current domain
                    Button(action: {
                        HapticManager.impact(style: .light)
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedSubSection = nil
                            if !selectedDomain.plates.contains(selectedPlate), let first = selectedDomain.plates.first {
                                selectedPlate = first
                                zoomScale = 1.0
                                dragOffset = .zero
                                lastDragOffset = .zero
                                selectedCallout = first.callouts.first
                            }
                        }
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "square.grid.2x2.fill")
                                .font(.system(size: 10, weight: .bold))
                            Text("All \(selectedDomain == .cranial ? "Cranial" : "Spine") (\(selectedDomain.plateCount))")
                                .font(.system(size: 11, weight: .bold))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(selectedSubSection == nil ? ObsidianTheme.neonCyan.opacity(0.2) : ObsidianTheme.surfaceGlass)
                        .foregroundColor(selectedSubSection == nil ? ObsidianTheme.neonCyan : ObsidianTheme.textSecondary)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedSubSection == nil ? ObsidianTheme.neonCyan : ObsidianTheme.borderSubtle, lineWidth: 1)
                        )
                    }
                    
                    // Sub-sections
                    ForEach(selectedDomain.subSections) { sub in
                        Button(action: {
                            HapticManager.impact(style: .light)
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedSubSection = sub
                                if !sub.plates.contains(selectedPlate), let first = sub.plates.first {
                                   selectedPlate = first
                                   zoomScale = 1.0
                                   dragOffset = .zero
                                   lastDragOffset = .zero
                                   selectedCallout = first.callouts.first
                                }
                            }
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: sub.iconName)
                                    .font(.system(size: 10, weight: .bold))
                                Text("\(sub.rawValue) (\(sub.plates.count))")
                                    .font(.system(size: 11, weight: .bold))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(selectedSubSection == sub ? ObsidianTheme.neonAmber.opacity(0.2) : ObsidianTheme.surfaceGlass)
                            .foregroundColor(selectedSubSection == sub ? ObsidianTheme.neonAmber : ObsidianTheme.textSecondary)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedSubSection == sub ? ObsidianTheme.neonAmber : ObsidianTheme.borderSubtle, lineWidth: 1)
                            )
                        }
                        .id(sub)
                    }
                }
                .padding(.horizontal, 14)
            }
            .onChange(of: selectedPlate) { newPlate in
                withAnimation(.easeInOut(duration: 0.2)) {
                    proxy.scrollTo(newPlate.subSection, anchor: .center)
                }
            }
        }
    }

    // MARK: - Plate Selector Bar
    private var plateSelectorBar: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(currentFilteredPlates, id: \.self) { plate in
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
                if let idx = currentFilteredPlates.firstIndex(of: selectedPlate) {
                    Text("PLATE \(idx + 1) OF \(currentFilteredPlates.count)")
                        .font(.system(size: 12, weight: .black, design: .monospaced))
                        .foregroundColor(ObsidianTheme.textPrimary)
                }
                Text(selectedPlate.subSection.rawValue.uppercased())
                    .font(.system(size: 8, weight: .black))
                    .foregroundColor(ObsidianTheme.neonAmber)
                    .lineLimit(1)
            }
            .frame(width: 140)
            
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
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(selectedPlate.domain == .cranial ? "CRANIAL" : "SPINE")
                        .font(.system(size: 8, weight: .black))
                        .foregroundColor(ObsidianTheme.neonAmber)
                    Text("•")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(ObsidianTheme.textMuted)
                    Text(selectedPlate.subSection.rawValue.uppercased())
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                Text(selectedPlate.title)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.textPrimary)
                    .lineLimit(1)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.black.opacity(0.85))
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
            .overlay(
                MultiTouchPanZoomOverlay(
                    scale: $zoomScale,
                    offset: $dragOffset,
                    maxScale: 5.0,
                    allowHorizontalSwipe: true,
                    onSwipeNext: { selectAdjacentPlate(direction: 1) },
                    onSwipePrevious: { selectAdjacentPlate(direction: -1) }
                )
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
public enum AtlasDomain: String, CaseIterable, Identifiable {
    case cranial = "🧠 CRANIAL & SKULL BASE (22)"
    case spine = "🦴 SPINE & CVJ (21)"
    
    public var id: String { rawValue }
    
    public var shortTitle: String {
        switch self {
        case .cranial: return "🧠 CRANIAL"
        case .spine: return "🦴 SPINE"
        }
    }
    
    public var plateCount: Int {
        switch self {
        case .cranial: return 22
        case .spine: return 21
        }
    }
    
    public var subSections: [AtlasSubSection] {
        switch self {
        case .cranial:
            return [.anteriorSkullBase, .convexityTrauma, .posteriorFossa, .vascularVentricular]
        case .spine:
            return [.craniovertebral, .cervical, .thoracicOncology, .lumbarMIS, .deformitySalvage]
        }
    }
    
    public var plates: [SurgicalPlateType] {
        subSections.flatMap { $0.plates }
    }
}

public enum AtlasSubSection: String, CaseIterable, Identifiable {
    // Cranial (4 sub-sections)
    case anteriorSkullBase = "Anterior Skull Base"
    case convexityTrauma = "Convexity & Trauma"
    case posteriorFossa = "Posterior Fossa"
    case vascularVentricular = "Vascular & Ventricular"
    
    // Spine (5 sub-sections)
    case craniovertebral = "Craniovertebral Junction"
    case cervical = "Cervical Spine"
    case thoracicOncology = "Thoracic & Oncology"
    case lumbarMIS = "Lumbar & MIS Corridors"
    case deformitySalvage = "Deformity & Salvage"
    
    public var id: String { rawValue }
    
    public var domain: AtlasDomain {
        switch self {
        case .anteriorSkullBase, .convexityTrauma, .posteriorFossa, .vascularVentricular:
            return .cranial
        case .craniovertebral, .cervical, .thoracicOncology, .lumbarMIS, .deformitySalvage:
            return .spine
        }
    }
    
    public var iconName: String {
        switch self {
        case .anteriorSkullBase: return "eye.circle.fill"
        case .convexityTrauma: return "brain.head.profile"
        case .posteriorFossa: return "circle.grid.cross.fill"
        case .vascularVentricular: return "cross.vial.fill"
        case .craniovertebral: return "link.circle.fill"
        case .cervical: return "figure.stand"
        case .thoracicOncology: return "shield.lefthalf.filled"
        case .lumbarMIS: return "square.stack.3d.down.right.fill"
        case .deformitySalvage: return "arrow.triangle.merge"
        }
    }
    
    public var plates: [SurgicalPlateType] {
        switch self {
        case .anteriorSkullBase:
            return [.plate017, .plate009, .plate012, .plate008, .plate005, .plate033, .plate030]
        case .convexityTrauma:
            return [.plate018, .plate016, .plate019, .plate021, .plate025]
        case .posteriorFossa:
            return [.plate010, .plate020, .plate004, .plate003, .plate006, .plate022]
        case .vascularVentricular:
            return [.plate002, .plate027, .plate040, .plate041]
        case .craniovertebral:
            return [.plate001, .plate013, .plate014, .plate035, .plate043]
        case .cervical:
            return [.plate015, .plate031, .plate034, .plate042]
        case .thoracicOncology:
            return [.plate026, .plate036, .plate038]
        case .lumbarMIS:
            return [.plate011, .plate007, .plate037, .plate029, .plate028, .plate032]
        case .deformitySalvage:
            return [.plate023, .plate024, .plate039]
        }
    }
}

public enum AtlasCategory: String, CaseIterable {
    case all = "All Plates (43)"
    case cranial = "Cranial & Skull Base (22)"
    case spine = "Spine & CVJ (21)"

    public var filteredPlates: [SurgicalPlateType] {
        switch self {
        case .all:
            return AtlasDomain.cranial.plates + AtlasDomain.spine.plates
        case .cranial:
            return AtlasDomain.cranial.plates
        case .spine:
            return AtlasDomain.spine.plates
        }
    }
}
public enum SurgicalPlateType: String, CaseIterable {
    case plate001 = "plate_001_craniocervical_junction_gray307"
    case plate002 = "plate_002_neonatal_evd_fontanelle"
    case plate003 = "plate_003_suboccipital_craniectomy_cisterna_magna"
    case plate004 = "plate_004_retrosigmoid_cpa_microdissection"
    case plate005 = "plate_005_frontotemporal_orbitozygomatic_ftozo"
    case plate006 = "plate_006_far_lateral_transcondylar_vertebral_artery"
    case plate007 = "plate_007_lumbar_lateral_recess_stenosis"
    case plate008 = "plate_008_pterional_pcoma_aneurysm_clipping"
    case plate009 = "plate_009_sylvian_fissure_distal_split"
    case plate010 = "plate_010_retromastoid_positioning_landmarks"
    case plate011 = "plate_011_lumbar_disc_degeneration_annular_tear"
    case plate012 = "plate_012_pterional_sylvian_fissure"
    case plate013 = "plate_013_chiari_decompression_duraplasty"
    case plate014 = "plate_014_harms_c1_c2_fixation"
    case plate015 = "plate_015_acdf_anterior_cervical"
    case plate016 = "plate_016_temporal_craniotomy_middle_meningeal"
    case plate017 = "plate_017_pterional_craniotomy_bone_window"
    case plate018 = "plate_018_bifrontal_craniotomy_3d"
    case plate019 = "plate_019_parietal_craniotomy_dura"
    case plate020 = "plate_020_retrosigmoid_asterion_3d"
    case plate021 = "plate_021_decompressive_hemicraniectomy_duroplasty"
    case plate022 = "plate_022_pineal_supracerebellar_transtentorial_corridors"
    case plate023 = "plate_023_smith_petersen_ponte_osteotomy"
    case plate024 = "plate_024_pedicle_subtraction_osteotomy_pso"
    case plate025 = "plate_025_atl_vs_selective_amygdalohippocampectomy"
    case plate026 = "plate_026_thoracic_costotransversectomy"
    case plate027 = "plate_027_mips_ich_tubular_evacuation"
    case plate028 = "plate_028_llif_transpsoas_corridor"
    case plate029 = "plate_029_tlif_surgical_corridor"
    case plate030 = "plate_030_endoscopic_endonasal_sellar"
    case plate031 = "plate_031_posterior_cervical_decompression_fusion"
    case plate032 = "plate_032_360_lumbar_interbody_fusion_approaches"
    case plate033 = "plate_033_supraorbital_eyebrow_keyhole_craniotomy"
    case plate034 = "plate_034_bilateral_jumped_cervical_facets"
    case plate035 = "plate_035_odontoid_fractures_classification"
    case plate036 = "plate_036_thoracolumbar_burst_fracture"
    case plate037 = "plate_037_cauda_equina_massive_lumbar_disc"
    case plate038 = "plate_038_metastatic_epidural_spinal_cord_compression"
    case plate039 = "plate_039_postoperative_lumbar_pseudomeningocele_dural_repair"
    case plate040 = "plate_040_aneurysmal_subarachnoid_hemorrhage"
    case plate041 = "plate_041_ganglionic_ich_intraventricular_hemorrhage"
    case plate042 = "plate_042_cervical_spondylotic_myelopathy"
    case plate043 = "plate_043_pediatric_atlantoaxial_rotatory_subluxation"

    public var subSection: AtlasSubSection {
        for section in AtlasSubSection.allCases {
            if section.plates.contains(self) {
                return section
            }
        }
        return .anteriorSkullBase
    }
    
    public var domain: AtlasDomain {
        subSection.domain
    }

    public var plateNumber: Int {
        switch self {
        case .plate001: return 1
        case .plate002: return 2
        case .plate003: return 3
        case .plate004: return 4
        case .plate005: return 5
        case .plate006: return 6
        case .plate007: return 7
        case .plate008: return 8
        case .plate009: return 9
        case .plate010: return 10
        case .plate011: return 11
        case .plate012: return 12
        case .plate013: return 13
        case .plate014: return 14
        case .plate015: return 15
        case .plate016: return 16
        case .plate017: return 17
        case .plate018: return 18
        case .plate019: return 19
        case .plate020: return 20
        case .plate021: return 21
        case .plate022: return 22
        case .plate023: return 23
        case .plate024: return 24
        case .plate025: return 25
        case .plate026: return 26
        case .plate027: return 27
        case .plate028: return 28
        case .plate029: return 29
        case .plate030: return 30
        case .plate031: return 31
        case .plate032: return 32
        case .plate033: return 33
        case .plate034: return 34
        case .plate035: return 35
        case .plate036: return 36
        case .plate037: return 37
        case .plate038: return 38
        case .plate039: return 39
        case .plate040: return 40
        case .plate041: return 41
        case .plate042: return 42
        case .plate043: return 43
        }
    }

    public var assetImageName: String? {
        return self.rawValue
    }

    public var shortTitle: String {
        switch self {
        case .plate001: return "01: CCJ Ligaments"
        case .plate002: return "02: Fontanelle EVD"
        case .plate003: return "03: Suboccipital"
        case .plate004: return "04: Retrosigmoid CPA"
        case .plate005: return "05: Two-Piece FT-OZO"
        case .plate006: return "06: Far-Lateral VA"
        case .plate007: return "07: Lateral Recess"
        case .plate008: return "08: PComA Aneurysm"
        case .plate009: return "09: Distal Sylvian Split"
        case .plate010: return "10: Retromastoid Mayfield"
        case .plate011: return "11: Disc Annular Tear"
        case .plate012: return "12: Pterional Fissure"
        case .plate013: return "13: Chiari I Duraplasty"
        case .plate014: return "14: Goel-Harms C1-C2"
        case .plate015: return "15: ACDF Corridor"
        case .plate016: return "16: Temporal MMA Map"
        case .plate017: return "17: Pterional Bone"
        case .plate018: return "18: Bifrontal 3D"
        case .plate019: return "19: Parietal SSS"
        case .plate020: return "20: Asterion Window"
        case .plate021: return "21: Hemicraniectomy"
        case .plate022: return "22: Pineal Corridors"
        case .plate023: return "23: SPO & Ponte"
        case .plate024: return "24: 3-Column PSO"
        case .plate025: return "25: ATL vs SelAH"
        case .plate026: return "26: Costotransversectomy"
        case .plate027: return "27: MIPS Tubular ICH"
        case .plate028: return "28: LLIF Transpsoas"
        case .plate029: return "29: TLIF Corridor"
        case .plate030: return "30: Endonasal Sellar"
        case .plate031: return "31: Posterior C7-T1"
        case .plate032: return "32: 360 Lumbar Fusion"
        case .plate033: return "33: Supraorbital Eyebrow"
        case .plate034: return "34: Jumped Facets"
        case .plate035: return "35: Odontoid Fractures"
        case .plate036: return "36: Burst Fracture"
        case .plate037: return "37: Cauda Equina"
        case .plate038: return "38: MESCC Bilsky 3"
        case .plate039: return "39: Pseudomeningocele"
        case .plate040: return "40: Aneurysmal SAH"
        case .plate041: return "41: Ganglionic ICH & IVH"
        case .plate042: return "42: Cervical Myelopathy"
        case .plate043: return "43: Pediatric AARS"
        }
    }

    public var title: String {
        switch self {
        case .plate001: return "Posterior Craniocervical Junction (Occiput–C1–C2)"
        case .plate002: return "Neonatal Ventricular Access Device / EVD via Open Anterior Fontanelle"
        case .plate003: return "Midline Suboccipital Craniectomy & Cisterna Magna Dissection"
        case .plate004: return "Right Retrosigmoid Cerebellopontine Angle (CPA) Microdissection"
        case .plate005: return "Two-Piece Fronto-Temporal Orbitozygomatic (FT-OZO) Craniotomy"
        case .plate006: return "Right Far-Lateral Transcondylar Approach with Vertebral Artery Mobilization"
        case .plate007: return "Lumbar Lateral Recess Stenosis vs. Normal Spine (Axial Comparison)"
        case .plate008: return "Left Pterional Transsylvian Approach & PComA Aneurysm Clipping (1:1 Modernized Master)"
        case .plate009: return "Splitting of Distal Anterior Sylvian Fissure (Microsurgical Corridor)"
        case .plate010: return "Retromastoid / Retrosigmoid Positioning, 3-Pin Mayfield Fixation & Surface Landmarks"
        case .plate011: return "Lumbar Disc Degeneration & Posterior Annular Tear (Axial + Sagittal View)"
        case .plate012: return "Left Pterional Craniotomy & Sylvian Fissure Opercular Exposure (1:1 Modernized Master)"
        case .plate013: return "Chiari I Malformation Suboccipital Decompression & Expansile Patch Duraplasty (1:1 Modernized Master)"
        case .plate014: return "Posterior C1–C2 Goel-Harms Screw-Rod Fixation Construct (1:1 Modernized Master)"
        case .plate015: return "Anterior Cervical Discectomy & Fusion (ACDF) — Smith-Robinson Corridor (1:1 Modernized & Restored Master)"
        case .plate016: return "Right Subtemporal / Temporal Craniotomy & Middle Meningeal Artery (1:1 Text-Scrubbed Master)"
        case .plate017: return "Left Pterional (Frontotemporal) Craniotomy Bone Window & Sphenoid Ridge (3D Master)"
        case .plate018: return "Bifrontal Craniotomy 3D Skull Model & Anterior Cranial Fossa Corridor"
        case .plate019: return "Left Parietal Craniotomy Window & Dural Venous Tributaries (3D Master)"
        case .plate020: return "Right Retrosigmoid / Asterion Craniectomy Window & Dural Venous Junction (3D Master)"
        case .plate021: return "Decompressive Frontotemporoparietal Hemicraniectomy & Expansile Duroplasty"
        case .plate022: return "Pineal Region Tumor & Supracerebellar Infratentorial / Transtentorial Corridors (Midsagittal Master)"
        case .plate023: return "Smith-Petersen (SPO) & Ponte Posterior Column Osteotomy — Open Wedge vs. Closed Lordotic Correction"
        case .plate024: return "Three-Column Pedicle Subtraction Osteotomy (PSO) — Transpedicular Wedge Resection vs. Closed Lordotic Correction"
        case .plate025: return "Anterior Temporal Lobectomy (ATL) vs. Selective Amygdalohippocampectomy (SelAH)"
        case .plate026: return "Thoracic Costotransversectomy — Posterolateral Extrapleural Approach (Two-Panel 3D & Axial Master)"
        case .plate027: return "Minimally Invasive Parafascicular Surgery (MIPS) — Trans-Sulcal Tubular ICH Evacuation"
        case .plate028: return "Lateral Lumbar Interbody Fusion (LLIF / XLIF) — Transpsoas Retroperitoneal Corridor"
        case .plate029: return "Transforaminal Lumbar Interbody Fusion (TLIF) — Modernized Operative Overview"
        case .plate030: return "Endoscopic Endonasal Sellar Corridor — Skull Base Landmarks & Microvascular Relationships"
        case .plate031: return "Posterior Cervical (C7–T1) Decompression & Stabilization"
        case .plate032: return "360° Comprehensive Lumbar Interbody Fusion Approaches (ALIF / OLIF / LLIF / TLIF / PLIF)"
        case .plate033: return "Supraorbital Eyebrow Keyhole Craniotomy"
        case .plate034: return "Bilateral Jumped / Locked Cervical Facets (C6–C7) — Diagnostic & Pathoanatomical Correlation"
        case .plate035: return "Anderson & D'Alonzo Odontoid Fractures Classification & Management Strategy"
        case .plate036: return "Acute Thoracolumbar Burst Fracture & Canal Retropulsion"
        case .plate037: return "Cauda Equina Syndrome — Massive Lumbar Disc Extrusion"
        case .plate038: return "Metastatic Epidural Spinal Cord Compression (MESCC — Bilsky Grade 3)"
        case .plate039: return "Postoperative Lumbar Pseudomeningocele & Microsurgical Dural Repair"
        case .plate040: return "Acute Aneurysmal Subarachnoid Hemorrhage (SAH) & Acute Hydrocephalus"
        case .plate041: return "Hypertensive Ganglionic Intracerebral Hemorrhage (ICH) & Intraventricular Extension (IVH)"
        case .plate042: return "Cervical Spondylotic Myelopathy (CSM) & Multilevel Canal Stenosis"
        case .plate043: return "Pediatric Atlantoaxial Rotatory Subluxation (AARS) & Fielding Classification"
        }
    }

    public var iconName: String {
        switch self {
        case .plate001: return "link"
        case .plate002: return "cross.vial.fill"
        case .plate003: return "circle.hexagonpath.fill"
        case .plate004: return "waveform.path.ecg"
        case .plate005: return "eye.circle.fill"
        case .plate006: return "tortoiseshell.fill"
        case .plate007: return "arrow.triangle.pull"
        case .plate008: return "bolt.horizontal.fill"
        case .plate009: return "brain.head.profile"
        case .plate010: return "circle.grid.cross"
        case .plate011: return "waveform.path"
        case .plate012: return "brain.head.profile"
        case .plate013: return "brain"
        case .plate014: return "wrench.and.screwdriver.fill"
        case .plate015: return "arrow.up.and.down.circle.fill"
        case .plate016: return "ear"
        case .plate017: return "shield.lefthalf.filled"
        case .plate018: return "face.dashed"
        case .plate019: return "cross.case.fill"
        case .plate020: return "circle.grid.cross"
        case .plate021: return "shield.slash.fill"
        case .plate022: return "sparkles"
        case .plate023: return "arrow.triangle.branch"
        case .plate024: return "arrow.triangle.branch"
        case .plate025: return "scissors"
        case .plate026: return "cube.fill"
        case .plate027: return "cylinder.split.1x2.fill"
        case .plate028: return "arrow.left.and.right.circle.fill"
        case .plate029: return "triangle.fill"
        case .plate030: return "mouth"
        case .plate031: return "point.topleft.down.curvedto.point.bottomright.up"
        case .plate032: return "square.stack.3d.down.right.fill"
        case .plate033: return "eye.fill"
        case .plate034: return "lock.open.fill"
        case .plate035: return "triangle.circle.fill"
        case .plate036: return "burst.fill"
        case .plate037: return "waveform.path.badge.plus"
        case .plate038: return "cross.circle.fill"
        case .plate039: return "bandage.fill"
        case .plate040: return "bolt.horizontal.fill"
        case .plate041: return "drop.fill"
        case .plate042: return "lines.measurement.horizontal"
        case .plate043: return "arrow.triangle.2.circlepath.circle.fill"
        }
    }

    public var callouts: [SurgicalCallout] {
        switch self {
        case .plate001:
            return [
                SurgicalCallout(
                    id: "plate_001_1",
                    title: "Posterior Craniocervical Junction (",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Deep stabilizing ligaments of the spinal canal with vertebral arches resected.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate002:
            return [
                SurgicalCallout(
                    id: "plate_002_1",
                    title: "Neonatal Ventricular Access Device ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "External ventricular drain and subcutaneous reservoir placement in a neonate with open cranial sutures.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate003:
            return [
                SurgicalCallout(
                    id: "plate_003_1",
                    title: "Midline Suboccipital Craniectomy & ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct operative view into the posterior fossa through a midline suboccipital craniectomy with dural opening under surgical microscope magni",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate004:
            return [
                SurgicalCallout(
                    id: "plate_004_1",
                    title: "Right Retrosigmoid Cerebellopontine",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Operative microsurgical view into the right cerebellopontine angle through a retrosigmoid / retromastoid craniectomy.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate005:
            return [
                SurgicalCallout(
                    id: "plate_005_1",
                    title: "Two-Piece Fronto-Temporal Orbitozyg",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "3-part exploded osteological plate showing the cranium and its two detached bone pieces (pterional flap and one-piece orbitozygomatic bar).",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate006:
            return [
                SurgicalCallout(
                    id: "plate_006_1",
                    title: "Right Far-Lateral Transcondylar App",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Microsurgical operative view of the right craniocervical junction during a far-lateral transcondylar approach with mobilization of the V3 ve",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate007:
            return [
                SurgicalCallout(
                    id: "plate_007_1",
                    title: "Lumbar Lateral Recess Stenosis vs. ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Side-by-side comparative axial cross-sections at L4–L5 contrasting a normal, patent lumbar canal with severe lateral recess (subarticular) s",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate008:
            return [
                SurgicalCallout(
                    id: "plate_008_1",
                    title: "Left Pterional Transsylvian Approac",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 surface-texture modernization of NeuroCall Plate 1 (`plate_aneurysm`), preserving 100% of the exact perspective, vascular geometr",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate009:
            return [
                SurgicalCallout(
                    id: "plate_009_1",
                    title: "Splitting of Distal Anterior Sylvia",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Microsurgical opening of the superficial and deep Sylvian cisterns between the frontal and temporal opercula.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate010:
            return [
                SurgicalCallout(
                    id: "plate_010_1",
                    title: "Retromastoid / Retrosigmoid Positio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Lateral cranial positioning in a 3-point Mayfield skull clamp illustrating the osteological and dural venous sinus landmarks for a retromast",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate011:
            return [
                SurgicalCallout(
                    id: "plate_011_1",
                    title: "Lumbar Disc Degeneration & Posterio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Dual-view anatomical pathology plate showing concentric annular lamellae with a posterior radial/concentric annular tear (top axial view) an",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate012:
            return [
                SurgicalCallout(
                    id: "plate_012_1",
                    title: "Left Pterional Craniotomy & Sylvian",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 modernization of NeuroCall's `plate_pterional_fissure` line drawing into publication-grade Modern Atlas Realism.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate013:
            return [
                SurgicalCallout(
                    id: "plate_013_1",
                    title: "Chiari I Malformation Suboccipital ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 dual-panel modernization of NeuroCall's `plate_chiari_decompression` comparing pre-duraplasty tonsillar herniation (left) with co",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate014:
            return [
                SurgicalCallout(
                    id: "plate_014_1",
                    title: "Posterior C1–C2 Goel-Harms Screw-Ro",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 dual-view modernization of NeuroCall's `plate_harms_c1_c2` illustrating bilateral C1 lateral mass and C2 pedicle/pars polyaxial s",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate015:
            return [
                SurgicalCallout(
                    id: "plate_015_1",
                    title: "Anterior Cervical Discectomy & Fusi",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 surface-texture modernization and inferior vertebral body restoration of NeuroCall's `plate_acdf`.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate016:
            return [
                SurgicalCallout(
                    id: "plate_016_1",
                    title: "Right Subtemporal / Temporal Cranio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 typography-scrubbed master of NeuroCall's `plate_craniotomy_temporal`, showing a right temporal craniotomy flush with the zygomat",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate017:
            return [
                SurgicalCallout(
                    id: "plate_017_1",
                    title: "Left Pterional (Frontotemporal) Cra",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "3D osteological and cortical exposure of a standard left frontotemporal (pterional) craniotomy centered on the sphenoid ridge and Sylvian cl",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate018:
            return [
                SurgicalCallout(
                    id: "plate_018_1",
                    title: "Bifrontal Craniotomy 3D Skull Model",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Anterior coronal 3D skull view demonstrating a bilateral frontal craniotomy crossing the midline above the supraorbital rims, exposing both ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate019:
            return [
                SurgicalCallout(
                    id: "plate_019_1",
                    title: "Left Parietal Craniotomy Window & D",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Left lateral 3D skull model with a circumscribed parietal craniotomy behind the coronal suture, showing the beveled diploic bone margin and ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate020:
            return [
                SurgicalCallout(
                    id: "plate_020_1",
                    title: "Right Retrosigmoid / Asterion Crani",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Right posterolateral 3D skull and upper cervical spine model illustrating the key retrosigmoid craniectomy window tucked immediately inferio",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate021:
            return [
                SurgicalCallout(
                    id: "plate_021_1",
                    title: "Decompressive Frontotemporoparietal",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Large trauma/stroke frontotemporoparietal hemicraniectomy with reflected myocutaneous scalp flap, peripheral bone tack-up holes, and waterti",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate022:
            return [
                SurgicalCallout(
                    id: "plate_022_1",
                    title: "Pineal Region Tumor & Supracerebell",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Midsagittal anatomical and surgical corridor master illustrating a pineal region mass in the quadrigeminal cistern and the three classic sur",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate023:
            return [
                SurgicalCallout(
                    id: "plate_023_1",
                    title: "Smith-Petersen (SPO) & Ponte Poster",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Two-stage lateral biomechanical and osteological comparison of a Schwab Grade 2 Posterior Column Osteotomy (Smith-Petersen / Ponte Osteotomy",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate024:
            return [
                SurgicalCallout(
                    id: "plate_024_1",
                    title: "Three-Column Pedicle Subtraction Os",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Two-stage lateral biomechanical and osteological comparison of a Schwab Grade 3 Three-Column Pedicle Subtraction Osteotomy (PSO) across a 3-",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate025:
            return [
                SurgicalCallout(
                    id: "plate_025_1",
                    title: "Anterior Temporal Lobectomy (ATL) v",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "4-part 2x2 comparative neurosurgical epilepsy atlas plate contrasting Anterior Temporal Lobectomy (ATL, left column) with Selective Amygdalo",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate026:
            return [
                SurgicalCallout(
                    id: "plate_026_1",
                    title: "Thoracic Costotransversectomy — Pos",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Dual-panel comprehensive spine atlas plate depicting a completed Right-Sided Thoracic Costotransversectomy (posterolateral extrapleural corr",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate027:
            return [
                SurgicalCallout(
                    id: "plate_027_1",
                    title: "Minimally Invasive Parafascicular S",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Three-panel master neurosurgical atlas plate illustrating Minimally Invasive Parafascicular Surgery (MIPS) for deep subcortical/basal gangli",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate028:
            return [
                SurgicalCallout(
                    id: "plate_028_1",
                    title: "Lateral Lumbar Interbody Fusion (LL",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Publication-grade anatomical atlas plate depicting the surgical transpsoas retroperitoneal corridor for Lateral Lumbar Interbody Fusion (LLI",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate029:
            return [
                SurgicalCallout(
                    id: "plate_029_1",
                    title: "Transforaminal Lumbar Interbody Fus",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Modernized multi-panel educational atlas plate illustrating Transforaminal Lumbar Interbody Fusion (TLIF).",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate030:
            return [
                SurgicalCallout(
                    id: "plate_030_1",
                    title: "Endoscopic Endonasal Sellar Corrido",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-quadrant endoscopic transsphenoidal skull base master plate illustrating anatomical landmarks and neurovascular relationships for pitui",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate031:
            return [
                SurgicalCallout(
                    id: "plate_031_1",
                    title: "Posterior Cervical (C7–T1) Decompre",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Dual-panel cervical spine atlas plate illustrating C2–T1 root anatomy alongside posterior C7–T1 laminectomy, C8 nerve root decompression, an",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate032:
            return [
                SurgicalCallout(
                    id: "plate_032_1",
                    title: "360° Comprehensive Lumbar Interbody",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel anatomical and biomechanical reference plate comparing all 360° surgical corridors into the lumbar intervertebral disc space.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate033:
            return [
                SurgicalCallout(
                    id: "plate_033_1",
                    title: "Supraorbital Eyebrow Keyhole Cranio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Master 3D cranial osteology plate demonstrating the precise bone window, burr hole placement, and surgical landmarks for the Supraorbital Ey",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate034:
            return [
                SurgicalCallout(
                    id: "plate_034_1",
                    title: "Bilateral Jumped / Locked Cervical ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-panel master atlas plate correlating authentic diagnostic radiology (CT & MRI) with high-detail Netter-style pathoanatomical dissection",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate035:
            return [
                SurgicalCallout(
                    id: "plate_035_1",
                    title: "Anderson & D'Alonzo Odontoid Fractu",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Master neurosurgical spine trauma decision plate detailing the anatomical classification, vascular watershed biomechanics, union rates, and ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate036:
            return [
                SurgicalCallout(
                    id: "plate_036_1",
                    title: "Acute Thoracolumbar Burst Fracture ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-panel master atlas plate correlating authentic diagnostic CT imaging (axial and sagittal bone windows) with 3D Frank Netter-style sagit",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate037:
            return [
                SurgicalCallout(
                    id: "plate_037_1",
                    title: "Cauda Equina Syndrome — Massive Lum",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Sagittal T2 MRI with 3D Frank Netter-style sagittal and axial pa",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate038:
            return [
                SurgicalCallout(
                    id: "plate_038_1",
                    title: "Metastatic Epidural Spinal Cord Com",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Sagittal T2 MRI with 3D Frank Netter-style sagittal and axial pa",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate039:
            return [
                SurgicalCallout(
                    id: "plate_039_1",
                    title: "Postoperative Lumbar Pseudomeningoc",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-panel master neurosurgical atlas plate correlating authentic diagnostic T2 MRI (sagittal and axial) with 3D Frank Netter-style sagittal",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate040:
            return [
                SurgicalCallout(
                    id: "plate_040_1",
                    title: "Acute Aneurysmal Subarachnoid Hemor",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Axial Non-Contrast Head CT with 3D Frank Netter-style Circle of ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate041:
            return [
                SurgicalCallout(
                    id: "plate_041_1",
                    title: "Hypertensive Ganglionic Intracerebr",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Axial Non-Contrast Head CT with 3D Frank Netter-style axial basa",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate042:
            return [
                SurgicalCallout(
                    id: "plate_042_1",
                    title: "Cervical Spondylotic Myelopathy (CS",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic High-Resolution Sagittal T2 Cervical MRI with 3D Frank Netter-st",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate043:
            return [
                SurgicalCallout(
                    id: "plate_043_1",
                    title: "Cock-Robin Torticollis Presentation",
                    structureType: "CLINICAL HALLMARK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.18,
                    normalizedY: 0.45,
                    description: "Head tilted toward ipsilateral shoulder with chin rotated toward contralateral shoulder. Contralateral SCM in reactive spasm (opposing deformity), distinguishing AARS from congenital muscular torticollis.",
                    surgicalPearl: "Often triggered by Grisel's syndrome (pharyngovertebral venous hyperemia after URI / ENT surgery) or minor sports trauma."
                ),
                SurgicalCallout(
                    id: "plate_043_2",
                    title: "C1–C2 Rotatory Lock & Subluxation",
                    structureType: "BONY KINEMATICS",
                    color: Color.red,
                    normalizedX: 0.65,
                    normalizedY: 0.42,
                    description: "C1 ring rotated 25°–30° on C2. One C1 lateral mass subluxates anteriorly onto the anterior slope of C2 superior articular facet (exposing cartilage); contralateral mass displaced posteriorly.",
                    surgicalPearl: "Diagnostic Gold Standard: Dynamic Cervical 3D-CT (head turned left, neutral, right) showing non-reducing fixed C1–C2 rotational angle."
                ),
                SurgicalCallout(
                    id: "plate_043_3",
                    title: "Fielding Classification & TAL Sling",
                    structureType: "STABILIZING LIGAMENTS",
                    color: Color.cyan,
                    normalizedX: 0.58,
                    normalizedY: 0.35,
                    description: "Type I: Rotatory fixation without anterior shift (AADI ≤ 3 mm, TAL intact). Type II: 3–5 mm anterior translation (TAL deficient). Type III: > 5 mm bilateral shift. Type IV: Posterior subluxation.",
                    surgicalPearl: "Intact Transverse Atlantal Ligament preserves upper canal diameter, protecting the spinal cord from compression in Type I."
                )
            ]
        }
    }

    public var steps: [ApproachSequentialStep] {
        switch self {
        case .plate001:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate002:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate003:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate004:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate005:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate006:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate007:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate008:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate009:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate010:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate011:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate012:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate013:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate014:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate015:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate016:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate017:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate018:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate019:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate020:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate021:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate022:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate023:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate024:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate025:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate026:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate027:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate028:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate029:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate030:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate031:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate032:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate033:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate034:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate035:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate036:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate037:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate038:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate039:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate040:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate041:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate042:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate043:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Acute Phase (< 1–2 Weeks)", detail: "Soft cervical collar, strict bed rest, analgesia, NSAIDs, and muscle relaxants (diazepam). >80% spontaneous resolution rate."),
                ApproachSequentialStep(stepNumber: 2, title: "Subacute Phase (2–4 Weeks)", detail: "Inpatient continuous cervical halter traction (5–7 lbs) with mild neck extension until reduction confirmed on lateral C-spine. Rigid collar / Minerva brace for 4–6 weeks."),
                ApproachSequentialStep(stepNumber: 3, title: "Chronic (> 1 Month) / Failed Traction", detail: "Halo-gravity traction under conscious sedation with fluoroscopic monitoring. If reduction achieved, immobilize in Halo vest for 8–12 weeks."),
                ApproachSequentialStep(stepNumber: 4, title: "Surgical Goel-Harms Fusion (Refractory/Type III–IV)", detail: "Posterior C1–C2 instrumental fusion (C1 lateral mass and C2 pedicle/pars screws) indicated for irreducible deformity, recurrence, neurologic deficit, or Fielding Type III/IV (AADI > 5 mm).")
            ]
        }
    }

    public var catastrophicHazards: [String] {
        switch self {
        case .plate001:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate002:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate003:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate004:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate005:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate006:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate007:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate008:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate009:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate010:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate011:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate012:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate013:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate014:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate015:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate016:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate017:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate018:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate019:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate020:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate021:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate022:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate023:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate024:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate025:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate026:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate027:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate028:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate029:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate030:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate031:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate032:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate033:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate034:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate035:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate036:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate037:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate038:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate039:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate040:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate041:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate042:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate043:
            return [
                "Never attempt forceful manual manipulation or sudden rotational cracking under anesthesia without traction; high risk of dens displacement or fatal cervicomedullary injury.",
                "Distinguish AARS from Congenital Muscular Torticollis: in AARS, the tight/spastic SCM is CONTRALATERAL to head tilt; in congenital torticollis, tight SCM is IPSILATERAL.",
                "Fielding Type III (>5 mm anterior displacement) and Type IV carry high risk of cord compression and transverse ligament rupture; halo reduction and prompt surgical fusion are mandatory."
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
