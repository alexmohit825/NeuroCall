import SwiftUI

// MARK: - Dedicated Neurosurgical Calculator Hub
public struct NeurosurgeryCalculatorsView: View {
    @State private var selectedCalculator = "abc2"
    
    // ABC/2 State
    @State private var dimensionA: Double = 4.0 // cm
    @State private var dimensionB: Double = 3.0 // cm
    @State private var sliceCountC: Double = 6.0 // slices
    @State private var sliceThickness: Double = 0.5 // cm (5mm)
    
    // CPP State
    @State private var mapInput: Double = 85.0 // mmHg
    @State private var icpInput: Double = 18.0 // mmHg
    
    // WFNS & Hunt-Hess
    @State private var gcsInput: Double = 14
    @State private var focalDeficit: Bool = false
    @State private var meningismusSeverity: Int = 1 // 1: Mild, 2: Moderate, 3: Severe
    
    // SINS (Spine Instability Neoplastic Score)
    @State private var sinsLocation: Int = 3 // 1-3
    @State private var sinsPain: Int = 3 // 1-3
    @State private var sinsBoneLesion: Int = 2 // 1-2
    @State private var sinsAlignment: Int = 2 // 0-4
    @State private var sinsCollapse: Int = 2 // 0-3
    @State private var sinsPosterior: Int = 1 // 0-3
    
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
                    Text("DECISION SUPPORT HUB")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.indigo)
                    Text("Neurosurgery Calculators")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Text("Instant bedside calculation of hematoma volume, CPP, SINS stability, and hemorrhage grading.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Calculator Picker
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        CalcPill(id: "abc2", label: "ABC/2 Volume", icon: "cube.fill", selected: $selectedCalculator)
                        CalcPill(id: "cpp", label: "CPP (MAP - ICP)", icon: "waveform.path.ecg", selected: $selectedCalculator)
                        CalcPill(id: "sah", label: "WFNS / Hunt-Hess", icon: "brain.head.profile", selected: $selectedCalculator)
                        CalcPill(id: "sins", label: "SINS Spine Score", icon: "figure.walk", selected: $selectedCalculator)
                    }
                    .padding(.horizontal)
                }
                
                // Active Calculator View
                Group {
                    if selectedCalculator == "abc2" {
                        ABC2CalculatorView(
                            dimA: $dimensionA,
                            dimB: $dimensionB,
                            slices: $sliceCountC,
                            thickness: $sliceThickness,
                            volume: abc2Volume
                        )
                    } else if selectedCalculator == "cpp" {
                        CPPCalculatorView(
                            map: $mapInput,
                            icp: $icpInput,
                            cpp: calculatedCPP
                        )
                    } else if selectedCalculator == "sah" {
                        SAHGradeCalculatorView(
                            gcs: $gcsInput,
                            deficit: $focalDeficit,
                            meningismus: $meningismusSeverity
                        )
                    } else {
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
                    }
                }
                .padding(.horizontal)
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
                    Text("ESTIMATED HEMATOMA VOLUME")
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
                        Text("CRITICAL: ≥ 30 cc")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.red)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(Color.red.opacity(0.12)))
                        Text("Surgical Evacuation Indicated")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.red)
                    } else {
                        Text("NON-CRITICAL (< 30 cc)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(Color.green.opacity(0.12)))
                        Text("ICU Monitoring / Medical Rx")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color(red: 0.95, green: 0.96, blue: 0.99))
            .cornerRadius(16)
            
            // Slider Inputs
            VStack(spacing: 12) {
                MetricSlider(label: "Dimension A (Max Diameter on Slice)", value: $dimA, range: 0.5...10.0, unit: "cm")
                MetricSlider(label: "Dimension B (Perpendicular Diameter)", value: $dimB, range: 0.5...10.0, unit: "cm")
                MetricSlider(label: "Number of CT Slices with Blood (C)", value: $slices, range: 1...20, unit: "slices")
                MetricSlider(label: "CT Slice Thickness (Usually 0.5 cm)", value: $thickness, range: 0.1...1.0, unit: "cm")
            }
            
            // Formula Annotation
            HStack(spacing: 8) {
                Image(systemName: "function")
                    .foregroundColor(.indigo)
                Text("Formula: Volume = (A × B × C × Slice Thickness) / 2. Slices with 25-75% clot count as 0.5; >75% count as 1.0.")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(red: 0.3, green: 0.35, blue: 0.45))
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.indigo.opacity(0.06)))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - CPP Calculator View
struct CPPCalculatorView: View {
    @Binding var map: Double
    @Binding var icp: Double
    let cpp: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("CEREBRAL PERFUSION PRESSURE")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.teal)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(String(format: "%.0f", cpp))
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .foregroundColor(cpp < 60 ? .red : (cpp > 70 ? .green : .orange))
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
                            .background(Capsule().fill(Color.red.opacity(0.12)))
                        Text("Risk of Secondary Ischemia")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.red)
                    } else if cpp >= 60 && cpp <= 70 {
                        Text("TARGET GOAL (60-70)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(Color.green.opacity(0.12)))
                        Text("Optimal Perfusion")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.green)
                    } else {
                        Text("HYPERPERFUSION (> 70)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.orange)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(Color.orange.opacity(0.12)))
                        Text("Risk of ARDS / Vasogenic Edema")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color(red: 0.95, green: 0.98, blue: 0.98))
            .cornerRadius(16)
            
            VStack(spacing: 12) {
                MetricSlider(label: "Mean Arterial Pressure (MAP)", value: $map, range: 40...160, unit: "mmHg")
                MetricSlider(label: "Intracranial Pressure (ICP)", value: $icp, range: 0...60, unit: "mmHg")
            }
            
            // Clinical Rule
            Text("BTF Guideline Goal: Maintain CPP between 60 to 70 mmHg. Avoid aggressive vasopressor titration beyond 70 mmHg due to acute lung injury (ARDS) risk.")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color(red: 0.3, green: 0.35, blue: 0.45))
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.teal.opacity(0.08)))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - SAH Grading Calculator View
struct SAHGradeCalculatorView: View {
    @Binding var gcs: Double
    @Binding var deficit: Bool
    @Binding var meningismus: Int
    
