import SwiftUI

// MARK: - Consult Intake & SBAR Note Generation Module
public struct ConsultManagerView: View {
    @State private var patientAgeGender = "54M"
    @State private var referringService = "Trauma Surgery"
    @State private var callbackNumber = "x4821 / pager 206-555-0199"
    @State private var chiefComplaint = "Fall from ladder with acute LOC and right dilated pupil"
    @State private var gcs = 8
    @State private var pupils = "Right 5mm sluggish, Left 3mm reactive"
    @State private var motorExam = "Left hemiparesis (withdraws to pain left, localizes right)"
    @State private var anticoagulation = "Eliquis 5mg BID (last dose 4 hrs ago)"
    @State private var imagingFindings = "14 mm right acute temporoparietal subdural hematoma, 8 mm midline shift, effaced suprasellar cistern"
    
    @State private var showingGeneratedNote = false
    @State private var generatedNoteText = ""
    @State private var copiedToClipboard = false
    
    public init() {}
    
    // Generate Formatted Resident Consult Note
    func generateConsultNote() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let timestamp = formatter.string(from: Date())
        
        generatedNoteText = """
        ============================================================
        NEUROSURGERY ON-CALL CONSULTATION NOTE
        Time of Evaluation: \(timestamp)
        Referring Service: \(referringService) | Callback: \(callbackNumber)
        Patient: \(patientAgeGender)
        ============================================================
        
        REASON FOR CONSULTATION:
        \(chiefComplaint)
        
        HISTORY OF PRESENT ILLNESS:
        \(patientAgeGender) evaluated emergently at the request of \(referringService). Patient suffered traumatic event resulting in acute neurological decline. Anticoagulation history: \(anticoagulation).
        
        NEUROLOGICAL EXAMINATION:
        • Mental Status / GCS: \(gcs) (E2 V2 M4)
        • Cranial Nerves: Pupils \(pupils). Gag intact. Corneal reflexes present bilaterally.
        • Motor: \(motorExam).
        • Sensory: Grossly withdraws to noxious stimulus in all 4 extremities.
        • Brainstem: Spontaneous respirations, cough intact.
        
        NEUROIMAGING REVIEW (Resident Interpretation):
        Non-contrast Head CT reviewed personally:
        \(imagingFindings)
        
        ASSESSMENT:
        Acute intracranial neurosurgical pathology with severe mass effect, subfalcine herniation, and impending transtentorial herniation in the setting of active direct oral anticoagulation (\(anticoagulation)).
        
        PLAN & RECOMMENDATIONS:
        1. AIRWAY / RESUSCITATION: Ensure endotracheal intubation, elevate head of bed 30 degrees, maintain cervical collar if indicated. Target SBP 110–140 mmHg, pCO2 35–38 mmHg.
        2. HYPEROSMOLAR THERAPY: Administer 3% Hypertonic Saline 250 mL IV bolus STAT (or Mannitol 20% 1 g/kg IV) for intracranial decompression.
        3. URGENT REVERSAL: Reversal of \(anticoagulation) with Andexanet Alfa (or 4-Factor PCC 50 units/kg IV STAT).
        4. SURGICAL INTERVENTION: Emergent right decompressive hemicraniectomy and evacuation of acute hematoma.
        5. SEIZURE PROPHYLAXIS: Levetiracetam (Keppra) 2,000 mg IV load STAT.
        6. ATTENDING DISCUSSION: Discussed with Neurosurgery Attending On-Call who concurs with operative plan. Consents obtained and OR mobilized.
        ============================================================
        """
        showingGeneratedNote = true
        HapticManager.notification(type: .success)
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("BEDSIDE CONSULT INTAKE & NOTE GENERATOR")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.blue)
                    Text("Consult Intake Manager")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Text("Log after-hours consults and generate structured SBAR consult notes with 1-tap.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Structured Input Form
                VStack(spacing: 12) {
                    ConsultInputField(label: "Patient Demographic (e.g. 54M)", text: $patientAgeGender)
                    ConsultInputField(label: "Referring Service", text: $referringService)
                    ConsultInputField(label: "Callback Number / Pager", text: $callbackNumber)
                    ConsultInputField(label: "Chief Complaint / Mechanism", text: $chiefComplaint)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Glasgow Coma Scale (GCS):")
                                .font(.system(size: 12, weight: .bold))
                            Spacer()
                            Text("\(gcs) / 15")
                                .font(.system(size: 14, weight: .black, design: .rounded))
                                .foregroundColor(gcs <= 8 ? .red : .blue)
                        }
                        Slider(value: Binding(get: { Double(gcs) }, set: { gcs = Int($0) }), in: 3...15, step: 1)
                            .tint(gcs <= 8 ? .red : .blue)
                    }
                    .padding(10)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                    .cornerRadius(10)
                    
                    ConsultInputField(label: "Pupillary Examination", text: $pupils)
                    ConsultInputField(label: "Motor Examination (Lateralizing signs)", text: $motorExam)
                    ConsultInputField(label: "Anticoagulation / Antiplatelet History", text: $anticoagulation)
                    ConsultInputField(label: "Key Neuroimaging Findings (CT / MRI)", text: $imagingFindings)
                }
                .padding(.horizontal)
                
                // Action Button: Generate Consult Note
                Button(action: generateConsultNote) {
                    HStack(spacing: 8) {
                        Image(systemName: "doc.text.fill")
                        Text("Generate Formatted Consult Note")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(colors: [Color.blue, Color.indigo], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, y: 3)
                }
                .padding(.horizontal)
                
                // Formatted Output Display
                if showingGeneratedNote {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("READY-TO-SIGN CONSULT NOTE:")
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(.indigo)
                            Spacer()
                            Button(action: {
                                UIPasteboard.general.string = generatedNoteText
                                copiedToClipboard = true
                                HapticManager.impact(style: .medium)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    copiedToClipboard = false
                                }
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: copiedToClipboard ? "checkmark" : "doc.on.doc.fill")
                                    Text(copiedToClipboard ? "Copied!" : "Copy Note")
                                }
                                .font(.system(size: 11, weight: .bold))
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(copiedToClipboard ? Color.green : Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        
                        Text(generatedNoteText)
                            .font(.system(size: 11, weight: .regular, design: .monospaced))
                            .foregroundColor(Color(red: 0.15, green: 0.2, blue: 0.3))
                            .padding(12)
                            .background(Color(red: 0.96, green: 0.97, blue: 0.99))
                            .cornerRadius(12)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.04), radius: 6)
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 28)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}

struct ConsultInputField: View {
    let label: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.4))
            TextField(label, text: $text)
                .font(.system(size: 13, weight: .medium))
                .padding(10)
                .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.06), lineWidth: 1))
        }
    }
}
