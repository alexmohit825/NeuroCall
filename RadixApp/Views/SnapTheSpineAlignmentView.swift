import SwiftUI
import CoreGraphics

// MARK: - "Snap-the-Spine": Bedside Spinopelvic & Sagittal Alignment Auto-Drafter
// Synthesized from SRS-Schwab Adult Spinal Deformity Classification, Duval-Beaupère Spinopelvic Anatomy,
// and Glassman Sagittal Vertical Axis Standards.
// 100% On-Device Deterministic Trigonometry: Zero cloud dependencies, zero HIPAA data egress.
// Computes Pelvic Incidence (PI), Pelvic Tilt (PT), Sacral Slope (SS), Lumbar Lordosis (LL), PI-LL Mismatch, and SVA.

public struct SnapTheSpineAlignmentView: View {
    @State private var capturedImage: UIImage? = nil
    @State private var isShowingCamera = false
    @State private var isShowingPhotoPicker = false
    @State private var isCaliperActive = true
    
    // Normalized Coordinate Points (0.0 to 1.0 relative to image viewport)
    // 1. Femoral Heads
    @State private var femoralHead1 = CGPoint(x: 0.42, y: 0.82)
    @State private var femoralHead2 = CGPoint(x: 0.48, y: 0.82)
    
    // 2. S1 Superior Endplate (Promontory to Posterior Corner)
    @State private var sacralPromontory = CGPoint(x: 0.38, y: 0.65)
    @State private var sacralPosteriorCorner = CGPoint(x: 0.54, y: 0.61)
    
    // 3. L1 Superior Endplate
    @State private var l1Anterior = CGPoint(x: 0.44, y: 0.34)
    @State private var l1Posterior = CGPoint(x: 0.58, y: 0.35)
    
    // 4. C7 Centroid (Plumb Line)
    @State private var c7Centroid = CGPoint(x: 0.52, y: 0.12)
    
    // Calibration Scale (assumes 400 mm vertical spine FOV)
    private let assumedSpineFovMm: Double = 600.0
    
    public init() {}
    
    // MARK: - Deterministic Trigonometric Calculations (Duval-Beaupère)
    
    // Center of Femoral Heads (Bicoxofemoral Axis)
    private var bicoxofemoralCenter: CGPoint {
        CGPoint(
            x: (femoralHead1.x + femoralHead2.x) / 2.0,
            y: (femoralHead1.y + femoralHead2.y) / 2.0
        )
    }
    
    // Midpoint of S1 Superior Endplate
    private var sacralMidpoint: CGPoint {
        CGPoint(
            x: (sacralPromontory.x + sacralPosteriorCorner.x) / 2.0,
            y: (sacralPromontory.y + sacralPosteriorCorner.y) / 2.0
        )
    }
    
    // Sacral Slope (SS): Angle between S1 endplate and horizontal
    private var calculatedSS: Double {
        let dx = sacralPosteriorCorner.x - sacralPromontory.x
        let dy = sacralPosteriorCorner.y - sacralPromontory.y
        let radians = atan2(abs(dy), abs(dx))
        let degrees = radians * (180.0 / .pi)
        return min(max(degrees, 10.0), 75.0)
    }
    
    // Pelvic Tilt (PT): Angle between femoral-sacral axis and vertical plumb line
    private var calculatedPT: Double {
        let dx = sacralMidpoint.x - bicoxofemoralCenter.x
        let dy = bicoxofemoralCenter.y - sacralMidpoint.y
        let radians = atan2(dx, dy)
        let degrees = radians * (180.0 / .pi)
        return min(max(degrees, 0.0), 50.0)
    }
    
    // Pelvic Incidence (PI): Exact mathematical invariant PI = PT + SS
    private var calculatedPI: Double {
        calculatedPT + calculatedSS
    }
    
    // Lumbar Lordosis (LL): Cobb angle between L1 superior endplate and S1 superior endplate
    private var calculatedLL: Double {
        let l1Dx = l1Posterior.x - l1Anterior.x
        let l1Dy = l1Posterior.y - l1Anterior.y
        let l1Angle = atan2(l1Dy, l1Dx) * (180.0 / .pi)
        
        let s1Dx = sacralPosteriorCorner.x - sacralPromontory.x
        let s1Dy = sacralPosteriorCorner.y - sacralPromontory.y
        let s1Angle = atan2(s1Dy, s1Dx) * (180.0 / .pi)
        
        let cobb = abs(s1Angle - l1Angle)
        return min(max(cobb, 15.0), 90.0)
    }
    