    var wfnsGrade: String {
        if gcs == 15 && !deficit { return "Grade I (GCS 15, No Deficit)" }
        if gcs >= 13 && gcs <= 14 && !deficit { return "Grade II (GCS 13-14, No Deficit)" }
        if gcs >= 13 && gcs <= 14 && deficit { return "Grade III (GCS 13-14, Major Deficit)" }
        if gcs >= 7 && gcs <= 12 { return "Grade IV (GCS 7-12, ± Deficit)" }
        return "Grade V (GCS 3-6, Comatose / Posturing)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("WFNS SUBARACHNOID HEMORRHAGE SCORE")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.purple)
                Text(wfnsGrade)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.purple.opacity(0.08))
            .cornerRadius(16)
            
            VStack(spacing: 12) {
                MetricSlider(label: "Glasgow Coma Scale (GCS)", value: $gcs, range: 3...15, unit: "pts")
                
                Toggle(isOn: $deficit) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Major Focal Neurological Deficit")
                            .font(.system(size: 13, weight: .bold))
                        Text("Hemiparesis, severe aphasia (excludes CN III/VI palsy)")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }
                .tint(.purple)
            }
            
            Divider()
            
            // Hunt and Hess Reference
            VStack(alignment: .leading, spacing: 6) {
                Text("HUNT & HESS REFERENCE SCALE:")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.secondary)
                Text("• Grade 1: Asymptomatic or minimal headache and slight nuchal rigidity")
                    .font(.system(size: 11))
                Text("• Grade 2: Moderate to severe headache, nuchal rigidity, no deficit (except CN palsy)")
                    .font(.system(size: 11))
                Text("• Grade 3: Drowsiness, confusion, or mild focal deficit")
                    .font(.system(size: 11))
                Text("• Grade 4: Stupor, moderate-to-severe hemiparesis, early decerebrate rigidity")
                    .font(.system(size: 11))
                Text("• Grade 5: Deep coma, decerebrate rigidity, moribund appearance")
                    .font(.system(size: 11))
            }
            .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.4))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}

// MARK: - SINS Calculator View
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
            VStack(alignment: .leading, spacing: 4) {
                Text("SPINE INSTABILITY NEOPLASTIC SCORE")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.orange)
                HStack(alignment: .firstTextBaseline) {
                    Text("\(total)")
                        .font(.system(size: 38, weight: .black, design: .rounded))
                        .foregroundColor(total >= 13 ? .red : (total >= 7 ? .orange : .green))
                    Text("/ 18 Total Points")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.secondary)
                }
                Text(verdict)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(total >= 13 ? .red : (total >= 7 ? .orange : .green))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.orange.opacity(0.08))
            .cornerRadius(16)
            
            // Interactive Pickers
            VStack(spacing: 10) {
                ScoreSelector(title: "Location", options: [("Junctional (Occ-C2, C7-T2, T11-L1, L5-S1)", 3), ("Mobile Spine (C3-C6, L2-L4)", 2), ("Semirigid (T3-T10)", 1), ("Rigid (S2-S5)", 0)], selection: $loc)
                ScoreSelector(title: "Mechanical Pain", options: [("Yes (Movement-related)", 3), ("Occasional / Non-mechanical", 1), ("No Pain", 0)], selection: $pain)
                ScoreSelector(title: "Bone Lesion Quality", options: [("Lytic", 2), ("Mixed", 1), ("Blastic", 0)], selection: $bone)
                ScoreSelector(title: "Spinal Alignment", options: [("Subluxation / Translation", 4), ("De novo Deformity (Kyphosis/Scoliosis)", 2), ("Normal", 0)], selection: $align)
                ScoreSelector(title: "Vertebral Body Collapse", options: [("> 50% Collapse", 3), ("< 50% Collapse", 2), ("No collapse (>50% body involved)", 1), ("None", 0)], selection: $collapse)
                ScoreSelector(title: "Posterior Element Involvement", options: [("Bilateral", 3), ("Unilateral", 1), ("None", 0)], selection: $post)
            }
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
