import SwiftUI

// MARK: - Dedicated Neurosurgical Calculator Hub
// Synthesized from Brain Trauma Foundation (BTF) Guidelines, Hemphill ICH Score,
// Claassen Modified Fisher Criteria, Hunt & Hess, WFNS, Spetzler-Martin AVM,
// Vaccaro TLICS / SLIC, Fisher SINS, and Neurocritical Hyperosmolar Standards.
// Formatted with Apple Pro-Tier Obsidian Dark Theme, zero tag collisions, and verified clinical algorithms.

public struct NeurosurgeryCalculatorsView: View {
    @State private var selectedCalculator = "cpp"
    @State private var isShowingDisclaimer = false
    @Environment(\.requestReview) var requestReview
    @Environment(\.openURL) var openURL
    @State private var hasRated = false
    
    // CPP State
    @State private var mapInput: Double = 85.0 // mmHg
    @State private var icpInput: Double = 18.0 // mmHg
    
    // ICH Score State
    @State private var ichGCS: Int = 1 // 0: 13-15, 1: 5-12, 2: 3-4
    @State private var ichVolumeOver30: Bool = true
    @State private var ichIVH: Bool = false
    @State private var ichInfratentorial: Bool = false
    @State private var ichAgeOver80: Bool = false
    
    // SAH: WFNS & Hunt & Hess & Modified Fisher State
    @State private var gcsInput: Double = 14
    @State private var focalDeficit: Bool = false
    @State private var huntHessGrade: Int = 2 // 1: Asymptomatic/mild, 2: Mod-severe/nuchal, 3: Drowsy/confusion, 4: Stupor, 5: Coma
    @State private var modifiedFisherGrade: Int = 2 // 0: None, 1: Thin no IVH, 2: Thin with IVH, 3: Thick no IVH, 4: Thick with IVH
    
    // Spetzler-Martin AVM State
    @State private var avmSize: Int = 1 // 1: <3cm, 2: 3-6cm, 3: >6cm
    @State private var avmEloquence: Int = 1 // 0: Non-eloquent, 1: Eloquent
    @State private var avmVenousDrainage: Int = 1 // 0: Superficial only, 1: Deep
    
    // TLICS State (Unique indices to prevent tag collisions)
    @State private var tlicsMorphIndex: Int = 1 // 0: None(0), 1: Compression(1), 2: Burst(2), 3: Transl/Rot(3), 4: Distraction(4)
    @State private var tlicsPLCIndex: Int = 1 // 0: Intact(0), 1: Suspected/Indeterminate(2), 2: Disrupted(3)
    @State private var tlicsNeuroIndex: Int = 0 // 0: Intact(0), 1: Root(2), 2: Complete cord(2), 3: Incomplete cord(3), 4: Cauda equina(3)
    
    // SLIC State
    @State private var slicMorphIndex: Int = 1 // 0: None(0), 1: Compression(1), 2: Burst(2), 3: Distraction(3), 4: Rotation/Transl(4)
    @State private var slicDLCIndex: Int = 1 // 0: Intact(0), 1: Indeterminate(1), 2: Disrupted(2)
    @State private var slicNeuroIndex: Int = 0 // 0: Intact(0), 1: Root(1), 2: Complete(2), 3: Incomplete(3)
    @State private var slicPersistentCompression: Bool = false // +1 modifier
    
    // SINS State
    @State private var sinsLocation: Int = 3 // 1-3
    @State private var sinsPain: Int = 3 // 1-3
    @State private var sinsBoneLesion: Int = 2 // 1-2
    @State private var sinsAlignment: Int = 2 // 0-4
    @State private var sinsCollapse: Int = 2 // 0-3
    @State private var sinsPosterior: Int = 1 // 0-3
    
    // Osmotherapy State
    @State private var patientWeightKg: Double = 75.0
    @State private var currentSodium: Double = 138.0
    @State private var targetSodium: Double = 150.0
    @State private var isFemalePatient: Bool = false
    
    public init() {}
    
    // CPP Calculation
    var calculatedCPP: Double { mapInput - icpInput }
    
    // ICH Score Calculation
    var totalICHScore: Int {
        var score = ichGCS
        if ichVolumeOver30 { score += 1 }
        if ichIVH { score += 1 }
        if ichInfratentorial { score += 1 }
        if ichAgeOver80 { score += 1 }
        return score
    }
    
    var ichMortalityText: String {
        switch totalICHScore {
        case 0: return "0% estimated 30-day mortality"
        case 1: return "13% estimated 30-day mortality"
        case 2: return "26% estimated 30-day mortality"
        case 3: return "72% estimated 30-day mortality"
        case 4: return "97% estimated 30-day mortality"
        case 5, 6: return "100% estimated 30-day mortality"
        default: return "Variable"
        }
    }
    
