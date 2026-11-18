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
    case cranial = "🧠 CRANIAL & SKULL BASE (23)"
    case spine = "🦴 SPINE & CVJ (22)"
    
    public var id: String { rawValue }
    
    public var shortTitle: String {
        switch self {
        case .cranial: return "🧠 CRANIAL"
        case .spine: return "🦴 SPINE"
        }
    }
    
    public var plateCount: Int {
        switch self {
        case .cranial: return 23
        case .spine: return 22
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
            return [.plate018, .plate016, .plate019, .plate021, .plate025, .plate045]
        case .posteriorFossa:
            return [.plate010, .plate020, .plate004, .plate003, .plate006, .plate022]
        case .vascularVentricular:
            return [.plate002, .plate027, .plate040, .plate041]
        case .craniovertebral:
            return [.plate001, .plate013, .plate014, .plate035, .plate043, .plate047, .plate049]
        case .cervical:
            return [.plate015, .plate031, .plate034, .plate042, .plate044, .plate050]
        case .thoracicOncology:
            return [.plate026, .plate036, .plate038, .plate048]
        case .lumbarMIS:
            return [.plate011, .plate007, .plate037, .plate029, .plate028, .plate032]
        case .deformitySalvage:
            return [.plate023, .plate024, .plate039, .plate046]
        }
    }
}

