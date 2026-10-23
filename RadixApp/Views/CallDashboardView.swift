import SwiftUI

// MARK: - Main Call Dashboard & Census Command Center
public struct CallDashboardView: View {
    @State private var patients: [CallPatient] = [
        CallPatient(
            name: "J. Doe",
            mrn: "981244",
            location: "Neuro ICU Bed 2",
            diagnosis: "Traumatic Acute SDH s/p Decompressive Hemicraniectomy",
            acuity: .immediate,
            gcs: "7T (E1 V1T M5)",
            pupils: "R 4mm sluggish, L 3mm reactive",
            hardware: "Right EVD clamped, Camino bolt ICP 16",
            contingencyPlan: "If ICP > 20 for > 5 min -> open EVD @ 10; if pupil sluggish -> 250cc 3% HTS stat",
            keyTasks: ["Check morning CT Head at 05:00", "Follow Na goal 145-150 on Q4H BMP", "Confirm repeat INR < 1.3"]
        ),
        CallPatient(
            name: "R. Smith",
            mrn: "450129",
            location: "Neuro ICU Bed 6",
            diagnosis: "Fisher 3 Hunt-Hess 2 aSAH s/p ACom Aneurysm Coiling",
            acuity: .urgent,
            gcs: "14 (E4 V4 M6)",
            pupils: "Bilateral 3mm reactive",
            hardware: "Right EVD draining @ 15 cmH2O (clear CSF)",
            contingencyPlan: "If focal pronator drift or speech arrest develops -> STAT CTA/CTP for vasospasm; initiate induced hypertension (MAP > 95)",
            keyTasks: ["Verify Nimodipine 60mg given Q4H", "TCD ultrasound in AM", "Maintain euvolemia"]
        ),
        CallPatient(
            name: "M. Taylor",
            mrn: "782310",
            location: "Spine Stepdown 412",
            diagnosis: "L4-L5 Lumbar Microdiscectomy POD#1",
            acuity: .routine,
            gcs: "15",
            pupils: "Bilateral 3mm reactive",
            hardware: "Hemovac drain (30 mL serosanguinous)",
            contingencyPlan: "If urinary retention occurs -> bladder scan, straight cath if PVR > 300 mL; alert team if motor drop in EHL",
            keyTasks: ["PT/OT evaluation", "D/C drain if < 50 mL over 24h", "Transition to PO analgesia"]
        ),
        CallPatient(
            name: "E. Clark",
            mrn: "239841",
            location: "7 West 708",
            diagnosis: "Normal Pressure Hydrocephalus s/p VP Shunt",
            acuity: .stable,
            gcs: "15",
            pupils: "Bilateral 3mm reactive",
            hardware: "Certas Plus Programmable Valve @ Setting 4",
            contingencyPlan: "If headache or lethargy -> head of bed flat, check shunt series",
            keyTasks: ["Discharge planning to acute rehab", "Wound check"]
        )
    ]
    
    @State private var filterAcuity: TriageAcuity? = nil
    @State private var isShowingReviewStation = false
    @State private var isShowingDeveloperPortfolio = false
    @State private var isAcuityGuideExpanded = false
    @Environment(\.requestReview) var requestReview
    @Environment(\.openURL) var openURL
    @State private var hasRatedNeuroCall = false
    