    // Spetzler-Martin Total Grade
    var spetzlerMartinGrade: Int {
        avmSize + avmEloquence + avmVenousDrainage
    }
    
    // TLICS Total (Points mapped from indices)
    let tlicsMorphPoints = [0, 1, 2, 3, 4]
    let tlicsPLCPoints = [0, 2, 3]
    let tlicsNeuroPoints = [0, 2, 2, 3, 3]
    
    var totalTLICS: Int {
        let m = tlicsMorphPoints[min(tlicsMorphIndex, tlicsMorphPoints.count - 1)]
        let p = tlicsPLCPoints[min(tlicsPLCIndex, tlicsPLCPoints.count - 1)]
        let n = tlicsNeuroPoints[min(tlicsNeuroIndex, tlicsNeuroPoints.count - 1)]
        return m + p + n
    }
    
    // SLIC Total
    let slicMorphPoints = [0, 1, 2, 3, 4]
    let slicDLCPoints = [0, 1, 2]
    let slicNeuroPoints = [0, 1, 2, 3]
    
    var totalSLIC: Int {
        let m = slicMorphPoints[min(slicMorphIndex, slicMorphPoints.count - 1)]
        let d = slicDLCPoints[min(slicDLCIndex, slicDLCPoints.count - 1)]
        var n = slicNeuroPoints[min(slicNeuroIndex, slicNeuroPoints.count - 1)]
        if slicPersistentCompression && (slicNeuroIndex == 2 || slicNeuroIndex == 3) {
            n += 1
        }
        return m + d + n
    }
    
    // SINS Score
    var totalSINS: Int {
        sinsLocation + sinsPain + sinsBoneLesion + sinsAlignment + sinsCollapse + sinsPosterior
    }
    
