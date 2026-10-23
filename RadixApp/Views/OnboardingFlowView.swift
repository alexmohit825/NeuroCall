import SwiftUI

// MARK: - Welcome & Manifesto Screen (No Questions)
public struct OnboardingFlowView: View {
    @Binding var isOnboardingComplete: Bool
    @State private var activeTab = 0
    
    public init(isOnboardingComplete: Binding<Bool>) {
        self._isOnboardingComplete = isOnboardingComplete
    }
    
    public var body: some View {
        ZStack {
            // Ceramic Dark Aesthetic Canvas
            Color(red: 0.07, green: 0.09, blue: 0.13)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header Pill
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "cross.fill")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(.cyan)
                        Text("TREPHINE • RESIDENT CALL COMPANION")
                            .font(.system(size: 11, weight: .black, design: .rounded))
                            .tracking(1.2)
                            .foregroundColor(.white.opacity(0.85))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Capsule().fill(Color.white.opacity(0.06)))
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                // Manifesto Cards Scroll Area
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        
                        // Hero Graphic & Title
                        VStack(alignment: .leading, spacing: 10) {
                            Text("What This App\nIs Meant To Be.")
                                .font(.system(size: 32, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                                .lineSpacing(2)
                            
                            Text("Your pocket preceptor for after-hours calls, high-stakes decisions, and morning rounds excellence.")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(Color(red: 0.65, green: 0.72, blue: 0.82))
                                .lineSpacing(4)
                        }
                        .padding(.top, 12)
                        
                        // Pillar 1: After-Hours Calls
                        ManifestoPillarCard(
                            badge: "AFTER-HOURS SURVIVAL",
                            badgeColor: .red,
                            icon: "phone.bubble.left.fill",
                            title: "Deal With 2 AM Crises Decisively",
                            description: "When the ED calls with a 12 mm acute subdural, pupillary asymmetry, or suspected cauda equina, there is zero time to hesitate. NeuroCall gives you the exact surgical threshold criteria and hyperosmolar dosing in seconds.",
                            keyTakeaway: "Know the numbers cold: Midline shift ≥ 5 mm, clot thickness ≥ 10 mm, GCS drop ≥ 2 points."
                        )
                        
                        // Pillar 2: What is Expected of Residents
                        ManifestoPillarCard(
                            badge: "RESIDENT EXPECTATIONS",
                            badgeColor: .orange,
                            icon: "person.badge.shield.checkmark.fill",
                            title: "What Attendings Actually Expect",
                            description: "Senior attendings do not want a rambling narrative at 3:15 AM. They expect an airtight SBAR briefing: Age, Mechanism, GCS, Pupillary exam, Scan dimensions, Reversal status, and your recommended action.",
                            keyTakeaway: "Never call without a plan. NeuroCall crafts your Attending Briefing script automatically."
                        )
                        
                        // Pillar 3: Shine on Morning Rounds
                        ManifestoPillarCard(
                            badge: "MORNING ROUNDS EXCELLENCE",
                            badgeColor: .indigo,
                            icon: "sun.max.fill",
                            title: "Shine on Morning Rounds",
                            description: "Present patients with crisp anatomical and neuroimaging precision. Dissect spinal MRI caliber, interpret normal cranial anatomy, master ventricular anatomy, and articulate procedural nuances before you are asked.",
                            keyTakeaway: "Be prepared for pimping: EVD trajectory Kocher's points, pedicle screw anatomical landmarks, and shunt troubleshooting."
                        )
                        
                        // Pillar 4: The 5-Color Triage Pill System
                        ManifestoPillarCard(
                            badge: "TRIAGE TAXONOMY",
                            badgeColor: .cyan,
                            icon: "circle.grid.2x2.fill",
                            title: "5-Tier Colored Pill Acuity System",
                            description: "Every consult and census card features an instant triage pill: 🔴 Red for Immediate life/brain threats (midline shift ≥ 5mm, herniation), 🟠 Orange for Urgent ICU cases (aSAH, EVD), 🟡 Yellow for overnight Contingency triggers, 🔵 Blue for Routine floor post-ops, and 🟢 Green for Stable patients.",
                            keyTakeaway: "Zero ambiguity on acuity: Colored pills define bedside evaluation windows and attending escalation."
                        )
                        
                        // Pillar 5: Clinical Reference & Intended Use Disclaimer
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Image(systemName: "scale.3d")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.cyan)
                                Text("CLINICAL REFERENCE & INTENDED USE DISCLAIMER")
                                    .font(.system(size: 10, weight: .black))
                                    .foregroundColor(.cyan)
                            }
                            Text("NeuroCall is an educational on-call decision-support reference designed for rapid bedside information gathering. It does NOT replace independent clinical acumen, physical and neurological examination, direct imaging review, or attending physician judgment.")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                                .lineSpacing(3)
                            
                            Text("All calculations, hematoma volume approximations, spinopelvic parameters, and trauma scores are decision-support estimates synthesized from published literature. They must be independently verified against institutional protocols before clinical or surgical execution.")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(Color(red: 0.6, green: 0.66, blue: 0.76))
                                .lineSpacing(3)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.04))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.cyan.opacity(0.3), lineWidth: 1))
                        )
                        
                        Spacer().frame(height: 10)
                    }
                    .padding(.horizontal, 24)
                }
                
                // Bottom Launch Button
                VStack {
                    Button(action: {
                        HapticManager.notification(type: .success)
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isOnboardingComplete = true
                        }
                    }) {
                        HStack(spacing: 8) {
                            Text("I Acknowledge & Enter NeuroCall Atlas")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .bold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Color(red: 0.15, green: 0.5, blue: 0.95), Color(red: 0.35, green: 0.25, blue: 0.9)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .shadow(color: Color.blue.opacity(0.35), radius: 12, y: 4)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(Color(red: 0.07, green: 0.09, blue: 0.13))
            }
        }
    }
}

// MARK: - Supporting Pillar Card
struct ManifestoPillarCard: View {
    let badge: String
    let badgeColor: Color
    let icon: String
    let title: String
    let description: String
    let keyTakeaway: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 6) {
                    Circle()
                        .fill(badgeColor)
                        .frame(width: 6, height: 6)
                    Text(badge)
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(badgeColor)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(badgeColor.opacity(0.12)))
                
                Spacer()
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(badgeColor)
            }
            
            Text(title)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text(description)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(red: 0.72, green: 0.78, blue: 0.88))
                .lineSpacing(3)
            
            // Takeaway Banner
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.cyan)
                    .padding(.top, 2)
                Text(keyTakeaway)
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundColor(.cyan)
                    .lineSpacing(2)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.cyan.opacity(0.08)))
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.11, green: 0.14, blue: 0.20))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.07), lineWidth: 1)
        )
    }
}

// MARK: - Haptic Feedback Utility
public struct HapticManager {
    public static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    public static func notification(type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
