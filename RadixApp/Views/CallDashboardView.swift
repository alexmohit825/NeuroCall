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
                        Text("ACTIVE ON-CALL CENSUS")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.5)
                            .foregroundColor(.blue)
                        Spacer()
                        Text("\(patients.count) Patients Covered")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                    Text("Call Command Center")
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
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
            }
            .padding(.bottom, 28)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
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
                    .foregroundColor(.orange)
                    .font(.system(size: 11))
                    .padding(.top, 2)
                Text("If/Then: \(patient.contingencyPlan)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
            }
            
            // Overnight Tasks Checklist
            VStack(alignment: .leading, spacing: 4) {
                Text("OUTSTANDING OVERNIGHT TASKS:")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(.secondary)
                ForEach(patient.keyTasks, id: \.self) { task in
                    HStack(spacing: 6) {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                            .foregroundColor(.blue)
                        Text(task)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.4))
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
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
