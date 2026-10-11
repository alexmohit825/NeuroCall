import SwiftUI

// MARK: - Design-Award Vector Anatomical Schematics Suite
// Rendered in pure SwiftUI with precision Bezier curves, ceramic slate lighting, and Apple Design Award polish.

public struct AtlasInfoStrip: View {
    public let color: Color
    public let title: String
    public let pearl: String
    
    public init(color: Color, title: String, pearl: String) {
        self.color = color
        self.title = title
        self.pearl = pearl
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Circle().fill(color).frame(width: 8, height: 8)
                Text(title)
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(color)
            }
            Text(pearl)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.4))
                .lineSpacing(2)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(color.opacity(0.2), lineWidth: 1)
                )
        )
        .shadow(color: Color.black.opacity(0.03), radius: 4)
    }
}

// =========================================================================
// 1. CIRCLE OF WILLIS & ANEURYSM ATLAS (VASCULAR VECTOR SCHEMATIC)
// =========================================================================
public struct CircleOfWillisDiagramView: View {
    @State private var selectedAneurysm: String? = "ACom"
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 14) {
            ZStack {
                // Dark Ceramic Substrate
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.08, green: 0.10, blue: 0.15))
                    .frame(height: 280)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                
                // Anatomic Vessel Paths
                VStack(spacing: 0) {
                    ZStack {
                        // Basilar Artery (Vertebral inputs -> Basilar trunk)
                        Path { path in
                            // Left Vertebral
                            path.move(to: CGPoint(x: 120, y: 240))
                            path.addQuadCurve(to: CGPoint(x: 150, y: 200), control: CGPoint(x: 135, y: 220))
                            // Right Vertebral
                            path.move(to: CGPoint(x: 180, y: 240))
                            path.addQuadCurve(to: CGPoint(x: 150, y: 200), control: CGPoint(x: 165, y: 220))
                            // Basilar Trunk
                            path.addLine(to: CGPoint(x: 150, y: 130))
                        }
                        .stroke(Color(red: 0.95, green: 0.35, blue: 0.35), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        
                        // Posterior Cerebral Arteries (PCA bilateral bifurcation)
                        Path { path in
                            // Left PCA
                            path.move(to: CGPoint(x: 150, y: 130))
                            path.addQuadCurve(to: CGPoint(x: 80, y: 110), control: CGPoint(x: 110, y: 115))
                            // Right PCA
                            path.move(to: CGPoint(x: 150, y: 130))
                            path.addQuadCurve(to: CGPoint(x: 220, y: 110), control: CGPoint(x: 190, y: 115))
                        }
                        .stroke(Color(red: 0.95, green: 0.35, blue: 0.35), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        
                        // Posterior Communicating Arteries (PCom)
                        Path { path in
                            // Left PCom
                            path.move(to: CGPoint(x: 100, y: 112))
                            path.addLine(to: CGPoint(x: 90, y: 65))
                            // Right PCom
                            path.move(to: CGPoint(x: 200, y: 112))
                            path.addLine(to: CGPoint(x: 210, y: 65))
                        }
                        .stroke(Color.orange.opacity(0.85), style: StrokeStyle(lineWidth: 3.5, dash: [4, 2]))
                        
                        // Internal Carotid (ICA) & Middle Cerebral Arteries (MCA M1 trunks)
                        Path { path in
                            // Left MCA
                            path.move(to: CGPoint(x: 90, y: 65))
                            path.addLine(to: CGPoint(x: 30, y: 60))
                            // Right MCA
                            path.move(to: CGPoint(x: 210, y: 65))
                            path.addLine(to: CGPoint(x: 270, y: 60))
                        }
                        .stroke(Color(red: 0.95, green: 0.35, blue: 0.35), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        
                        // Anterior Cerebral Arteries (A1 segments)
                        Path { path in
                            // Left A1
                            path.move(to: CGPoint(x: 90, y: 65))
                            path.addQuadCurve(to: CGPoint(x: 140, y: 35), control: CGPoint(x: 110, y: 40))
                            // Right A1
                            path.move(to: CGPoint(x: 210, y: 65))
                            path.addQuadCurve(to: CGPoint(x: 160, y: 35), control: CGPoint(x: 190, y: 40))
                            // Anterior Communicating Artery (ACom)
                            path.move(to: CGPoint(x: 140, y: 35))
                            path.addLine(to: CGPoint(x: 160, y: 35))
                            // Distal A2 segments
                            path.move(to: CGPoint(x: 140, y: 35))
                            path.addLine(to: CGPoint(x: 140, y: 12))
                            path.move(to: CGPoint(x: 160, y: 35))
                            path.addLine(to: CGPoint(x: 160, y: 12))
                        }
                        .stroke(Color(red: 0.95, green: 0.35, blue: 0.35), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        
                        // Aneurysm Hotspot Indicators (Interactive Glowing Spheres)
                        // 1. ACom (Most common 30-35%)
                        AneurysmHotspotNode(name: "ACom", frequency: "35%", x: 150, y: 35, selected: $selectedAneurysm)
                        // 2. PCom (25%)
                        AneurysmHotspotNode(name: "PCom", frequency: "25%", x: 210, y: 65, selected: $selectedAneurysm)
                        // 3. MCA Bifurcation (20%)
                        AneurysmHotspotNode(name: "MCA", frequency: "20%", x: 50, y: 60, selected: $selectedAneurysm)
                        // 4. Basilar Apex (5-10%)
                        AneurysmHotspotNode(name: "Basilar Apex", frequency: "7%", x: 150, y: 130, selected: $selectedAneurysm)
                    }
                    .frame(width: 300, height: 260)
                }
            }
            .padding(.horizontal)
            
            // Educational Landmark Card
            if let active = selectedAneurysm {
                HStack(spacing: 12) {
                    Image(systemName: "waveform.path.ecg")
                        .foregroundColor(.red)
                        .font(.system(size: 18, weight: .bold))
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(active) Berry Aneurysm Landmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                        Text(aneurysmDescription(for: active))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 0.3, green: 0.35, blue: 0.45))
                    }
                    Spacer()
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(14)
                .shadow(color: Color.black.opacity(0.04), radius: 4)
                .padding(.horizontal)
            }
        }
    }
    
    func aneurysmDescription(for name: String) -> String {
        switch name {
        case "ACom": return "Most common intracranial aneurysm site (35%). Causes acute abulia, memory disruption, or anterior cerebral ischemic spasm."
        case "PCom": return "Classic presentation: Painful, pupil-involving CN III palsy (compression of parasympathetic pupillomotor fibers on superior medial aspect)."
        case "MCA": return "Frequently ruptures into temporal lobe creating intraparenchymal hematoma + hemiplegia; preferred for surgical micro-clipping over coiling."
        default: return "Basilar bifurcation aneurysm. High morbidity posterior circulation site; requires coil embolization or retrosigmoid/subtemporal corridor."
        }
    }
}