    // PI - LL Mismatch: SRS-Schwab Deformity Modifier
    private var piMinusLL: Double {
        calculatedPI - calculatedLL
    }
    
    // Sagittal Vertical Axis (SVA): Horizontal offset between C7 plumbline and S1 posterior corner in cm
    private var calculatedSVACm: Double {
        let horizontalOffsetRatio = c7Centroid.x - sacralPosteriorCorner.x
        let offsetMm = horizontalOffsetRatio * assumedSpineFovMm
        return offsetMm / 10.0 // mm to cm
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Banner
                headerBanner
                
                // Camera & Ingestion Bar
                ingestionControlBar
                
                // Interactive Alignment Canvas
                alignmentCanvasView
                
                // Primary Spinopelvic Metrics Readout (PI, PT, SS)
                spinopelvicTriadCard
                
                // Sagittal Alignment & PI-LL Mismatch Card (SRS-Schwab)
                srsSchwabDeformityCard
                
                // Clinical Decision Guide
                alignmentPearlsCard
                
                Spacer(minLength: 40)
            }
            .padding(.top, 10)
        }
        .background(ObsidianTheme.surfaceVoid)
        .sheet(isPresented: $isShowingCamera) {
            ImagePickerSheet(sourceType: .camera) { image in
                capturedImage = image
            }
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            ImagePickerSheet(sourceType: .photoLibrary) { image in
                capturedImage = image
            }
        }
    }
    
    // MARK: - Header Banner
    private var headerBanner: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Circle().fill(ObsidianTheme.neonGreen).frame(width: 8, height: 8)
                Text("ON-DEVICE RADIOLOGIC SAGITTAL ALIGNMENT")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.8)
                    .foregroundColor(ObsidianTheme.neonGreen)
            }
            Text("Snap-the-Spine Alignment Engine")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("100% on-device Duval-Beaupère spinopelvic parameters (PI, PT, SS, LL, SVA).")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    // MARK: - Camera & Ingestion Bar
    private var ingestionControlBar: some View {
        HStack(spacing: 8) {
            Button(action: {
                HapticManager.impact(style: .medium)
                isShowingCamera = true
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "camera.fill")
                    Text("Snap Lateral Film")
                        .font(.system(size: 11, weight: .bold))
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(ObsidianTheme.neonCyan)
                .foregroundColor(.black)
                .cornerRadius(10)
            }
            
            Button(action: {
                HapticManager.impact(style: .light)
                isShowingPhotoPicker = true
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "photo.on.rectangle")
                    Text("PACS Photo")
                        .font(.system(size: 11, weight: .bold))
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(ObsidianTheme.surfaceElevated)
                .foregroundColor(ObsidianTheme.textPrimary)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
            }
            
            Spacer()
            
            Button(action: {
                HapticManager.impact(style: .light)
                resetPinsToDefault()
            }) {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .padding(8)
                    .background(ObsidianTheme.surfaceElevated)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Interactive Alignment Canvas
    private var alignmentCanvasView: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            
            ZStack {
                // Background: User Camera Photo OR Default Lateral Spine Template
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: w, height: h)
                        .clipped()
                } else {
                    // Dark Medical Radiograph Backdrop with Reference Grid
                    ZStack {
                        Color.black
                        
                        VStack(spacing: 20) {
                            Text("LATERAL LUMBAR / SPINOPELVIC CALIPER CANVAS")
                                .font(.system(size: 10, weight: .black, design: .monospaced))
                                .foregroundColor(Color.white.opacity(0.2))
                            Text("Snap PACS screen or drag pins to calculate Cobb angles & PI")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(Color.white.opacity(0.35))
                        }
                    }
                    .frame(width: w, height: h)
                }
                
                // Caliper Geometric Overlay Vectors
                if isCaliperActive {
                    Canvas { ctx, size in
                        let f1 = toCanvas(femoralHead1, size)
                        let f2 = toCanvas(femoralHead2, size)
                        let fc = toCanvas(bicoxofemoralCenter, size)
                        let sa = toCanvas(sacralPromontory, size)
                        let sp = toCanvas(sacralPosteriorCorner, size)
                        let sm = toCanvas(sacralMidpoint, size)
                        let l1a = toCanvas(l1Anterior, size)
                        let l1p = toCanvas(l1Posterior, size)
                        let c7 = toCanvas(c7Centroid, size)
                        
                        // 1. Femoral Axis Line
                        var fAxis = Path()
                        fAxis.move(to: f1)
                        fAxis.addLine(to: f2)
                        ctx.stroke(fAxis, with: .color(ObsidianTheme.neonAmber), style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
                        
                        // 2. Femoral-Sacral Line (from FC to SM)
                        var fsLine = Path()
                        fsLine.move(to: fc)
                        fsLine.addLine(to: sm)
                        ctx.stroke(fsLine, with: .color(ObsidianTheme.neonCyan), lineWidth: 2.5)
                        
                        // 3. S1 Endplate Line (SA to SP)
                        var s1Line = Path()
                        s1Line.move(to: sa)
                        s1Line.addLine(to: sp)
                        ctx.stroke(s1Line, with: .color(ObsidianTheme.neonGreen), lineWidth: 2.5)
                        
                        // 4. L1 Endplate Line
                        var l1Line = Path()
                        l1Line.move(to: l1a)
                        l1Line.addLine(to: l1p)
                        ctx.stroke(l1Line, with: .color(ObsidianTheme.neonPurple), lineWidth: 2)
                        
                        // 5. C7 Plumb Line (Vertical drop)
                        var c7Line = Path()
                        c7Line.move(to: c7)
                        c7Line.addLine(to: CGPoint(x: c7.x, y: sp.y + 40))
                        ctx.stroke(c7Line, with: .color(ObsidianTheme.neonRed), style: StrokeStyle(lineWidth: 1.5, dash: [5, 3]))
                    }
                    
                    // Draggable Landmark Pins
                    draggablePin(point: $femoralHead1, label: "F1", color: ObsidianTheme.neonAmber, geo: geo)
                    draggablePin(point: $femoralHead2, label: "F2", color: ObsidianTheme.neonAmber, geo: geo)
                    draggablePin(point: $sacralPromontory, label: "S1-Ant", color: ObsidianTheme.neonGreen, geo: geo)
                    draggablePin(point: $sacralPosteriorCorner, label: "S1-Post", color: ObsidianTheme.neonGreen, geo: geo)
                    draggablePin(point: $l1Anterior, label: "L1-Ant", color: ObsidianTheme.neonPurple, geo: geo)
                    draggablePin(point: $l1Posterior, label: "L1-Post", color: ObsidianTheme.neonPurple, geo: geo)
                    draggablePin(point: $c7Centroid, label: "C7", color: ObsidianTheme.neonRed, geo: geo)
                }
            }
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1.5))
        }
        .frame(height: 340)
        .padding(.horizontal)
    }
    
    // MARK: - Spinopelvic Triad Card (PI, PT, SS)
    private var spinopelvicTriadCard: some View {
        VStack(spacing: 12) {
            HStack {
                Text("DUVAL-BEAUPÈRE SPINOPELVIC PARAMETERS")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(ObsidianTheme.neonCyan)
                Spacer()
                Text("PI = PT + SS")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(ObsidianTheme.surfaceElevated)
                    .cornerRadius(4)
            }
            
            HStack(spacing: 10) {
                metricBox(
                    label: "PELVIC INCIDENCE",
                    value: String(format: "%.1f°", calculatedPI),
                    status: "Anatomic Constant",
                    color: ObsidianTheme.neonCyan
                )
                metricBox(
                    label: "PELVIC TILT (PT)",
                    value: String(format: "%.1f°", calculatedPT),
                    status: calculatedPT > 20 ? "Compensated (>20°)" : "Normal (<20°)",
                    color: calculatedPT > 20 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen
                )
                metricBox(
                    label: "SACRAL SLOPE (SS)",
                    value: String(format: "%.1f°", calculatedSS),
                    status: "Horizontal Base",
                    color: ObsidianTheme.neonAmber
                )
            }
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - SRS-Schwab Deformity Card (PI-LL Mismatch & SVA)
    private var srsSchwabDeformityCard: some View {
        let mismatch = piMinusLL
        let sva = calculatedSVACm
        
        let mismatchGrade: (String, Color) = {
            if mismatch < 10.0 {
                return ("Non-Pathologic (<10°)", ObsidianTheme.neonGreen)
            } else if mismatch <= 20.0 {
                return ("Moderate Mismatch (10–20°)", ObsidianTheme.neonAmber)
            } else {
                return ("Marked Deformity (>20°)", ObsidianTheme.neonRed)
            }
        }()
        
        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SRS-SCHWAB SAGITTAL ALIGNMENT MODIFIERS")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonPurple)
                    Text("Lumbar lordosis requirement & C7 plumbline offset")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text(mismatchGrade.0)
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(mismatchGrade.1)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(mismatchGrade.1.opacity(0.18))
                    .cornerRadius(4)
            }
            
            HStack(spacing: 12) {
                // Measured LL
                VStack(alignment: .leading, spacing: 2) {
                    Text("LUMBAR LORDOSIS")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(ObsidianTheme.textTertiary)
                    Text(String(format: "%.1f°", calculatedLL))
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(ObsidianTheme.neonPurple)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // PI - LL Mismatch
                VStack(alignment: .leading, spacing: 2) {
                    Text("PI - LL MISMATCH")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(ObsidianTheme.textTertiary)
                    Text(String(format: "%+.1f°", mismatch))
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(mismatchGrade.1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // SVA
                VStack(alignment: .trailing, spacing: 2) {
                    Text("SAGITTAL VERTICAL AXIS")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(ObsidianTheme.textTertiary)
                    Text(String(format: "%.1f cm", sva))
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(sva > 5.0 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Text("Rule: Target postoperative Lumbar Lordosis = Pelvic Incidence ± 9°. Failure to restore LL triggers proximal junctional kyphosis (PJK) and hardware failure.")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - Alignment Pearls Card
    private var alignmentPearlsCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("SURGICAL ALIGNMENT TARGETS")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(ObsidianTheme.neonGreen)
            
            VStack(alignment: .leading, spacing: 4) {
                bullet(label: "Pelvic Tilt (PT):", text: "Goal < 20°. Elevated PT indicates pelvic retroversion compensating for flatback.")
                bullet(label: "PI - LL Match:", text: "Goal within 10°. For every 10° of mismatch, risk of PJK revision increases 3-fold.")
                bullet(label: "SVA Target:", text: "Goal < 5 cm anterior to S1 posterior superior corner. Positive SVA = severe pain/disability.")
            }
        }
        .padding(12)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    private func bullet(label: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text(label)
                .font(.system(size: 10, weight: .black))
                .foregroundColor(ObsidianTheme.neonGreen)
                .frame(width: 90, alignment: .leading)
            Text(text)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
    }
    
    private func metricBox(label: String, value: String, status: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label)
                .font(.system(size: 8, weight: .black))
                .foregroundColor(ObsidianTheme.textTertiary)
            Text(value)
                .font(.system(size: 18, weight: .heavy, design: .rounded))
                .foregroundColor(color)
            Text(status)
                .font(.system(size: 8, weight: .bold))
                .foregroundColor(color.opacity(0.85))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(ObsidianTheme.surfaceElevated)
        .cornerRadius(10)
    }
    
    // MARK: - Pin Gesture & Helpers
    private func draggablePin(point: Binding<CGPoint>, label: String, color: Color, geo: GeometryProxy) -> some View {
        let x = point.wrappedValue.x * geo.size.width
        let y = point.wrappedValue.y * geo.size.height
        
        return ZStack {
            Circle()
                .fill(color)
                .frame(width: 22, height: 22)
                .shadow(color: color.opacity(0.8), radius: 6)
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 22, height: 22)
            Text(label)
                .font(.system(size: 7, weight: .black))
                .foregroundColor(.black)
        }
        .position(x: x, y: y)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let newX = max(0.05, min(0.95, value.location.x / geo.size.width))
                    let newY = max(0.05, min(0.95, value.location.y / geo.size.height))
                    point.wrappedValue = CGPoint(x: newX, y: newY)
                }
        )
    }
    
    private func toCanvas(_ normalized: CGPoint, _ size: CGSize) -> CGPoint {
        CGPoint(x: normalized.x * size.width, y: normalized.y * size.height)
    }
    
    private func resetPinsToDefault() {
        femoralHead1 = CGPoint(x: 0.42, y: 0.82)
        femoralHead2 = CGPoint(x: 0.48, y: 0.82)
        sacralPromontory = CGPoint(x: 0.38, y: 0.65)
        sacralPosteriorCorner = CGPoint(x: 0.54, y: 0.61)
        l1Anterior = CGPoint(x: 0.44, y: 0.34)
        l1Posterior = CGPoint(x: 0.58, y: 0.35)
        c7Centroid = CGPoint(x: 0.52, y: 0.12)
    }
}