    var sinsStabilityText: String {
        if totalSINS <= 6 { return "STABLE (0-6) • Conservative / Radiation Therapy" }
        if totalSINS <= 12 { return "POTENTIALLY UNSTABLE (7-12) • Surgical Consult Recommended" }
        return "UNSTABLE (13-18) • Emergent Surgical Stabilization Required"
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Banner
                headerView
                
                // Calculator Selector Bar
                calculatorSelectorBar
                
                // Active Calculator View
                Group {
                    switch selectedCalculator {
                    case "cpp":
                        CPPCalculatorView(map: $mapInput, icp: $icpInput, cpp: calculatedCPP)
                    case "ich":
                        ICHScoreCalculatorView(
                            gcsScore: $ichGCS,
                            volOver30: $ichVolumeOver30,
                            ivh: $ichIVH,
                            infra: $ichInfratentorial,
                            ageOver80: $ichAgeOver80,
                            totalScore: totalICHScore,
                            mortalityText: ichMortalityText
                        )
                    case "sah":
                        SAHGradeCalculatorView(
                            gcs: $gcsInput,
                            deficit: $focalDeficit,
                            huntHess: $huntHessGrade,
                            modifiedFisher: $modifiedFisherGrade
                        )
                    case "avm":
                        SpetzlerMartinCalculatorView(
                            size: $avmSize,
                            eloquence: $avmEloquence,
                            drainage: $avmVenousDrainage,
                            totalGrade: spetzlerMartinGrade
                        )
                    case "tlics":
                        TLICSCalculatorView(
                            morphIndex: $tlicsMorphIndex,
                            plcIndex: $tlicsPLCIndex,
                            neuroIndex: $tlicsNeuroIndex,
                            total: totalTLICS
                        )
                    case "slic":
                        SLICCalculatorView(
                            morphIndex: $slicMorphIndex,
                            dlcIndex: $slicDLCIndex,
                            neuroIndex: $slicNeuroIndex,
                            comp: $slicPersistentCompression,
                            total: totalSLIC
                        )
                    case "sins":
                        SINSCalculatorView(
                            location: $sinsLocation,
                            pain: $sinsPain,
                            bone: $sinsBoneLesion,
                            align: $sinsAlignment,
                            collapse: $sinsCollapse,
                            post: $sinsPosterior,
                            total: totalSINS,
                            statusText: sinsStabilityText
                        )
                    case "osmo":
                        OsmotherapyCalculatorView(
                            weight: $patientWeightKg,
                            currentNa: $currentSodium,
                            targetNa: $targetSodium,
                            isFemale: $isFemalePatient
                        )
                    default:
                        CPPCalculatorView(map: $mapInput, icp: $icpInput, cpp: calculatedCPP)
                    }
                }
                .padding(.horizontal)
                
                // In-App Rating Banner (Apple Guideline 5.6.1 Compliant)
                ratingBannerCard
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                Spacer(minLength: 32)
            }
            .padding(.top, 8)
        }
        .background(ObsidianTheme.surfaceVoid)
        .sheet(isPresented: $isShowingDisclaimer) {
            MedicalDisclaimerSheet()
        }
    }
    
    // MARK: - Header
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Circle().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 8)
                    Text("CLINICAL DECISION SUPPORT & DOSING")
                        .font(.system(size: 10, weight: .black))
                        .tracking(1.8)
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                Text("Neurosurgery Clinical Calculators")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Text("Peer-reviewed clinical scoring, trauma classification, and neurocritical dosing.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            Spacer()
            Button(action: {
                HapticManager.impact(style: .light)
                isShowingDisclaimer = true
            }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(ObsidianTheme.neonCyan)
                    .padding(8)
                    .background(ObsidianTheme.surfaceGlass)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Calculator Selector Bar
    private var calculatorSelectorBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                CalcPill(id: "cpp", label: "CPP & Perfusion", icon: "waveform.path.ecg", selected: $selectedCalculator)
                CalcPill(id: "ich", label: "ICH Score", icon: "drop.fill", selected: $selectedCalculator)
                CalcPill(id: "sah", label: "SAH / Fisher / WFNS", icon: "brain.head.profile", selected: $selectedCalculator)
                CalcPill(id: "avm", label: "Spetzler-Martin AVM", icon: "circle.grid.cross.fill", selected: $selectedCalculator)
                CalcPill(id: "tlics", label: "TLICS Thoracolumbar", icon: "shield.fill", selected: $selectedCalculator)
                CalcPill(id: "slic", label: "SLIC Cervical", icon: "link", selected: $selectedCalculator)
                CalcPill(id: "sins", label: "SINS Spine Tumor", icon: "figure.walk", selected: $selectedCalculator)
                CalcPill(id: "osmo", label: "Osmotherapy & Na+", icon: "cross.vial.fill", selected: $selectedCalculator)
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Un-Gated App Store Rating Card
    private var ratingBannerCard: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color.yellow)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Enjoying NeuroCall?")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(ObsidianTheme.textPrimary)
                    Text("Your rating on the App Store supports ongoing neurosurgical updates.")
                        .font(.system(size: 11))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
            }
            
            HStack(spacing: 10) {
                Button(action: {
                    HapticManager.impact(style: .medium)
                    requestReview()
                }) {
                    Text("Rate NeuroCall")
                        .font(.system(size: 12, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(ObsidianTheme.neonCyan)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    HapticManager.impact(style: .light)
                    if let url = URL(string: "https://apps.apple.com/app/id6821489631?action=write-review") {
                        openURL(url)
                    }
                }) {
                    Text("Write a Review")
                        .font(.system(size: 12, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(ObsidianTheme.surfaceVoid)
                        .foregroundColor(ObsidianTheme.textPrimary)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
                }
            }
        }
        .padding(14)
        .background(ObsidianTheme.surfaceGlass)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
}

// MARK: - 1. CPP Calculator View
struct CPPCalculatorView: View {
    @Binding var map: Double
    @Binding var icp: Double
    let cpp: Double
    
    var cppStatusColor: Color {
        if cpp >= 60 && cpp <= 70 { return Color.green }
        if cpp < 60 { return Color.red }
        return Color.orange
    }
    
    var cppStatusText: String {
        if cpp >= 60 && cpp <= 70 { return "TARGET OPTIMAL (60 - 70 mmHg)" }
        if cpp < 60 { return "ISCHEMIA THRESHOLD (< 60 mmHg) • Inadequate Perfusion" }
        return "HYPEREMIA RISK (> 70 mmHg) • ARDS / Vasogenic Edema Risk"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("CEREBRAL PERFUSION PRESSURE (CPP = MAP - ICP)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(String(format: "%.0f", cpp))
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .foregroundColor(cppStatusColor)
                        Text("mmHg")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                Spacer()
                Text(cppStatusText)
                    .font(.system(size: 9, weight: .black))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(cppStatusColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(cppStatusColor.opacity(0.12))
                    .cornerRadius(8)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            VStack(spacing: 12) {
                MetricSlider(label: "Mean Arterial Pressure (MAP)", value: $map, range: 40...140, unit: "mmHg")
                MetricSlider(label: "Intracranial Pressure (ICP)", value: $icp, range: 0...50, unit: "mmHg")
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("• Brain Trauma Foundation (BTF 4th Ed.) Guideline:")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.neonCyan)
                Text("Target CPP is strictly **60 to 70 mmHg**. Avoid aggressive fluid/vasopressor titration attempting to push CPP > 70 mmHg due to significant risk of adult respiratory distress syndrome (ARDS).")
                    .font(.system(size: 11))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
        }
    }
}

// MARK: - 2. ICH Score View
struct ICHScoreCalculatorView: View {
    @Binding var gcsScore: Int
    @Binding var volOver30: Bool
    @Binding var ivh: Bool
    @Binding var infra: Bool
    @Binding var ageOver80: Bool
    let totalScore: Int
    let mortalityText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("HEMPHILL ICH SCORE")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(totalScore)")
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .foregroundColor(totalScore >= 3 ? Color.red : (totalScore >= 2 ? Color.orange : Color.green))
                        Text("/ 6 POINTS")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                Spacer()
                Text(mortalityText)
                    .font(.system(size: 11, weight: .heavy))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(totalScore >= 3 ? Color.red : (totalScore >= 2 ? Color.orange : Color.green))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background((totalScore >= 3 ? Color.red : (totalScore >= 2 ? Color.orange : Color.green)).opacity(0.12))
                    .cornerRadius(8)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            VStack(spacing: 8) {
                ScoreSelector(title: "Glasgow Coma Scale (GCS)", options: [
                    ("GCS 13 - 15 (0 pts)", 0),
                    ("GCS 5 - 12 (1 pt)", 1),
                    ("GCS 3 - 4 (2 pts)", 2)
                ], selection: $gcsScore)
                
                ToggleRow(title: "ICH Volume ≥ 30 cm³ (ABC/2)", subtitle: "+1 point if hemorrhage volume ≥ 30 cc", isOn: $volOver30)
                ToggleRow(title: "Intraventricular Hemorrhage (IVH)", subtitle: "+1 point for IVH presence in lateral/3rd/4th ventricles", isOn: $ivh)
                ToggleRow(title: "Infratentorial Origin", subtitle: "+1 point for cerebellar or brainstem location", isOn: $infra)
                ToggleRow(title: "Age ≥ 80 Years", subtitle: "+1 point for patient age ≥ 80", isOn: $ageOver80)
            }
        }
    }
}

