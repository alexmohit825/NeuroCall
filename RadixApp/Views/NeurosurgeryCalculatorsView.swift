import SwiftUI

// MARK: - Dedicated Neurosurgical Calculator Hub
// Synthesized from Brain Trauma Foundation (BTF) Guidelines, Kothari ABC/2 Volume Standards, and Ellenbogen Principles of Neurosurgery.
// Provides rapid, precise bedside calculations for intracranial volume, cerebral perfusion, acute hemorrhage grading,
// spinal trauma classification (TLICS / SLIC / SINS), AVM grading, and neurocritical hyperosmolar therapy.

public struct NeurosurgeryCalculatorsView: View {
    @State private var selectedCalculator = "snapspine"
    @Environment(\.requestReview) var requestReview
    @Environment(\.openURL) var openURL
    @State private var hasRated = false
    
    // ABC/2 State
    @State private var dimensionA: Double = 4.0 // cm
    @State private var dimensionB: Double = 3.0 // cm
    @State private var sliceCountC: Double = 6.0 // slices
    @State private var sliceThickness: Double = 0.5 // cm (5mm)
    
    // CPP State
    @State private var mapInput: Double = 85.0 // mmHg
    @State private var icpInput: Double = 18.0 // mmHg
    
    // ICH Score State
    @State private var ichGCS: Int = 1 // 0: 13-15, 1: 5-12, 2: 3-4
    @State private var ichVolumeOver30: Bool = true
    @State private var ichIVH: Bool = false
    @State private var ichInfratentorial: Bool = false
    @State private var ichAgeOver80: Bool = false
    
    // WFNS & Hunt-Hess & Fisher State
    @State private var gcsInput: Double = 14
    @State private var focalDeficit: Bool = false
    @State private var meningismusSeverity: Int = 1 // 1: Mild, 2: Moderate, 3: Severe
    @State private var fisherGrade: Int = 3 // 1: Thin, 2: Thin+IVH, 3: Thick, 4: Thick+IVH
    
    // Spetzler-Martin AVM State
    @State private var avmSize: Int = 1 // 1: <3cm, 2: 3-6cm, 3: >6cm
    @State private var avmEloquence: Int = 1 // 0: Non-eloquent, 1: Eloquent
    @State private var avmVenousDrainage: Int = 1 // 0: Superficial only, 1: Deep
    
    // TLICS State
    @State private var tlicsMorphology: Int = 2 // 1: Compression, 2: Burst, 3: Transl/Rot, 4: Distraction
    @State private var tlicsPLC: Int = 2 // 0: Intact, 2: Suspected/indeterminate, 3: Disrupted
    @State private var tlicsNeuro: Int = 0 // 0: Intact, 2: Root, 2: Complete cord, 3: Incomplete cord, 3: Cauda equina
    
    // SLIC State
    @State private var slicMorphology: Int = 1 // 0: None, 1: Compression, 2: Burst, 3: Distraction, 4: Rotation/Transl
    @State private var slicDLC: Int = 1 // 0: Intact, 1: Indeterminate, 2: Disrupted
    @State private var slicNeuro: Int = 0 // 0: Intact, 1: Root, 2: Complete, 3: Incomplete, +1 if cont compression
    @State private var slicPersistentCompression: Bool = false
    
    // SINS (Spine Instability Neoplastic Score)
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
    
    public init() {}
    
    // ABC/2 Calculation
    var abc2Volume: Double {
        let cDimension = sliceCountC * sliceThickness
        return (dimensionA * dimensionB * cDimension) / 2.0
    }
    