public enum AtlasCategory: String, CaseIterable {
    case all = "All Plates (50)"
    case cranial = "Cranial & Skull Base (23)"
    case spine = "Spine & CVJ (27)"

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
    case plate044 = "plate_044_hangmans_fracture_levine_edwards"
    case plate045 = "plate_045_brain_herniation_syndromes"
    case plate046 = "plate_046_tethered_cord_lipomyelomeningocele"
    case plate047 = "plate_047_retro_odontoid_pseudotumor"
    case plate048 = "plate_048_spinal_dural_avf"
    case plate049 = "plate_049_jefferson_burst_fracture"
    case plate050 = "plate_050_cervical_opll"

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
        case .plate044: return 44
        case .plate045: return 45
        case .plate046: return 46
        case .plate047: return 47
        case .plate048: return 48
        case .plate049: return 49
        case .plate050: return 50
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
        case .plate044: return "44: Hangman's C2"
        case .plate045: return "45: Herniation Types"
        case .plate046: return "46: Spinal Dysraphism"
        case .plate047: return "47: Retro-Odontoid"
        case .plate048: return "48: Spinal Dural AVF"
        case .plate049: return "49: Jefferson C1"
        case .plate050: return "50: Cervical OPLL"
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
        case .plate044: return "Hangman's Fracture (Traumatic C2 Spondylolisthesis) & Levine-Edwards Classification"
        case .plate045: return "The 4 Classical Brain Herniation Syndromes"
        case .plate046: return "Lumbosacral Spinal Dysraphism & Tethered Cord Spectrum"
        case .plate047: return "C1–C2 Retro-Odontoid Pseudotumor (Pannus) & Goel-Harms Fixation"
        case .plate048: return "Spinal Dural Arteriovenous Fistula (sDAVF) & Microsurgical Clip Ligation"
        case .plate049: return "Jefferson Fracture of the Atlas (C1) & The Rule of Spence"
        case .plate050: return "Cervical Ossification of Posterior Longitudinal Ligament (OPLL) & 8K Multi-Modality Correlation"
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
        case .plate044: return "cross.case.fill"
        case .plate045: return "brain.head.profile"
        case .plate046: return "figure.child"
        case .plate047: return "shield.lefthalf.filled"
        case .plate048: return "waveform.path.ecg"
        case .plate049: return "triangle.circle.fill"
        case .plate050: return "cylinder.split.1x2.fill"
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
        case .plate044:
            return [
                SurgicalCallout(
                    id: "plate_044_1",
                    title: "Type I: Nondisplaced Pars Fracture",
                    structureType: "STABLE INJURY",
                    color: Color.green,
                    normalizedX: 0.13,
                    normalizedY: 0.50,
                    description: "Vertical bilateral C2 pars fracture with < 3 mm anterior translation and 0° angulation. C2–C3 disc and ALL/PLL are completely intact. Stable injury.",
                    surgicalPearl: "Managed non-operatively with rigid cervical collar (Miami J/Aspen) for 8–12 weeks. >95% osseous union rate."
                ),
                SurgicalCallout(
                    id: "plate_044_2",
                    title: "Type II: Displaced with Disc Rupture",
                    structureType: "UNSTABLE TRANSLATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.50,
                    description: "Hyperextension-rebound flexion. Anterior displacement > 3 mm over C3 with moderate angulation (< 10°). C2–C3 disc ruptured with stripped PLL.",
                    surgicalPearl: "Requires inpatient traction reduction (5–10 lbs) under fluoroscopy, followed by Halo vest for 12 weeks or anterior C2–C3 ACDF."
                ),
                SurgicalCallout(
                    id: "plate_044_3",
                    title: "Type IIA: Flexion-Distraction (Traction Hazard)",
                    structureType: "CRITICAL DANGER TRAP",
                    color: Color.red,
                    normalizedX: 0.63,
                    normalizedY: 0.50,
                    description: "Severe kyphotic angulation (> 10°) with minimal/no translation. Wide posterior C2–C3 disc gaping with intact ALL anterior hinge.",
                    surgicalPearl: "TRACTION IS STRICTLY CONTRAINDICATED: Longitudinal pull causes catastrophic cord distraction. Treat with gentle extension reduction without traction."
                ),
                SurgicalCallout(
                    id: "plate_044_4",
                    title: "Type III: Bilateral Locked Facets",
                    structureType: "GROSS INSTABILITY",
                    color: Color.purple,
                    normalizedX: 0.88,
                    normalizedY: 0.50,
                    description: "Severe displacement and angulation combined with bilateral jumped/locked C2–C3 facet dislocation. Complete disruption of all disc and ligamentous restraints.",
                    surgicalPearl: "Closed reduction rarely succeeds. Requires urgent open posterior reduction of locked facets + C2–C3 instrumented fusion."
                )
            ]
        case .plate045:
            return [
                SurgicalCallout(
                    id: "plate_045_1",
                    title: "Subfalcine (Cingulate) Herniation",
                    structureType: "DURAL NOTCH DISPLACEMENT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.25,
                    normalizedY: 0.25,
                    description: "Cingulate gyrus wedged beneath the inferior free margin of the rigid falx cerebri. Compresses pericallosal and callosomarginal ACA branches, causing contralateral lower-extremity paresis.",
                    surgicalPearl: "Often early and clinically silent until severe ACA ischemia ensues. High risk of converting to secondary uncal herniation."
                ),
                SurgicalCallout(
                    id: "plate_045_2",
                    title: "Uncal (Lateral Transtentorial) Herniation",
                    structureType: "INCISURAL HERNIATION",
                    color: Color.red,
                    normalizedX: 0.75,
                    normalizedY: 0.25,
                    description: "Medial temporal uncus herniates over the sharp tentorial edge. Compresses ipsilateral CN III (blown pupil), PCA (hemianopia), and contralateral cerebral peduncle (Kernohan's notch false localizing sign).",
                    surgicalPearl: "Immediate neurosurgical emergency: demands osmotherapy bolus and emergent surgical decompression within minutes."
                ),
                SurgicalCallout(
                    id: "plate_045_3",
                    title: "Central Transtentorial (Duret Hemorrhages)",
                    structureType: "ROSTROCAUDAL DISPLACEMENT",
                    color: Color.purple,
                    normalizedX: 0.25,
                    normalizedY: 0.75,
                    description: "Bilateral downward displacement of diencephalon and midbrain. Mechanical traction shears basilar paramedian perforators, producing fatal Duret brainstem hemorrhages.",
                    surgicalPearl: "Progressive rostrocaudal deterioration: small reactive pupils become midposition fixed; decorticate rigidity progresses to decerebrate posturing."
                ),
                SurgicalCallout(
                    id: "plate_045_4",
                    title: "Tonsillar Herniation ('Coning')",
                    structureType: "FORAMEN MAGNUM CONING",
                    color: Color.red,
                    normalizedX: 0.75,
                    normalizedY: 0.75,
                    description: "Cerebellar tonsils impacted > 5 mm through the foramen magnum, compressing the dorsal medulla oblongata (cardiorespiratory center). Causes Cushing's triad and sudden apnea.",
                    surgicalPearl: "Lumbar puncture is STRICTLY CONTRAINDICATED in the presence of mass effect due to the catastrophic risk of precipitating fatal tonsillar coning."
                )
            ]
        case .plate046:
            return [
                SurgicalCallout(
                    id: "plate_046_1",
                    title: "Normal Conus & Slender Filum",
                    structureType: "NORMAL LUMBOSACRAL ANATOMY",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.40,
                    description: "Conus medullaris tapers normally and terminates at L1–L2. Slender filum terminale (<2 mm) with vertically draping cauda equina rootlets. Posterior bony elements, fascia, and overlying skin are intact.",
                    surgicalPearl: "Normal conus level must be confirmed by counting down from T12/ribs or up from S1 to avoid misidentifying low-lying cord on sagittal MRI."
                ),
                SurgicalCallout(
                    id: "plate_046_2",
                    title: "Filar Lipoma (Tethered Cord)",
                    structureType: "OCCULT SPINAL DYSRAPHISM",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.375,
                    normalizedY: 0.65,
                    description: "Conus medullaris pathologically low-lying (descending to L4–L5). Thickened, bright golden-yellow fibroadipose filum (>2 mm) tethering the conus under mechanical traction with taut horizontal nerve roots.",
                    surgicalPearl: "Microsurgical sectioning of the fatty filum immediately relaxes traction. Intraoperative nerve stimulation must confirm absent motor response before bipolaring and transecting the filum."
                ),
                SurgicalCallout(
                    id: "plate_046_3",
                    title: "Lipomyelomeningocele",
                    structureType: "CLOSED SPINAL DYSRAPHISM",
                    color: Color.orange,
                    normalizedX: 0.625,
                    normalizedY: 0.50,
                    description: "Spina bifida with dorsal laminar defect (L4–S2) beneath intact skin (subcutaneous fatty dome). Subcutaneous lipoma enters the spinal canal through the fascial defect and fuses directly into the dorsal aspect of the tethered placode.",
                    surgicalPearl: "NEVER attempt complete resection of the lipoma into cord tissue; debulk only the extraneous mass and untether the placode. Aggressive parenchymal resection causes permanent paraplegia or neurogenic bladder."
                ),
                SurgicalCallout(
                    id: "plate_046_4",
                    title: "Open Myelomeningocele",
                    structureType: "SPINA BIFIDA APERTA",
                    color: Color.red,
                    normalizedX: 0.875,
                    normalizedY: 0.48,
                    description: "Failure of primary neurulation with complete absence of posterior bony arches, fascia, and skin. Exposed, raw, highly vascular neural placode elevated on a fluid-filled arachnoid sac with ventral nerve roots traversing the cystic cavity.",
                    surgicalPearl: "Demands urgent neonatal repair within 24–48 hours to prevent ventriculitis and ascending meningitis. Reconstitute neural placode into a tube (tubulation) and perform watertight multilayered closure."
                )
            ]
        case .plate047:
            return [
                SurgicalCallout(
                    id: "plate_047_1",
                    title: "Normal C1–C2 Anatomy & Wide CSF Cistern",
                    structureType: "NORMAL CRANIOCERVICAL ALIGNMENT",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.35,
                    description: "Freestanding oval C1 anterior arch, intact conical dens, and C1 posterior arch ring. Wide perimedullary and prepontine subarachnoid space (CSF) cushioning an uncompressed brainstem and spinal cord. AADI is strictly < 3 mm.",
                    surgicalPearl: "Anterior atlantodental interval (AADI) > 3 mm in adults is pathognomonic of transverse atlantal ligament incompetency and atlantoaxial instability."
                ),
                SurgicalCallout(
                    id: "plate_047_2",
                    title: "Retro-Odontoid Pannus & Crowned Dens",
                    structureType: "PATHOLOGICAL PSEUDOTUMOR",
                    color: Color.red,
                    normalizedX: 0.375,
                    normalizedY: 0.35,
                    description: "Crowned dens with multi-lobulated calcific deposits at the dens tip. A bulky, fleshy retro-odontoid pseudotumor mass expands into the spinal canal. The cord is caught in a pincer between the anterior pannus and forward-shifted C1 posterior arch, with focal intramedullary myelomalacia.",
                    surgicalPearl: "Pannus develops as an inflammatory fibrocartilaginous pseudotumor secondary to repetitive atlantoaxial micromotion (seen in CPPD, rheumatoid arthritis, or chronic non-union)."
                ),
                SurgicalCallout(
                    id: "plate_047_3",
                    title: "Rigid Goel-Harms Fixation In Situ",
                    structureType: "POSTERIOR C1-C2 ARTHRODESIS",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.625,
                    normalizedY: 0.40,
                    description: "Posterior titanium C1 lateral mass screw (angled 10-15° cephalad) connected via a longitudinal rod to a C2 pedicle screw (angled 25-30° cephalad). Vascularized morselized autograft packed between C1 and C2. The retro-odontoid mass is deliberately left in situ without anterior resection.",
                    surgicalPearl: "Direct transoral or transnasal resection carries up to a 10% risk of CSF leak and fatal meningitis. Posterior stabilization alone reliably cures the condition."
                ),
                SurgicalCallout(
                    id: "plate_047_4",
                    title: "Spontaneous Involution & Solid Bony Fusion",
                    structureType: "12-MONTH POST-OP ARTHRODESIS",
                    color: Color.blue,
                    normalizedX: 0.875,
                    normalizedY: 0.35,
                    description: "The pseudotumor pannus has completely regressed and disappeared following elimination of mechanical micromotion. The prepontine and premedullary CSF space has fully reopened, the spinal cord has re-expanded, and the posterior bone graft has consolidated into a solid bony bridge.",
                    surgicalPearl: "MRI at 6 to 12 months post-fixation routinely confirms over 90% to 100% volumetric reduction of the retro-odontoid pannus without requiring any anterior decompression."
                )
            ]
        case .plate048:
            return [
                SurgicalCallout(
                    id: "plate_048_1",
                    title: "Normal Dorsal Microvasculature",
                    structureType: "PHYSIOLOGICAL DRAINAGE",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.35,
                    description: "Slender, straight, non-dilated posterior median spinal vein (cobalt blue) with a delicate coronal venous plexus. Normal radicular vein draining smoothly through the lateral dural sleeve into the epidural venous plexus. Normal cord caliber.",
                    surgicalPearl: "Normal spinal venous drainage is low-pressure and valveless; cord perfusion depends entirely on the arteriovenous pressure gradient."
                ),
                SurgicalCallout(
                    id: "plate_048_2",
                    title: "Arterialized Serpentine Veins & Foix-Alajouanine",
                    structureType: "CONGESTIVE MYELOPATHY",
                    color: Color.red,
                    normalizedX: 0.375,
                    normalizedY: 0.35,
                    description: "Fistulous nidus inside the dural root sleeve shunts high-pressure arterial blood retrogradely into the coronal venous plexus. Grossly dilated, hyper-convoluted, serpentine arterialized veins and severe congestive cord swelling (Foix-Alajouanine myelopathy).",
                    surgicalPearl: "Presents insidiously with ascending lower extremity paraparesis, sensory level, and sphincter dysfunction, frequently misdiagnosed as lumbar spinal stenosis or transverse myelitis."
                ),
                SurgicalCallout(
                    id: "plate_048_3",
                    title: "Intraoperative ICG Videoangiography",
                    structureType: "MICROSURGICAL LOCALIZATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.625,
                    normalizedY: 0.40,
                    description: "Under high microscope magnification, intense arterial-phase fluorescence reveals the radiculomeningeal arterial feeder entering the dural sleeve and shunting directly into the single arterialized medullary bridging vein before cord capillaries fill.",
                    surgicalPearl: "ICG videoangiography definitively differentiates the pathological arterialized draining vein from adjacent normal radicular veins."
                ),
                SurgicalCallout(
                    id: "plate_048_4",
                    title: "Micro-Clip Interruption & Decompression",
                    structureType: "DEFINITIVE SURGICAL CURE",
                    color: Color.blue,
                    normalizedX: 0.875,
                    normalizedY: 0.35,
                    description: "A single titanium aneurysm micro-clip placed across the arterialized bridging vein right at its dural exit immediately halts the shunt. The serpentine dorsal veins instantly collapse, darken to blue, and de-arterialize; the cord begins rapid decongestion.",
                    surgicalPearl: "NEVER resect or coagulate the engorged veins on the cord surface (causes fatal venous infarction); simple interruption of the single bridging vein at the dura cures the fistula."
                )
            ]
        case .plate049:
            return [
                SurgicalCallout(
                    id: "plate_049_1",
                    title: "Normal C1 Ring & Intact TAL",
                    structureType: "PHYSIOLOGICAL ALIGNMENT",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.20,
                    description: "Intact, continuous C1 ring with stout Transverse Atlantal Ligament (TAL) holding the C2 dens tightly against the anterior arch. Superior axial view shows generous canal space; anterior coronal view demonstrates flush lateral masses (0 mm overhang).",
                    surgicalPearl: "Normal lateral atlantodental intervals (LADI) are strictly symmetric; combined lateral mass overhang is 0 mm."
                ),
                SurgicalCallout(
                    id: "plate_049_2",
                    title: "Stable Burst (TAL Intact, Overhang < 6.9 mm)",
                    structureType: "STABLE JEFFERSON (DICKMAN I)",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.375,
                    normalizedY: 0.20,
                    description: "4-part burst fracture through the anterior and posterior arches. The Transverse Atlantal Ligament remains 100% intact, preventing lateral mass splaying. Combined lateral mass overhang on coronal view is strictly < 6.9 mm. Spinal cord is uncompromised.",
                    surgicalPearl: "Stable fractures with intact TAL can be treated conservatively in a rigid cervical collar (Miami J / Aspen) or Halo-vest for 8–12 weeks."
                ),
                SurgicalCallout(
                    id: "plate_049_3",
                    title: "Unstable Burst (TAL Ruptured, Overhang ≥ 7 mm)",
                    structureType: "UNSTABLE JEFFERSON (DICKMAN II)",
                    color: Color.red,
                    normalizedX: 0.625,
                    normalizedY: 0.20,
                    description: "Severe comminuted burst with mid-substance rupture and shredding of the Transverse Atlantal Ligament. Both lateral masses splay widely outward (> 7 mm combined overhang, positive Rule of Spence). The dens retropulses into the canal, indenting the spinal cord.",
                    surgicalPearl: "Combined lateral mass overhang ≥ 7.0 mm on open-mouth view or coronal CT proves TAL disruption, indicating gross mechanical instability requiring surgical stabilization."
                ),
                SurgicalCallout(
                    id: "plate_049_4",
                    title: "Anatomical Reduction & Arthrodesis",
                    structureType: "SURGICAL REDUCTION & RESTORATION",
                    color: Color.blue,
                    normalizedX: 0.875,
                    normalizedY: 0.20,
                    description: "Closed traction reduction or posterior instrumented reduction brings the splayed lateral masses back inward. Coronal overhang is eliminated (0 mm overhang), the C1 ring circumference is restored, and the cervical spinal cord is fully decompressed.",
                    surgicalPearl: "Posterior C1–C2 Goel-Harms instrumented fusion (C1 lateral mass to C2 pedicle/pars screws) provides immediate rigid biomechanical stability and high fusion rates."
                )
            ]

