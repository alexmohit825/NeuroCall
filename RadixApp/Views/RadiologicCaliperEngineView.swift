import SwiftUI

// MARK: - Dynamic Bedside Radiologic Caliper Engine
// Synthesized for neurosurgical operative planning:
// 1. ABC/2 Volumetric Hematoma Caliper (Length x Width x Slices / 2) with BTF 30 mL surgical indication cutoff
// 2. Midline Shift Caliper with millimeter ruler and 5 mm surgical threshold warning
// 3. Evans Index Caliper (Bifrontal Horn Span / Calvarial Diameter) with >0.30 hydrocephalus trigger

public enum CaliperToolMode: String, CaseIterable {
    case abc2 = "ABC/2 Volume"
    case midlineShift = "Midline Shift"
    case evansIndex = "Evans Index"
    
    public var icon: String {
        switch self {
        case .abc2: return "circle.grid.cross.fill"
        case .midlineShift: return "arrow.left.and.right"
        case .evansIndex: return "arrow.left.and.right.circle.fill"
        }
    }
}

public struct RadiologicCaliperEngineView: View {
    let imageName: String
    let emergencyTitle: String
    
    @State private var activeMode: CaliperToolMode = .abc2
    @State private var isCaliperActive: Bool = true
    @State private var customCapturedImage: UIImage? = nil
    @State private var isShowingCameraPicker: Bool = false
    
    // 1. ABC/2 Caliper State (Points normalized 0.0 to 1.0 relative to image viewport)
    @State private var pointA1: CGPoint = CGPoint(x: 0.35, y: 0.35)
    @State private var pointA2: CGPoint = CGPoint(x: 0.65, y: 0.35)
    @State private var pointB1: CGPoint = CGPoint(x: 0.50, y: 0.25)
    @State private var pointB2: CGPoint = CGPoint(x: 0.50, y: 0.45)
    @State private var sliceCount: Double = 6.0
    @State private var sliceThicknessMm: Double = 5.0
    
    // 2. Midline Shift State
    @State private var midLineA: CGPoint = CGPoint(x: 0.50, y: 0.15)
    @State private var midLineB: CGPoint = CGPoint(x: 0.50, y: 0.85)
    @State private var septumPoint: CGPoint = CGPoint(x: 0.62, y: 0.45)
    
    // 3. Evans Index State
    @State private var frontalLeft: CGPoint = CGPoint(x: 0.38, y: 0.45)
    @State private var frontalRight: CGPoint = CGPoint(x: 0.62, y: 0.45)
    @State private var skullLeft: CGPoint = CGPoint(x: 0.22, y: 0.45)
    @State private var skullRight: CGPoint = CGPoint(x: 0.78, y: 0.45)
    
    // Scale factor: assuming standard axial CT viewport width is ~200 mm inner skull
    private let assumedSkullWidthMm: Double = 180.0
    
    public init(imageName: String, emergencyTitle: String) {
        self.imageName = imageName
        self.emergencyTitle = emergencyTitle
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            // Mode Selector Bar
            HStack(spacing: 8) {
                ForEach(CaliperToolMode.allCases, id: \.self) { mode in
                    Button(action: {
                        HapticManager.impact(style: .light)
                        activeMode = mode
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: mode.icon)
                            Text(mode.rawValue)
                                .font(.system(size: 11, weight: .bold))
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activeMode == mode ? ObsidianTheme.neonCyan : ObsidianTheme.surfaceElevated)
                        .foregroundColor(activeMode == mode ? .black : ObsidianTheme.textSecondary)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(activeMode == mode ? ObsidianTheme.neonCyan : ObsidianTheme.borderSubtle, lineWidth: 1))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    HapticManager.impact(style: .medium)
                    isShowingCameraPicker = true
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "camera.fill")
                        Text("Snap PACS")
                            .font(.system(size: 10, weight: .bold))
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .background(ObsidianTheme.neonCyan)
                    .foregroundColor(.black)
                    .cornerRadius(6)
                }
                