// MARK: - 3. SAH / Modified Fisher / Hunt & Hess / WFNS View
struct SAHGradeCalculatorView: View {
    @Binding var gcs: Double
    @Binding var deficit: Bool
    @Binding var huntHess: Int
    @Binding var modifiedFisher: Int
    
    var wfnsGrade: Int {
        let g = Int(gcs)
        if g == 15 { return 1 }
        if g >= 13 { return deficit ? 3 : 2 }
        if g >= 7 { return 4 }
        return 5
    }
    
    var huntHessDescription: String {
        switch huntHess {
        case 1: return "Grade 1: Asymptomatic or mild headache and slight nuchal rigidity"
        case 2: return "Grade 2: Moderate to severe headache, nuchal rigidity, cranial nerve palsy only"
        case 3: return "Grade 3: Drowsiness, confusion, or mild focal neurological deficit"
        case 4: return "Grade 4: Stupor, moderate-to-severe hemiparesis, early decerebrate rigidity"
        case 5: return "Grade 5: Deep coma, decerebrate posturing, moribund appearance"
        default: return ""
        }
    }
    
    var modifiedFisherDescription: String {
        switch modifiedFisher {
        case 0: return "Grade 0: No focal or diffuse SAH, No IVH (0% symptomatic vasospasm)"
        case 1: return "Grade 1: Focal or diffuse thin SAH (<1mm), NO IVH (24% symptomatic vasospasm)"
        case 2: return "Grade 2: Focal or diffuse thin SAH (<1mm) WITH IVH (33% symptomatic vasospasm)"
        case 3: return "Grade 3: Dense thick cisternal SAH (≥1mm), NO IVH (33% symptomatic vasospasm)"
        case 4: return "Grade 4: Dense thick cisternal SAH (≥1mm) WITH bilateral IVH (40% symptomatic vasospasm)"
        default: return ""
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Summary Cards
            HStack(spacing: 8) {
                GradeBadge(title: "WFNS", grade: "Grade \(wfnsGrade)", color: ObsidianTheme.neonCyan)
                GradeBadge(title: "HUNT & HESS", grade: "Grade \(huntHess)", color: Color.orange)
                GradeBadge(title: "MOD. FISHER", grade: "Grade \(modifiedFisher)", color: Color.red)
            }
            
            // WFNS Controls
            VStack(alignment: .leading, spacing: 8) {
                Text("WFNS (World Federation of Neurosurgical Societies)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.neonCyan)
                
                MetricSlider(label: "Glasgow Coma Scale", value: $gcs, range: 3...15, unit: "GCS")
                ToggleRow(title: "Major Focal Motor Deficit (Hemiparesis/Aphasia)", subtitle: "Shifts GCS 13-14 from Grade 2 to Grade 3", isOn: $deficit)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            // Hunt & Hess Direct Decoupled Selector
            VStack(alignment: .leading, spacing: 8) {
                Text("Hunt & Hess Clinical Grade (Aneurysmal SAH)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(Color.orange)
                
                Picker("Hunt & Hess", selection: $huntHess) {
                    Text("Grade 1: Asymptomatic / Mild Headache").tag(1)
                    Text("Grade 2: Mod-Severe Headache / Nuchal Rigidity").tag(2)
                    Text("Grade 3: Drowsy / Confusion / Mild Deficit").tag(3)
                    Text("Grade 4: Stupor / Dense Hemiparesis").tag(4)
                    Text("Grade 5: Deep Coma / Decerebrate").tag(5)
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color(red: 0.08, green: 0.1, blue: 0.14))
                .cornerRadius(8)
                
                Text(huntHessDescription)
                    .font(.system(size: 10))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            // Modified Fisher (Claassen et al.)
            VStack(alignment: .leading, spacing: 8) {
                Text("Modified Fisher Scale (CT Vasospasm Risk)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(Color.red)
                
                Picker("Modified Fisher", selection: $modifiedFisher) {
                    Text("Grade 0: No SAH, No IVH (0%)").tag(0)
                    Text("Grade 1: Thin SAH, No IVH (24%)").tag(1)
                    Text("Grade 2: Thin SAH WITH IVH (33%)").tag(2)
                    Text("Grade 3: Thick SAH, No IVH (33%)").tag(3)
                    Text("Grade 4: Thick SAH WITH IVH (40%)").tag(4)
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color(red: 0.08, green: 0.1, blue: 0.14))
                .cornerRadius(8)
                
                Text(modifiedFisherDescription)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(Color.red.opacity(0.9))
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
        }
    }
}

// MARK: - 4. Spetzler-Martin AVM View
struct SpetzlerMartinCalculatorView: View {
    @Binding var size: Int
    @Binding var eloquence: Int
    @Binding var drainage: Int
    let totalGrade: Int
    
    var operativeRiskText: String {
        switch totalGrade {
        case 1: return "Grade I (Low Risk) • Microsurgical Resection First-Line"
        case 2: return "Grade II (Low-Mod Risk) • Safe Microsurgical Resection"
        case 3: return "Grade III (Moderate Risk) • Multimodal: Embo + Surgery / SRS"
        case 4: return "Grade IV (High Risk) • Conservative unless repeated bleed"
        case 5: return "Grade V (Extreme Risk) • Conservative Management Preferred"
        default: return "Variable"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SPETZLER-MARTIN AVM CLASSIFICATION")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("Grade \(totalGrade)")
                            .font(.system(size: 34, weight: .black, design: .rounded))
                            .foregroundColor(totalGrade <= 2 ? Color.green : (totalGrade == 3 ? Color.orange : Color.red))
                    }
                }
                Spacer()
                Text(operativeRiskText)
                    .font(.system(size: 10, weight: .heavy))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(totalGrade <= 2 ? Color.green : (totalGrade == 3 ? Color.orange : Color.red))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background((totalGrade <= 2 ? Color.green : (totalGrade == 3 ? Color.orange : Color.red)).opacity(0.12))
                    .cornerRadius(8)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            VStack(spacing: 8) {
                ScoreSelector(title: "Nidus Size (Maximum Angiographic Dimension)", options: [
                    ("Small (< 3 cm) (1 pt)", 1),
                    ("Medium (3 - 6 cm) (2 pts)", 2),
                    ("Large (> 6 cm) (3 pts)", 3)
                ], selection: $size)
                
                ScoreSelector(title: "Eloquence of Adjacent Cortex", options: [
                    ("Non-eloquent area (0 pts)", 0),
                    ("Eloquent (Sensorimotor, Language, Visual, Thalamus, Brainstem) (1 pt)", 1)
                ], selection: $eloquence)
                
                ScoreSelector(title: "Pattern of Venous Drainage", options: [
                    ("Superficial cortical drainage only (0 pts)", 0),
                    ("Deep venous drainage (Internal cerebral, Basal vein, Straight sinus) (1 pt)", 1)
                ], selection: $drainage)
            }
        }
    }
}

// MARK: - 5. TLICS Calculator View
struct TLICSCalculatorView: View {
    @Binding var morphIndex: Int
    @Binding var plcIndex: Int
    @Binding var neuroIndex: Int
    let total: Int
    
    var recommendation: String {
        if total <= 3 { return "CONSERVATIVE (≤3 pts) • TLSO Brace / Early Mobilization" }
        if total == 4 { return "EQUIVOCAL (4 pts) • Surgeon Discretion (Brace vs Fusion)" }
        return "OPERATIVE MANDATE (≥5 pts) • Posterior / Anterior Stabilization"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("TLICS THORACOLUMBAR TRAUMA SCORE")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(total)")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundColor(total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green))
                        Text("POINTS")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                Spacer()
                Text(recommendation)
                    .font(.system(size: 10, weight: .heavy))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background((total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green)).opacity(0.12))
                    .cornerRadius(8)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            VStack(spacing: 8) {
                IndexedSelector(title: "1. Fracture Morphology", options: [
                    "No Abnormality (0 pts)",
                    "Compression (+1 pt)",
                    "Burst (+2 pts)",
                    "Translational / Rotational (+3 pts)",
                    "Distraction (+4 pts)"
                ], selection: $morphIndex)
                
                IndexedSelector(title: "2. Posterior Ligamentous Complex (PLC)", options: [
                    "Intact (0 pts)",
                    "Suspected / Indeterminate (+2 pts)",
                    "Disrupted (+3 pts)"
                ], selection: $plcIndex)
                
                IndexedSelector(title: "3. Neurologic Status", options: [
                    "Intact (0 pts)",
                    "Nerve Root Injury (+2 pts)",
                    "Complete Cord Injury (+2 pts)",
                    "Incomplete Cord Injury (+3 pts)",
                    "Cauda Equina Syndrome (+3 pts)"
                ], selection: $neuroIndex)
            }
        }
    }
}

// MARK: - 6. SLIC Calculator View
struct SLICCalculatorView: View {
    @Binding var morphIndex: Int
    @Binding var dlcIndex: Int
    @Binding var neuroIndex: Int
    @Binding var comp: Bool
    let total: Int
    
    var recommendation: String {
        if total <= 3 { return "NON-OPERATIVE (≤3 pts) • Rigid Miami J Collar" }
        if total == 4 { return "EQUIVOCAL (4 pts) • Conservative vs Surgical Decompression" }
        return "SURGICAL STABILIZATION (≥5 pts) • Emergent / Urgent Fixation"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SLIC SUBAXIAL CERVICAL SCORE (C3-C7)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(total)")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundColor(total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green))
                        Text("POINTS")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                Spacer()
                Text(recommendation)
                    .font(.system(size: 10, weight: .heavy))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background((total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green)).opacity(0.12))
                    .cornerRadius(8)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            VStack(spacing: 8) {
                IndexedSelector(title: "1. Fracture Morphology", options: [
                    "No Abnormality (0 pts)",
                    "Compression (+1 pt)",
                    "Burst (+2 pts)",
                    "Distraction / Facet Perched (+3 pts)",
                    "Rotation / Translation / Jumped Facets (+4 pts)"
                ], selection: $morphIndex)
                
                IndexedSelector(title: "2. Discoligamentous Complex (DLC)", options: [
                    "Intact (0 pts)",
                    "Indeterminate / Suspected (+1 pt)",
                    "Disrupted (+2 pts)"
                ], selection: $dlcIndex)
                
                IndexedSelector(title: "3. Neurologic Status", options: [
                    "Intact (0 pts)",
                    "Root Injury (+1 pt)",
                    "Complete Cord Injury (+2 pts)",
                    "Incomplete Cord Injury (+3 pts)"
                ], selection: $neuroIndex)
                
                ToggleRow(title: "Persistent Cord Compression (+1 pt)", subtitle: "Adds +1 modifier if incomplete or complete cord deficit with persistent spinal canal impingement", isOn: $comp)
            }
        }
    }
}

