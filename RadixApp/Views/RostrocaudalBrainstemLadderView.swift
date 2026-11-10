import SwiftUI

// MARK: - Rostrocaudal Brainstem Herniation & Consciousness Ladder View
// Inspired by Plum & Posner's Diagnosis of Stupor and Coma
// Interactive slider-driven vertical anatomical elevator illustrating rostrocaudal brainstem collapse.

public struct RostrocaudalBrainstemLadderView: View {
    @State private var progressionDepth: Double = 0 // 0 to 5
    @State private var overlayMode: VisualizationMode = .anatomicalRegions
    
    public enum VisualizationMode: String, CaseIterable {
        case anatomicalRegions = "Anatomical Regions"
        case keyReflexTriggers = "Key Reflex Triggers"
    }
    
    public init() {}
    
    private var stageIndex: Int {
        Int(progressionDepth.rounded())
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Circle().fill(statusColor).frame(width: 8, height: 8)
                        Text("ROSTROCAUDAL BRAINSTEM DETERIORATION")
                            .font(.system(size: 10, weight: .black))
                            .tracking(1.1)
                            .foregroundColor(statusColor)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        Spacer(minLength: 4)
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Brainstem Reflex Ladder")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.white)
                        Spacer()
                        Text(statusBadgeText)
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(statusColor.opacity(0.18))
                            .foregroundColor(statusColor)
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(statusColor.opacity(0.4), lineWidth: 1))
                    }
                    Text("Plum & Posner Transtentorial Herniation Architecture")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.6, green: 0.65, blue: 0.75))
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                // Interactive Progression Slider (Placed near top for immediate thumb control)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Collapse Progression Depth")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color(red: 0.85, green: 0.88, blue: 0.95))
                        Spacer()
                        Text(sliderLevelLabel)
                            .font(.system(size: 12, weight: .black, design: .monospaced))
                            .foregroundColor(statusColor)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    
                    Slider(value: $progressionDepth, in: 0...5, step: 1)
                        .tint(statusColor)
                    
                    HStack {
                        Text("0 Intact")
                        Spacer()
                        Text("1 Dien")
                        Spacer()
                        Text("2 Mid")
                        Spacer()
                        Text("3 Pons")
                        Spacer()
                        Text("4 Med")
                        Spacer()
                        Text("5 Apnea")
                    }
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(red: 0.55, green: 0.6, blue: 0.7))
                }
                .padding(12)
                .background(Color(red: 0.11, green: 0.13, blue: 0.18))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                
                // Overlay Mode Toggle
                Picker("Mode", selection: $overlayMode) {
                    ForEach(VisualizationMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                
                // Vertical Anatomical Elevator Board (100% Fluid iPhone Width)
                VStack(spacing: 8) {
                    HStack {
                        Text("ROSTRAL (Cortex / Thalamus)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.65))
                        Spacer()
                        Text(overlayMode == .anatomicalRegions ? "ANATOMICAL LEVEL" : "REFLEX CORRELATE")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(Color(red: 0.45, green: 0.5, blue: 0.6))
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 10)
                    
                    VStack(spacing: 8) {
                        stageRow(
                            index: 1,
                            anatomicalLevel: "Thalamus / Hypothalamus",
                            reflexTrigger: "Pupillary Dilation / Sympathetic",
                            stageName: "1. Diencephalic"
                        )
                        stageRow(
                            index: 2,
                            anatomicalLevel: "Upper Brainstem (Tectum)",
                            reflexTrigger: "Pupillary Light Reflex (CN II/III)",
                            stageName: "2. Midbrain"
                        )
                        stageRow(
                            index: 3,
                            anatomicalLevel: "Middle Brainstem (Basis Pontis)",
                            reflexTrigger: "Corneal & Oculocephalic (CN V/VII/VIII)",
                            stageName: "3. Pons"
                        )
                        stageRow(
                            index: 4,
                            anatomicalLevel: "Upper Medulla (Glossopharyngeal)",
                            reflexTrigger: "Gag & Carinal Cough (CN IX/X)",
                            stageName: "4. Upper Medulla"
                        )
                        stageRow(
                            index: 5,
                            anatomicalLevel: "Low Medulla (VRG / Pre-Bötzinger)",
                            reflexTrigger: "Apnea Test / Respiratory Drive",
                            stageName: "5. Low Medulla"
                        )
                    }
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Text("CAUDAL (Foramen Magnum / C1)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.65))
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 10)
                }
                .background(Color(red: 0.08, green: 0.09, blue: 0.12))
                .cornerRadius(14)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.08), lineWidth: 1))
                .padding(.horizontal, 16)
                
                // Dynamic Clinical Triad Readout Strip (Fluid 3-Card Layout)
                VStack(spacing: 8) {
                    clinicalReadoutCard(
                        title: "PUPILLARY RESPONSE (CN II / III / SYMPATHETIC)",
                        value: currentPupilText,
                        icon: "eye.fill"
                    )
                    HStack(spacing: 8) {
                        clinicalReadoutCard(
                            title: "MOTOR POSTURING",
                            value: currentMotorText,
                            icon: "figure.walk"
                        )
                        clinicalReadoutCard(
                            title: "RESPIRATORY PATTERN",
                            value: currentRespirationText,
                            icon: "lungs.fill"
                        )
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer(minLength: 24)
            }
        }
        .background(Color(red: 0.04, green: 0.05, blue: 0.07))
    }
    
    // MARK: - Responsive Stage Node Row (Fits 100% within 375pt-430pt iPhone width)
    private func stageRow(index: Int, anatomicalLevel: String, reflexTrigger: String, stageName: String) -> some View {
        let isCollapsed = stageIndex >= index
        let isCurrentFront = stageIndex == index
        let subtitleLabel = overlayMode == .anatomicalRegions ? anatomicalLevel : reflexTrigger
        
        return HStack(spacing: 10) {
            // Left Vertical Indicator Dot + Connector
            Circle()
                .fill(isCollapsed ? Color.white : Color(red: 0.3, green: 0.35, blue: 0.45))
                .frame(width: 8, height: 8)
            
            // Center Stage Name & Subtitle (Fluid width)
            VStack(alignment: .leading, spacing: 2) {
                Text(stageName)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(isCollapsed ? Color.white : Color(red: 0.85, green: 0.88, blue: 0.94))
                    .lineLimit(1)
                Text(subtitleLabel)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(isCollapsed ? Color.white.opacity(0.88) : Color(red: 0.55, green: 0.6, blue: 0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Right Status Pill
            Text(isCollapsed ? "▼ COLLAPSED" : "✓ INTACT")
                .font(.system(size: 9, weight: .black))
                .padding(.horizontal, 7)
                .padding(.vertical, 4)
                .background(isCollapsed ? Color.black.opacity(0.28) : Color.green.opacity(0.14))
                .foregroundColor(isCollapsed ? Color.white : Color.green)
                .cornerRadius(6)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 9)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isCollapsed ? stageColor(index: index) : Color(red: 0.12, green: 0.14, blue: 0.19))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isCurrentFront ? Color.white : (isCollapsed ? stageColor(index: index).opacity(0.8) : Color.white.opacity(0.06)), lineWidth: isCurrentFront ? 2 : 1)
        )
    }
    
    // MARK: - Clinical Readout Card
    private func clinicalReadoutCard(title: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 10))
                    .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.65))
                Text(title)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.65))
            }
            Text(value)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color.white)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 65, alignment: .topLeading)
        .padding(10)
        .background(Color(red: 0.09, green: 0.11, blue: 0.16))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.06), lineWidth: 1))
    }
    
    // MARK: - Computed Properties
    private func stageColor(index: Int) -> Color {
        switch index {
        case 1: return Color.orange
        case 2: return Color(red: 0.95, green: 0.35, blue: 0.3)
        case 3: return Color(red: 0.85, green: 0.25, blue: 0.25)
        case 4: return Color(red: 0.7, green: 0.2, blue: 0.2)
        case 5: return Color(red: 0.5, green: 0.15, blue: 0.15)
        default: return Color.green
        }
    }
    
    private var statusColor: Color {
        switch stageIndex {
        case 0: return Color.cyan
        case 1: return Color.orange
        case 2, 3: return Color.red
        case 4, 5: return Color(red: 0.8, green: 0.1, blue: 0.2)
        default: return Color.cyan
        }
    }
    
    private var statusBadgeText: String {
        switch stageIndex {
        case 0: return "Status: Fully Awake"
        case 1: return "Herniation: Stage 1"
        case 2: return "Herniation: Stage 2"
        case 3: return "Herniation: Stage 3"
        case 4: return "Herniation: Stage 4"
        case 5: return "Status: Brain Death"
        default: return "Intact"
        }
    }
    
    private var sliderLevelLabel: String {
        switch stageIndex {
        case 0: return "0 - Fully Intact"
        case 1: return "1 - Diencephalic Stage"
        case 2: return "2 - Midbrain Stage"
        case 3: return "3 - Pons Stage"
        case 4: return "4 - Upper Medulla Stage"
        case 5: return "5 - Low Medulla (Brain Death)"
        default: return ""
        }
    }
    
    private var currentPupilText: String {
        switch stageIndex {
        case 0: return "Normal, Reactive (3-4mm)"
        case 1: return "Small, Reactive (1.5-2.5mm)"
        case 2: return "Mid-position, Fixed/Sluggish"
        case 3: return "Pinpoint, Fixed (1mm)"
        case 4: return "Mid-position or Dilated, Fixed"
        case 5: return "Fully Dilated, Fixed (7-9mm)"
        default: return "Intact"
        }
    }
    
    private var currentMotorText: String {
        switch stageIndex {
        case 0: return "Normal / Purposeful"
        case 1: return "Decorticate (Flexion)"
        case 2: return "Decerebrate (Extension)"
        case 3: return "Flaccid or Weak Extension"
        case 4: return "Flaccid, No Response"
        case 5: return "Completely Flaccid"
        default: return "Normal"
        }
    }
    
    private var currentRespirationText: String {
        switch stageIndex {
        case 0: return "Normal Eupnea"
        case 1: return "Cheyne-Stokes breathing"
        case 2: return "Central Hyperventilation"
        case 3: return "Apneustic / Cluster"
        case 4: return "Ataxic (Biot's) breathing"
        case 5: return "Apnea (Respiratory arrest)"
        default: return "Normal"
        }
    }
}