struct AneurysmHotspotNode: View {
    let name: String
    let frequency: String
    let x: CGFloat
    let y: CGFloat
    @Binding var selected: String?
    
    var isSelected: Bool { selected == name }
    
    var body: some View {
        Button(action: {
            HapticManager.impact(style: .medium)
            selected = name
        }) {
            ZStack {
                Circle()
                    .fill(isSelected ? Color.yellow : Color.red)
                    .frame(width: isSelected ? 18 : 14, height: isSelected ? 18 : 14)
                    .shadow(color: isSelected ? Color.yellow.opacity(0.8) : Color.red.opacity(0.5), radius: isSelected ? 8 : 4)
                if isSelected {
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 22, height: 22)
                }
            }
        }
        .position(x: x, y: y)
    }
}

// =========================================================================
// 2. VENTRICULAR SYSTEM & FORAMINA FLOW SCHEMATIC
// =========================================================================
public struct VentricularSystemDiagramView: View {
    @State private var obstructedLevel: String = "Foramen of Monro"
    
    let obstructionSites = ["Foramen of Monro", "Aqueduct of Sylvius", "Foramen of Magendie/Luschka", "Arachnoid Granulations"]
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 14) {
            ZStack {
                // Ceramic Soft Blueprint
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.94, green: 0.96, blue: 0.99))
                    .frame(height: 260)
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.blue.opacity(0.15), lineWidth: 1.5))
                
                VStack(spacing: 8) {
                    // Ventricular Cast Schematic
                    ZStack {
                        // Lateral Ventricles (Frontal horns + Body + Occipital/Temporal horns)
                        Path { path in
                            // C-shaped left ventricle
                            path.move(to: CGPoint(x: 100, y: 40))
                            path.addQuadCurve(to: CGPoint(x: 50, y: 90), control: CGPoint(x: 60, y: 45))
                            path.addQuadCurve(to: CGPoint(x: 95, y: 130), control: CGPoint(x: 45, y: 125))
                            path.addLine(to: CGPoint(x: 125, y: 100))
                            path.closeSubpath()
                            
                            // C-shaped right ventricle
                            path.move(to: CGPoint(x: 200, y: 40))
                            path.addQuadCurve(to: CGPoint(x: 250, y: 90), control: CGPoint(x: 240, y: 45))
                            path.addQuadCurve(to: CGPoint(x: 205, y: 130), control: CGPoint(x: 255, y: 125))
                            path.addLine(to: CGPoint(x: 175, y: 100))
                            path.closeSubpath()
                        }
                        .fill(LinearGradient(colors: [Color.cyan.opacity(0.7), Color.blue.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                        
                        // Foramen of Monro (Bilateral conduits into 3rd Ventricle)
                        Path { path in
                            path.move(to: CGPoint(x: 125, y: 90))
                            path.addLine(to: CGPoint(x: 140, y: 100))
                            path.move(to: CGPoint(x: 175, y: 90))
                            path.addLine(to: CGPoint(x: 160, y: 100))
                        }
                        .stroke(Color.teal, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        
                        // Third Ventricle (Slit-like midline cavity)
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.blue.opacity(0.85))
                            .frame(width: 22, height: 42)
                            .position(x: 150, y: 118)
                        
                        // Cerebral Aqueduct of Sylvius (Narrow conduit through midbrain)
                        Rectangle()
                            .fill(obstructedLevel == "Aqueduct of Sylvius" ? Color.red : Color.cyan)
                            .frame(width: 5, height: 32)
                            .position(x: 150, y: 155)
                        
                        // Fourth Ventricle (Diamond-shaped rhomboid fossa)
                        Path { path in
                            path.move(to: CGPoint(x: 150, y: 172))
                            path.addLine(to: CGPoint(x: 172, y: 192))
                            path.addLine(to: CGPoint(x: 150, y: 212))
                            path.addLine(to: CGPoint(x: 128, y: 192))
                            path.closeSubpath()
                        }
                        .fill(Color.blue.opacity(0.8))
                        
                        // Central Canal of spinal cord
                        Rectangle()
                            .fill(Color.teal)
                            .frame(width: 4, height: 25)
                            .position(x: 150, y: 225)
                    }
                    .frame(width: 300, height: 240)
                }
            }
            .padding(.horizontal)
            
            // CSF Flow Legend Bar
            HStack(spacing: 8) {
                CSFStepChip(step: "1. Choroid Plexus", color: .cyan)
                Image(systemName: "arrow.right").font(.system(size: 10)).foregroundColor(.secondary)
                CSFStepChip(step: "2. Monro", color: .teal)
                Image(systemName: "arrow.right").font(.system(size: 10)).foregroundColor(.secondary)
                CSFStepChip(step: "3. 3rd Vent", color: .blue)
                Image(systemName: "arrow.right").font(.system(size: 10)).foregroundColor(.secondary)
                CSFStepChip(step: "4. Aqueduct", color: .indigo)
                Image(systemName: "arrow.right").font(.system(size: 10)).foregroundColor(.secondary)
                CSFStepChip(step: "5. 4th Vent", color: .purple)
            }
            .padding(.horizontal)
        }
    }
}