// MARK: - 7. SINS Calculator View
struct SINSCalculatorView: View {
    @Binding var location: Int
    @Binding var pain: Int
    @Binding var bone: Int
    @Binding var align: Int
    @Binding var collapse: Int
    @Binding var post: Int
    let total: Int
    let statusText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SPINAL INSTABILITY NEOPLASTIC SCORE (SINS)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(total)")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundColor(total >= 13 ? Color.red : (total >= 7 ? Color.orange : Color.green))
                        Text("/ 18 PTS")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                Spacer()
                Text(statusText)
                    .font(.system(size: 10, weight: .heavy))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(total >= 13 ? Color.red : (total >= 7 ? Color.orange : Color.green))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background((total >= 13 ? Color.red : (total >= 7 ? Color.orange : Color.green)).opacity(0.12))
                    .cornerRadius(8)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            VStack(spacing: 8) {
                ScoreSelector(title: "1. Spinal Location", options: [
                    ("Junctional (Occ-C2, C7-T1, T11-L1, L5-S1) (3 pts)", 3),
                    ("Mobile Spine (C3-C6, L2-L4) (2 pts)", 2),
                    ("Semi-rigid (T2-T10) (1 pt)", 1),
                    ("Rigid (S2-S5) (0 pts)", 0)
                ], selection: $location)
                
                ScoreSelector(title: "2. Mechanical Pain", options: [
                    ("Mechanical pain (worse with loading/movement) (3 pts)", 3),
                    ("True non-mechanical pain (1 pt)", 1),
                    ("Pain-free lesion (0 pts)", 0)
                ], selection: $pain)
                
                ScoreSelector(title: "3. Bone Lesion Quality", options: [
                    ("Lytic (2 pts)", 2),
                    ("Mixed Lytic / Blastic (1 pt)", 1),
                    ("Blastic only (0 pts)", 0)
                ], selection: $bone)
                
                ScoreSelector(title: "4. Radiographic Alignment", options: [
                    ("Subluxation / Translation present (4 pts)", 4),
                    ("De novo deformity (kyphosis / scoliosis) (2 pts)", 2),
                    ("Normal alignment (0 pts)", 0)
                ], selection: $align)
                
                ScoreSelector(title: "5. Vertebral Body Collapse", options: [
                    ("> 50% collapse (3 pts)", 3),
                    ("< 50% collapse (2 pts)", 2),
                    ("No collapse with >50% body involvement (1 pt)", 1),
                    ("None (<50% body involved) (0 pts)", 0)
                ], selection: $collapse)
                
                ScoreSelector(title: "6. Posterolateral Elements Involvement", options: [
                    ("Bilateral pedicle / facet involvement (3 pts)", 3),
                    ("Unilateral pedicle / facet involvement (1 pt)", 1),
                    ("None (0 pts)", 0)
                ], selection: $post)
            }
        }
    }
}

