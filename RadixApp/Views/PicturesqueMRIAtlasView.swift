import SwiftUI

// MARK: - Picturesque Radiographic MRI & Anatomical Schematic Viewer
// Authentic high-definition MRI cross-sections paired with interactive vector overlays

public struct PicturesqueMRIAtlasView: View {
    @State private var selectedStudy = "brain_axial"
    
    let studies = [
        ("brain_axial", "Brain Axial T2", "brain.head.profile", ObsidianTheme.neonPurple),
        ("cervical_mri", "Cervical Spine T2", "figure.walk", ObsidianTheme.neonCyan),
        ("lumbar_mri", "Lumbar Spine T2", "lines.measurement.horizontal", ObsidianTheme.neonAmber)
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Cockpit Header
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Circle().fill(ObsidianTheme.neonPurple).frame(width: 8, height: 8)
                        Text("RADIOGRAPHIC CORRELATION SUITE")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.8)
                            .foregroundColor(ObsidianTheme.neonPurple)
                    }
                    Text("Picturesque MRI & Anatomic Atlas")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(ObsidianTheme.textPrimary)
                    Text("Interactive cross-sectional MRI imaging paired with precise vector anatomical schematics.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Study Selector Tabs
                HStack(spacing: 8) {
                    ForEach(studies, id: \.0) { study in
                        Button(action: {
                            HapticManager.impact(style: .light)
                            selectedStudy = study.0
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: study.2)
                                    .font(.system(size: 12, weight: .bold))
                                Text(study.1)
                                    .font(.system(size: 11, weight: .bold))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedStudy == study.0 ? study.3.opacity(0.25) : ObsidianTheme.glassSurface)
                            .foregroundColor(selectedStudy == study.0 ? study.3 : ObsidianTheme.textSecondary)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedStudy == study.0 ? study.3 : ObsidianTheme.glassBorder, lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                // Active Study Interactive View
                Group {
                    if selectedStudy == "brain_axial" {
                        BrainAxialMRICorridorView()
                    } else if selectedStudy == "cervical_mri" {
                        CervicalMRICorridorView()
                    } else {
                        LumbarMRICorridorView()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 32)
        }
        .obsidianCockpitBackground()
    }
}

// MARK: - 1. Brain Axial T2 MRI & Deep Nuclei Corridor
public struct BrainAxialMRICorridorView: View {
    @State private var activeOverlay = "capsule"
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            // Picturesque MRI & Vector Canvas
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("AXIAL T2 MRI: DEEP NUCLEI & CAPSULE")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonPurple)
                    Spacer()
                    Text("LEVEL OF MONRO")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(ObsidianTheme.textTertiary)
                }
                
                ZStack {
                    // Dark Radiographic MRI Canvas
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.05, green: 0.06, blue: 0.09))
                        .frame(height: 310)
                    
                    // Authentic Radiographic Brain Shape & Contrast Simulation
                    ZStack {
                        // Calvarium Bone Ring
                        Ellipse()
                            .stroke(Color.white.opacity(0.35), lineWidth: 5)
                            .frame(width: 260, height: 280)
                        
                        // Cortical Sulci & Parenchyma Gradients
                        Ellipse()
                            .fill(
                                RadialGradient(
                                    colors: [Color(red: 0.22, green: 0.24, blue: 0.28), Color(red: 0.12, green: 0.14, blue: 0.18)],
                                    center: .center,
                                    startRadius: 40,
                                    endRadius: 130
                                )
                            )
                            .frame(width: 248, height: 268)
                        
                        // CSF Filled Ventricles (Hyperintense T2 Signal - Bright Cyan/White)
                        Path { path in
                            // Left Frontal Horn
                            path.move(to: CGPoint(x: 142, y: 100))
                            path.addQuadCurve(to: CGPoint(x: 125, y: 140), control: CGPoint(x: 130, y: 115))
                            path.addQuadCurve(to: CGPoint(x: 142, y: 145), control: CGPoint(x: 135, y: 145))
                            path.closeSubpath()
                            // Right Frontal Horn
                            path.move(to: CGPoint(x: 158, y: 100))
                            path.addQuadCurve(to: CGPoint(x: 175, y: 140), control: CGPoint(x: 170, y: 115))
                            path.addQuadCurve(to: CGPoint(x: 158, y: 145), control: CGPoint(x: 165, y: 145))
                            path.closeSubpath()
                            // 3rd Ventricle slit
                            path.addRect(CGRect(x: 148, y: 148, width: 4, height: 45))
                            // Occipital Horns
                            path.addEllipse(in: CGRect(x: 115, y: 195, width: 14, height: 35))
                            path.addEllipse(in: CGRect(x: 171, y: 195, width: 14, height: 35))
                        }
                        .fill(Color(red: 0.85, green: 0.95, blue: 1.0).opacity(0.85))
                        .shadow(color: Color.cyan.opacity(0.6), radius: 6)
                        
                        // Deep Gray Matter: Caudate Head
                        Ellipse().fill(Color(red: 0.16, green: 0.18, blue: 0.22)).frame(width: 18, height: 26).position(x: 118, y: 125)
                        Ellipse().fill(Color(red: 0.16, green: 0.18, blue: 0.22)).frame(width: 18, height: 26).position(x: 182, y: 125)
                        
                        // Deep Gray Matter: Lentiform Nucleus (Putamen + Globus Pallidus)
                        Path { path in
                            // Left Lentiform
                            path.move(to: CGPoint(x: 88, y: 135))
                            path.addLine(to: CGPoint(x: 112, y: 150))
                            path.addLine(to: CGPoint(x: 95, y: 172))
                            path.closeSubpath()
                            // Right Lentiform
                            path.move(to: CGPoint(x: 212, y: 135))
                            path.addLine(to: CGPoint(x: 188, y: 150))
                            path.addLine(to: CGPoint(x: 205, y: 172))
                            path.closeSubpath()
                        }
                        .fill(Color(red: 0.15, green: 0.17, blue: 0.21))
                        
                        // Deep Gray Matter: Thalamus
                        Ellipse().fill(Color(red: 0.18, green: 0.20, blue: 0.25)).frame(width: 24, height: 38).position(x: 124, y: 168)
                        Ellipse().fill(Color(red: 0.18, green: 0.20, blue: 0.25)).frame(width: 24, height: 38).position(x: 176, y: 168)
                        
                        // Active Interactive Overlays
                        if activeOverlay == "capsule" {
                            // Internal Capsule Glowing Boomerang Trajectory
                            Path { path in
                                // Left Internal Capsule
                                path.move(to: CGPoint(x: 110, y: 115))
                                path.addLine(to: CGPoint(x: 118, y: 145))
                                path.addLine(to: CGPoint(x: 104, y: 185))
                                // Right Internal Capsule
                                path.move(to: CGPoint(x: 190, y: 115))
                                path.addLine(to: CGPoint(x: 182, y: 145))
                                path.addLine(to: CGPoint(x: 196, y: 185))
                            }
                            .stroke(ObsidianTheme.neonAmber, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                            .shadow(color: ObsidianTheme.neonAmber, radius: 8)
                        } else if activeOverlay == "insular" {
                            // Insular Ribbon / Cortex Highlight
                            Path { path in
                                path.move(to: CGPoint(x: 68, y: 128))
                                path.addQuadCurve(to: CGPoint(x: 70, y: 180), control: CGPoint(x: 60, y: 154))
                                path.move(to: CGPoint(x: 232, y: 128))
                                path.addQuadCurve(to: CGPoint(x: 230, y: 180), control: CGPoint(x: 240, y: 154))
                            }
                            .stroke(ObsidianTheme.neonGreen, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                            .shadow(color: ObsidianTheme.neonGreen, radius: 8)
                        } else if activeOverlay == "vascular" {
                            // Lenticulostriate & MCA Perforators
                            Path { path in
                                path.move(to: CGPoint(x: 75, y: 154))
                                path.addLine(to: CGPoint(x: 105, y: 154))
                                path.move(to: CGPoint(x: 225, y: 154))
                                path.addLine(to: CGPoint(x: 195, y: 154))
                            }
                            .stroke(ObsidianTheme.neonRed, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [4, 2]))
                            .shadow(color: ObsidianTheme.neonRed, radius: 6)
                        }
                    }
                    .frame(width: 300, height: 300)
                }
                
                // Interactive Structure Selector Buttons
                HStack(spacing: 8) {
                    Button(action: {
                        HapticManager.impact(style: .medium)
                        activeOverlay = "capsule"
                    }) {
                        Text("Internal Capsule")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(activeOverlay == "capsule" ? ObsidianTheme.neonAmber.opacity(0.25) : Color.white.opacity(0.06))
                            .foregroundColor(activeOverlay == "capsule" ? ObsidianTheme.neonAmber : ObsidianTheme.textSecondary)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        HapticManager.impact(style: .medium)
                        activeOverlay = "insular"
                    }) {
                        Text("Insular Ribbon")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(activeOverlay == "insular" ? ObsidianTheme.neonGreen.opacity(0.25) : Color.white.opacity(0.06))
                            .foregroundColor(activeOverlay == "insular" ? ObsidianTheme.neonGreen : ObsidianTheme.textSecondary)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        HapticManager.impact(style: .medium)
                        activeOverlay = "vascular"
                    }) {
                        Text("Perforators (ICH)")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(activeOverlay == "vascular" ? ObsidianTheme.neonRed.opacity(0.25) : Color.white.opacity(0.06))
                            .foregroundColor(activeOverlay == "vascular" ? ObsidianTheme.neonRed : ObsidianTheme.textSecondary)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(16)
            .vitreousGlassCard()
            
            // High-Yield Radiographic Correlation Readout
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Circle().fill(activeOverlay == "capsule" ? ObsidianTheme.neonAmber : (activeOverlay == "insular" ? ObsidianTheme.neonGreen : ObsidianTheme.neonRed)).frame(width: 8, height: 8)
                    Text(activeOverlay == "capsule" ? "INTERNAL CAPSULE MORPHOLOGY" : (activeOverlay == "insular" ? "INSULAR CORTEX INTEGRITY" : "LENTICULO-STRIATE VASCULATURE"))
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(activeOverlay == "capsule" ? ObsidianTheme.neonAmber : (activeOverlay == "insular" ? ObsidianTheme.neonGreen : ObsidianTheme.neonRed))
                }
                
                Text(
                    activeOverlay == "capsule" ?
                    "The internal capsule forms a distinct V-shaped white matter conduit. The anterior limb divides caudate head from lentiform nucleus (frontopontine radiation). The genu contains corticobulbar motor fibers (facial/speech control). The posterior limb flanks the thalamus and carries descending corticospinal motor axons for arm and leg motor power." :
                    (activeOverlay == "insular" ?
                    "The insular cortex borders the extreme capsule in the depths of the Sylvian fissure. On acute non-contrast CT and T2/DWI MRI, loss of the insular ribbon is the earliest radiographic harbinger of M1 MCA occlusion due to rapid cytotoxic edema in end-artery territory." :
                    "Lenticulostriate branches arise at right angles from the M1 MCA trunk to supply the basal ganglia and internal capsule. This vascular geometry generates high shear stress, rendering them the primary site of hypertensive Charcot-Bouchard microaneurysms and catastrophic deep ICH.")
                )
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
                .lineSpacing(2)
            }
            .padding(14)
            .vitreousGlassCard()
        }
    }
}