    var filteredPatients: [CallPatient] {
        if let filter = filterAcuity {
            return patients.filter { $0.acuity == filter }
        }
        return patients
    }
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                // Census Summary Header
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Circle().fill(ObsidianTheme.neonRed).frame(width: 8, height: 8)
                        Text("ACTIVE ON-CALL CENSUS")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.8)
                            .foregroundColor(ObsidianTheme.neonRed)
                        Spacer()
                        HStack(spacing: 8) {
                            Text("\(patients.count) Covered")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(ObsidianTheme.textTertiary)
                            Button(action: {
                                HapticManager.impact(style: .medium)
                                isShowingDeveloperPortfolio = true
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "square.stack.3d.up.fill")
                                        .font(.system(size: 10))
                                    Text("Developer's Apps")
                                        .font(.system(size: 10, weight: .bold))
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(ObsidianTheme.neonPurple.opacity(0.18))
                                .foregroundColor(ObsidianTheme.neonPurple)
                                .cornerRadius(6)
                                .overlay(RoundedRectangle(cornerRadius: 6).stroke(ObsidianTheme.neonPurple.opacity(0.3), lineWidth: 1))
                            }
                            Button(action: {
                                HapticManager.impact(style: .medium)
                                isShowingReviewStation = true
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 10))
                                    Text("Audit Studio")
                                        .font(.system(size: 10, weight: .bold))
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(ObsidianTheme.neonCyan.opacity(0.18))
                                .foregroundColor(ObsidianTheme.neonCyan)
                                .cornerRadius(6)
                                .overlay(RoundedRectangle(cornerRadius: 6).stroke(ObsidianTheme.neonCyan.opacity(0.3), lineWidth: 1))
                            }
                        }
                    }
                    Text("Call Command Cockpit")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(ObsidianTheme.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Toggleable Clinical Acuity Pill Guide (Starts Collapsed)
                TriageAcuityInfoBox(isExpanded: $isAcuityGuideExpanded)
                    .padding(.horizontal)
                
                // Color-Coded Acuity Filter Bar
                HStack(spacing: 8) {
                    AcuityFilterPill(title: "All (\(patients.count))", isSelected: filterAcuity == nil) {
                        filterAcuity = nil
                    }
                    AcuityFilterPill(title: "🔴 Immediate (\(patients.filter { $0.acuity == .immediate }.count))", isSelected: filterAcuity == .immediate) {
                        filterAcuity = .immediate
                    }
                    AcuityFilterPill(title: "🟠 Urgent (\(patients.filter { $0.acuity == .urgent }.count))", isSelected: filterAcuity == .urgent) {
                        filterAcuity = .urgent
                    }
                    AcuityFilterPill(title: "🟢 Stable", isSelected: filterAcuity == .stable) {
                        filterAcuity = .stable
                    }
                }
                .padding(.horizontal)
                
                // Sickest Patient Banner
                if let sickest = patients.first(where: { $0.acuity == .immediate }) {
                    SickestPatientBanner(patient: sickest)
                        .padding(.horizontal)
                }
                
                // Patient Cards List
                VStack(spacing: 14) {
                    ForEach(filteredPatients) { pt in
                        PatientCensusCard(patient: pt)
                    }
                }
                .padding(.horizontal)
                
                // Persistent Un-Gated App Store Review & Rating Card
                DashboardRatingBannerCard()
                    .padding(.horizontal)
            }
            .padding(.bottom, 28)
        }
        .obsidianCockpitBackground()
        .sheet(isPresented: $isShowingReviewStation) {
            AnatomicReviewStationView()
        }
        .sheet(isPresented: $isShowingDeveloperPortfolio) {
            DeveloperPortfolioView()
        }
    }
}

// MARK: - Sickest Patient Alert Banner
struct SickestPatientBanner: View {
    let patient: CallPatient
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                    Text("HIGHEST OVERNIGHT ACUITY")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.red)
                }
                Spacer()
                Text(patient.location)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
            }
            
            Text("\(patient.name) • \(patient.diagnosis)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
            
            HStack(spacing: 12) {
                Text("GCS: \(patient.gcs)")
                    .font(.system(size: 11, weight: .semibold))
                Text("Pupils: \(patient.pupils)")
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundColor(.secondary)
            
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "bolt.shield.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 2)
                Text("Contingency: \(patient.contingencyPlan)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.red)
                    .lineSpacing(2)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.red.opacity(0.08)))
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(18)
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.red.opacity(0.3), lineWidth: 1.5))
        .shadow(color: Color.red.opacity(0.08), radius: 8)
    }
}