// MARK: - 8. Osmotherapy & Sodium Deficit View
struct OsmotherapyCalculatorView: View {
    @Binding var weight: Double
    @Binding var currentNa: Double
    @Binding var targetNa: Double
    @Binding var isFemale: Bool
    
    // Total Body Water (TBW) factor
    var tbwFactor: Double { isFemale ? 0.5 : 0.6 }
    
    // Sodium Deficit: TBW * (TargetNa - CurrentNa)
    var sodiumDeficitMeq: Double {
        let tbw = tbwFactor * weight
        return max(0, (targetNa - currentNa) * tbw)
    }
    
    // 3% NaCl volume (0.513 mEq Na per mL)
    var hts3VolumeMl: Double {
        sodiumDeficitMeq / 0.513
    }
    
    // 20% Mannitol bolus (0.5 - 1.0 g/kg = 2.5 - 5.0 mL/kg of 20% solution)
    var mannitolLowMl: Double { weight * 2.5 }
    var mannitolHighMl: Double { weight * 5.0 }
    var mannitolLowGrams: Double { weight * 0.5 }
    var mannitolHighGrams: Double { weight * 1.0 }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Deficit Calculation Summary
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("SODIUM DEFICIT & 3% HYPERTONIC SALINE")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(ObsidianTheme.neonCyan)
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text(String(format: "%.0f", sodiumDeficitMeq))
                                .font(.system(size: 36, weight: .black, design: .rounded))
                                .foregroundColor(ObsidianTheme.neonCyan)
                            Text("mEq Na⁺ Deficit")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(ObsidianTheme.textSecondary)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("3% NaCl VOLUME")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(Color.cyan)
                        Text(String(format: "%.0f mL", hts3VolumeMl))
                            .font(.system(size: 24, weight: .black, design: .rounded))
                            .foregroundColor(Color.cyan)
                    }
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            // Sliders & Gender Toggle
            VStack(spacing: 12) {
                ToggleRow(title: "Female Patient (TBW = 0.50 × Weight)", subtitle: "Male default is TBW = 0.60 × Weight", isOn: $isFemale)
                MetricSlider(label: "Patient Weight", value: $weight, range: 40...140, unit: "kg")
                MetricSlider(label: "Current Serum Sodium", value: $currentNa, range: 120...165, unit: "mEq/L")
                MetricSlider(label: "Target Serum Sodium", value: $targetNa, range: 135...160, unit: "mEq/L")
            }
            
            // 20% Mannitol Bolus Card
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "drop.triangle.fill")
                        .foregroundColor(Color.blue)
                    Text("20% MANNITOL DOSING (0.5 – 1.0 g/kg IV BOLUS)")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(Color.blue)
                }
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Low Dose (0.5 g/kg)")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(ObsidianTheme.textMuted)
                        Text(String(format: "%.0f g (%.0f mL)", mannitolLowGrams, mannitolLowMl))
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("High Dose (1.0 g/kg)")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(ObsidianTheme.textMuted)
                        Text(String(format: "%.0f g (%.0f mL)", mannitolHighGrams, mannitolHighMl))
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            
            // Osmotic Demyelination Warning
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(Color.yellow)
                    Text("OSMOTIC DEMYELINATION SYNDROME (ODS) WARNING")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(Color.yellow)
                }
                Text("Do not correct serum sodium faster than **8 to 10 mEq/L per 24 hours** (or 18 mEq/L in 48 hours). Rapid overcorrection in chronic hyponatremia triggers central pontine myelinolysis.")
                    .font(.system(size: 11))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding()
            .background(Color.yellow.opacity(0.06))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.yellow.opacity(0.3), lineWidth: 1))
        }
    }
}