    // CPP Calculation
    var calculatedCPP: Double {
        return mapInput - icpInput
    }
    
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
        return avmSize + avmEloquence + avmVenousDrainage
    }
    
    // TLICS Total
    var totalTLICS: Int {
        return tlicsMorphology + tlicsPLC + tlicsNeuro
    }
    
    // SLIC Total
    var totalSLIC: Int {
        var score = slicMorphology + slicDLC + slicNeuro
        if slicPersistentCompression && (slicNeuro == 2 || slicNeuro == 3) {
            score += 1
        }
        return score
    }
    
    // SINS Score
    var totalSINS: Int {
        return sinsLocation + sinsPain + sinsBoneLesion + sinsAlignment + sinsCollapse + sinsPosterior
    }
    
    var sinsStabilityText: String {
        if totalSINS <= 6 { return "STABLE (0-6) • Conservative / Radiation" }
        if totalSINS <= 12 { return "POTENTIALLY UNSTABLE (7-12) • Surgical Consult" }
        return "UNSTABLE (13-18) • Emergent Surgical Stabilization Required"
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Circle().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 8)
                        Text("RESIDENT ON-CALL DECISION HUB")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.5)
                            .foregroundColor(ObsidianTheme.neonCyan)
                    }
                    Text("Neurosurgery Clinical Calculators")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Text("Bedside hematoma volume, perfusion targets, SAH & ICH grading, spinal trauma (TLICS/SLIC), and osmotherapy dosing.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Calculator Picker
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        CalcPill(id: "snapspine", label: "Snap-the-Spine", icon: "camera.viewfinder", selected: $selectedCalculator)
                        CalcPill(id: "calipers", label: "Bedside Calipers", icon: "ruler.fill", selected: $selectedCalculator)
                        CalcPill(id: "icpladder", label: "BTF ICP Ladder", icon: "ladder", selected: $selectedCalculator)
                        CalcPill(id: "reversal", label: "Reversal Engine", icon: "cross.vial.fill", selected: $selectedCalculator)
                        CalcPill(id: "abc2", label: "ABC/2 Volume", icon: "cube.fill", selected: $selectedCalculator)
                        CalcPill(id: "cpp", label: "CPP & ICP Targets", icon: "waveform.path.ecg", selected: $selectedCalculator)
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
                
                // Active Calculator View
                Group {
                    switch selectedCalculator {
                    case "snapspine":
                        SnapTheSpineAlignmentView()
                    case "calipers":
                        RadiologicCaliperEngineView(
                            imageName: "plate_ct_edh",
                            emergencyTitle: "Bedside Radiologic Calipers"
                        )
                    case "icpladder":
                        TieredICPLadderView()
                    case "reversal":
                        EmergencyReversalEngineView()
                    case "abc2":
                        ABC2CalculatorView(
                            dimA: $dimensionA,
                            dimB: $dimensionB,
                            slices: $sliceCountC,
                            thickness: $sliceThickness,
                            volume: abc2Volume
                        )
                    case "cpp":
                        CPPCalculatorView(
                            map: $mapInput,
                            icp: $icpInput,
                            cpp: calculatedCPP
                        )
                    case "ich":
                        ICHScoreCalculatorView(
                            gcs: $ichGCS,
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
                            meningismus: $meningismusSeverity,
                            fisher: $fisherGrade
                        )
                    case "avm":
                        SpetzlerMartinCalculatorView(
                            size: $avmSize,
                            eloquence: $avmEloquence,
                            venous: $avmVenousDrainage,
                            totalGrade: spetzlerMartinGrade
                        )
                    case "tlics":
                        TLICSCalculatorView(
                            morph: $tlicsMorphology,
                            plc: $tlicsPLC,
                            neuro: $tlicsNeuro,
                            total: totalTLICS
                        )
                    case "slic":
                        SLICCalculatorView(
                            morph: $slicMorphology,
                            dlc: $slicDLC,
                            neuro: $slicNeuro,
                            comp: $slicPersistentCompression,
                            total: totalSLIC
                        )
                    case "sins":
                        SINSCalculatorView(
                            loc: $sinsLocation,
                            pain: $sinsPain,
                            bone: $sinsBoneLesion,
                            align: $sinsAlignment,
                            collapse: $sinsCollapse,
                            post: $sinsPosterior,
                            total: totalSINS,
                            verdict: sinsStabilityText
                        )
                    case "osmo":
                        OsmotherapyCalculatorView(
                            weight: $patientWeightKg,
                            currentNa: $currentSodium,
                            targetNa: $targetSodium
                        )
                    default:
                        ABC2CalculatorView(
                            dimA: $dimensionA,
                            dimB: $dimensionB,
                            slices: $sliceCountC,
                            thickness: $sliceThickness,
                            volume: abc2Volume
                        )
                    }
                }
                .padding(.horizontal)
                
                // Persistent Un-Gated In-App Rating Banner Card
                DashboardRatingBannerCard()
                    .padding(.horizontal)
                    .padding(.top, 8)
            }
            .padding(.bottom, 28)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}

