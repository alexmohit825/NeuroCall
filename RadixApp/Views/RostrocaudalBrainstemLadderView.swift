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
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Circle().fill(statusColor).frame(width: 8, height: 8)
                        Text("ROSTROCAUDAL BRAINSTEM DETERIORATION")
                            .font(.system(size: 10, weight: .black))
                            .tracking(1.6)
                            .foregroundColor(statusColor)
                        Spacer()
                        Text(statusBadgeText)
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(statusColor.opacity(0.18))
                            .foregroundColor(statusColor)
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(statusColor.opacity(0.4), lineWidth: 1))
                    }
                    Text("Brainstem Reflex & Consciousness Ladder")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                    Text("Plum & Posner Transtentorial Herniation Architecture")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.6, green: 0.65, blue: 0.75))
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Vertical Anatomical Elevator Board
                VStack(spacing: 0) {
                    // Top Rostral Anchor
                    HStack {
                        Text("ROSTRAL (Higher Brain)")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.65))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                    
                    // Stages Stack
                    ZStack {
                        // Central Descent Arrow Line
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(stageIndex > 0 ? Color.red : Color(red: 0.25, green: 0.28, blue: 0.35))
                                .frame(width: 3, height: CGFloat(stageIndex) * 54)
                            if stageIndex > 0 {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(.red)
                            }
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        // Stage Nodes
                        VStack(spacing: 10) {
                            stageRow(
                                index: 1,
                                anatomicalLevel: "Thalamus / Hypothalamus",
                                reflexTrigger: "Pupillary Dilation / Sympathetic",
                                stageName: "Diencephalic Stage"
                            )
                            stageRow(
                                index: 2,
                                anatomicalLevel: "Upper Brainstem",
                                reflexTrigger: "Pupillary Light Reflex (CN II/III)",
                                stageName: "Midbrain Stage"
                            )
                            stageRow(
                                index: 3,
                                anatomicalLevel: "Middle Brainstem",
                                reflexTrigger: "Corneal & Dolls Reflex (CN V/VII/VIII)",
                                stageName: "Pons Stage"
                            )
                            stageRow(
                                index: 4,
                                anatomicalLevel: "Lower Brainstem (Upper)",
                                reflexTrigger: "Gag & Carinal Cough (CN IX/X)",
                                stageName: "Upper Medulla Stage"
                            )
                            stageRow(
                                index: 5,
                                anatomicalLevel: "Terminal Brainstem",
                                reflexTrigger: "Apnea Test / Respiratory Drive",
                                stageName: "Low Medulla (Brain Death)"
                            )
                        }
                        .padding(.vertical, 12)
                    }
                    
                    // Bottom Caudal Anchor
                    HStack {
                        Text("CAUDAL (Spinal Cord Junction)")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.65))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 14)
                }
                .background(Color(red: 0.08, green: 0.09, blue: 0.12))
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.08), lineWidth: 1))
                .padding(.horizontal)
                
                // Dynamic Clinical Triad Readout Strip
                HStack(spacing: 12) {
                    clinicalReadoutCard(
                        title: "Pupil Response",
                        value: currentPupilText,
                        icon: "eye.fill"
                    )
                    clinicalReadoutCard(
                        title: "Motor Pattern",
                        value: currentMotorText,
                        icon: "figure.walk"
                    )
                    clinicalReadoutCard(
                        title: "Respiration",
                        value: currentRespirationText,
                        icon: "lungs.fill"
                    )
                }
                .padding(.horizontal)
                
                // Interactive Progression Slider
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Rostrocaudal Collapse Progression Depth")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color(red: 0.85, green: 0.88, blue: 0.95))
                        Spacer()
                        Text(sliderLevelLabel)
                            .font(.system(size: 13, weight: .black, design: .monospaced))
                            .foregroundColor(statusColor)
                    }
                    
                    Slider(value: $progressionDepth, in: 0...5, step: 1)
                        .tint(statusColor)
                }
                .padding(14)
                .background(Color(red: 0.11, green: 0.13, blue: 0.18))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Overlay Mode Toggle
                VStack(alignment: .leading, spacing: 8) {
                    Text("Visualization Overlay Mode")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color(red: 0.55, green: 0.6, blue: 0.7))
                    
                    Picker("Mode", selection: $overlayMode) {
                        ForEach(VisualizationMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 24)
            }
        }
        .background(Color(red: 0.04, green: 0.05, blue: 0.07))
    }
    
    // MARK: - Stage Node Row
    private func stageRow(index: Int, anatomicalLevel: String, reflexTrigger: String, stageName: String) -> some View {
        let isCollapsed = stageIndex >= index
        let isCurrentFront = stageIndex == index
        let leftLabel = overlayMode == .anatomicalRegions ? anatomicalLevel : reflexTrigger
        
        return HStack(spacing: 12) {
            Text(leftLabel)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(Color(red: 0.55, green: 0.6, blue: 0.7))
                .frame(width: 140, alignment: .trailing)
                .lineLimit(2)
            
            // Central Capsule
            HStack {
                Circle()
                    .fill(isCollapsed ? Color.white : Color(red: 0.3, green: 0.35, blue: 0.45))
                    .frame(width: 6, height: 6)
                
                Spacer()
                
                Text(stageName)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(isCollapsed ? Color.white : Color(red: 0.6, green: 0.65, blue: 0.75))
                
                Spacer()
                
                Circle()
                    .fill(isCollapsed ? Color.white : Color(red: 0.3, green: 0.35, blue: 0.45))
                    .frame(width: 6, height: 6)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(width: 180)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isCollapsed ? stageColor(index: index) : Color(red: 0.12, green: 0.14, blue: 0.19))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isCurrentFront ? Color.white : (isCollapsed ? stageColor(index: index).opacity(0.8) : Color.white.opacity(0.06)), lineWidth: isCurrentFront ? 2 : 1)
            )
            
            // State Tag
            HStack(spacing: 4) {
                if isCollapsed {
                    Text("▼ COLLAPSED")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(stageColor(index: index))
                } else {
                    Text("✓ FUNCTIONAL")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(Color.green)
                }
            }
            .frame(width: 100, alignment: .leading)
        }
        .padding(.horizontal, 10)
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