// MARK: - Helper UI Components
struct CalcPill: View {
    let id: String
    let label: String
    let icon: String
    @Binding var selected: String
    
    var body: some View {
        Button(action: {
            HapticManager.impact(style: .light)
            selected = id
        }) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                Text(label)
            }
            .font(.system(size: 11, weight: .bold))
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(selected == id ? ObsidianTheme.neonCyan : ObsidianTheme.surfaceGlass)
            .foregroundColor(selected == id ? .black : ObsidianTheme.textSecondary)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selected == id ? ObsidianTheme.neonCyan : ObsidianTheme.borderSubtle, lineWidth: 1)
            )
        }
    }
}

struct MetricSlider: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Spacer()
                Text(String(format: "%.0f %@", value, unit))
                    .font(.system(size: 12, weight: .black, design: .monospaced))
                    .foregroundColor(ObsidianTheme.neonCyan)
            }
            Slider(value: $value, in: range, step: 1.0)
                .tint(ObsidianTheme.neonCyan)
        }
        .padding(10)
        .background(ObsidianTheme.surfaceGlass)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
}

struct ScoreSelector: View {
    let title: String
    let options: [(String, Int)]
    @Binding var selection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            
            Picker(title, selection: $selection) {
                ForEach(0..<options.count, id: \.self) { idx in
                    Text(options[idx].0).tag(options[idx].1)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(6)
            .background(Color(red: 0.08, green: 0.1, blue: 0.14))
            .cornerRadius(8)
        }
        .padding(8)
        .background(ObsidianTheme.surfaceGlass)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
}

struct IndexedSelector: View {
    let title: String
    let options: [String]
    @Binding var selection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            
            Picker(title, selection: $selection) {
                ForEach(0..<options.count, id: \.self) { idx in
                    Text(options[idx]).tag(idx)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(6)
            .background(Color(red: 0.08, green: 0.1, blue: 0.14))
            .cornerRadius(8)
        }
        .padding(8)
        .background(ObsidianTheme.surfaceGlass)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
}

struct ToggleRow: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Text(subtitle)
                    .font(.system(size: 10))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(ObsidianTheme.neonCyan)
        }
        .padding(10)
        .background(ObsidianTheme.surfaceGlass)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
    }
}

