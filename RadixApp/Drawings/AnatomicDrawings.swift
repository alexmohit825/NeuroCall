import SwiftUI

// MARK: - Anatomic Brain CT Window & Herniation Diagram
public struct BrainCTDiagramView: View {
    @Binding var activeHerniation: String
    
    public init(activeHerniation: Binding<String>) {
        self._activeHerniation = activeHerniation
    }
    
    public var body: some View {
        ZStack {
            // Calvarium (Skull Vault) in soft clinical slate
            RoundedRectangle(cornerRadius: 110)
                .stroke(Color(red: 0.85, green: 0.88, blue: 0.92), lineWidth: 14)
                .background(RoundedRectangle(cornerRadius: 110).fill(Color(red: 0.96, green: 0.97, blue: 0.99)))
                .frame(width: 280, height: 320)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
            
            // Brain Parenchyma base
            RoundedRectangle(cornerRadius: 95)
                .fill(Color(red: 0.91, green: 0.94, blue: 0.97))
                .frame(width: 250, height: 290)
            
            // Midline Falx Cerebri
            Path { path in
                path.move(to: CGPoint(x: 140, y: 25))
                path.addLine(to: CGPoint(x: 140, y: 295))
            }
            .stroke(Color.indigo.opacity(0.4), style: StrokeStyle(lineWidth: 3, dash: [6, 4]))
            .frame(width: 280, height: 320)
            
            // Lateral Ventricles (Frontal Horns)
            HStack(spacing: 18) {
                // Left Frontal Horn
                Capsule()
                    .fill(Color(red: 0.22, green: 0.44, blue: 0.88).opacity(0.85))
                    .frame(width: 14, height: 48)
                    .rotationEffect(.degrees(12))
                
                // Right Frontal Horn
                Capsule()
                    .fill(Color(red: 0.22, green: 0.44, blue: 0.88).opacity(0.85))
                    .frame(width: 14, height: 48)
                    .rotationEffect(.degrees(-12))
            }
            .offset(y: -20)
            
            // Third Ventricle
            Capsule()
                .fill(Color(red: 0.22, green: 0.44, blue: 0.88).opacity(0.8))
                .frame(width: 6, height: 26)
                .offset(y: 18)
            
            // Quadrigeminal / Ambient Basal Cisterns
            Circle()
                .stroke(Color.teal.opacity(0.6), lineWidth: 4)
                .frame(width: 44, height: 44)
                .offset(y: 50)
            
            // Interactive Lesion Overlay (EDH vs SDH vs Midline Shift)
            if activeHerniation == "EDH" {
                // Epidural Hematoma: Biconvex / Lenticular (does not cross sutures)
                BiconvexLensShape()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.95, green: 0.35, blue: 0.35), Color(red: 0.88, green: 0.18, blue: 0.18)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 32, height: 110)
                    .offset(x: 108, y: -20)
                    .shadow(color: Color.red.opacity(0.3), radius: 6)
            } else if activeHerniation == "SDH" {
                // Subdural Hematoma: Crescentic / Concave (crosses sutures)
                CrescentShape()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.98, green: 0.55, blue: 0.25), Color(red: 0.92, green: 0.38, blue: 0.12)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 24, height: 160)
                    .offset(x: 112, y: -10)
            } else if activeHerniation == "Uncal" {
                // Uncal Herniation: Medial temporal lobe impinging brainstem
                Circle()
                    .fill(Color.purple.opacity(0.85))
                    .frame(width: 36, height: 36)
                    .offset(x: 32, y: 46)
                    .overlay(
                        Text("Uncus")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.white)
                            .offset(x: 32, y: 46)
                    )
            }
        }
        .frame(width: 300, height: 340)
    }
}

// Biconvex lens shape for Epidural Hematoma
struct BiconvexLensShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.maxX + 12, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.minX - 12, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

