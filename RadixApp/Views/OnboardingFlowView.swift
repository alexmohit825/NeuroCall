import SwiftUI

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

// MARK: - Wellspoken-Style 4-Step Interactive Onboarding Flow
public struct OnboardingFlowView: View {
    @Binding var isOnboardingComplete: Bool
    @State private var currentStep = 0
    @State private var selectedPainPoints: Set<String> = []
    @State private var callFrequency = "Often (Every 3-4 days)"
    @State private var confidenceLevel = "Developing"
    
    let painPointOptions = [
        ("pain_attending", "I get anxious briefing attendings over the phone at 3 AM", "phone.bubble.left.fill", Color.red),
        ("pain_threshold", "I second-guess surgical bleed thresholds (EDH vs. SDH vs. shift)", "cross.fill", Color.orange),
        ("pain_emergencies", "I worry about missing subtle cauda equina or epidural abscess signs", "exclamationmark.triangle.fill", Color.purple),
        ("pain_procedural", "I want airtight trajectory precision for EVDs and lumbar drains", "syringe.fill", Color.teal)
    ]
    
    let callFrequencyOptions = [
        "Heavy Call (Every 2-3 nights)",
        "Standard (Every 4-5 nights)",
        "Starting Neuro / Spine Rotation Soon",
        "Attending / Fellow Mentoring Residents"
    ]
    
    public init(isOnboardingComplete: Binding<Bool>) {
        self._isOnboardingComplete = isOnboardingComplete
    }
    
    public var body: some View {
        ZStack {
            // Elegant Slate Ceramic Background (Inspired by Wellspoken)
            Color(red: 0.08, green: 0.10, blue: 0.14)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Progress Bar
                HStack(spacing: 8) {
                    // Back button
                    if currentStep > 0 {
                        Button(action: {
                            HapticManager.impact(style: .light)
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                currentStep -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(10)
                                .background(Circle().fill(Color.white.opacity(0.08)))
                        }
                    } else {
                        Spacer().frame(width: 36)
                    }
                    
                    // Glowing progress track
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.white.opacity(0.12))
                                .frame(height: 6)
                            Capsule()
                                .fill(LinearGradient(colors: [Color.cyan, Color.indigo], startPoint: .leading, endPoint: .trailing))
                                .frame(width: geo.size.width * CGFloat(currentStep + 1) / 4.0, height: 6)
                                .shadow(color: Color.cyan.opacity(0.6), radius: 6)
                        }
                    }
                    .frame(height: 6)
                    
                    // Step counter
                    Text("\(currentStep + 1)/4")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 36)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 24)
                
                // Animated Step Card Deck
                TabView(selection: $currentStep) {
                    // Step 1: Identity & Hero Welcome
                    Step1WelcomeView()
                        .tag(0)
                    
                    // Step 2: The Pain Point Diagnostic
                    Step2PainPointsView(selectedPainPoints: $selectedPainPoints, options: painPointOptions)
                        .tag(1)
                    
                    // Step 3: Rotation & Call Calibration
                    Step3CalibrationView(callFrequency: $callFrequency, options: callFrequencyOptions)
                        .tag(2)
                    
                    // Step 4: The Affirmation & Unlock
                    Step4AffirmationView()
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.spring(response: 0.45, dampingFraction: 0.85), value: currentStep)
                
                // Bottom Fixed Action Button
                VStack {
                    Button(action: {
                        HapticManager.impact(style: .medium)
                        if currentStep < 3 {
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                                currentStep += 1
                            }
                        } else {
                            HapticManager.notification(type: .success)
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isOnboardingComplete = true
                            }
                        }
                    }) {
                        HStack(spacing: 8) {
                            Text(currentStep == 0 ? "Begin Calibration" : (currentStep == 3 ? "Enter Trephine" : "Continue"))
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .bold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Color(red: 0.2, green: 0.45, blue: 0.95), Color(red: 0.35, green: 0.3, blue: 0.9)],
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
                .padding(.bottom, 24)
            }
        }
    }
}

// MARK: - Step 1: Welcome & Identity
struct Step1WelcomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 10)
                
                // Animated Trephine Crown Illustration
                ZStack {
                    Circle()
                        .fill(RadialGradient(colors: [Color.indigo.opacity(0.3), Color.clear], center: .center, startRadius: 20, endRadius: 100))
                        .frame(width: 180, height: 180)
                    
                    // Trephine circular serrated saw crown
                    Circle()
                        .stroke(Color.cyan, style: StrokeStyle(lineWidth: 6, lineCap: .round, dash: [12, 10]))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "cross.fill")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .cyan, radius: 10)
                }
                
                VStack(spacing: 12) {
                    Text("Master the 2 AM Call.")
                        .font(.system(size: 30, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("From acute bleeds and brain herniation to cannot-miss spine emergencies and surgical procedures — never second-guess in the trauma bay.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(Color(red: 0.65, green: 0.72, blue: 0.82))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                        .padding(.horizontal, 16)
                }
                
                // Trust pill
                HStack(spacing: 6) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.cyan)
                    Text("Designed for Neurosurgery & Spine Trainees")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white.opacity(0.85))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Capsule().fill(Color.white.opacity(0.06)))
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Step 2: Pain Point Diagnostic
struct Step2PainPointsView: View {
    @Binding var selectedPainPoints: Set<String>
    let options: [(String, String, String, Color)]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("What challenges you most on call?")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                    Text("Select all that apply. Trephine adapts its quick-access triage accordingly.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.6, green: 0.68, blue: 0.78))
                }
                