// MARK: - ABC/2 Hematoma Volume View
struct ABC2CalculatorView: View {
    @Binding var dimA: Double
    @Binding var dimB: Double
    @Binding var slices: Double
    @Binding var thickness: Double
    let volume: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Volume Output Display
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("ESTIMATED HEMATOMA VOLUME (KWAK ET AL.)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.indigo)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(String(format: "%.1f", volume))
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .foregroundColor(volume >= 30 ? .red : Color(red: 0.1, green: 0.12, blue: 0.18))
                        Text("mL / cm³")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                // Surgical Imperative Badge
                VStack(alignment: .trailing, spacing: 4) {
                    if volume >= 30 {
                        Text("SURGICAL THRESHOLD: ≥ 30 cc")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.red)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red.opacity(0.12))
                            .cornerRadius(6)
                    } else {
                        Text("SUB-CRITICAL (< 30 cc)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.12))
                            .cornerRadius(6)
                    }
                }
            }
            .padding()
            .background(Color(red: 0.94, green: 0.95, blue: 0.98))
            .cornerRadius(14)
            
            // Formula Explanation
            Text("V = (A × B × C) / 2 • Where A = largest diameter, B = largest perpendicular diameter, C = number of CT slices displaying hemorrhage multiplied by slice thickness.")
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(.secondary)
                .lineSpacing(2)
            
            // Sliders
            VStack(spacing: 12) {
                MetricSlider(label: "Dimension A (Max Diameter)", value: $dimA, range: 0.5...12.0, unit: "cm")
                MetricSlider(label: "Dimension B (Perpendicular Diameter)", value: $dimB, range: 0.5...12.0, unit: "cm")
                MetricSlider(label: "CT Slices with Hematoma (Count C)", value: $slices, range: 1.0...25.0, unit: "slices")
                MetricSlider(label: "Slice Thickness", value: $thickness, range: 0.1...1.0, unit: "cm")
            }
            
            // Clinical Rule Pearl
            HStack(spacing: 8) {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 14))
                Text("ABC/2 Slice Counting Rule (Kothari et al.): Slices displaying >75% hematoma area count as 1.0; 25-75% count as 0.5; <25% are excluded.")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.4))
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.orange.opacity(0.08))
            .cornerRadius(8)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - CPP & ICP Targets View