struct CSFStepChip: View {
    let step: String
    let color: Color
    
    var body: some View {
        Text(step)
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(color)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(Capsule().fill(color.opacity(0.12)))
    }
}

// =========================================================================
// 3. LUMBAR VERTEBRAL ANATOMY & PEDICLE SCREW TRAJECTORY CALIPER
// =========================================================================
public struct LumbarVertebraTrajectoryView: View {
    @State private var screwAngle: Double = 15.0 // degrees convergence
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 14) {
            ZStack {
                // Dark Ceramic Surface
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.10, green: 0.12, blue: 0.17))
                    .frame(height: 270)
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.08), lineWidth: 1))
                
                VStack(spacing: 6) {
                    ZStack {
                        // Vertebral Body (Anterior Kidney Bean Shape)
                        Path { path in
                            path.move(to: CGPoint(x: 100, y: 70))
                            path.addQuadCurve(to: CGPoint(x: 200, y: 70), control: CGPoint(x: 150, y: 55))
                            path.addQuadCurve(to: CGPoint(x: 185, y: 135), control: CGPoint(x: 210, y: 105))
                            path.addQuadCurve(to: CGPoint(x: 115, y: 135), control: CGPoint(x: 150, y: 120))
                            path.addQuadCurve(to: CGPoint(x: 100, y: 70), control: CGPoint(x: 90, y: 105))
                        }
                        .fill(Color(red: 0.22, green: 0.27, blue: 0.36))
                        .overlay(
                            Path { path in
                                path.move(to: CGPoint(x: 100, y: 70))
                                path.addQuadCurve(to: CGPoint(x: 200, y: 70), control: CGPoint(x: 150, y: 55))
                                path.addQuadCurve(to: CGPoint(x: 185, y: 135), control: CGPoint(x: 210, y: 105))
                                path.addQuadCurve(to: CGPoint(x: 115, y: 135), control: CGPoint(x: 150, y: 120))
                                path.addQuadCurve(to: CGPoint(x: 100, y: 70), control: CGPoint(x: 90, y: 105))
                            }
                            .stroke(Color.cyan.opacity(0.6), lineWidth: 2)
                        )
                        
                        // Spinal Canal (Triangular / Trefoil shape)
                        Path { path in
                            path.move(to: CGPoint(x: 118, y: 135))
                            path.addQuadCurve(to: CGPoint(x: 182, y: 135), control: CGPoint(x: 150, y: 122))
                            path.addLine(to: CGPoint(x: 150, y: 180))
                            path.closeSubpath()
                        }
                        .fill(Color(red: 0.08, green: 0.10, blue: 0.14))
                        
                        // Left & Right Pedicle Cortices
                        Capsule()
                            .fill(Color(red: 0.28, green: 0.34, blue: 0.45))
                            .frame(width: 22, height: 44)
                            .rotationEffect(.degrees(12))
                            .position(x: 98, y: 145)
                        
                        Capsule()
                            .fill(Color(red: 0.28, green: 0.34, blue: 0.45))
                            .frame(width: 22, height: 44)
                            .rotationEffect(.degrees(-12))
                            .position(x: 202, y: 145)
                        
                        // Spinous Process (Posterior midline projection)
                        Path { path in
                            path.move(to: CGPoint(x: 142, y: 180))
                            path.addLine(to: CGPoint(x: 158, y: 180))
                            path.addLine(to: CGPoint(x: 152, y: 235))
                            path.addLine(to: CGPoint(x: 148, y: 235))
                            path.closeSubpath()
                        }
                        .fill(Color(red: 0.22, green: 0.27, blue: 0.36))
                        
                        // Transverse Processes (Bilateral lateral extensions)
                        Path { path in
                            // Left TP
                            path.move(to: CGPoint(x: 88, y: 140))
                            path.addLine(to: CGPoint(x: 35, y: 135))
                            path.addLine(to: CGPoint(x: 35, y: 150))
                            path.addLine(to: CGPoint(x: 88, y: 155))
                            // Right TP
                            path.move(to: CGPoint(x: 212, y: 140))
                            path.addLine(to: CGPoint(x: 265, y: 135))
                            path.addLine(to: CGPoint(x: 265, y: 150))
                            path.addLine(to: CGPoint(x: 212, y: 155))
                        }
                        .fill(Color(red: 0.22, green: 0.27, blue: 0.36))
                        
                        // Pedicle Screw Trajectory Rays (Glowing Orange / Gold with Target Calipers)
                        Path { path in
                            // Left Screw
                            path.move(to: CGPoint(x: 80, y: 195))
                            path.addLine(to: CGPoint(x: 130, y: 80))
                            // Right Screw
                            path.move(to: CGPoint(x: 220, y: 195))
                            path.addLine(to: CGPoint(x: 170, y: 80))
                        }
                        .stroke(Color.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [6, 3]))
                        .shadow(color: .orange, radius: 6)
                        
                        // Roy-Camille Mamillary Entry Dots
                        Circle().fill(Color.yellow).frame(width: 8, height: 8).position(x: 80, y: 195)
                        Circle().fill(Color.yellow).frame(width: 8, height: 8).position(x: 220, y: 195)
                    }
                    .frame(width: 300, height: 245)
                }
            }
            .padding(.horizontal)
            
            // Anatomical Legend Strip
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Circle().fill(Color.yellow).frame(width: 8, height: 8)
                    Text("Mamillary Entry").font(.system(size: 11, weight: .bold)).foregroundColor(.white.opacity(0.85))
                }
                HStack(spacing: 4) {
                    Circle().fill(Color.orange).frame(width: 8, height: 8)
                    Text("15° Medial Convergence").font(.system(size: 11, weight: .bold)).foregroundColor(.orange)
                }
                HStack(spacing: 4) {
                    Circle().fill(Color.cyan).frame(width: 8, height: 8)
                    Text("Anterior Body Base").font(.system(size: 11, weight: .bold)).foregroundColor(.cyan)
                }
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.06)))
            .padding(.horizontal)
        }
    }
}

