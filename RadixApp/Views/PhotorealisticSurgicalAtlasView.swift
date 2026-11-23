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
                
                // Tactical Operational Protocol Card (completely hidden if both steps and hazards are empty)
                if !selectedPlate.steps.isEmpty || !selectedPlate.catastrophicHazards.isEmpty {
                    approachTacticalSummaryCard
                        .padding(.horizontal, 14)
                }
                
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
            
            if zoomScale > 1.05 || dragOffset != .zero {
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
            
            // Sequential Dissection Steps (completely omitted if empty)
            if !selectedPlate.steps.isEmpty {
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
            }
            
            // Dangerous Pitfalls Callout Box (completely omitted if empty)
            if !selectedPlate.catastrophicHazards.isEmpty {
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
        }
        .padding(14)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
}

// MARK: - Data Models
public enum AtlasDomain: String, CaseIterable, Identifiable {
    case cranial = "🧠 CRANIAL & SKULL BASE (45)"
    case spine = "🦴 SPINE & CVJ (56)"
    case pediatric = "👶 PEDIATRIC NEUROSURGERY (5)"
    
    public var id: String { rawValue }
    
    public var shortTitle: String {
        switch self {
        case .cranial: return "🧠 CRANIAL"
        case .spine: return "🦴 SPINE"
        case .pediatric: return "👶 PEDIATRIC"
        }
    }
    
    public var plateCount: Int {
        plates.count
    }
    