struct CPPCalculatorView: View {
    @Binding var map: Double
    @Binding var icp: Double
    let cpp: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("CEREBRAL PERFUSION PRESSURE (CPP = MAP - ICP)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.indigo)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(String(format: "%.0f", cpp))
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .foregroundColor((cpp < 60 || cpp > 70) ? (cpp < 60 ? .red : .orange) : .green)
                        Text("mmHg")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    if cpp < 60 {
                        Text("ISCHEMIC THRESHOLD (< 60)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.red)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red.opacity(0.12))
                            .cornerRadius(6)
                    } else if cpp <= 70 {
                        Text("OPTIMAL TARGET (60 - 70)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.12))
                            .cornerRadius(6)
                    } else {
                        Text("HYPERPERFUSION (> 70 ARDS RISK)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.orange)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.orange.opacity(0.12))
                            .cornerRadius(6)
                    }
                }
            }
            .padding()
            .background(Color(red: 0.94, green: 0.95, blue: 0.98))
            .cornerRadius(14)
            
            VStack(spacing: 12) {
                MetricSlider(label: "Mean Arterial Pressure (MAP)", value: $map, range: 40.0...160.0, unit: "mmHg")
                MetricSlider(label: "Intracranial Pressure (ICP)", value: $icp, range: 0.0...50.0, unit: "mmHg")
            }
            
            // Brain Trauma Foundation 4th Ed Targets
            VStack(alignment: .leading, spacing: 6) {
                Text("BRAIN TRAUMA FOUNDATION TARGET CRITERIA:")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                
                HStack {
                    Text("• Target ICP:")
                    Spacer()
                    Text("< 22 mmHg (Initiate tier 1-3 therapy if >22)").bold()
                }
                .font(.system(size: 11))
                
                HStack {
                    Text("• Target CPP:")
                    Spacer()
                    Text("60 - 70 mmHg (Avoid aggressive push >70)").bold()
                }
                .font(.system(size: 11))
                
                HStack {
                    Text("• Transducer Zero Reference:")
                    Spacer()
                    Text("External Auditory Meatus / Tragus (Foramen of Monro)").bold()
                }
                .font(.system(size: 11))
            }
            .padding(12)
            .background(Color(red: 0.98, green: 0.98, blue: 0.99))
            .cornerRadius(10)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - ICH Score Calculator View (Hemphill et al.)
struct ICHScoreCalculatorView: View {
    @Binding var gcs: Int // 0: 13-15, 1: 5-12, 2: 3-4
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
                    Text("ICH SCORE (HEMPHILL ET AL.)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.red)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(totalScore)")
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .foregroundColor(totalScore >= 3 ? .red : (totalScore >= 2 ? .orange : .green))
                        Text("/ 6 POINTS")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(mortalityText)
                        .font(.system(size: 11, weight: .heavy))
                        .foregroundColor(totalScore >= 3 ? .red : .primary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(totalScore >= 3 ? 0.15 : 0.06))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(red: 0.98, green: 0.94, blue: 0.94))
            .cornerRadius(14)
            
            // Factors
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Glasgow Coma Scale (GCS):")
                        .font(.system(size: 12, weight: .bold))
                    Picker("GCS", selection: $gcs) {
                        Text("GCS 13 - 15 (0 pts)").tag(0)
                        Text("GCS 5 - 12 (1 pt)").tag(1)
                        Text("GCS 3 - 4 (2 pts)").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
                
                Toggle(isOn: $volOver30) {
                    VStack(alignment: .leading) {
                        Text("ICH Volume ≥ 30 cm³ (+1 pt)")
                            .font(.system(size: 12, weight: .bold))
                        Text("Calculated via ABC/2 method on initial CT")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
                .tint(.red)
                
                Toggle(isOn: $ivh) {
                    VStack(alignment: .leading) {
                        Text("Intraventricular Hemorrhage (IVH) Present (+1 pt)")
                            .font(.system(size: 12, weight: .bold))
                        Text("Blood present in lateral, third, or fourth ventricle")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
                .tint(.red)
                
                Toggle(isOn: $infra) {
                    VStack(alignment: .leading) {
                        Text("Infratentorial Origin (+1 pt)")
                            .font(.system(size: 12, weight: .bold))
                        Text("Brainstem or cerebellar hematoma")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
                .tint(.red)
                
                Toggle(isOn: $ageOver80) {
                    VStack(alignment: .leading) {
                        Text("Age ≥ 80 Years (+1 pt)")
                            .font(.system(size: 12, weight: .bold))
                    }
                }
                .tint(.red)
            }
            
            // STICH II Pearl
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundColor(.blue)
                Text("STICH II Criteria: Superficial lobar hematoma (within 1 cm of cortex) without IVH presenting with GCS 9-12 benefits from surgical evacuation.")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
            }
            .padding(10)
            .background(Color.blue.opacity(0.08))
            .cornerRadius(8)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - SAH / Fisher / WFNS View
struct SAHGradeCalculatorView: View {
    @Binding var gcs: Double
    @Binding var deficit: Bool
    @Binding var meningismus: Int
    @Binding var fisher: Int
    
    var wfnsGrade: Int {
        let g = Int(gcs)
        if g == 15 { return 1 }
        if g >= 13 { return deficit ? 3 : 2 }
        if g >= 7 { return 4 }
        return 5
    }
    
    var huntHessGrade: Int {
        let g = Int(gcs)
        if g == 15 {
            return meningismus <= 1 ? 1 : 2
        } else if g >= 13 {
            return 3
        } else if g >= 7 {
            return 4
        } else {
            return 5
        }
    }
    
    var vasospasmRisk: String {
        switch fisher {
        case 1: return "Grade 1: Minimal / Focal Subarachnoid Blood (Low Risk ~20%)"
        case 2: return "Grade 2: Diffuse Thin SAH <1mm, No IVH (Moderate Risk ~25%)"
        case 3: return "Grade 3: Dense Thick Clot >1mm, High Vasospasm Risk (~35-40%)"
        case 4: return "Grade 4: Intraventricular / Parenchymal Blood with Thick SAH (Highest Risk ~45%)"
        default: return "Variable"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("WFNS GRADE")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(.indigo)
                    Text("Grade \(wfnsGrade)")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.indigo)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.indigo.opacity(0.08))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("HUNT & HESS")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(.purple)
                    Text("Grade \(huntHessGrade)")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.purple)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.purple.opacity(0.08))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("MODIFIED FISHER")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(.red)
                    Text("Grade \(fisher)")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.red.opacity(0.08))
                .cornerRadius(12)
            }
            
            // Vasospasm Risk Text
            Text(vasospasmRisk)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(fisher >= 3 ? .red : .primary)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(fisher >= 3 ? Color.red.opacity(0.1) : Color(red: 0.95, green: 0.96, blue: 0.98))
                .cornerRadius(10)
            
            // Sliders & Selectors
            VStack(spacing: 12) {
                MetricSlider(label: "Patient GCS", value: $gcs, range: 3.0...15.0, unit: "")
                
                Toggle("Major Focal Neurological Deficit (Hemiparesis / Aphasia)", isOn: $deficit)
                    .font(.system(size: 12, weight: .bold))
                    .tint(.indigo)
                
                ScoreSelector(title: "Meningismus / Headache Severity", options: [
                    ("Asymptomatic / Mild Headache (H&H 1)", 1),
                    ("Severe Headache / Nuchal Rigidity (H&H 2)", 2),
                    ("Drowsy / Stuporous / Mild Deficit (H&H 3)", 3)
                ], selection: $meningismus)
                
                ScoreSelector(title: "Modified Fisher CT Clot Appearance", options: [
                    ("Focal / Minimal Subarachnoid Clot", 1),
                    ("Thin Diffuse SAH (<1mm) without IVH", 2),
                    ("Thick Focal SAH (≥1mm) without IVH", 3),
                    ("Thick SAH with Bilateral IVH / Clot", 4)
                ], selection: $fisher)
            }
            
            // Triple-H / Nimodipine Pearl
            HStack(spacing: 8) {
                Image(systemName: "pills.fill")
                    .foregroundColor(.teal)
                Text("Management Pearl: Start Nimodipine 60 mg PO q4h immediately. Maintain euvolemia (avoid hypervolemic hemodilution). Induced hypertension (MAP >100) if vasospasm develops.")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(red: 0.1, green: 0.35, blue: 0.35))
            }
            .padding(10)
            .background(Color.teal.opacity(0.08))
            .cornerRadius(8)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - Spetzler-Martin AVM Calculator View
struct SpetzlerMartinCalculatorView: View {
    @Binding var size: Int
    @Binding var eloquence: Int
    @Binding var venous: Int
    let totalGrade: Int
    
    var operativeRiskText: String {
        switch totalGrade {
        case 1, 2: return "LOW SURGICAL RISK • Microneurosurgical resection standard"
        case 3: return "INTERMEDIATE RISK • Multimodal (Embolization + Microsurgery + Radiosurgery)"
        case 4, 5: return "HIGH OPERATIVE RISK • Non-operative / Radiosurgery / Embolization for high-risk rupture features"
        default: return "Grade VI represents inoperable / diffuse AVM"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SPETZLER-MARTIN AVM GRADE")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.indigo)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("Grade \(totalGrade)")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundColor(totalGrade >= 4 ? .red : (totalGrade == 3 ? .orange : .green))
                        Text("/ V")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(totalGrade >= 4 ? "HIGH MORBIDITY" : (totalGrade == 3 ? "MODERATE" : "SURGICAL CANDIDATE"))
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(totalGrade >= 4 ? .red : (totalGrade == 3 ? .orange : .green))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background((totalGrade >= 4 ? Color.red : (totalGrade == 3 ? Color.orange : Color.green)).opacity(0.12))
                        .cornerRadius(6)
                }
            }
            .padding()
            .background(Color(red: 0.94, green: 0.95, blue: 0.98))
            .cornerRadius(14)
            
            Text(operativeRiskText)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                ScoreSelector(title: "Nidus Size (Maximum Diameter)", options: [
                    ("Small (< 3 cm)", 1),
                    ("Medium (3 - 6 cm)", 2),
                    ("Large (> 6 cm)", 3)
                ], selection: $size)
                
                ScoreSelector(title: "Eloquence of Adjacent Brain", options: [
                    ("Non-eloquent cortex", 0),
                    ("Eloquent (Sensorimotor, Language, Visual, Thalamus/Hypothalamus, Brainstem)", 1)
                ], selection: $eloquence)
                
                ScoreSelector(title: "Venous Drainage Pattern", options: [
                    ("Superficial cortical veins only", 0),
                    ("Deep venous drainage (Internal cerebral, basal vein, straight sinus)", 1)
                ], selection: $venous)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - TLICS Thoracolumbar Spine Trauma View
struct TLICSCalculatorView: View {
    @Binding var morph: Int
    @Binding var plc: Int
    @Binding var neuro: Int
    let total: Int
    
    var recommendation: String {
        if total <= 3 { return "CONSERVATIVE (≤3 pts) • TLSO Brace / Early Mobilization" }
        if total == 4 { return "INDETERMINATE (4 pts) • Surgeon Discretion (Brace vs Fusion)" }
        return "OPERATIVE MANDATE (≥5 pts) • Posterior / Anterior Stabilization"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("TLICS SCORE (VACCARO ET AL.)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.indigo)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(total)")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundColor(total >= 5 ? .red : (total == 4 ? .orange : .green))
                        Text("POINTS")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(recommendation)
                        .font(.system(size: 11, weight: .heavy))
                        .foregroundColor(total >= 5 ? .red : (total == 4 ? .orange : .green))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background((total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green)).opacity(0.12))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(red: 0.94, green: 0.95, blue: 0.98))
            .cornerRadius(14)
            
            VStack(spacing: 12) {
                ScoreSelector(title: "1. Injury Morphology", options: [
                    ("No abnormality (0)", 0),
                    ("Compression (1)", 1),
                    ("Burst (+1 extra -> 2 total)", 2),
                    ("Translational / Rotational (3)", 3),
                    ("Distraction (4)", 4)
                ], selection: $morph)
                
                ScoreSelector(title: "2. Posterior Ligamentous Complex (PLC)", options: [
                    ("Intact (0)", 0),
                    ("Suspected / Indeterminate (2)", 2),
                    ("Injured / Disrupted (3)", 3)
                ], selection: $plc)
                
                ScoreSelector(title: "3. Neurological Status", options: [
                    ("Intact (0)", 0),
                    ("Nerve Root Injury (2)", 2),
                    ("Complete Cord / Conus Injury (2)", 2),
                    ("Incomplete Cord Injury (3)", 3),
                    ("Cauda Equina Syndrome (3)", 3)
                ], selection: $neuro)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - SLIC Subaxial Cervical Spine Trauma View
struct SLICCalculatorView: View {
    @Binding var morph: Int
    @Binding var dlc: Int
    @Binding var neuro: Int
    @Binding var comp: Bool
    let total: Int
    
    var recommendation: String {
        if total <= 3 { return "NON-OPERATIVE (≤3 pts) • Rigid Collar (Miami J) / Inpatient Observation" }
        if total == 4 { return "EQUIVOCAL (4 pts) • Conservative vs Surgical Decompression" }
        return "SURGICAL STABILIZATION (≥5 pts) • Emergent / Urgent Fixation"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SLIC CERVICAL TRAUMA SCORE (C3-C7)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.indigo)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(total)")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundColor(total >= 5 ? .red : (total == 4 ? .orange : .green))
                        Text("POINTS")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(recommendation)
                        .font(.system(size: 11, weight: .heavy))
                        .foregroundColor(total >= 5 ? .red : (total == 4 ? .orange : .green))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background((total >= 5 ? Color.red : (total == 4 ? Color.orange : Color.green)).opacity(0.12))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(red: 0.94, green: 0.95, blue: 0.98))
            .cornerRadius(14)
            
            VStack(spacing: 12) {
                ScoreSelector(title: "1. Fracture Morphology", options: [
                    ("No abnormality (0)", 0),
                    ("Compression (1)", 1),
                    ("Burst (2)", 2),
                    ("Distraction / Facet perched (3)", 3),
                    ("Rotation / Translation / Unilateral facet jump (4)", 4)
                ], selection: $morph)
                
                ScoreSelector(title: "2. Discoligamentous Complex (DLC)", options: [
                    ("Intact (0)", 0),
                    ("Indeterminate / Widened interspinous space (1)", 1),
                    ("Disrupted / Kyphosis >11° / Facet dislocation (2)", 2)
                ], selection: $dlc)
                
                ScoreSelector(title: "3. Neurological Status", options: [
                    ("Intact (0)", 0),
                    ("Root injury only (1)", 1),
                    ("Complete spinal cord injury (2)", 2),
                    ("Incomplete spinal cord injury (3)", 3)
                ], selection: $neuro)
                
                Toggle("Continuous spinal cord compression in setting of neuro deficit (+1 pt)", isOn: $comp)
                    .font(.system(size: 12, weight: .bold))
                    .tint(.indigo)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - SINS Spine Instability Neoplastic Score View
struct SINSCalculatorView: View {
    @Binding var loc: Int
    @Binding var pain: Int
    @Binding var bone: Int
    @Binding var align: Int
    @Binding var collapse: Int
    @Binding var post: Int
    let total: Int
    let verdict: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("SPINE INSTABILITY NEOPLASTIC SCORE (SINS)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.indigo)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(total)")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundColor(total >= 13 ? .red : (total >= 7 ? .orange : .green))
                        Text("/ 18")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(verdict)
                        .font(.system(size: 10, weight: .heavy))
                        .foregroundColor(total >= 13 ? .red : (total >= 7 ? .orange : .green))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background((total >= 13 ? Color.red : (total >= 7 ? Color.orange : Color.green)).opacity(0.12))
                        .cornerRadius(6)
                }
            }
            .padding()
            .background(Color(red: 0.94, green: 0.95, blue: 0.98))
            .cornerRadius(14)
            
            VStack(spacing: 12) {
                ScoreSelector(title: "Location in Spine", options: [
                    ("Junctional (Occiput-C2, C7-T2, T11-L1, L5-S1)", 3),
                    ("Mobile Spine (C3-C6, L2-L4)", 2),
                    ("Semirigid (T3-T10)", 1),
                    ("Rigid (S2-S5)", 0)
                ], selection: $loc)
                
                ScoreSelector(title: "Mechanical Pain Quality", options: [
                    ("Mechanical / Movement-related Pain", 3),
                    ("Non-mechanical / Purely nocturnal", 1),
                    ("Pain-free", 0)
                ], selection: $pain)
                
                ScoreSelector(title: "Bone Lesion Quality", options: [
                    ("Lytic", 2),
                    ("Mixed", 1),
                    ("Blastic", 0)
                ], selection: $bone)
                
                ScoreSelector(title: "Spinal Alignment", options: [
                    ("Subluxation / Translation", 4),
                    ("De novo Deformity (Kyphosis/Scoliosis)", 2),
                    ("Normal", 0)
                ], selection: $align)
                
                ScoreSelector(title: "Vertebral Body Collapse", options: [
                    ("> 50% Collapse", 3),
                    ("< 50% Collapse", 2),
                    ("No collapse (>50% body involved)", 1),
                    ("None", 0)
                ], selection: $collapse)
                
                ScoreSelector(title: "Posterior Element Involvement", options: [
                    ("Bilateral", 3),
                    ("Unilateral", 1),
                    ("None", 0)
                ], selection: $post)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - Osmotherapy & Sodium Dosing View
struct OsmotherapyCalculatorView: View {
    @Binding var weight: Double
    @Binding var currentNa: Double
    @Binding var targetNa: Double
    
    // Mannitol bolus 0.5 - 1.0 g/kg
    var mannitolLowDose: Double { weight * 0.5 }
    var mannitolHighDose: Double { weight * 1.0 }
    
    // 3% Hypertonic Saline bolus: 250 mL or (targetNa - currentNa) * (0.6 * weight)
    var sodiumDeficitMeq: Double {
        let tbw = 0.6 * weight
        return max(0, (targetNa - currentNa) * tbw)
    }
    
    var hts3VolumeMl: Double {
        // 3% NaCl contains 513 mEq Na per Liter -> ~0.513 mEq/mL
        return sodiumDeficitMeq / 0.513
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("NEUROCRITICAL HYPEROSMOLAR THERAPY")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.teal)
                Text("Mannitol & 3% Hypertonic Saline (HTS) Dosing")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                Text("Calculated for rapid intracranial pressure (ICP) de-escalation in impending herniation.")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.teal.opacity(0.08))
            .cornerRadius(14)
            
            // Weight & Sodium sliders
            VStack(spacing: 12) {
                MetricSlider(label: "Patient Weight", value: $weight, range: 40.0...140.0, unit: "kg")
                MetricSlider(label: "Current Serum Sodium", value: $currentNa, range: 120.0...165.0, unit: "mEq/L")
                MetricSlider(label: "Target Serum Sodium", value: $targetNa, range: 140.0...160.0, unit: "mEq/L")
            }
            
            // Mannitol Dosing Card
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "drop.triangle.fill")
                        .foregroundColor(.blue)
                    Text("20% MANNITOL DOSING (0.5 – 1.0 g/kg IV BOLUS)")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(.blue)
                }
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading) {
                        Text("Initial Bolus Range:")
                            .font(.system(size: 11, weight: .semibold))
                        Text("\(String(format: "%.0f", mannitolLowDose)) – \(String(format: "%.0f", mannitolHighDose)) grams")
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("20% Volume Equivalent:")
                            .font(.system(size: 11, weight: .semibold))
                        Text("\(String(format: "%.0f", mannitolLowDose * 5)) – \(String(format: "%.0f", mannitolHighDose * 5)) mL")
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(.blue)
                    }
                }
                
                Text("Infuse over 15-30 min. Hold if serum osmolality >320 mOsm/kg or osmolar gap >20.")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.secondary)
            }
            .padding(12)
            .background(Color.blue.opacity(0.06))
            .cornerRadius(12)
            