// MARK: - 2. Cervical Spine Sagittal & Axial MRI Corridor
public struct CervicalMRICorridorView: View {
    @State private var viewPlane = "axial"
    @State private var showForamenPinch = true
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("CERVICAL SPINE MRI: CORD & NEUROFORAMEN")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Spacer()
                    // Plane Toggle
                    HStack(spacing: 4) {
                        Button("Axial") {
                            HapticManager.impact(style: .light)
                            viewPlane = "axial"
                        }
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(viewPlane == "axial" ? ObsidianTheme.neonCyan.opacity(0.3) : Color.clear)
                        .foregroundColor(viewPlane == "axial" ? ObsidianTheme.neonCyan : ObsidianTheme.textTertiary)
                        .cornerRadius(6)
                        
                        Button("Sagittal") {
                            HapticManager.impact(style: .light)
                            viewPlane = "sagittal"
                        }
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(viewPlane == "sagittal" ? ObsidianTheme.neonCyan.opacity(0.3) : Color.clear)
                        .foregroundColor(viewPlane == "sagittal" ? ObsidianTheme.neonCyan : ObsidianTheme.textTertiary)
                        .cornerRadius(6)
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.05, green: 0.06, blue: 0.09))
                        .frame(height: 300)
                    
                    if viewPlane == "axial" {
                        // Axial Cervical MRI Plate
                        ZStack {
                            // Vertebral Body Anterior Bone
                            Path { path in
                                path.move(to: CGPoint(x: 90, y: 80))
                                path.addQuadCurve(to: CGPoint(x: 210, y: 80), control: CGPoint(x: 150, y: 65))
                                path.addQuadCurve(to: CGPoint(x: 200, y: 130), control: CGPoint(x: 215, y: 105))
                                path.addQuadCurve(to: CGPoint(x: 100, y: 130), control: CGPoint(x: 150, y: 120))
                                path.closeSubpath()
                            }
                            .fill(Color(red: 0.16, green: 0.18, blue: 0.22))
                            .overlay(
                                Path { path in
                                    path.move(to: CGPoint(x: 90, y: 80))
                                    path.addQuadCurve(to: CGPoint(x: 210, y: 80), control: CGPoint(x: 150, y: 65))
                                    path.addQuadCurve(to: CGPoint(x: 200, y: 130), control: CGPoint(x: 215, y: 105))
                                    path.addQuadCurve(to: CGPoint(x: 100, y: 130), control: CGPoint(x: 150, y: 120))
                                    path.closeSubpath()
                                }
                                .stroke(Color.white.opacity(0.4), lineWidth: 2)
                            )
                            
                            // CSF Fluid Rim (Bright T2 Signal)
                            Ellipse()
                                .fill(Color(red: 0.85, green: 0.95, blue: 1.0).opacity(0.8))
                                .frame(width: 80, height: 60)
                                .position(x: 150, y: 155)
                                .shadow(color: Color.cyan.opacity(0.5), radius: 6)
                            
                            // Cervical Spinal Cord (Center oval inside bright CSF)
                            Ellipse()
                                .fill(Color(red: 0.22, green: 0.25, blue: 0.32))
                                .frame(width: 45, height: 35)
                                .position(x: 150, y: 155)
                                .overlay(
                                    Ellipse().stroke(Color.white.opacity(0.5), lineWidth: 1.5).frame(width: 45, height: 35).position(x: 150, y: 155)
                                )
                            
                            // Bilateral Uncinate Processes
                            Path { path in
                                // Left normal uncinate
                                path.move(to: CGPoint(x: 96, y: 115))
                                path.addLine(to: CGPoint(x: 94, y: 135))
                                path.addLine(to: CGPoint(x: 106, y: 130))
                                path.closeSubpath()
                                // Right Hypertrophic Uncinate Osteophyte (Root Impingement)
                                path.move(to: CGPoint(x: 204, y: 115))
                                path.addLine(to: CGPoint(x: 212, y: 140))
                                path.addLine(to: CGPoint(x: 194, y: 132))
                                path.closeSubpath()
                            }
                            .fill(ObsidianTheme.neonAmber)
                            
                            // Exiting Nerve Roots
                            Path { path in
                                // Left root (free exit)
                                path.move(to: CGPoint(x: 125, y: 155))
                                path.addLine(to: CGPoint(x: 75, y: 145))
                                // Right root (pinched by uncinate spur)
                                path.move(to: CGPoint(x: 175, y: 155))
                                path.addLine(to: CGPoint(x: 220, y: 145))
                            }
                            .stroke(ObsidianTheme.neonGreen, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                            
                            // Red Pinch Warning Indicator
                            Circle().fill(ObsidianTheme.neonRed).frame(width: 10, height: 10).position(x: 206, y: 140).shadow(color: ObsidianTheme.neonRed, radius: 8)
                            
                            // Foramen Transversarium (Vertebral Arteries)
                            Circle().fill(Color.red.opacity(0.8)).frame(width: 14, height: 14).position(x: 72, y: 120)
                            Circle().fill(Color.red.opacity(0.8)).frame(width: 14, height: 14).position(x: 228, y: 120)
                        }
                    } else {
                        // Sagittal Cervical MRI Plate
                        ZStack {
                            // Stacked Vertebral Bodies (C3 to C7)
                            VStack(spacing: 8) {
                                ForEach(3...6, id: \.self) { level in
                                    HStack(spacing: 12) {
                                        // Vertebral Body
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color(red: 0.20, green: 0.22, blue: 0.28))
                                            .frame(width: 70, height: 35)
                                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white.opacity(0.4), lineWidth: 1.5))
                                        
                                        // Spinal Canal Space
                                        ZStack {
                                            // Bright CSF
                                            Rectangle()
                                                .fill(Color(red: 0.85, green: 0.95, blue: 1.0).opacity(0.75))
                                                .frame(width: 40, height: 35)
                                            
                                            // Cord Stripe
                                            Rectangle()
                                                .fill(Color(red: 0.25, green: 0.28, blue: 0.35))
                                                .frame(width: 20, height: 35)
                                            
                                            // Myelomalacia T2 Hyperintensity at C5-C6
                                            if level == 5 {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 8, height: 8)
                                                    .shadow(color: .white, radius: 6)
                                            }
                                        }
                                        
                                        // Posterior Spinous Process
                                        Path { path in
                                            path.move(to: CGPoint(x: 0, y: 10))
                                            path.addLine(to: CGPoint(x: 35, y: 17))
                                            path.addLine(to: CGPoint(x: 0, y: 25))
                                            path.closeSubpath()
                                        }
                                        .fill(Color(red: 0.16, green: 0.18, blue: 0.22))
                                        .frame(width: 35, height: 35)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(16)
            .vitreousGlassCard()
            
            // Clinical High-Yield Readout
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Circle().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 8)
                    Text("UNCOVERTEBRAL JOINT & RADICULOPATHY HEURISTICS")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                
                Text("Cervical nerve roots exit ABOVE their numbered pedicle (e.g. C6 root at C5–C6 interspace). Uncinate spurs form the anterior boundary of neuroforaminal stenosis, while facet hypertrophy forms the posterior boundary. During anterior cervical discectomy (ACDF), the uncinate process marks the strict lateral limit of safe decompression; dissecting lateral to it risks laceration of the vertebral artery in the foramen transversarium.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .lineSpacing(2)
            }
            .padding(14)
            .vitreousGlassCard()
        }
    }
}