        case .plate050:
            return [
                SurgicalCallout(
                    id: "plate_050_1",
                    title: "Midsagittal OPLL & Cord Tenting",
                    structureType: "CONTINUOUS TSUYAMA OPLL",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.15,
                    normalizedY: 0.45,
                    description: "Dense continuous ivory ossified mass extending along the posterior borders of C2–C5, causing critical anterior cord indentation (>60% canal occupancy) and severe focal cord narrowing.",
                    surgicalPearl: "Tsuyama continuous type has the highest rate of progression and severe compressive myelopathy; canal occupancy >60% strongly favors direct anterior resection/floating or combined 360° stabilization."
                ),
                SurgicalCallout(
                    id: "plate_050_2",
                    title: "Intramedullary Myelomalacia Core",
                    structureType: "COMPRESSIVE CORD ISCHEMIA",
                    color: Color.red,
                    normalizedX: 0.18,
                    normalizedY: 0.50,
                    description: "Focal pale ischemic core within the central gray and anterior white columns at the apex of compression (C3–C4), representing irreversible or semi-reversible cord edema, gliosis, and microvascular ischemia.",
                    surgicalPearl: "Preoperative focal intramedullary T2 hyperintensity coupled with T1 hypointensity (double-signal sign) correlates with poorer neurological recovery and calls for prompt surgical decompression."
                ),
                SurgicalCallout(
                    id: "plate_050_3",
                    title: "8K Bone CT & K-Line Analysis",
                    structureType: "K-LINE (-) / CANAL OCCUPANCY >65%",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.48,
                    normalizedY: 0.45,
                    description: "Thin-cut bone window CT confirms thick, uninterrupted retrovertebral ossification. The K-line (line connecting mid-canal C2 to C7) is touched and breached by the OPLL apex (K-line negative), indicating that indirect posterior decompression alone will leave persistent cord tenting.",
                    surgicalPearl: "In K-line negative patients, posterior laminoplasty alone fails to achieve backward cord drift; anterior corpectomy (ACCF) or posterior lordosis restoration + anterior release is required."
                ),
                SurgicalCallout(
                    id: "plate_050_4",
                    title: "8K T2-MRI Subarachnoid Effacement",
                    structureType: "COMPLETE CSF BLOCKS & CORD PINCH",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.45,
                    description: "3T Sagittal T2 MRI demonstrates total loss of anterior and posterior subarachnoid CSF envelopes across C3–C5 with conspicuous high-signal intramedullary myelomalacia at C3–C4. Normal CSF columns are preserved at C1–C2 and C6–T1.",
                    surgicalPearl: "Evaluate thin-cut axial CT for the 'C-sign' or 'double-layer sign' (dural ossification). When dura is ossified into the OPLL, aggressive resection tears the dura; the anterior floating technique with diamond burr prevents CSF fistula."
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
        case .plate044:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Type I: Conservative Immobilization", detail: "Rigid cervical collar (Miami J or Aspen) for 8–12 weeks with serial upright lateral radiographs. High union rate (>95%)."),
                ApproachSequentialStep(stepNumber: 2, title: "Type II: Closed Reduction & Halo", detail: "Inpatient closed cervical traction reduction (5–10 lbs) under fluoroscopy until alignment restored, then immobilization in Halo vest for 12 weeks. ACDF if unstable."),
                ApproachSequentialStep(stepNumber: 3, title: "Type IIA: Extension Reduction (NO TRACTION)", detail: "Cervical traction is strictly CONTRAINDICATED. Perform gentle closed reduction in neck extension without traction under fluoroscopy, then Halo vest or anterior C2–C3 ACDF."),
                ApproachSequentialStep(stepNumber: 4, title: "Type III: Open Reduction & Instrumented Fusion", detail: "Urgent open posterior reduction of locked C2–C3 facets via midline corridor, followed by C2–C3 posterior instrumentation/fusion (C2 pedicle/pars screws to C3 lateral mass) ± anterior C2–C3 ACDF.")
            ]
        case .plate045:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Hyperosmolar Resuscitation", detail: "Immediate IV bolus of 3% Hypertonic Saline (250–500 mL over 15 min) or 20% Mannitol (1 g/kg IV) to re-establish osmotic pressure gradient and reduce brain volume."),
                ApproachSequentialStep(stepNumber: 2, title: "Temporizing Hyperventilation Bridge", detail: "Brief controlled mechanical hyperventilation targeting PaCO2 30–35 mmHg to induce cerebral vasoconstriction. Strictly a temporizing bridge to immediate surgical theater."),
                ApproachSequentialStep(stepNumber: 3, title: "Ventricular Drainage (EVD)", detail: "Immediate placement of external ventricular drain (EVD) at Kocher's point if acute obstructive hydrocephalus is present to release supratentorial CSF pressure."),
                ApproachSequentialStep(stepNumber: 4, title: "Emergent Decompressive Surgery", detail: "Immediate craniotomy/craniectomy to evacuate mass lesion (EDH/SDH/ICH) or wide Decompressive Hemicraniectomy with expansile duraplasty. Suboccipital craniectomy for tonsillar herniation.")
            ]
        case .plate046:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Neuromonitoring & Prone Positioning", detail: "Continuous intraoperative SSEP, MEP, and multichannel electromyography (anal sphincter, bilateral lower extremity motor roots). Avoid muscle relaxants after intubation."),
                ApproachSequentialStep(stepNumber: 2, title: "Normal-to-Abnormal Surgical Exposure", detail: "Expose normal rostral lamina one level above the defect. Perform laminotomy/laminectomy in pristine anatomy to identify normal dura and conus before tracing into the dysraphic zone."),
                ApproachSequentialStep(stepNumber: 3, title: "Microsurgical Untethering & Placode Preservation", detail: "For filar lipoma: bipolar and transect the filum below the conus. For lipomyelomeningocele: subtotal lipoma debulking, untethering placode from dura without invading cord parenchyma, and soft-tissue placode tubulation."),
                ApproachSequentialStep(stepNumber: 4, title: "Expansile Watertight Duraplasty & Flap Closure", detail: "Perform wide, tension-free expansile duraplasty (pericranial/collagen graft) to provide a spacious CSF reservoir that prevents retethering. Layered myofascial and fasciocutaneous closure.")
            ]
        case .plate047:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Awake Fiberoptic Intubation & Neutral Positioning", detail: "Perform awake fiberoptic intubation strictly maintaining neutral cervical alignment; avoid any neck extension which can precipitate fatal cervicomedullary compression. Secure Mayfield pin headrest and confirm baseline MEP/SSEP signals."),
                ApproachSequentialStep(stepNumber: 2, title: "C1-C2 Posterior Exposure & Venous Hemostasis", detail: "Midline suboccipital-to-C3 exposure. Cautiously skeletonize C1 posterior arch and lateral masses, controlling profuse bleeding from the peri-ganglionic C1-C2 venous plexus with bipolar cautery, thrombin-soaked gelfoam, and cottonoid compression."),
                ApproachSequentialStep(stepNumber: 3, title: "Goel-Harms Screw Instrumentation", detail: "Under fluoroscopic guidance, place bilateral C1 lateral mass screws (entry at center of posterior C1 lateral mass, directed 10-15° cephalad and slightly convergent). Place C2 pedicle screws (or pars screws if high-riding vertebral artery present). Connect with contoured titanium rods."),
                ApproachSequentialStep(stepNumber: 4, title: "Posterior Decortication & Arthrodesis", detail: "Thoroughly decorticate the posterior arch of C1, superior lamina of C2, and C1-C2 facet joints. Pack morselized autologous bone graft across the decorticated bed. Close in anatomical layers. Do NOT attempt anterior mass resection.")
            ]
        case .plate048:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Spinal DSA Localization & Hemilaminectomy", detail: "Preoperative catheter spinal DSA maps the exact intercostal/lumbar feeding pedicle. Prone positioning under general anesthesia without systemic hypotension. Perform a targeted unilateral hemilaminectomy / laminotomy at the fistula level."),
                ApproachSequentialStep(stepNumber: 2, title: "Dural Opening & Microvascular Exposure", detail: "Perform a paramedian linear dural incision over the lateral margin of the cord and nerve root sleeve. Place fine silk dural stay sutures. Identify the arterialized red serpentine coronal veins and the bridging vein entering the dural cuff."),
                ApproachSequentialStep(stepNumber: 3, title: "ICG Videoangiography Confirmation", detail: "Administer IV Indocyanine Green (ICG). High-magnification microscope videoangiography confirms early arterial transit through the dural feeder into the bridging vein, confirming the exact fistula point before cord parenchymal filling."),
                ApproachSequentialStep(stepNumber: 4, title: "Micro-Clip Application & Vessel Division", detail: "Apply a permanent titanium aneurysm micro-clip across the arterialized bridging vein flush against the inner dural layer. Bipolar coagulate and sharply transect the vein between the clip and dura. Confirm immediate collapse and darkening of coronal veins.")
            ]
        case .plate049:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Diagnostic Imaging & Rule of Spence Measurement", detail: "Obtain thin-cut cervical CT with coronal reconstructions and open-mouth radiograph. Measure combined bilateral overhang of C1 lateral masses over C2 (Rule of Spence). Perform MRI to evaluate mid-substance vs. avulsive TAL tear (Dickman classification)."),
                ApproachSequentialStep(stepNumber: 2, title: "Conservative Protocol for Stable Burst (< 6.9 mm)", detail: "For isolated C1 burst fractures with intact TAL (overhang < 6.9 mm), immobilize in a rigid cervical orthosis (Miami J) or Halo vest for 8–12 weeks with dynamic flexion-extension radiographs at completion to verify stability."),
                ApproachSequentialStep(stepNumber: 3, title: "Closed Halo-Gravity Traction Reduction", detail: "For unstable burst fractures with splayed lateral masses (overhang ≥ 7.0 mm), apply Gardner-Wells tongs or Halo traction under serial fluoroscopic guidance to pull the splayed lateral masses back inward and restore articular alignment."),
                ApproachSequentialStep(stepNumber: 4, title: "Posterior C1–C2 Instrumented Arthrodesis (Goel-Harms)", detail: "Perform posterior C1–C2 instrumentation using bilateral C1 lateral mass screws and C2 pedicle/pars screws connected with longitudinal titanium rods. Decorticate C1 posterior elements and C2 lamina, placing autologous morselized bone graft for permanent arthrodesis.")
            ]

        case .plate050:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Preoperative Multimodal Planning & K-Line Assessment", detail: "Evaluate sagittal bone CT and T2 MRI. Measure Canal Occupying Ratio (COR) and draw the K-line (mid-canal C2 to C7). If COR > 60% or K-line is negative, plan direct anterior corpectomy (ACCF) or 360° circumspinal reconstruction rather than posterior laminoplasty alone."),
                ApproachSequentialStep(stepNumber: 2, title: "Anterior Exposure & Multilevel Corpectomy (Smith-Robinson)", detail: "Transverse or longitudinal skin crease incision along medial border of SCM. Dissect through pretracheal fascia between carotid sheath laterally and trachea/esophagus medially. Perform discectomies above and below the ossified bodies (e.g. C3–C5). Use high-speed diamond burr under microscopic magnification to resect the anterior vertebral bodies."),
                ApproachSequentialStep(stepNumber: 3, title: "The OPLL 'Floating' Technique (Preserving Ossified Dura)", detail: "Thin the dense retrovertebral OPLL mass with a 2–3 mm diamond burr under copious irrigation until it becomes paper-thin and translucent. Using micro-curettes or diamond burr, isolate the lateral boundaries of the OPLL. Allow the floating ossified island to pulsate and drift anteriorly on the intact ventral dura without aggressively peeling it off."),
                ApproachSequentialStep(stepNumber: 4, title: "Titanium Mesh Cage & 360° Posterior Instrumentation", detail: "Measure and contour a vertical titanium mesh cage packed with autologous cancellous bone graft. Seat securely into the corpectomy trough and secure with an anterior cervical plate. For multi-level corpectomies (≥2 levels) or poor bone quality, perform posterior lateral mass screw-rod fixation (C3–C6) to prevent cage dislodgement and achieve 100% fusion.")
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
        case .plate044:
            return [
                "NEVER APPLY CERVICAL TRACTION TO TYPE IIA: Traction causes catastrophic gapping of the avulsed posterior disc space and severe spinal cord traction injury.",
                "Verify vertebral artery patency on CTA: bilateral C2 pars fractures pass directly adjacent to the C2 transverse foramina, with risk of traumatic dissection or thrombosis.",
                "Do not attempt aggressive closed reduction in Type III: jumped C2–C3 facets are locked by bone; closed manipulation risks neurological injury. Proceed directly to open reduction."
            ]
        case .plate045:
            return [
                "LUMBAR PUNCTURE IS STRICTLY CONTRAINDICATED: In patients with intracranial mass effect or midline shift, lumbar puncture creates a pressure gradient that precipitates fatal tonsillar coning.",
                "KERNOHAN'S NOTCH PHENOMENON: In uncal herniation, contralateral cerebral peduncle compression produces paradoxical IPSILATERAL hemiparesis; always decompress the side of the dilated pupil and CT lesion.",
                "DURET HEMORRHAGE IRREVERSIBILITY: Symmetrical rostrocaudal brainstem shift shears basilar paramedian perforating arteries; once Duret hemorrhages occur on CT/MRI, brainstem death is imminent."
            ]
        case .plate046:
            return [
                "NEVER CHASE LIPOMA INTO NEURAL PLACODE PARENCHYMA: Subtotal debulking is the standard of care; resecting fat within functional cord tissue causes irreversible lower extremity motor deficits and permanent neurogenic bowel/bladder.",
                "INTRAOPERATIVE NERVE STIMULATION IS MANDATORY: An anomalous low-lying functional nerve root can simulate or travel adherent to the filum or transitional lipoma; never divide any tissue without direct bipolar/monopolar stimulation.",
                "EMERGENT 24–48 HOUR REPAIR IN OPEN MYELOMENINGOCELE: Exposed neural placode lacks protective epidermal barriers; delayed surgical closure risks bacterial ventriculitis, meningitis, and rapidly progressive hydrocephalus."
            ]
        case .plate047:
            return [
                "AVOID NECK EXTENSION DURING INTUBATION: Extension narrows the retro-odontoid space and drives the pannus backward directly into the medulla, risking acute respiratory arrest or quadriplegia; awake fiberoptic intubation in neutral position is mandatory.",
                "HIGH-RIDING VERTEBRAL ARTERY DISRUPTION: Always review preoperative CTA/MRA for a high-riding C2 vertebral artery or persistent intersegmental artery; if the C2 pedicle internal height is < 4 mm, place C2 translaminar or pars screws instead of pedicle screws to prevent fatal arterial laceration.",
                "UNNECESSARY ANTERIOR SURGICAL MORBIDITY: Do not perform transoral, transnasal, or transcervical anterior odontoid resection; posterior stabilization alone induces spontaneous regression in >95% of cases without the high risk of pharyngeal contamination and CSF fistula."
            ]
        case .plate048:
            return [
                "NEVER COAGULATE OR RESECT SURFACE CORONAL VEINS: The serpentine dorsal veins are normal draining channels engorged by high pressure; coagulating or resecting them causes acute, catastrophic, irreversible spinal cord venous infarction and permanent flaccid paraplegia.",
                "RULE OUT ARTERY OF ADAMKIEWICZ ON DSA: Always perform superselective angiography of the feeding intercostal/lumbar artery to verify that the anterior spinal artery (radiculomedullary artery of Adamkiewicz) does NOT originate from the same pedicle before embolization or surgical clipping.",
                "AVOID SYSTEMIC HYPOTENSION: Congested, edematous spinal cord has critically compromised capillary perfusion; keep mean arterial pressure (MAP) > 85 mmHg throughout surgery and early postoperative recovery to prevent watershed ischemia."
            ]
        case .plate049:
            return [
                "MISSING OCCULT TAL RUPTURE: Up to 15% of open-mouth plain X-rays underestimate lateral mass overhang due to radiographic magnification errors; thin-cut coronal CT or MRI is mandatory to prevent unrecognized instability and late myelopathy.",
                "OVER-DISTRACTION DURING TRACTION: Never apply aggressive traction in patients with concurrent, unrecognized atlanto-occipital dissociation (AOD); always calculate the Powers ratio and CCI (condyle-C1 interval) before initiating cervical traction.",
                "VERTEBRAL ARTERY INJURY DURING C1 LATERAL MASS SCREW PLACEMENT: The vertebral artery grooves the superior surface of the C1 posterior arch immediately above the lateral mass; stay strictly on the inferior border of the C1 arch and visualize the medial wall of the lateral mass."
            ]

        case .plate050:
            return [
                "CATASTROPHIC DURAL TEAR FROM PEELING DURAL OSSIFICATION: In continuous OPLL, up to 30% of cases exhibit dural ossification (DO / double-layer sign on axial CT) where the OPLL has penetrated and replaced the dura mater. Never grab or peel the ossified mass with Kerrison rongeurs; always thin it with a diamond burr and float it on pulsating arachnoid to avoid giant dural defects, pseudomeningocele, and subarachnoid hemorrhage.",
                "VERTEBRAL ARTERY LACERATION DURING LATERAL CORPECTOMY: The uncinate processes mark the absolute lateral safety boundary (~15-18 mm total width). Exceeding the lateral margin of the uncinates into the transverse foramen risks catastrophic laceration of the V2 vertebral artery; maintain strictly midline orientation with fluoroscopic guidance.",
                "EARLY GRAFT DISLODGEMENT IN MULTI-LEVEL ACCF WITHOUT POSTERIOR REINFORCEMENT: A 2-level or 3-level anterior cervical corpectomy has a high pseudarthrosis and cage kick-out rate (up to 30%) with anterior plating alone. Always reinforce multi-level corpectomy constructs with posterior instrumented arthrodesis (360° stabilization)."
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