                Button(action: {
                    isCaliperActive.toggle()
                }) {
                    Image(systemName: isCaliperActive ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(isCaliperActive ? ObsidianTheme.neonCyan : ObsidianTheme.textTertiary)
                        .padding(8)
                        .background(ObsidianTheme.surfaceElevated)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            
            // Interactive Caliper Viewport Canvas
            GeometryReader { geo in
                ZStack {
                    // Base Radiologic Scan (Custom Camera Snapshot OR Pre-Loaded Scan)
                    Group {
                        if let customImage = customCapturedImage {
                            Image(uiImage: customImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .background(Color.black)
                    .cornerRadius(14)
                    
                    if isCaliperActive {
                        // Caliper Overlay Layer
                        switch activeMode {
                        case .abc2:
                            abc2CaliperOverlay(size: geo.size)
                        case .midlineShift:
                            midlineShiftOverlay(size: geo.size)
                        case .evansIndex:
                            evansIndexOverlay(size: geo.size)
                        }
                    }
                    
                    // Anatomical Orientation Indicators
                    VStack {
                        Text("[ANT]")
                            .font(.system(size: 9, weight: .heavy, design: .monospaced))
                            .foregroundColor(Color.yellow)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(4)
                            .padding(.top, 6)
                        Spacer()
                        Text("[POST]")
                            .font(.system(size: 9, weight: .heavy, design: .monospaced))
                            .foregroundColor(Color.yellow)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(4)
                            .padding(.bottom, 6)
                    }
                    
                    HStack {
                        Text("[R]")
                            .font(.system(size: 9, weight: .heavy, design: .monospaced))
                            .foregroundColor(Color.yellow)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(4)
                            .padding(.leading, 6)
                        Spacer()
                        Text("[L]")
                            .font(.system(size: 9, weight: .heavy, design: .monospaced))
                            .foregroundColor(Color.yellow)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(4)
                            .padding(.trailing, 6)
                    }
                }
            }
            .frame(height: 320)
            .cornerRadius(14)
            .padding(.horizontal)
            
            // Diagnostic Measurements & Clinical Indication Cockpit Card
            measurementCockpitCard
                .padding(.horizontal)
        }
        .sheet(isPresented: $isShowingCameraPicker) {
            ImagePickerSheet(sourceType: .camera) { img in
                customCapturedImage = img
            }
        }
    }
    
    // MARK: - 1. ABC/2 Caliper Overlay
    private func abc2CaliperOverlay(size: CGSize) -> some View {
        ZStack {
            // Line A (Length)
            Path { path in
                path.move(to: denormalize(pointA1, size: size))
                path.addLine(to: denormalize(pointA2, size: size))
            }
            .stroke(ObsidianTheme.neonAmber, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, dash: [6, 4]))
            
            // Handle A1
            caliperHandle(point: $pointA1, size: size, color: ObsidianTheme.neonAmber, label: "A1")
            // Handle A2
            caliperHandle(point: $pointA2, size: size, color: ObsidianTheme.neonAmber, label: "A2")
            
            // Line B (Width)
            Path { path in
                path.move(to: denormalize(pointB1, size: size))
                path.addLine(to: denormalize(pointB2, size: size))
            }
            .stroke(ObsidianTheme.neonCyan, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, dash: [6, 4]))
            
            // Handle B1
            caliperHandle(point: $pointB1, size: size, color: ObsidianTheme.neonCyan, label: "B1")
            // Handle B2
            caliperHandle(point: $pointB2, size: size, color: ObsidianTheme.neonCyan, label: "B2")
        }
    }
    
    // MARK: - 2. Midline Shift Overlay
    private func midlineShiftOverlay(size: CGSize) -> some View {
        ZStack {
            // True Midline Reference Axis (Falx anterior to internal occipital protuberance)
            Path { path in
                path.move(to: denormalize(midLineA, size: size))
                path.addLine(to: denormalize(midLineB, size: size))
            }
            .stroke(Color.white.opacity(0.7), style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
            
            // Shift Vector: perpendicular distance from septumPoint to Midline Axis
            let pSeptum = denormalize(septumPoint, size: size)
            let midX = denormalize(CGPoint(x: midLineA.x, y: septumPoint.y), size: size)
            
            Path { path in
                path.move(to: midX)
                path.addLine(to: pSeptum)
            }
            .stroke(ObsidianTheme.neonRed, style: StrokeStyle(lineWidth: 3, lineCap: .round))
            
            // Septum Handle
            caliperHandle(point: $septumPoint, size: size, color: ObsidianTheme.neonRed, label: "Septum")
        }
    }
    
    // MARK: - 3. Evans Index Overlay
    private func evansIndexOverlay(size: CGSize) -> some View {
        ZStack {
            // Frontal Horn Diameter (Line 1)
            Path { path in
                path.move(to: denormalize(frontalLeft, size: size))
                path.addLine(to: denormalize(frontalRight, size: size))
            }
            .stroke(ObsidianTheme.neonCyan, style: StrokeStyle(lineWidth: 2.5, dash: [5, 3]))
            
            caliperHandle(point: $frontalLeft, size: size, color: ObsidianTheme.neonCyan, label: "F1")
            caliperHandle(point: $frontalRight, size: size, color: ObsidianTheme.neonCyan, label: "F2")
            
            // Inner Calvarial Diameter (Line 2)
            Path { path in
                path.move(to: denormalize(skullLeft, size: size))
                path.addLine(to: denormalize(skullRight, size: size))
            }
            .stroke(ObsidianTheme.neonRose, style: StrokeStyle(lineWidth: 2.5, dash: [5, 3]))
            
            caliperHandle(point: $skullLeft, size: size, color: ObsidianTheme.neonRose, label: "S1")
            caliperHandle(point: $skullRight, size: size, color: ObsidianTheme.neonRose, label: "S2")
        }
    }
    
    // MARK: - Caliper Draggable Handle Component
    private func caliperHandle(point: Binding<CGPoint>, size: CGSize, color: Color, label: String) -> some View {
        let p = denormalize(point.wrappedValue, size: size)
        return ZStack {
            Circle()
                .fill(color)
                .frame(width: 22, height: 22)
                .shadow(color: color.opacity(0.8), radius: 6)
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 22, height: 22)
            Text(label)
                .font(.system(size: 8, weight: .black))
                .foregroundColor(.black)
        }
        .position(p)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let normX = max(0.05, min(0.95, value.location.x / size.width))
                    let normY = max(0.05, min(0.95, value.location.y / size.height))
                    point.wrappedValue = CGPoint(x: normX, y: normY)
                }
        )
    }
    
    // Helper Coordinate Conversion
    private func denormalize(_ pt: CGPoint, size: CGSize) -> CGPoint {
        CGPoint(x: pt.x * size.width, y: pt.y * size.height)
    }
    
    // Computed Distance in Millimeters
    private func distanceMm(_ p1: CGPoint, _ p2: CGPoint) -> Double {
        let dx = (p1.x - p2.x) * assumedSkullWidthMm
        let dy = (p1.y - p2.y) * assumedSkullWidthMm
        return sqrt(dx * dx + dy * dy)
    }
    
    // MARK: - Measurement Cockpit Card
    private var measurementCockpitCard: some View {
        VStack(spacing: 12) {
            switch activeMode {
            case .abc2:
                abc2CalculationView
            case .midlineShift:
                midlineShiftCalculationView
            case .evansIndex:
                evansIndexCalculationView
            }
        }
        .padding(14)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
    
    // ABC/2 Calculation Breakdown
    private var abc2CalculationView: some View {
        let lengthCm = distanceMm(pointA1, pointA2) / 10.0
        let widthCm = distanceMm(pointB1, pointB2) / 10.0
        let depthCm = (sliceCount * sliceThicknessMm) / 10.0
        let volumeCc = (lengthCm * widthCm * depthCm) / 2.0
        let isSurgical = volumeCc >= 30.0
        
        return VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("ABC/2 HEMATOMA VOLUMETRIC ANALYSIS")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonAmber)
                    Text(String(format: "%.1f mL (cc)", volumeCc))
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                        .foregroundColor(isSurgical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                Spacer()
                Text(isSurgical ? "SURGICAL INDICATION (>30 mL)" : "BELOW 30 mL CRITERIA")
                    .font(.system(size: 10, weight: .black))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(isSurgical ? ObsidianTheme.neonRed.opacity(0.18) : ObsidianTheme.neonGreen.opacity(0.18))
                    .foregroundColor(isSurgical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                    .cornerRadius(6)
            }
            
            Divider().background(ObsidianTheme.borderSubtle)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("A (Max Length)").font(.system(size: 9, weight: .bold)).foregroundColor(ObsidianTheme.textTertiary)
                    Text(String(format: "%.1f cm", lengthCm)).font(.system(size: 13, weight: .heavy)).foregroundColor(ObsidianTheme.neonAmber)
                }
                VStack(alignment: .leading) {
                    Text("B (Max Width)").font(.system(size: 9, weight: .bold)).foregroundColor(ObsidianTheme.textTertiary)
                    Text(String(format: "%.1f cm", widthCm)).font(.system(size: 13, weight: .heavy)).foregroundColor(ObsidianTheme.neonCyan)
                }
                VStack(alignment: .leading) {
                    Text("C (Z-Depth)").font(.system(size: 9, weight: .bold)).foregroundColor(ObsidianTheme.textTertiary)
                    Text(String(format: "%.1f cm", depthCm)).font(.system(size: 13, weight: .heavy)).foregroundColor(Color.white)
                }
            }
            
            // Slice Stepper
            HStack {
                Text("CT Slices with Hematoma:")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
                Spacer()
                Stepper(value: $sliceCount, in: 1...20, step: 1) {
                    Text("\(Int(sliceCount)) slices (\(Int(sliceCount * sliceThicknessMm)) mm)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
            }
        }
    }
    
    // Midline Shift Calculation Breakdown
    private var midlineShiftCalculationView: some View {
        let shiftMm = abs(septumPoint.x - midLineA.x) * assumedSkullWidthMm
        let isCritical = shiftMm >= 5.0
        
        return VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SEPTUM PELLUCIDUM MIDLINE SHIFT")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonRed)
                    Text(String(format: "%.1f mm", shiftMm))
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                        .foregroundColor(isCritical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                Spacer()
                Text(isCritical ? "CRITICAL SHIFT (>5 mm)" : "COMPENSATED (<5 mm)")
                    .font(.system(size: 10, weight: .black))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(isCritical ? ObsidianTheme.neonRed.opacity(0.18) : ObsidianTheme.neonGreen.opacity(0.18))
                    .foregroundColor(isCritical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                    .cornerRadius(6)
            }
            
            Text("BTF Rule: Midline shift > 5 mm in acute SDH or EDH is an independent indication for emergent surgical craniotomy regardless of admission GCS score.")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
    }
    
    // Evans Index Calculation Breakdown
    private var evansIndexCalculationView: some View {
        let frontalMm = distanceMm(frontalLeft, frontalRight)
        let skullMm = distanceMm(skullLeft, skullRight)
        let evansRatio = skullMm > 0 ? (frontalMm / skullMm) : 0.0
        let isHydro = evansRatio >= 0.30
        
        return VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("EVANS HYDROCEPHALUS INDEX")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Text(String(format: "%.2f", evansRatio))
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                        .foregroundColor(isHydro ? ObsidianTheme.neonCyan : ObsidianTheme.neonGreen)
                }
                Spacer()
                Text(isHydro ? "VENTRICULOMEGALY (>0.30)" : "NORMAL RATIO (<0.30)")
                    .font(.system(size: 10, weight: .black))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(isHydro ? ObsidianTheme.neonCyan.opacity(0.18) : ObsidianTheme.neonGreen.opacity(0.18))
                    .foregroundColor(isHydro ? ObsidianTheme.neonCyan : ObsidianTheme.neonGreen)
                    .cornerRadius(6)
            }
            
            Text("Evans Index > 0.30 establishes acute ventricular enlargement / communicating hydrocephalus requiring external ventricular drain (EVD) or shunt revision.")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
    }
}