// =========================================================================
// 4. RHOTON CRANIAL ANATOMY: PTERIONAL CRANIOTOMY & SPHENOID RIDGE DRILL
// =========================================================================
public struct PterionalApproachDiagramView: View {
    @State private var activeLandmark = "maccarty"
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 14) {
            ZStack {
                // Ceramic Dark Surface
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.08, green: 0.10, blue: 0.15))
                    .frame(height: 290)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                
                VStack(spacing: 0) {
                    ZStack {
                        // Lateral Calvarium Contour
                        Path { path in
                            path.move(to: CGPoint(x: 50, y: 150))
                            path.addQuadCurve(to: CGPoint(x: 150, y: 35), control: CGPoint(x: 75, y: 55))
                            path.addQuadCurve(to: CGPoint(x: 250, y: 140), control: CGPoint(x: 230, y: 65))
                            path.addQuadCurve(to: CGPoint(x: 230, y: 220), control: CGPoint(x: 260, y: 190))
                            path.addQuadCurve(to: CGPoint(x: 130, y: 220), control: CGPoint(x: 180, y: 235))
                            path.addQuadCurve(to: CGPoint(x: 50, y: 150), control: CGPoint(x: 65, y: 200))
                        }
                        .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
                        
                        // Pterional Bone Flap (Classic Yaşargil / Rhoton Window)
                        Path { path in
                            path.move(to: CGPoint(x: 85, y: 150)) // MacCarty keyhole
                            path.addQuadCurve(to: CGPoint(x: 140, y: 75), control: CGPoint(x: 95, y: 95)) // Frontal sweep
                            path.addQuadCurve(to: CGPoint(x: 195, y: 120), control: CGPoint(x: 180, y: 80)) // Parietal sweep
                            path.addQuadCurve(to: CGPoint(x: 185, y: 180), control: CGPoint(x: 205, y: 160)) // Squamosal
                            path.addQuadCurve(to: CGPoint(x: 120, y: 180), control: CGPoint(x: 150, y: 190)) // Sphenoid wing base
                            path.addLine(to: CGPoint(x: 85, y: 150))
                        }
                        .fill(
                            LinearGradient(
                                colors: [Color.purple.opacity(0.25), Color.indigo.opacity(0.12)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            Path { path in
                                path.move(to: CGPoint(x: 85, y: 150))
                                path.addQuadCurve(to: CGPoint(x: 140, y: 75), control: CGPoint(x: 95, y: 95))
                                path.addQuadCurve(to: CGPoint(x: 195, y: 120), control: CGPoint(x: 180, y: 80))
                                path.addQuadCurve(to: CGPoint(x: 185, y: 180), control: CGPoint(x: 205, y: 160))
                                path.addQuadCurve(to: CGPoint(x: 120, y: 180), control: CGPoint(x: 150, y: 190))
                                path.addLine(to: CGPoint(x: 85, y: 150))
                            }
                            .stroke(Color.cyan, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        )
                        
                        // Sphenoid Ridge Drilling Zone (Flattening Greater Wing of Sphenoid)
                        Path { path in
                            path.move(to: CGPoint(x: 85, y: 150))
                            path.addQuadCurve(to: CGPoint(x: 145, y: 165), control: CGPoint(x: 110, y: 162))
                        }
                        .stroke(Color.orange, style: StrokeStyle(lineWidth: 7, lineCap: .round))
                        .shadow(color: .orange.opacity(0.8), radius: 6)
                        
                        // Sylvian Fissure Corridor (Trans-Sylvian Access Ray)
                        Path { path in
                            path.move(to: CGPoint(x: 140, y: 165))
                            path.addQuadCurve(to: CGPoint(x: 185, y: 140), control: CGPoint(x: 165, y: 155))
                        }
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [5, 3]))
                        
                        // Keyhole Landmark: MacCarty Keyhole (Orbit + Frontal Cranium)
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 14, height: 14)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(color: .yellow, radius: 8)
                            .position(x: 85, y: 150)
                        
                        // Internal Carotid & Optic Nerve Target (Supraclinoid Target)
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .shadow(color: .red, radius: 6)
                            .position(x: 140, y: 168)
                    }
                    .frame(width: 300, height: 235)
                }
            }
            .padding(.horizontal)
            
            // Interactive Landmark Selector
            HStack(spacing: 8) {
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activeLandmark = "maccarty"
                }) {
                    Text("MacCarty Keyhole")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activeLandmark == "maccarty" ? Color.yellow.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activeLandmark == "maccarty" ? .yellow : .white.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activeLandmark = "sphenoid"
                }) {
                    Text("Sphenoid Ridge Drill")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activeLandmark == "sphenoid" ? Color.orange.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activeLandmark == "sphenoid" ? .orange : .white.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activeLandmark = "sylvian"
                }) {
                    Text("Sylvian Corridor")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activeLandmark == "sylvian" ? Color.pink.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activeLandmark == "sylvian" ? .pink : .white.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // Detail Callout Banner
            Group {
                if activeLandmark == "maccarty" {
                    AtlasInfoStrip(
                        color: .yellow,
                        title: "MacCarty Keyhole Placement",
                        pearl: "Placed 5 mm superior to frontozygomatic suture. Superior half enters anterior cranial fossa (dura), inferior half enters orbit (periorbita). Eliminates orbital roof ridge without blind plunge."
                    )
                } else if activeLandmark == "sphenoid" {
                    AtlasInfoStrip(
                        color: .orange,
                        title: "Sphenoid Ridge Drilling (Rhoton Principle)",
                        pearl: "Extensively drill the lesser wing of the sphenoid medially to the meningo-orbital band (superior orbital fissure). Flattening this bony prominence allows low-trajectory access to basal cisterns with ZERO frontal lobe retraction."
                    )
                } else {
                    AtlasInfoStrip(
                        color: .pink,
                        title: "Trans-Sylvian Corridor (Yaşargil)",
                        pearl: "Sharp arachnoid dissection from distal to proximal (or superficial to deep). Exposes M1 trunk, ICA bifurcation, A1, optic chiasm, and basilar apex without brain sacrifice."
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

// =========================================================================
// 5. AXIAL BRAIN MRI: BASAL GANGLIA & INTERNAL CAPSULE SCHEMATIC
// =========================================================================
public struct AxialBrainMRIDiagramView: View {
    @State private var activeStructure = "capsule"
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 14) {
            ZStack {
                // High-Contrast Ceramic Dark Field
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.08, green: 0.10, blue: 0.15))
                    .frame(height: 290)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                
                VStack(spacing: 0) {
                    ZStack {
                        // Brain Calvarium Outer Oval
                        Path { path in
                            path.addEllipse(in: CGRect(x: 45, y: 25, width: 210, height: 210))
                        }
                        .stroke(Color.white.opacity(0.2), lineWidth: 2)
                        
                        // Lateral Ventricles (Frontal Horns & Septum Pellucidum)
                        Path { path in
                            // Left Frontal Horn
                            path.move(to: CGPoint(x: 145, y: 70))
                            path.addQuadCurve(to: CGPoint(x: 130, y: 105), control: CGPoint(x: 135, y: 85))
                            path.addQuadCurve(to: CGPoint(x: 145, y: 110), control: CGPoint(x: 138, y: 110))
                            path.addLine(to: CGPoint(x: 145, y: 70))
                            // Right Frontal Horn
                            path.move(to: CGPoint(x: 155, y: 70))
                            path.addQuadCurve(to: CGPoint(x: 170, y: 105), control: CGPoint(x: 165, y: 85))
                            path.addQuadCurve(to: CGPoint(x: 155, y: 110), control: CGPoint(x: 162, y: 110))
                            path.addLine(to: CGPoint(x: 155, y: 70))
                        }
                        .fill(Color.cyan.opacity(0.35))
                        
                        // 3rd Ventricle
                        Path { path in
                            path.addRect(CGRect(x: 147, y: 115, width: 6, height: 40))
                        }
                        .fill(Color.cyan.opacity(0.35))
                        
                        // Caudate Nuclei (Head of Caudate - Medial to Anterior Limb)
                        Path { path in
                            // Left Caudate
                            path.addEllipse(in: CGRect(x: 118, y: 80, width: 14, height: 22))
                            // Right Caudate
                            path.addEllipse(in: CGRect(x: 168, y: 80, width: 14, height: 22))
                        }
                        .fill(Color.indigo.opacity(0.8))
                        
                        // Lentiform Nucleus (Putamen & Globus Pallidus - Wedge lateral to capsule)
                        Path { path in
                            // Left Lentiform
                            path.move(to: CGPoint(x: 95, y: 95))
                            path.addLine(to: CGPoint(x: 115, y: 115))
                            path.addLine(to: CGPoint(x: 100, y: 135))
                            path.addLine(to: CGPoint(x: 82, y: 115))
                            path.closeSubpath()
                            // Right Lentiform
                            path.move(to: CGPoint(x: 205, y: 95))
                            path.addLine(to: CGPoint(x: 185, y: 115))
                            path.addLine(to: CGPoint(x: 200, y: 135))
                            path.addLine(to: CGPoint(x: 218, y: 115))
                            path.closeSubpath()
                        }
                        .fill(Color.purple.opacity(0.75))
                        
                        // Thalami (Medial to Posterior Limb)
                        Path { path in
                            // Left Thalamus
                            path.addEllipse(in: CGRect(x: 122, y: 120, width: 22, height: 32))
                            // Right Thalamus
                            path.addEllipse(in: CGRect(x: 156, y: 120, width: 22, height: 32))
                        }
                        .fill(Color.orange.opacity(0.75))
                        
                        // Internal Capsule "Boomerang" (Anterior Limb, Genu, Posterior Limb)
                        Path { path in
                            // Left Internal Capsule
                            path.move(to: CGPoint(x: 112, y: 82)) // Anterior limb
                            path.addLine(to: CGPoint(x: 120, y: 115)) // Genu
                            path.addLine(to: CGPoint(x: 105, y: 155)) // Posterior limb
                            // Right Internal Capsule
                            path.move(to: CGPoint(x: 188, y: 82)) // Anterior limb
                            path.addLine(to: CGPoint(x: 180, y: 115)) // Genu
                            path.addLine(to: CGPoint(x: 195, y: 155)) // Posterior limb
                        }
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .shadow(color: .yellow.opacity(0.8), radius: 6)
                        
                        // Insular Ribbon / Cortex (Lateral Sylvian boundary)
                        Path { path in
                            // Left Insula
                            path.move(to: CGPoint(x: 72, y: 90))
                            path.addQuadCurve(to: CGPoint(x: 72, y: 145), control: CGPoint(x: 65, y: 115))
                            // Right Insula
                            path.move(to: CGPoint(x: 228, y: 90))
                            path.addQuadCurve(to: CGPoint(x: 228, y: 145), control: CGPoint(x: 235, y: 115))
                        }
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    }
                    .frame(width: 300, height: 235)
                }
            }
            .padding(.horizontal)
            
            // Structure Selection Buttons
            HStack(spacing: 8) {
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activeStructure = "capsule"
                }) {
                    Text("Internal Capsule")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activeStructure == "capsule" ? Color.yellow.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activeStructure == "capsule" ? .yellow : .white.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activeStructure = "lentiform"
                }) {
                    Text("Lentiform / Basal Ganglia")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activeStructure == "lentiform" ? Color.purple.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activeStructure == "lentiform" ? .purple : .white.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activeStructure = "insula"
                }) {
                    Text("Insular Ribbon")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activeStructure == "insula" ? Color.green.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activeStructure == "insula" ? .green : .white.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // Detail Callout Banner
            Group {
                if activeStructure == "capsule" {
                    AtlasInfoStrip(
                        color: .yellow,
                        title: "Internal Capsule (Boomerang Architecture)",
                        pearl: "Anterior Limb: Between caudate and lentiform (frontopontine/thalamic radiation). Genu: Corticobulbar fibers (face/speech). Posterior Limb: Between thalamus and lentiform (corticospinal tract / motor fibers for arm & leg). Highly vulnerable to hypertensive lacunar infarcts."
                    )
                } else if activeStructure == "lentiform" {
                    AtlasInfoStrip(
                        color: .purple,
                        title: "Lentiform Nucleus & Thalamus",
                        pearl: "Lentiform = Putamen (lateral) + Globus Pallidus (medial). Supplied by Lenticulostriate branches of M1 MCA. Common site of hypertensive intraparenchymal hemorrhage (Charcot-Bouchard microaneurysms)."
                    )
                } else {
                    AtlasInfoStrip(
                        color: .green,
                        title: "Insular Ribbon & Extreme Capsule",
                        pearl: "Loss of the insular ribbon is one of the earliest signs of hyperacute ischemic stroke on non-contrast CT, appearing within 6 hours due to early cytotoxic edema in the insular cortex (end-artery MCA supply)."
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

// =========================================================================
// 6. AXIAL CERVICAL SPINE MRI: RADICULOPATHY & UNCOVERTEBRAL JOINT
// =========================================================================
public struct AxialCervicalMRIDiagramView: View {
    @State private var activePathology = "uncinate"
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 14) {
            ZStack {
                // High-Contrast Ceramic Dark Field
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.08, green: 0.10, blue: 0.15))
                    .frame(height: 290)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                
                VStack(spacing: 0) {
                    ZStack {
                        // Cervical Vertebral Body (Anterior Kidney/Oval shape)
                        Path { path in
                            path.move(to: CGPoint(x: 90, y: 70))
                            path.addQuadCurve(to: CGPoint(x: 210, y: 70), control: CGPoint(x: 150, y: 55))
                            path.addQuadCurve(to: CGPoint(x: 200, y: 120), control: CGPoint(x: 215, y: 95))
                            path.addQuadCurve(to: CGPoint(x: 100, y: 120), control: CGPoint(x: 150, y: 110))
                            path.addQuadCurve(to: CGPoint(x: 90, y: 70), control: CGPoint(x: 85, y: 95))
                        }
                        .fill(Color.white.opacity(0.12))
                        .overlay(
                            Path { path in
                                path.move(to: CGPoint(x: 90, y: 70))
                                path.addQuadCurve(to: CGPoint(x: 210, y: 70), control: CGPoint(x: 150, y: 55))
                                path.addQuadCurve(to: CGPoint(x: 200, y: 120), control: CGPoint(x: 215, y: 95))
                                path.addQuadCurve(to: CGPoint(x: 100, y: 120), control: CGPoint(x: 150, y: 110))
                                path.addQuadCurve(to: CGPoint(x: 90, y: 70), control: CGPoint(x: 85, y: 95))
                            }
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        )
                        
                        // Spinal Canal & Thecal Sac
                        Path { path in
                            path.addEllipse(in: CGRect(x: 115, y: 125, width: 70, height: 50))
                        }
                        .fill(Color.blue.opacity(0.3))
                        .overlay(
                            Path { path in
                                path.addEllipse(in: CGRect(x: 115, y: 125, width: 70, height: 50))
                            }
                            .stroke(Color.cyan, lineWidth: 2)
                        )
                        
                        // Cervical Spinal Cord (Center of Sac)
                        Path { path in
                            path.addEllipse(in: CGRect(x: 130, y: 135, width: 40, height: 30))
                        }
                        .fill(Color.indigo)
                        .overlay(
                            Path { path in
                                path.addEllipse(in: CGRect(x: 130, y: 135, width: 40, height: 30))
                            }
                            .stroke(Color.white.opacity(0.5), lineWidth: 1.5)
                        )
                        
                        // Uncinate Processes (Posterolateral Body Projections)
                        Path { path in
                            // Left Uncinate
                            path.move(to: CGPoint(x: 95, y: 105))
                            path.addLine(to: CGPoint(x: 92, y: 125))
                            path.addLine(to: CGPoint(x: 105, y: 120))
                            path.closeSubpath()
                            // Right Uncinate (Hypertrophic spurring)
                            path.move(to: CGPoint(x: 205, y: 105))
                            path.addLine(to: CGPoint(x: 210, y: 128))
                            path.addLine(to: CGPoint(x: 195, y: 122))
                            path.closeSubpath()
                        }
                        .fill(Color.orange)
                        
                        // Foramen Transversarium (Vertebral Artery conduits)
                        Circle().fill(Color.red.opacity(0.7)).frame(width: 14, height: 14).position(x: 75, y: 115)
                        Circle().fill(Color.red.opacity(0.7)).frame(width: 14, height: 14).position(x: 225, y: 115)
                        
                        // Exiting Nerve Roots (Neural Foramina Corridors)
                        Path { path in
                            // Left Exiting Root (Patent)
                            path.move(to: CGPoint(x: 120, y: 145))
                            path.addLine(to: CGPoint(x: 80, y: 135))
                            // Right Exiting Root (Pinched by Uncinate Spur)
                            path.move(to: CGPoint(x: 180, y: 145))
                            path.addLine(to: CGPoint(x: 215, y: 135))
                        }
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        
                        // Lamina & Spinous Process
                        Path { path in
                            path.move(to: CGPoint(x: 105, y: 165))
                            path.addLine(to: CGPoint(x: 150, y: 220))
                            path.addLine(to: CGPoint(x: 195, y: 165))
                        }
                        .stroke(Color.white.opacity(0.3), lineWidth: 2.5)
                        
                        // Red Alert Pinch Marker on Right Foramen
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .shadow(color: .red, radius: 8)
                            .position(x: 202, y: 130)
                    }
                    .frame(width: 300, height: 235)
                }
            }
            .padding(.horizontal)
            
            // Pathology Toggle Buttons
            HStack(spacing: 8) {
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activePathology = "uncinate"
                }) {
                    Text("Uncovertebral Joint")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activePathology == "uncinate" ? Color.orange.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activePathology == "uncinate" ? .orange : .white.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activePathology = "foramen"
                }) {
                    Text("Foraminal Stenosis")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activePathology == "foramen" ? Color.red.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activePathology == "foramen" ? .red : .white.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    HapticManager.impact(style: .medium)
                    activePathology = "artery"
                }) {
                    Text("Vertebral Artery")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(activePathology == "artery" ? Color.cyan.opacity(0.25) : Color.white.opacity(0.06))
                        .foregroundColor(activePathology == "artery" ? .cyan : .white.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // Detail Callout Banner
            Group {
                if activePathology == "uncinate" {
                    AtlasInfoStrip(
                        color: .orange,
                        title: "Uncovertebral Joint (Luschka's Joint)",
                        pearl: "Formed between the uncinate process of the inferior vertebra and the beveled lip of the superior vertebra. Hypertrophic uncinate spurs are the primary anterior cause of cervical radiculopathy."
                    )
                } else if activePathology == "foramen" {
                    AtlasInfoStrip(
                        color: .red,
                        title: "Cervical Neuroforaminal Architecture",
                        pearl: "Anterior wall: Uncinate process & disc margin. Posterior wall: Superior articular process (facet joint). The cervical root exits ABOVE its pedicle (e.g., C6 root exits between C5–C6)."
                    )
                } else {
                    AtlasInfoStrip(
                        color: .cyan,
                        title: "Foramen Transversarium & Vertebral Artery",
                        pearl: "Located immediately lateral to the uncinate process. When performing anterior cervical discectomy & fusion (ACDF), never drill lateral to the uncinate process to prevent catastrophic vertebral artery laceration."
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