// Crescent shape for Subdural Hematoma
struct CrescentShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: rect.minX - 16, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY), control: CGPoint(x: rect.minX + 8, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Anatomic Spinal Cord Cross Section & Root Branching Diagram
public struct SpinalCordCrossSectionView: View {
    @Binding var selectedSegment: String
    
    public init(selectedSegment: Binding<String>) {
        self._selectedSegment = selectedSegment
    }
    
    public var body: some View {
        ZStack {
            // Vertebral Body Ring in light porcelain ceramic tone
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(red: 0.95, green: 0.97, blue: 0.99))
                .stroke(Color(red: 0.82, green: 0.87, blue: 0.93), lineWidth: 4)
                .frame(width: 310, height: 260)
            
            // Spinal Canal boundary
            Circle()
                .fill(Color(red: 0.88, green: 0.92, blue: 0.96))
                .frame(width: 170, height: 170)
            
            // Spinal Cord (White Matter)
            Ellipse()
                .fill(Color.white)
                .stroke(Color.indigo.opacity(0.3), lineWidth: 2)
                .frame(width: 120, height: 96)
                .shadow(color: Color.indigo.opacity(0.06), radius: 6)
            
            // Gray Matter Butterfly (Dorsal & Ventral Horns)
            ButterflyShape()
                .fill(LinearGradient(colors: [Color.indigo.opacity(0.65), Color.purple.opacity(0.65)], startPoint: .top, endPoint: .bottom))
                .frame(width: 70, height: 55)
            
            // Dorsal Roots (Sensory - Cyan)
            Path { path in
                // Left Dorsal
                path.move(to: CGPoint(x: 120, y: 105))
                path.addQuadCurve(to: CGPoint(x: 45, y: 70), control: CGPoint(x: 80, y: 80))
                // Right Dorsal
                path.move(to: CGPoint(x: 190, y: 105))
                path.addQuadCurve(to: CGPoint(x: 265, y: 70), control: CGPoint(x: 230, y: 80))
            }
            .stroke(Color.cyan, style: StrokeStyle(lineWidth: 6, lineCap: .round))
            .frame(width: 310, height: 260)
            
            // Dorsal Root Ganglion (DRG) swellings
            Circle()
                .fill(Color.cyan)
                .frame(width: 16, height: 16)
                .offset(x: -88, y: -60)
            Circle()
                .fill(Color.cyan)
                .frame(width: 16, height: 16)
                .offset(x: 88, y: -60)
            
            // Ventral Roots (Motor - Violet / Magenta)
            Path { path in
                // Left Ventral
                path.move(to: CGPoint(x: 125, y: 145))
                path.addQuadCurve(to: CGPoint(x: 45, y: 180), control: CGPoint(x: 80, y: 170))
                // Right Ventral
                path.move(to: CGPoint(x: 185, y: 145))
                path.addQuadCurve(to: CGPoint(x: 265, y: 180), control: CGPoint(x: 230, y: 170))
            }
            .stroke(Color.purple, style: StrokeStyle(lineWidth: 6, lineCap: .round))
            .frame(width: 310, height: 260)
            
            // Spinal Nerve Trunk Fusion (Mixed Root)
            Circle()
                .fill(Color.indigo)
                .frame(width: 14, height: 14)
                .offset(x: -110, y: 5)
            Circle()
                .fill(Color.indigo)
                .frame(width: 14, height: 14)
                .offset(x: 110, y: 5)
        }
        .frame(width: 320, height: 280)
    }
}

// Stylized Gray Matter Butterfly
struct ButterflyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.45))
        // Left dorsal horn
        path.addLine(to: CGPoint(x: w * 0.2, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.1, y: h * 0.35))
        // Left lateral horn & ventral horn
        path.addLine(to: CGPoint(x: w * 0.15, y: h * 0.9))
        path.addLine(to: CGPoint(x: w * 0.35, y: h * 0.8))
        path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.55))
        // Right ventral horn
        path.addLine(to: CGPoint(x: w * 0.65, y: h * 0.8))
        path.addLine(to: CGPoint(x: w * 0.85, y: h * 0.9))
        // Right dorsal horn
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.8, y: h * 0.1))
        path.closeSubpath()
        
        return path
    }
}