            // 3% HTS Dosing Card
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "cross.vial.fill")
                        .foregroundColor(.purple)
                    Text("3% HYPERTONIC SALINE (HTS) PROTOCOL")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(.purple)
                }
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading) {
                        Text("Crisis Bolus Dose:")
                            .font(.system(size: 11, weight: .semibold))
                        Text("250 mL IV over 15 min")
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(.purple)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Continuous Infusion:")
                            .font(.system(size: 11, weight: .semibold))
                        Text("0.5 – 1.5 mL/kg/hr")
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(.purple)
                    }
                }
                
                Text("Safety Cap: Serum Na target 145-155 mEq/L. Never elevate serum Na faster than 8-10 mEq/L per 24 hours to prevent central pontine myelinolysis.")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.secondary)
            }
            .padding(12)
            .background(Color.purple.opacity(0.06))
            .cornerRadius(12)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - Reusable UI Helper Components
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
                    .font(.system(size: 12, weight: .bold))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background(selected == id ? Color.indigo : Color.white)
            .foregroundColor(selected == id ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selected == id ? Color.indigo : Color.black.opacity(0.06), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.03), radius: 3)
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
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                Spacer()
                Text("\(String(format: "%.1f", value)) \(unit)")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(.indigo)
            }
            Slider(value: $value, in: range, step: 0.5)
                .tint(.indigo)
        }
        .padding(10)
        .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        .cornerRadius(10)
    }
}

struct ScoreSelector: View {
    let title: String
    let options: [(String, Int)]
    @Binding var selection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(red: 0.15, green: 0.2, blue: 0.28))
            
            Picker(title, selection: $selection) {
                ForEach(options, id: \.1) { opt in
                    Text("\(opt.0) (+\(opt.1))").tag(opt.1)
                }
            }
            .pickerStyle(.menu)
            .padding(6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.96, green: 0.97, blue: 0.99))
            .cornerRadius(8)
        }
    }
}