struct GradeBadge: View {
    let title: String
    let grade: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 8, weight: .black))
                .foregroundColor(color)
            Text(grade)
                .font(.system(size: 16, weight: .black, design: .rounded))
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(color.opacity(0.12))
        .cornerRadius(10)
    }
}

// MARK: - Medical Disclaimer Sheet
struct MedicalDisclaimerSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 8) {
                        Image(systemName: "cross.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(ObsidianTheme.neonCyan)
                        Text("Clinical Reference & Decision Support")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                    .padding(.top, 8)
                    
                    Text("NeuroCall provides rapid reference algorithms based on published clinical guidelines including the Brain Trauma Foundation (BTF 4th Edition), Hemphill ICH Score, Claassen Modified Fisher Criteria, and Subaxial Cervical / Thoracolumbar Injury Classification (SLIC / TLICS).")
                        .font(.system(size: 12))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    
                    Text("This application is intended strictly for licensed physicians, neurosurgery residents, and critical care professionals. It does not replace individualized clinical judgment, formal diagnostic radiological interpretation, or institutional emergency trauma protocols.")
                        .font(.system(size: 12))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    
                    Text("All osmotherapy dosages, hypertonic saline rates, and transfusion guidance must be verified against patient serum osmolarity, electrolyte panels, and renal status prior to administration.")
                        .font(.system(size: 12))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                .padding()
            }
            .background(ObsidianTheme.surfaceVoid)
            .navigationTitle("Medical Disclaimer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss") { dismiss() }
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
            }
        }
    }
}