// MARK: - Census Patient Card
struct PatientCensusCard: View {
    let patient: CallPatient
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header Row
            HStack {
                HStack(spacing: 6) {
                    Circle()
                        .fill(patient.acuity.color)
                        .frame(width: 8, height: 8)
                    Text(patient.acuity.rawValue.uppercased())
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(patient.acuity.color)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(patient.acuity.color.opacity(0.12)))
                
                Text(patient.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                
                Spacer()
                
                Text(patient.location)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
            }
            
            Text(patient.diagnosis)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
            
            // Neuro Vitals Strip
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 1) {
                    Text("GCS")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.secondary)
                    Text(patient.gcs)
                        .font(.system(size: 11, weight: .bold))
                }
                Divider().frame(height: 18)
                VStack(alignment: .leading, spacing: 1) {
                    Text("PUPILS")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.secondary)
                    Text(patient.pupils)
                        .font(.system(size: 11, weight: .bold))
                }
                Divider().frame(height: 18)
                VStack(alignment: .leading, spacing: 1) {
                    Text("HARDWARE")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.secondary)
                    Text(patient.hardware)
                        .font(.system(size: 11, weight: .bold))
                }
            }
            .padding(8)
            .background(Color(red: 0.98, green: 0.98, blue: 0.99))
            .cornerRadius(8)
            
            // Contingency If/Then Rule
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "arrow.triangle.branch")
                    .foregroundColor(ObsidianTheme.neonAmber)
                    .font(.system(size: 11, weight: .bold))
                    .padding(.top, 2)
                Text("CONTINGENCY: \(patient.contingencyPlan)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(ObsidianTheme.neonAmber)
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(ObsidianTheme.neonAmber.opacity(0.12)))
            
            // Overnight Tasks Checklist
            VStack(alignment: .leading, spacing: 4) {
                Text("OUTSTANDING OVERNIGHT TASKS:")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(ObsidianTheme.textTertiary)
                ForEach(patient.keyTasks, id: \.self) { task in
                    HStack(spacing: 6) {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                            .foregroundColor(ObsidianTheme.neonCyan)
                        Text(task)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
            }
        }
        .padding(16)
        .vitreousGlassCard()
    }
}

struct AcuityFilterPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticManager.impact(style: .light)
            action()
        }) {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(isSelected ? Color.blue : Color.white)
                .foregroundColor(isSelected ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(isSelected ? Color.blue : Color.black.opacity(0.06), lineWidth: 1))
        }
    }
}