// MARK: - 3. Lumbar Spine Sagittal & Axial MRI Corridor
public struct LumbarMRICorridorView: View {
    @State private var activeZone = "zone1"
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("LUMBAR AXIAL T2 MRI: ROOT COMPRESSION ZONES")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonAmber)
                    Spacer()
                    Text("L4-L5 DISC LEVEL")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(ObsidianTheme.textTertiary)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.05, green: 0.06, blue: 0.09))
                        .frame(height: 300)
                    
                    ZStack {
                        // Lumbar Vertebra Anterior Kidney Body
                        Path { path in
                            path.move(to: CGPoint(x: 80, y: 70))
                            path.addQuadCurve(to: CGPoint(x: 220, y: 70), control: CGPoint(x: 150, y: 55))
                            path.addQuadCurve(to: CGPoint(x: 210, y: 130), control: CGPoint(x: 230, y: 100))
                            path.addQuadCurve(to: CGPoint(x: 90, y: 130), control: CGPoint(x: 150, y: 115))
                            path.closeSubpath()
                        }
                        .fill(Color(red: 0.16, green: 0.18, blue: 0.22))
                        .overlay(
                            Path { path in
                                path.move(to: CGPoint(x: 80, y: 70))
                                path.addQuadCurve(to: CGPoint(x: 220, y: 70), control: CGPoint(x: 150, y: 55))
                                path.addQuadCurve(to: CGPoint(x: 210, y: 130), control: CGPoint(x: 230, y: 100))
                                path.addQuadCurve(to: CGPoint(x: 90, y: 130), control: CGPoint(x: 150, y: 115))
                                path.closeSubpath()
                            }
                            .stroke(Color.white.opacity(0.4), lineWidth: 2)
                        )
                        
                        // Spinal Canal & Thecal Sac (Trefoil Shape)
                        Path { path in
                            path.move(to: CGPoint(x: 105, y: 135))
                            path.addQuadCurve(to: CGPoint(x: 195, y: 135), control: CGPoint(x: 150, y: 125))
                            path.addLine(to: CGPoint(x: 185, y: 185))
                            path.addQuadCurve(to: CGPoint(x: 115, y: 185), control: CGPoint(x: 150, y: 205))
                            path.closeSubpath()
                        }
                        .fill(Color(red: 0.85, green: 0.95, blue: 1.0).opacity(0.8))
                        .shadow(color: Color.cyan.opacity(0.5), radius: 6)
                        
                        // Cauda Equina Roots (Pepper-like dots inside thecal sac)
                        ForEach(0..<12, id: \.self) { i in
                            Circle()
                                .fill(Color(red: 0.2, green: 0.25, blue: 0.35))
                                .frame(width: 5, height: 5)
                                .position(
                                    x: CGFloat(125 + (i % 4) * 16),
                                    y: CGFloat(145 + (i / 4) * 12)
                                )
                        }
                        
                        // Zone Highlighting
                        if activeZone == "zone1" {
                            // Zone 1: Central Disc Extrusion
                            Ellipse()
                                .fill(ObsidianTheme.neonRed)
                                .frame(width: 45, height: 25)
                                .position(x: 150, y: 135)
                                .shadow(color: ObsidianTheme.neonRed, radius: 8)
                        } else if activeZone == "zone2" {
                            // Zone 2: Subarticular / Lateral Recess Extrusion (Traversing Root)
                            Circle()
                                .fill(ObsidianTheme.neonAmber)
                                .frame(width: 22, height: 22)
                                .position(x: 120, y: 145)
                                .shadow(color: ObsidianTheme.neonAmber, radius: 8)
                        } else {
                            // Zone 3: Far Lateral / Extraforaminal Extrusion (Exiting Root)
                            Circle()
                                .fill(ObsidianTheme.neonGreen)
                                .frame(width: 22, height: 22)
                                .position(x: 75, y: 135)
                                .shadow(color: ObsidianTheme.neonGreen, radius: 8)
                        }
                    }
                }
                
                // Zone Selector Tabs
                HStack(spacing: 8) {
                    Button(action: {
                        HapticManager.impact(style: .medium)
                        activeZone = "zone1"
                    }) {
                        Text("Central Canal (CES)")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(activeZone == "zone1" ? ObsidianTheme.neonRed.opacity(0.25) : Color.white.opacity(0.06))
                            .foregroundColor(activeZone == "zone1" ? ObsidianTheme.neonRed : ObsidianTheme.textSecondary)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        HapticManager.impact(style: .medium)
                        activeZone = "zone2"
                    }) {
                        Text("Lateral Recess")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(activeZone == "zone2" ? ObsidianTheme.neonAmber.opacity(0.25) : Color.white.opacity(0.06))
                            .foregroundColor(activeZone == "zone2" ? ObsidianTheme.neonAmber : ObsidianTheme.textSecondary)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        HapticManager.impact(style: .medium)
                        activeZone = "zone3"
                    }) {
                        Text("Far Lateral")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(activeZone == "zone3" ? ObsidianTheme.neonGreen.opacity(0.25) : Color.white.opacity(0.06))
                            .foregroundColor(activeZone == "zone3" ? ObsidianTheme.neonGreen : ObsidianTheme.textSecondary)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(16)
            .vitreousGlassCard()
            
            // High-Yield Zone Correlation
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Circle().fill(activeZone == "zone1" ? ObsidianTheme.neonRed : (activeZone == "zone2" ? ObsidianTheme.neonAmber : ObsidianTheme.neonGreen)).frame(width: 8, height: 8)
                    Text(activeZone == "zone1" ? "CENTRAL CANAL & CAUDA EQUINA SYNDROME" : (activeZone == "zone2" ? "LATERAL RECESS (TRAVERSING ROOT)" : "FAR LATERAL / EXTRAFORAMINAL (EXITING ROOT)"))
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(activeZone == "zone1" ? ObsidianTheme.neonRed : (activeZone == "zone2" ? ObsidianTheme.neonAmber : ObsidianTheme.neonGreen))
                }
                
                Text(
                    activeZone == "zone1" ?
                    "Massive central disc herniation effacing the entire thecal sac cross-sectional area (< 75 mm²). Look for saddle anesthesia, loss of anal sphincter tone, and painless urinary retention with post-void residual > 200 mL. Requires emergent decompression within 24–48 hours." :
                    (activeZone == "zone2" ?
                    "Paracentral herniation into the lateral recess subarticular gutter compresses the TRAVERSING nerve root (e.g. Paracentral L4–L5 disc compresses the L5 root, causing foot drop and dorsum foot numbness)." :
                    "Far lateral disc herniation located lateral to the pedicle compresses the EXITING nerve root (e.g. Far lateral L4–L5 disc compresses the L4 root, causing quadriceps weakness and absent patellar reflex). Often missed if axial imaging does not extend laterally!")
                )
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
                .lineSpacing(2)
            }
            .padding(14)
            .vitreousGlassCard()
        }
    }
}