    public var subSections: [AtlasSubSection] {
        switch self {
        case .cranial:
            return [.anteriorSkullBase, .convexityTrauma, .posteriorFossa, .vascularVentricular]
        case .spine:
            return [.craniovertebral, .cervical, .thoracicOncology, .lumbarMIS, .deformitySalvage, .peripheralNerve]
        case .pediatric:
            return [.pediatricNeurosurgery]
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
    
    // Spine (6 sub-sections)
    case craniovertebral = "Craniovertebral Junction"
    case cervical = "Cervical Spine"
    case thoracicOncology = "Thoracic & Oncology"
    case lumbarMIS = "Lumbar & MIS Corridors"
    case deformitySalvage = "Deformity & Salvage"
    case peripheralNerve = "Peripheral Nerve"
    
    // Pediatric (1 sub-section)
    case pediatricNeurosurgery = "Pediatric Corridors & Dysraphism"
    
    public var id: String { rawValue }
    
    public var domain: AtlasDomain {
        switch self {
        case .anteriorSkullBase, .convexityTrauma, .posteriorFossa, .vascularVentricular:
            return .cranial
        case .craniovertebral, .cervical, .thoracicOncology, .lumbarMIS, .deformitySalvage, .peripheralNerve:
            return .spine
        case .pediatricNeurosurgery:
            return .pediatric
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
        case .peripheralNerve: return "hand.raised.fill"
        case .pediatricNeurosurgery: return "figure.and.child.holdinghands"
        }
    }
    
    public var plates: [SurgicalPlateType] {
        switch self {
        case .anteriorSkullBase:
            return [.plate017, .plate009, .plate012, .plate008, .plate005, .plate033, .plate030, .plate055, .plate059, .plate066, .plate074, .plate084]
        case .convexityTrauma:
            return [.plate018, .plate016, .plate019, .plate021, .plate025, .plate045, .plate069, .plate070]
        case .posteriorFossa:
            return [.plate010, .plate004, .plate003, .plate006, .plate020, .plate022, .plate052, .plate057, .plate077, .plate082]
        case .vascularVentricular:
            return [.plate027, .plate040, .plate041, .plate051, .plate053, .plate056, .plate060, .plate061, .plate062, .plate063, .plate065, .plate067, .plate079, .plate086, .plate093]
        case .craniovertebral:
            return [.plate001, .plate013, .plate014, .plate035, .plate047, .plate049, .plate088, .plate097]
        case .cervical:
            return [.plate015, .plate031, .plate034, .plate042, .plate044, .plate050, .plate064, .plate076, .plate080, .plate091, .plate098]
        case .thoracicOncology:
            return [.plate026, .plate036, .plate038, .plate048, .plate054, .plate058, .plate068, .plate072, .plate073, .plate078, .plate085, .plate094, .plate103]
        case .lumbarMIS:
            return [.plate011, .plate007, .plate037, .plate029, .plate028, .plate032, .plate083, .plate087, .plate100, .plate101, .plate106]
        case .deformitySalvage:
            return [.plate023, .plate024, .plate039, .plate071, .plate075, .plate081, .plate099, .plate102, .plate104]
        case .peripheralNerve:
            return [.plate089, .plate090, .plate092, .plate096]
        case .pediatricNeurosurgery:
            return [.plate002, .plate043, .plate046, .plate095, .plate105]
        }
    }
}

public enum AtlasCategory: String, CaseIterable {
    case all = "All Plates (106)"
    case cranial = "Cranial & Skull Base (45)"
    case spine = "Spine & CVJ (56)"
    case pediatric = "Pediatric Neurosurgery (5)"

    public var filteredPlates: [SurgicalPlateType] {
        switch self {
        case .all:
            return AtlasDomain.cranial.plates + AtlasDomain.spine.plates + AtlasDomain.pediatric.plates
        case .cranial:
            return AtlasDomain.cranial.plates
        case .spine:
            return AtlasDomain.spine.plates
        case .pediatric:
            return AtlasDomain.pediatric.plates
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
    case plate051 = "plate_051_mma_embolization_csdh"
    case plate052 = "plate_052_vestibular_schwannoma"
    case plate053 = "plate_053_normal_pressure_hydrocephalus"
    case plate054 = "plate_054_thoracic_olf_sato"
    case plate055 = "plate_055_petroclival_meningioma_kawase"
    case plate056 = "plate_056_brain_avm_spetzler_martin"
    case plate057 = "plate_057_trigeminal_neuralgia_mvd"
    case plate058 = "plate_058_spinal_epidural_abscess"
    case plate059 = "plate_059_pituitary_macroadenoma_knosp"
    case plate060 = "plate_060_moyamoya_revascularization"
    case plate061 = "plate_061_acoma_aneurysm_clipping"
    case plate062 = "plate_062_mca_bifurcation_aneurysm_clipping"
    case plate063 = "plate_063_basilar_apex_aneurysm_clipping"
    case plate064 = "plate_064_spinal_intramedullary_ependymoma"
    case plate065 = "plate_065_third_ventricle_colloid_cyst"
    case plate066 = "plate_066_olfactory_groove_meningioma"
    case plate067 = "plate_067_pica_vertebral_aneurysm_clipping"
    case plate068 = "plate_068_thoracic_dumbbell_schwannoma"
    case plate069 = "plate_069_parasagittal_falcine_meningioma"
    case plate070 = "plate_070_gbm_awake_craniotomy_mapping"
    case plate071 = "plate_071_as_chalk_stick_fracture_fixation"
    case plate072 = "plate_072_sih_csf_venous_fistula"
    case plate073 = "plate_073_calcified_thoracic_disc"
    case plate074 = "plate_074_sphenoid_wing_meningioma"
    case plate075 = "plate_075_high_grade_spondylolisthesis"
    case plate076 = "plate_076_cervical_keyhole_foraminotomy"
    case plate077 = "plate_077_brainstem_tectal_cavernoma"
    case plate078 = "plate_078_thoracolumbar_burst_fracture"
    case plate079 = "plate_079_stn_dbs_parkinsons"
    case plate080 = "plate_080_cervical_expansile_laminoplasty"
    case plate081 = "plate_081_adult_scoliosis_spinopelvic_realignment"
    case plate082 = "plate_082_fourth_ventricle_tumor_telovelar_approach"
    case plate083 = "plate_083_full_endoscopic_transforaminal_lumbar_discectomy"
    case plate084 = "plate_084_paraclinoid_ophthalmic_ica_aneurysm"
    case plate085 = "plate_085_sacral_chordoma_en_bloc_sacrectomy"
    case plate086 = "plate_086_endoscopic_third_ventriculostomy_etv"
    case plate087 = "plate_087_alif_l5_s1_hyperlordotic"
    case plate088 = "plate_088_occipitocervical_fixation_decompression"
    case plate089 = "plate_089_cubital_tunnel_submuscular_transposition"
    case plate090 = "plate_090_carpal_tunnel_release_recurrent_motor"
    case plate091 = "plate_091_anterior_cervical_corpectomy_fusion"
    case plate092 = "plate_092_brachial_plexus_oberlin_transfer"
    case plate093 = "plate_093_acute_ischemic_stroke_thrombectomy"
    case plate094 = "plate_094_scs_paddle_lead_placement"
    case plate095 = "plate_095_myelomeningocele_mmc_repair"
    case plate096 = "plate_096_neurocall_surgical_atlas_master"
    case plate097 = "plate_097_anterior_odontoid_screw_fixation"
    case plate098 = "plate_098_cervical_artificial_disc_replacement"
    case plate099 = "plate_099_cervical_pedicle_subtraction_osteotomy"
    case plate100 = "plate_100_oblique_lumbar_interbody_fusion"
    case plate101 = "plate_101_prone_single_position_lateral"
    case plate102 = "plate_102_posterior_vertebral_column_resection"
    case plate103 = "plate_103_thoracic_metastasis_corpectomy_reconstruction"
    case plate104 = "plate_104_proximal_junctional_failure_revision"
    case plate105 = "plate_105_split_cord_malformation_spur_resection"
    case plate106 = "plate_106_minimally_invasive_si_joint_arthrodesis"

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
        case .plate051: return 51
        case .plate052: return 52
        case .plate053: return 53
        case .plate054: return 54
        case .plate055: return 55
        case .plate056: return 56
        case .plate057: return 57
        case .plate058: return 58
        case .plate059: return 59
        case .plate060: return 60
        case .plate061: return 61
        case .plate062: return 62
        case .plate063: return 63
        case .plate064: return 64
        case .plate065: return 65
        case .plate066: return 66
        case .plate067: return 67
        case .plate068: return 68
        case .plate069: return 69
        case .plate070: return 70
        case .plate071: return 71
        case .plate072: return 72
        case .plate073: return 73
        case .plate074: return 74
        case .plate075: return 75
        case .plate076: return 76
        case .plate077: return 77
        case .plate078: return 78
        case .plate079: return 79
        case .plate080: return 80
        case .plate081: return 81
        case .plate082: return 82
        case .plate083: return 83
        case .plate084: return 84
        case .plate085: return 85
        case .plate086: return 86
        case .plate087: return 87
        case .plate088: return 88
        case .plate089: return 89
        case .plate090: return 90
        case .plate091: return 91
        case .plate092: return 92
        case .plate093: return 93
        case .plate094: return 94
        case .plate095: return 95
        case .plate096: return 96
        case .plate097: return 97
        case .plate098: return 98
        case .plate099: return 99
        case .plate100: return 100
        case .plate101: return 101
        case .plate102: return 102
        case .plate103: return 103
        case .plate104: return 104
        case .plate105: return 105
        case .plate106: return 106
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
        case .plate010: return "10: Retromastoid SOC"
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
        case .plate023: return "23: Ponte Osteotomy"
        case .plate024: return "24: PSO / 3-Column"
        case .plate025: return "25: ATL vs SelAH"
        case .plate026: return "26: Costotransversectomy"
        case .plate027: return "27: MIPS Tubular ICH"
        case .plate028: return "28: LLIF"
        case .plate029: return "29: TLIF"
        case .plate030: return "30: Endonasal Sellar"
        case .plate031: return "31: CT Junction Neural Anatomy"
        case .plate032: return "32: Lumbar Interbody Fusion"
        case .plate033: return "33: Supraorbital Crani"
        case .plate034: return "34: Jumped Facets"
        case .plate035: return "35: Odontoid Fractures"
        case .plate036: return "36: TL Burst Fracture"
        case .plate037: return "37: Cauda Equina (HNP)"
        case .plate038: return "38: Thoracic Spinal Met."
        case .plate039: return "39: Postop Pseudomeningocele"
        case .plate040: return "40: A Comm Aneurysm Rupture"
        case .plate041: return "41: Ganglionic ICH & IVH"
        case .plate042: return "42: Cervical Spondylitic Myelopathy"
        case .plate043: return "43: Pediatric Rotatory Subluxation"
        case .plate044: return "44: Hangman's Fracture"
        case .plate045: return "45: Brain Herniation Syndromes"
        case .plate046: return "46: Spinal Dysraphism"
        case .plate047: return "47: Retro-Odontoid"
        case .plate048: return "48: Spinal Dural AVF"
        case .plate049: return "49: Jefferson C1"
        case .plate050: return "50: Cervical OPLL"
        case .plate051: return "51: MMA Embolization"
        case .plate052: return "52: Acoustic Neuroma"
        case .plate053: return "53: NPH & DESH Sign"
        case .plate054: return "54: Thoracic OLF"
        case .plate055: return "55: Petroclival Meningioma"
        case .plate056: return "56: Brain AVM"
        case .plate057: return "57: Trigeminal Neuralgia"
        case .plate058: return "58: Epidural Abscess"
        case .plate059: return "59: Pituitary Macroadenoma"
        case .plate060: return "60: Moyamoya Revascularization"
        case .plate061: return "61: AComA Aneurysm"
        case .plate062: return "62: MCA Bifurcation"
        case .plate063: return "63: Basilar Apex"
        case .plate064: return "64: Cervical Ependymoma"
        case .plate065: return "65: Colloid Cyst"
        case .plate066: return "66: Olfactory Groove"
        case .plate067: return "67: PICA-VA Aneurysm"
        case .plate068: return "68: Dumbbell Schwannoma"
        case .plate069: return "69: Parasagittal Meningioma"
        case .plate070: return "70: Awake GBM Mapping"
        case .plate071: return "71: AS Chalk-Stick Fixation"
        case .plate072: return "72: SIH CSF-Venous Fistula"
        case .plate073: return "73: Calcified Thoracic Disc"
        case .plate074: return "74: Sphenoid Wing Meningioma"
        case .plate075: return "75: Spondyloptosis & Reduction"
        case .plate076: return "76: Keyhole Foraminotomy"
        case .plate077: return "77: Tectal Cavernoma"
        case .plate078: return "78: Burst Fracture Fixation"
        case .plate079: return "79: STN DBS (Parkinson's)"
        case .plate080: return "80: Cervical Laminoplasty"
        case .plate081: return "81: Adult Scoliosis & S2AI"
        case .plate082: return "82: Telovelar 4th Ventricle"
        case .plate083: return "83: Endoscopic Discectomy"
        case .plate084: return "84: Paraclinoid Aneurysm"
        case .plate085: return "85: En-Bloc Sacrectomy"
        case .plate086: return "86: Endoscopic 3rd Ventriculostomy"
        case .plate087: return "87: ALIF L5–S1 Hyperlordotic"
        case .plate088: return "88: Occipitocervical Fixation (OCF)"
        case .plate089: return "89: Cubital Tunnel Transposition"
        case .plate090: return "90: Carpal Tunnel Release (CTR)"
        case .plate091: return "91: ACCF C6 Corpectomy"
        case .plate092: return "92: Oberlin Double Transfer"
        case .plate093: return "93: Stroke Thrombectomy"
        case .plate094: return "94: SCS Paddle Lead"
        case .plate095: return "95: Myelomeningocele (MMC)"
        case .plate096: return "96: Master Surgical Corridors"
        case .plate097: return "97: Anterior Odontoid Screw"
        case .plate098: return "98: Cervical Disc Replacement"
        case .plate099: return "99: C7 PSO Realignment"
        case .plate100: return "100: OLIF / ATP Corridor"
        case .plate101: return "101: Prone Single-Position LLIF"
        case .plate102: return "102: Posterior VCR"
        case .plate103: return "103: T8 Corpectomy & Cage"
        case .plate104: return "104: PJF Revision to T2"
        case .plate105: return "105: SCM Spur Resection"
        case .plate106: return "106: SI Joint Arthrodesis"
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
        case .plate010: return "Retromastoid / Retrosigmoid Keyhole Suboccipital Craniectomy (SOC)"
        case .plate011: return "Lumbar Disc Degeneration & Posterior Annular Tear (Axial + Sagittal View)"
        case .plate012: return "Left Pterional Craniotomy & Sylvian Fissure Opercular Exposure (1:1 Modernized Master)"
        case .plate013: return "Chiari I Malformation Suboccipital Decompression & Expansile Patch Duraplasty (1:1 Modernized Master)"
        case .plate014: return "Posterior C1–C2 Goel-Harms Screw-Rod Fixation Construct (1:1 Modernized Master)"
        case .plate015: return "Anterior Cervical Discectomy & Fusion (ACDF) — Smith-Robinson Corridor, Uncinate Decompression & Anterior Plating"
        case .plate016: return "Right Subtemporal / Temporal Craniotomy & Middle Meningeal Artery (1:1 Text-Scrubbed Master)"
        case .plate017: return "Left Pterional (Frontotemporal) Craniotomy Bone Window & Sphenoid Ridge (3D Master)"
        case .plate018: return "Bifrontal Craniotomy 3D Skull Model & Anterior Cranial Fossa Corridor"
        case .plate019: return "Left Parietal Craniotomy Window & Dural Venous Tributaries (3D Master)"
        case .plate020: return "Right Retrosigmoid / Asterion Craniectomy Window & Dural Venous Junction (3D Master)"
        case .plate021: return "Decompressive Frontotemporoparietal Hemicraniectomy & Expansile Duroplasty"
        case .plate022: return "Pineal Region Tumor & Supracerebellar Infratentorial / Transtentorial Corridors (Midsagittal Master)"
        case .plate023: return "Ponte Posterior Column Osteotomy — Open Wedge vs. Closed Lordotic Correction"
        case .plate024: return "Pedicle Subtraction Osteotomy (PSO) / 3-Column Osteotomy"
        case .plate025: return "Anterior Temporal Lobectomy (ATL) vs. Selective Amygdalohippocampectomy (SelAH)"
        case .plate026: return "Costotransversectomy"
        case .plate027: return "Minimally Invasive Parafascicular Surgery (MIPS) — Trans-Sulcal Tubular ICH Evacuation"
        case .plate028: return "LLIF"
        case .plate029: return "TLIF"
        case .plate030: return "Endoscopic Endonasal Sellar Corridor — Skull Base Landmarks & Microvascular Relationships"
        case .plate031: return "CT Junction Neural Anatomy"
        case .plate032: return "Lumbar Interbody Fusion"
        case .plate033: return "Supraorbital Crani"
        case .plate034: return "Bilateral Jumped / Locked Cervical Facets (C6–C7) — Diagnostic & Pathoanatomical Correlation"
        case .plate035: return "Odontoid Fractures"
        case .plate036: return "TL Burst Fracture"
        case .plate037: return "Cauda Equina Syndrome (HNP)"
        case .plate038: return "Thoracic Spinal Met."
        case .plate039: return "Postop Pseudomeningocele"
        case .plate040: return "A Comm Aneurysm Rupture"
        case .plate041: return "Hypertensive Ganglionic Intracerebral Hemorrhage (ICH) & Intraventricular Extension (IVH)"
        case .plate042: return "Cervical Spondylitic Myelopathy"
        case .plate043: return "Pediatric Rotatory Subluxation"
        case .plate044: return "Hangman's Fracture"
        case .plate045: return "Brain Herniation Syndromes"
        case .plate046: return "Spinal Dysraphism"
        case .plate047: return "C1–C2 Retro-Odontoid Pseudotumor (Pannus) & Goel-Harms Fixation"
        case .plate048: return "Spinal Dural Arteriovenous Fistula (sDAVF) & Microsurgical Clip Ligation"
        case .plate049: return "Jefferson Fracture of the Atlas (C1) & The Rule of Spence"
        case .plate050: return "Cervical Ossification of Posterior Longitudinal Ligament (OPLL) & 8K Multi-Modality Correlation"
        case .plate051: return "Middle Meningeal Artery (MMA) Embolization for Chronic Subdural Hematoma"
        case .plate052: return "Vestibular Schwannoma (Acoustic Neuroma) — Retrosigmoid Microsurgical Anatomy & 3T MRI"
        case .plate053: return "Normal Pressure Hydrocephalus (NPH) & The DESH Sign — Multimodal Imaging & Programmable Shunt"
        case .plate054: return "Thoracic Ossification of the Ligamentum Flavum (T-OLF) & Sato Classification — Multi-Modality Correlation & Floating Decompression"
        case .plate055: return "Petroclival Meningioma & The Kawase Approach (Anterior Petrosectomy) — Multi-Planar 3T MRI & Trans-Tentorial Resection"
        case .plate056: return "Brain Arteriovenous Malformation (AVM) & Spetzler-Martin Classification — Hemodynamics, Cortical Eloquence & Circumdissection Protocol"
        case .plate057: return "Trigeminal Neuralgia & Jannetta Microvascular Decompression (MVD) — High-Resolution 3T FIESTA, Keyhole Corridor & Multi-Modal Transposition"
        case .plate058: return "Spinal Epidural Abscess (SEA) & Phlegmon — Contrast MRI, Spondylodiscitis & Catheter Decompression Protocol"
        case .plate059: return "Pituitary Macroadenoma & Endoscopic Endonasal Approach — Coronal 3T MRI, Knosp Matrix & Hadad Flap Reconstruction"
        case .plate060: return "Moyamoya Disease & Dual-Mechanism Cerebral Revascularization — Direct STA-MCA Bypass & Indirect EDAS Synangiosis"
        case .plate061: return "Anterior Communicating Artery (AComA) Aneurysm & Microsurgical Pterional Clipping — 3D Angiopathology, Projection Profiles & Gyrus Rectus Corridor"
        case .plate062: return "Middle Cerebral Artery (MCA) Bifurcation Aneurysm & Microsurgical Clipping — Catheter DSA, Transsylvian Exposure & Multi-Clip Reconstruction"
        case .plate063: return "Basilar Apex (Tip) Aneurysm & Microsurgical Clipping — Angiopathology, Bifurcation Height & Trans-Liliequist Corridor"
        case .plate064: return "Cervical Spinal Intramedullary Ependymoma — 3T MRI, Hemosiderin Cap Sign, Midline Myelotomy & En-Bloc Resection"
        case .plate065: return "Third Ventricle Colloid Cyst & Transcallosal Approach — 3D Neuroimaging, Ventricular Corridors & Capsule Resection"
        case .plate066: return "Olfactory Groove Meningioma & Bifrontal Transbasal Resection — 3D Contrast MRI, Extradural Devascularization & CUSA Debulking"
        case .plate067: return "PICA & Vertebral Artery Aneurysm & Far-Lateral Transcondylar Clipping — 3D Angiography, Suboccipital Triangle, Condylectomy & Lower CN Sparing"
        case .plate068: return "Thoracic Dumbbell Schwannoma & Posterolateral Costotransversectomy — 3D MRI, Eden Classification, Extrapleural Corridor & Arthrodesis"
        case .plate069: return "Parasagittal & Falcine Meningioma with SSS Invasion — 3D MRI, Sindou Matrix, Sinus-Crossing Flap & Venous Repair"
        case .plate070: return "Glioblastoma & Awake Craniotomy — Cortical & Subcortical White Matter Mapping, 5-ALA Fluorescence & CUSA Resection"
        case .plate071: return "Ankylosing Spondylitis (AS) 'Chalk-Stick' Fracture — 3-Column Fracture, Epidural Clot Evacuation & Long-Segment Fixation"
        case .plate072: return "Spontaneous Intracranial Hypotension (SIH) & CSF-Venous Fistula — Decubitus DSM, Transvenous Coiling & Microsurgical Clip Ligation"
        case .plate073: return "Giant Calcified Thoracic Disc Herniation — Posterolateral Transpedicular Corridor, Down-and-Away Trenching & Zero Cord Retraction"
        case .plate074: return "Sphenoid Wing Meningioma & Hyperostosis — Medial Clinoidal vs. Lateral, Extradural Optic Unroofing & MOB Peeling"
        case .plate075: return "High-Grade L5–S1 Spondylolisthesis & Spondyloptosis — Sacral Dome Osteotomy, L5 Root Decompression & Bohlman Spinopelvic Fixation"
        case .plate076: return "Cervical Spondylotic Radiculopathy & Posterior Keyhole Foraminotomy — V-Point Localization, ≤50% Facetectomy & Disc Fragmentectomy"
        case .plate077: return "Brainstem / Tectal Cavernous Malformation (Zabramski Type II) — Supracerebellar Corridor, Infracollicular Entry Zone & DVA Sparing"
        case .plate078: return "Thoracolumbar Burst Fracture (AO Spine A3/A4) — Short-Segment Fixation, Intermediate Screws & Ligamentotaxis"
        case .plate079: return "Subthalamic Nucleus (STN) Deep Brain Stimulation (DBS) — Stereotactic Trajectory, MER Bursting & Directional Lead Placement"
        case .plate080: return "Cervical Expansile Laminoplasty — Open-Door (Hirabayashi) vs. French-Door (Kurokawa), K-Line & C5 Palsy Prevention"
        case .plate081: return "Adult Scoliosis & Spinopelvic Realignment — Long-Segment Fusion (T10 to Pelvis), Ponte Osteotomies & S2AI Screws"
        case .plate082: return "Fourth Ventricle Tumor & The Telovelar Approach — Vermis-Sparing Exposure, Tonsillar Mobilization & Rhomboid Fossa Preservation"
        case .plate083: return "Full-Endoscopic Transforaminal Lumbar Discectomy — Kambin's Triangle, SAP Foraminoplasty & Endoscopic Fragmentectomy"
        case .plate084: return "Paraclinoid (Ophthalmic) ICA Aneurysm & Anterior Clinoidectomy — Optic Strut Drilling, Distal Dural Ring Dissection & Clip Occlusion"
        case .plate085: return "Sacral Chordoma & En-Bloc Sacrectomy — Combined Anterior-Posterior Resection & Rigid Spinopelvic Reconstruction"
        case .plate086: return "Endoscopic Third Ventriculostomy (ETV) — Foramen of Monro Anatomy, 3rd Ventricular Floor Landmarks & Prepontine Fenestration"
        case .plate087: return "Anterior Lumbar Interbody Fusion (ALIF) at L5–S1 — Retroperitoneal Exposure, Vascular Bifurcation & Hyperlordotic Reconstruction"
        case .plate088: return "Occipitocervical Fixation (OCF) & Decompression — Craniocervical Instability Metrics, Suboccipital Decompression & Occiput-to-C4 Screw-Rod Reconstruction"
        case .plate089: return "Cubital Tunnel Syndrome & Submuscular Ulnar Nerve Transposition — In-Situ Decompression, FCU Motor Branch Sparing & Learmonth Procedure"
        case .plate090: return "Carpal Tunnel Syndrome & Open Carpal Tunnel Release (CTR) — Retinacular Decompression, Thenar Motor Variants & Fat Pad Landmark"
        case .plate091: return "Anterior Cervical Corpectomy & Fusion (ACCF at C6) — Expandable Titanium Cage & Anterior Locking Plate"
        case .plate092: return "Brachial Plexus Injury (Upper Trunk / Erb's Palsy) & Oberlin Double Nerve Transfer — Ulnar to Biceps, Median to Brachialis"
        case .plate093: return "Acute Ischemic Stroke & Endovascular Mechanical Thrombectomy — Right MCA M1 Occlusion, Combined Stent-Retriever & Contact Aspiration"
        case .plate094: return "Spinal Cord Stimulation (SCS) & Paddle Lead Placement — FBSS, Thoracic T8–T10 Laminotomy, Multi-Column Paddle & Gluteal IPG Pocket"
        case .plate095: return "Myelomeningocele (MMC) Open Spinal Dysraphism Repair — Placode Untethering, Pial Tubularization, Watertight Duraplasty & Myofascial Flaps"
        case .plate096: return "The NeuroCall Surgical Atlas: 360° Master Corridors — Cranial Skull Base, Spinal Reconstruction & Functional Neural Pathways"
        case .plate097: return "Anterior Odontoid Screw Fixation — Type II Fracture, Biplanar Fluoroscopy & Direct Lag Screw Osteosynthesis"
        case .plate098: return "Cervical Artificial Disc Replacement (CDRA) — C5–C6 Arthroplasty, Complete Neural Decompression & Keel Seating"
        case .plate099: return "Cervical Pedicle Subtraction Osteotomy (C7 PSO) — Fixed Kyphosis Realignment, C8 Neural Sparing & Cervicothoracic Fixation"
        case .plate100: return "Oblique Lumbar Interbody Fusion (OLIF / ATP) — Anterior-to-Psoas Corridor (L2–L5), Lumbar Plexus Sparing & Hyperlordotic Interbody Fusion"
        case .plate101: return "Prone Single-Position Lateral Surgery (Prone LLIF) — Single-Position Prone Lateral Access, Gravitational Visceral Shift & Simultaneous 360° Stabilization"
        case .plate102: return "Posterior Vertebral Column Resection (PVCR) — Single-Stage 360° Circumferential Spondylectomy, Cord Suspension & Expandable Cage Realignment"
        case .plate103: return "Thoracic Metastasis: Posterolateral T8 Corpectomy — Costotransversectomy, Expandable Cage Reconstruction & T6–T10 Posterior Fixation"
        case .plate104: return "Proximal Junctional Failure: Definitive Revision Reconstruction — UIV+1 Fracture Collapse, Cranial Extension to T2 & Spinopelvic Multi-Rod Reconstruction"
        case .plate105: return "Split Cord Malformation: Spur Resection & Dural Reconstruction — Pang Type I Diastematomyelia, Extradural Bony Spur Drillout & Single-Tube Duraplasty"
        case .plate106: return "Minimally Invasive Sacroiliac Joint Arthrodesis — Lateral Transiliac Corridor, Triangular Implants & Threaded Porous Compression Screws (iFuse TORQ)"
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
        case .plate051: return "waveform.path.ecg"
        case .plate052: return "ear"
        case .plate053: return "brain.head.profile"
        case .plate054: return "waveform.path.ecg"
        case .plate055: return "brain.head.profile"
        case .plate056: return "waveform.path.ecg"
        case .plate057: return "bolt.fill"
        case .plate058: return "cross.circle.fill"
        case .plate059: return "eye.fill"
        case .plate060: return "arrow.triangle.branch"
        case .plate061: return "bolt.horizontal.fill"
        case .plate062: return "arrow.triangle.branch"
        case .plate063: return "arrow.triangle.branch"
        case .plate064: return "cylinder.split.1x2.fill"
        case .plate065: return "circle.hexagongrid.fill"
        case .plate066: return "eye.circle.fill"
        case .plate067: return "waveform.path.ecg"
        case .plate068: return "shield.lefthalf.filled"
        case .plate069: return "brain.head.profile"
        case .plate070: return "sparkles"
        case .plate071: return "shield.lefthalf.filled"
        case .plate072: return "drop.triangle.fill"
        case .plate073: return "cylinder.split.1x2.fill"
        case .plate074: return "eye.circle.fill"
        case .plate075: return "bolt.horizontal.fill"
        case .plate076: return "key.horizontal.fill"
        case .plate077: return "circle.grid.cross.fill"
        case .plate078: return "burst.fill"
        case .plate079: return "waveform.path.ecg"
        case .plate080: return "door.left.hand.open"
        case .plate081: return "arrow.triangle.merge"
        case .plate082: return "triangle.circle.fill"
        case .plate083: return "scope"
        case .plate084: return "eye.trianglebadge.exclamationmark"
        case .plate085: return "shield.lefthalf.filled"
        case .plate086: return "scope"
        case .plate087: return "square.3.layers.3d.down.right"
        case .plate088: return "shield.checkered"
        case .plate089: return "hand.point.right.fill"
        case .plate090: return "hand.raised.slash.fill"
        case .plate091: return "cylinder.split.1x2.fill"
        case .plate092: return "figure.arms.open"
        case .plate093: return "waveform.path.ecg"
        case .plate094: return "bolt.batteryblock.fill"
        case .plate095: return "bandage.fill"
        case .plate096: return "star.circle.fill"
        case .plate097: return "bolt.fill"
        case .plate098: return "circle.circle.fill"
        case .plate099: return "arrow.up.and.line.horizontal.and.arrow.down"
        case .plate100: return "square.split.diagonal.2x2"
        case .plate101: return "arrow.triangle.2.circlepath.circle.fill"
        case .plate102: return "arrow.up.and.down.and.sparkles"
        case .plate103: return "cross.case.fill"
        case .plate104: return "arrow.up.and.line.horizontal.and.arrow.down"
        case .plate105: return "scissors"
        case .plate106: return "bolt.horizontal.fill"
        }
    }

}