                VStack(spacing: 12) {
                    ForEach(options, id: \.0) { opt in
                        let isSelected = selectedPainPoints.contains(opt.0)
                        Button(action: {
                            HapticManager.impact(style: .light)
                            if isSelected {
                                selectedPainPoints.remove(opt.0)
                            } else {
                                selectedPainPoints.insert(opt.0)
                            }
                        }) {
                            HStack(alignment: .top, spacing: 14) {
                                ZStack {
                                    Circle()
                                        .fill(opt.3.opacity(isSelected ? 0.25 : 0.12))
                                        .frame(width: 36, height: 36)
                                    Image(systemName: opt.2)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(opt.3)
                                }
                                
                                Text(opt.1)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(isSelected ? .white : Color(red: 0.8, green: 0.85, blue: 0.9))
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(3)
                                
                                Spacer()
                                
                                // Glowing Checkbox
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(isSelected ? Color.cyan : Color.white.opacity(0.2), lineWidth: 2)
                                        .frame(width: 22, height: 22)
                                    if isSelected {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.cyan)
                                            .frame(width: 22, height: 22)
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 11, weight: .black))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(isSelected ? Color(red: 0.14, green: 0.18, blue: 0.26) : Color(red: 0.10, green: 0.12, blue: 0.17))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(isSelected ? Color.cyan.opacity(0.8) : Color.white.opacity(0.06), lineWidth: isSelected ? 2 : 1)
                            )
                            .shadow(color: isSelected ? Color.cyan.opacity(0.15) : Color.clear, radius: 8)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Step 3: Calibration View
struct Step3CalibrationView: View {
    @Binding var callFrequency: String
    let options: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("How often are you on call?")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                    Text("We calibrate procedural checklists and emergency protocols for your intensity level.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.6, green: 0.68, blue: 0.78))
                }
                
                VStack(spacing: 12) {
                    ForEach(options, id: \.self) { opt in
                        let isSelected = callFrequency == opt
                        Button(action: {
                            HapticManager.impact(style: .light)
                            callFrequency = opt
                        }) {
                            HStack {
                                Text(opt)
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(isSelected ? .white : Color(red: 0.75, green: 0.8, blue: 0.88))
                                Spacer()
                                Circle()
                                    .stroke(isSelected ? Color.cyan : Color.white.opacity(0.2), lineWidth: 2)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Circle()
                                            .fill(isSelected ? Color.cyan : Color.clear)
                                            .frame(width: 10, height: 10)
                                    )
                            }
                            .padding(18)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(isSelected ? Color(red: 0.14, green: 0.18, blue: 0.26) : Color(red: 0.10, green: 0.12, blue: 0.17))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(isSelected ? Color.cyan.opacity(0.8) : Color.white.opacity(0.06), lineWidth: isSelected ? 2 : 1)
                            )
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Step 4: The Affirmation & Reveal
struct Step4AffirmationView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Editorial Hero Art (Illustrated Sunset Peak motif inspired by Wellspoken)
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 0.95, green: 0.45, blue: 0.25), Color(red: 0.85, green: 0.25, blue: 0.45), Color(red: 0.35, green: 0.2, blue: 0.65)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 180)
                    
                    VStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.yellow)
                            .shadow(color: .orange, radius: 6)
                        Text("Surgical Instinct Is Built On Structure")
                            .font(.system(size: 16, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 4)
                
                VStack(spacing: 12) {
                    Text("Great surgeons never rely on memory alone.")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Senior attendings operate with calm because they rely on deterministic, structured protocols. Trephine gives you that same poise at 3:15 AM.")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color(red: 0.65, green: 0.72, blue: 0.82))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                
                // Key Pillar Summary Pills
                VStack(spacing: 10) {
                    HStack(spacing: 12) {
                        Image(systemName: "cross.case.fill")
                            .foregroundColor(.red)
                        Text("2 AM Herniation & Bleed Triage (SBAR Phone Script)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                        Spacer()
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.05)))
                    
                    HStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text("Cannot-Miss Emergencies (Cauda Equina, Abscess, aSAH)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                        Spacer()
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.05)))
                    
                    HStack(spacing: 12) {
                        Image(systemName: "syringe.fill")
                            .foregroundColor(.teal)
                        Text("Procedural Atlas (EVD Trajectory, Lumbar Drains, Camino)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                        Spacer()
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.05)))
                }
            }
            .padding(.horizontal, 24)
        }
    }
}
