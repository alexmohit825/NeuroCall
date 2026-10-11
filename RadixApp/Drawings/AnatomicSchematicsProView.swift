import SwiftUI

// MARK: - Design-Award Vector Anatomical Schematics Suite
// Rendered in pure SwiftUI with precision Bezier curves, ceramic slate lighting, and Apple Design Award polish.

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