// MARK: - Toggleable Clinical Triage Acuity Pill Guide (Starts Collapsed)
struct TriageAcuityInfoBox: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
                HapticManager.impact(style: .light)
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 6) {
                            Text("WHAT DO THE COLORED PILLS DESIGNATE?")
                                .font(.system(size: 10, weight: .black))
                                .tracking(1.0)
                                .foregroundColor(ObsidianTheme.neonCyan)
                        }
                        Text(isExpanded ? "Neurosurgical On-Call Triage Taxonomy" : "Tap to expand clinical acuity definitions & response times")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                    
                    Spacer()
                    
                    // Preview dots when collapsed
                    if !isExpanded {
                        HStack(spacing: 4) {
                            Circle().fill(Color.red).frame(width: 7, height: 7)
                            Circle().fill(Color.orange).frame(width: 7, height: 7)
                            Circle().fill(Color.yellow).frame(width: 7, height: 7)
                            Circle().fill(Color.blue).frame(width: 7, height: 7)
                            Circle().fill(Color.green).frame(width: 7, height: 7)
                        }
                        .padding(.trailing, 2)
                    }
                    
                    Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isExpanded ? ObsidianTheme.neonCyan : ObsidianTheme.textTertiary)
                }
                .padding(12)
                .background(Color(red: 0.10, green: 0.12, blue: 0.18))
                .cornerRadius(isExpanded ? 14 : 14)
            }
            .buttonStyle(.plain)
            
            // Expanded Content Guide
            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    Divider().background(ObsidianTheme.glassBorder)
                        .padding(.vertical, 4)
                    
                    acuityTierRow(
                        color: Color.red,
                        tag: "IMMEDIATE (STAT)",
                        window: "< 15 Min Bedside Evaluation",
                        description: "Life-or-brain-threatening acute mass effect or herniation. Stat attending notification & operating room mobilization.",
                        examples: "Acute EDH/SDH with ≥ 5mm shift, uncal herniation with pupillary dilation, acute cord transection, refractory ICP > 20 mmHg."
                    )
                    
                    acuityTierRow(
                        color: Color.orange,
                        tag: "URGENT (HIGH ACUITY)",
                        window: "< 1-2 Hours Evaluation",
                        description: "Severe neurological compromise requiring ICU neuromonitoring and planned surgical intervention within 2–6 hours.",
                        examples: "Fisher 3 aSAH with EVD, acute progressive cauda equina, worsening cervical myelopathy, open depressed skull fracture."
                    )
                    
                    acuityTierRow(
                        color: Color.yellow,
                        tag: "CONTINGENCY / CAUTION",
                        window: "Strict Overnight If/Then Rules",
                        description: "Actionable threshold protocols empowering nursing and on-call residents to preempt clinical deterioration.",
                        examples: "If ICP > 20 for > 5 min -> open EVD @ 10; if pupil sluggish -> 250cc 3% HTS stat; follow Q4H sodium goal 145-150."
                    )
                    
                    acuityTierRow(
                        color: Color.blue,
                        tag: "ROUTINE (STEPDOWN / FLOOR)",
                        window: "Standard Shift Care",
                        description: "Stable postoperative patients requiring drain output surveillance, transition to oral analgesia, and physical therapy clearance.",
                        examples: "POD#1 lumbar microdiscectomy, ACDF single-level, uncomplicated elective craniotomy for unruptured meningioma."
                    )
                    
                    acuityTierRow(
                        color: Color.green,
                        tag: "STABLE (FLOOR / DISCHARGE)",
                        window: "Non-Emergent Surveillance",
                        description: "Intact baseline neurology with zero acute surgical intervention required overnight. Discharge planning active.",
                        examples: "Functioning VP shunt at baseline setting, non-operative stable transverse process fracture, medically cleared for acute rehab."
                    )
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            isExpanded = false
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("Collapse Pill Guide ⌃")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(ObsidianTheme.neonCyan)
                            Spacer()
                        }
                        .padding(.top, 6)
                    }
                }
                .padding(12)
                .background(Color(red: 0.08, green: 0.10, blue: 0.15))
                .cornerRadius(14)
            }
        }
        .background(Color(red: 0.09, green: 0.11, blue: 0.16))
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.neonCyan.opacity(0.35), lineWidth: 1))
    }
    
    private func acuityTierRow(color: Color, tag: String, window: String, description: String, examples: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(spacing: 6) {
                Circle().fill(color).frame(width: 7, height: 7)
                Text(tag)
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(color)
                Spacer()
                Text(window)
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textTertiary)
            }
            
            Text(description)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(ObsidianTheme.textPrimary)
                .lineSpacing(2)
            
            Text("Examples: \(examples)")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(ObsidianTheme.textSecondary)
                .italic()
        }
        .padding(8)
        .background(color.opacity(0.06))
        .cornerRadius(8)
    }
}

// MARK: - Persistent In-App Rating & Review Card (Guideline 5.6.1 Compliant)
public struct DashboardRatingBannerCard: View {
    @State private var hasRated = false
    @Environment(\.requestReview) private var requestReview
    @Environment(\.openURL) private var openURL
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack(spacing: 5) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.yellow)
                    }
                }
                Spacer()
                Text("APP STORE DISCOVERABILITY")
                    .font(.system(size: 9, weight: .black))
                    .tracking(1.0)
                    .foregroundColor(.yellow)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Support NeuroCall with a 5-Star Rating")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Text("Apple's algorithm indexes unrated medical apps lower in search results. An un-gated review helps on-call residents and spine surgeons find NeuroCall instantly.")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .lineSpacing(2)
            }
            
            HStack(spacing: 10) {
                Button(action: {
                    HapticManager.impact(style: .medium)
                    requestReview()
                    hasRated = true
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: hasRated ? "checkmark.circle.fill" : "star.circle.fill")
                        Text(hasRated ? "Thank You!" : "Rate 5 Stars In-App")
                    }
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.yellow)
                    .cornerRadius(8)
                }
                
                Button(action: {
                    HapticManager.impact(style: .light)
                    if let url = URL(string: "https://apps.apple.com/app/id6821489631?action=write-review") {
                        openURL(url)
                    }
                }) {
                    HStack(spacing: 4) {
                        Text("App Store Page")
                        Image(systemName: "arrow.up.right")
                    }
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(Color(red: 0.16, green: 0.18, blue: 0.24))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
                }
            }
        }
        .padding(14)
        .background(Color(red: 0.12, green: 0.14, blue: 0.20))
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.yellow.opacity(0.3), lineWidth: 1))
    }
}
