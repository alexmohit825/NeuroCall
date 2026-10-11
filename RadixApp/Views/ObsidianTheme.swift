import SwiftUI

// MARK: - Obsidian Vitreous Theme System
// High-depth dark aerospace & neurosurgical cockpit aesthetics

public enum ObsidianTheme {
    // Spatial Canvas Backgrounds
    public static let canvasDark = Color(red: 0.04, green: 0.05, blue: 0.08)
    public static let canvasGradientTop = Color(red: 0.06, green: 0.08, blue: 0.12)
    public static let canvasGradientBottom = Color(red: 0.03, green: 0.04, blue: 0.06)
    
    // Vitreous Glass Surface Colors
    public static let glassSurface = Color(red: 0.09, green: 0.11, blue: 0.16).opacity(0.85)
    public static let glassSurfaceRaised = Color(red: 0.12, green: 0.15, blue: 0.22).opacity(0.9)
    public static let glassBorder = Color.white.opacity(0.10)
    public static let glassHighlight = Color.white.opacity(0.18)
    
    // Luminescent Status Colors
    public static let neonRed = Color(red: 1.00, green: 0.23, blue: 0.19)
    public static let neonRose = Color(red: 0.95, green: 0.25, blue: 0.35)
    public static let neonAmber = Color(red: 1.00, green: 0.62, blue: 0.04)
    public static let neonGreen = Color(red: 0.20, green: 0.84, blue: 0.29)
    public static let neonCyan = Color(red: 0.00, green: 0.88, blue: 1.00)
    public static let neonPurple = Color(red: 0.70, green: 0.35, blue: 0.95)
    public static let neonBlue = Color(red: 0.18, green: 0.52, blue: 1.00)
    
    // Semantic Theme Aliases
    public static let vitreousGlass = glassSurface
    public static let borderSubtle = glassBorder
    public static let surfaceVoid = canvasDark
    public static let surfaceElevated = glassSurfaceRaised
    public static let textMuted = textTertiary
    
    // High-Contrast Cockpit Typography Colors
    public static let textPrimary = Color.white
    public static let textSecondary = Color.white.opacity(0.70)
    public static let textTertiary = Color.white.opacity(0.42)
}

public extension Color {
    init(hex: String) {
        let hexCleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexCleaned).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexCleaned.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Vitreous Glass Card Modifier
public struct VitreousGlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    var strokeColor: Color = ObsidianTheme.glassBorder
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(ObsidianTheme.glassSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [ObsidianTheme.glassHighlight, strokeColor, strokeColor.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: Color.black.opacity(0.45), radius: 14, x: 0, y: 8)
    }
}

public extension View {
    func vitreousGlassCard(cornerRadius: CGFloat = 20, strokeColor: Color = ObsidianTheme.glassBorder) -> some View {
        self.modifier(VitreousGlassCardModifier(cornerRadius: cornerRadius, strokeColor: strokeColor))
    }
    
    func obsidianCockpitBackground() -> some View {
        self.background(
            LinearGradient(
                colors: [ObsidianTheme.canvasGradientTop, ObsidianTheme.canvasDark, ObsidianTheme.canvasGradientBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}
