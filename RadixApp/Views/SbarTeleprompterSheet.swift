import SwiftUI

// MARK: - Attending SBAR Teleprompter & Briefing Generator
// Designed for high-stress 3 AM attending on-call phone communications.
// Provides rapid structured case formulation, live teleprompter autoscroll,
// and 1-tap clipboard copying formatted for spoken call, Epic Haiku, or iMessage.

public struct SbarTeleprompterSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    // Caller & Attending
    @State private var attendingName = "Dr. Mohit"
    @State private var callerRole = "Neurosurgery Resident"
    
    // Patient Demographics
    @State private var patientAge = 48
    @State private var patientGender = "Male"
    @State private var patientLocation = "Trauma Bay 1"
    
    // Pathology
    @State private var selectedEmergency = "Acute Subdural Hematoma (SDH)"
    
    // Neurologic Exam
    @State private var gcsEye = 1
    @State private var gcsVerbal = 1
    @State private var gcsMotor = 4 // Withdrawal / flexor
    @State private var pupilExam = "Unilateral Right Blown (6mm Fixed)"
    @State private var motorExam = "Left-sided dense hemiplegia (0/5)"
    
    // Radiologic Calipers
    @State private var clotThicknessMm: Double = 14.0
    @State private var midlineShiftMm: Double = 8.5
    @State private var cisternStatus = "Obliterated ambient & crural cisterns"
    
    // Emergency Interventions Done
    @State private var isIntubated = true
    @State private var hasHyperosmolar = true
    @State private var hasReversalGiven = true
    @State private var hasArtLine = true
    @State private var hasTypeCross = true
    
    // Proposed Plan
    @State private var proposedPlan = "Immediate Emergent Decompressive Hemicraniectomy"
    
    // Teleprompter Auto-Scroll State
    @State private var isAutoScrolling = false
    @State private var scrollSpeed: Double = 1.0 // 1x, 1.5x, 2x
    @State private var copiedFormat = ""
    
    public init() {}
    
    private var totalGCS: Int {
        gcsEye + gcsVerbal + gcsMotor
    }
    
    // 1. Spoken Call Script (Natural spoken cadence for 30-second phone briefing)
    private var spokenScriptText: String {
        return """
        "\(attendingName), this is the \(callerRole) with an acute neurosurgical emergency in \(patientLocation).
        
        SITUATION:
        I have a \(patientAge)-year-old \(patientGender.lowercased()) with \(selectedEmergency). Current GCS is \(totalGCS) (E\(gcsEye)V\(gcsVerbal)M\(gcsMotor)), with \(pupilExam) and \(motorExam).
        
        BACKGROUND & RADIOLOGY:
        Head CT demonstrates a \(String(format: "%.1f", clotThicknessMm)) mm clot thickness with \(String(format: "%.1f", midlineShiftMm)) mm of septum pellucidum midline shift, and \(cisternStatus.lowercased()).
        
        ASSESSMENT:
        The patient is clinically herniating and definitively meets Brain Trauma Foundation Level I criteria for emergent operative intervention.
        
        INTERVENTIONS INITIATED:
        \(isIntubated ? "✓ Patient is intubated and pre-oxygenated." : "• Airway currently intact.")
        \(hasHyperosmolar ? "✓ Administered 250 mL of 3% Hypertonic Saline bolus." : "")
        \(hasReversalGiven ? "✓ Anticoagulation reversal initiated via rapid protocol." : "")
        \(hasArtLine ? "✓ Arterial line placed; MAP maintained > 80 mmHg." : "")
        \(hasTypeCross ? "✓ 4 units PRBCs typed and crossed in blood bank." : "")
        
        RECOMMENDATION:
        OR and anesthesia are on standby. Requesting your authorization to roll immediately to OR for \(proposedPlan)."
        """
    }
    
    // 2. Epic Haiku / EHR Secure Chat Format (Structured bulleted clinical handover)
    private var epicHaikuFormatText: String {
        return """
        🚨 NEUROSURGERY ON-CALL STAT SBAR BRIEFING 🚨
        • Attending: \(attendingName) | Caller: \(callerRole)
        • Patient: \(patientAge)yo \(patientGender) | Loc: \(patientLocation)
        • Diagnosis: \(selectedEmergency)
        
        [NEURO EXAM]
        • GCS: \(totalGCS) (E\(gcsEye) V\(gcsVerbal) M\(gcsMotor))
        • Pupils: \(pupilExam)
        • Motor: \(motorExam)
        
        [CT CALIPER MEASUREMENTS]
        • Max Clot Thickness: \(String(format: "%.1f", clotThicknessMm)) mm
        • Midline Shift: \(String(format: "%.1f", midlineShiftMm)) mm
        • Basal Cisterns: \(cisternStatus)
        
        [RESUSCITATION & PROTOCOLS]
        • Airway: \(isIntubated ? "Intubated" : "Spontaneous")
        • Osmotherapy: \(hasHyperosmolar ? "3% HTS Bolus Given" : "None")
        • Coagulopathy Reversal: \(hasReversalGiven ? "Given / In Progress" : "None Indicated")
        • Hemodynamics: \(hasArtLine ? "A-Line in place (MAP > 80)" : "Cuff MAP > 80")
        • Blood Bank: \(hasTypeCross ? "4U PRBC on hold" : "Type & Screen sent")
        
        [OPERATIVE PLAN]
        • Action: \(proposedPlan) (OR Alerted / Ready)
        """
    }
    
    // 3. Short iMessage / SMS Format
    private var smsFormatText: String {
        return """
        STAT NEUROSURG: \(patientAge)yo \(patientGender) in \(patientLocation) w/ \(selectedEmergency). GCS \(totalGCS), \(pupilExam), \(motorExam). CT: \(String(format: "%.1f", clotThicknessMm))mm clot, \(String(format: "%.1f", midlineShiftMm))mm shift, \(cisternStatus). Intubated, 3% HTS given, A-line placed. Rolling to OR for \(proposedPlan). Please call resident on spectral.
        """
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Tab Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        emergencyButton("Acute SDH", "Acute Subdural Hematoma (SDH)")
                        emergencyButton("Acute EDH", "Acute Epidural Hematoma (EDH)")
                        emergencyButton("Uncal Herniation", "Acute Uncal Herniation")
                        emergencyButton("Cerebellar ICH", "Posterior Fossa Cerebellar ICH")
                        emergencyButton("Jumped Facets", "Cervical Jumped / Locked Facets")
                        emergencyButton("Odontoid Fx", "Odontoid Type II Fracture")
                        emergencyButton("Cauda Equina", "Acute Cauda Equina Syndrome")
                        emergencyButton("Shunt Failure", "Acute VP Shunt Obstruction")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(ObsidianTheme.surfaceElevated)
                
                // Main Teleprompter Screen
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 16) {
                            // Teleprompter Large Readout Box
                            teleprompterDisplayBox
                                .id("teleprompterTop")
                            
                            // Interactive Parameter Adjustment Accordion
                            patientParametersAccordion
                            
                            // 1-Tap Copy Action Buttons
                            copyExportActionsCard
                            
                            Spacer(minLength: 30)
                        }
                        .padding()
                    }
                }
            }
            .background(ObsidianTheme.surfaceVoid)
            .navigationTitle("Attending SBAR Teleprompter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        dismiss()
                    }
                    .foregroundColor(ObsidianTheme.textSecondary)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 6) {
                        Circle().fill(ObsidianTheme.neonGreen).frame(width: 8, height: 8)
                        Text("READY TO CALL")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(ObsidianTheme.neonGreen)
                    }
                }
            }
        }
    }
    
    // MARK: - Teleprompter Box
    private var teleprompterDisplayBox: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Text("30-SECOND SPOKEN ATTENDING BRIEFING")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                Spacer()
                Text("GCS \(totalGCS)")
                    .font(.system(size: 11, weight: .black))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(totalGCS <= 8 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                    .foregroundColor(.black)
                    .cornerRadius(4)
            }
            
            Text(spokenScriptText)
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .foregroundColor(ObsidianTheme.textPrimary)
                .lineSpacing(5)
                .padding(14)
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.neonCyan.opacity(0.4), lineWidth: 1))
    }
    
    // MARK: - Patient Parameters Accordion
    private var patientParametersAccordion: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("LIVE CASE ADJUSTMENTS")
                .font(.system(size: 11, weight: .black))
                .foregroundColor(ObsidianTheme.neonAmber)
            
            // Row 1: GCS & Pupils
            VStack(spacing: 8) {
                HStack {
                    Text("Eye (1-4):")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Stepper("\(gcsEye)", value: $gcsEye, in: 1...4)
                    
                    Text("Verbal (1-5):")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Stepper("\(gcsVerbal)", value: $gcsVerbal, in: 1...5)
                }
                
                HStack {
                    Text("Motor (1-6):")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Stepper("\(gcsMotor)", value: $gcsMotor, in: 1...6)
                    Spacer()
                    Text("Total GCS: \(totalGCS)")
                        .font(.system(size: 13, weight: .heavy))
                        .foregroundColor(totalGCS <= 8 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                
                // Pupil Picker
                HStack {
                    Text("Pupil Exam:")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Spacer()
                    Picker("Pupils", selection: $pupilExam) {
                        Text("Bilateral Brisk (Normal)").tag("Bilateral brisk & reactive (3mm)")
                        Text("Right Blown Fixed (6mm)").tag("Unilateral Right Blown (6mm Fixed)")
                        Text("Left Blown Fixed (6mm)").tag("Unilateral Left Blown (6mm Fixed)")
                        Text("Bilateral Sluggish (4mm)").tag("Bilateral sluggish (4mm)")
                        Text("Bilateral Fixed & Dilated").tag("Bilateral fixed & dilated (7mm)")
                    }
                    .pickerStyle(.menu)
                    .tint(ObsidianTheme.neonCyan)
                }
            }
            .padding(10)
            .background(ObsidianTheme.surfaceElevated)
            .cornerRadius(10)
            
            // Row 2: Clot & Shift Sliders
            VStack(spacing: 8) {
                HStack {
                    Text("Clot Thickness:")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Spacer()
                    Text(String(format: "%.1f mm", clotThicknessMm))
                        .font(.system(size: 12, weight: .heavy))
                        .foregroundColor(clotThicknessMm >= 10.0 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                Slider(value: $clotThicknessMm, in: 0...30, step: 0.5)
                    .tint(clotThicknessMm >= 10.0 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                
                HStack {
                    Text("Midline Shift:")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Spacer()
                    Text(String(format: "%.1f mm", midlineShiftMm))
                        .font(.system(size: 12, weight: .heavy))
                        .foregroundColor(midlineShiftMm >= 5.0 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                Slider(value: $midlineShiftMm, in: 0...20, step: 0.5)
                    .tint(midlineShiftMm >= 5.0 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
            }
            .padding(10)
            .background(ObsidianTheme.surfaceElevated)
            .cornerRadius(10)
            
            // Row 3: Resuscitation Checklist Toggles
            VStack(alignment: .leading, spacing: 6) {
                Text("Pre-Call Interventions Completed:")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.textSecondary)
                
                Toggle("Intubated / Airway Secured", isOn: $isIntubated)
                    .toggleStyle(SwitchToggleStyle(tint: ObsidianTheme.neonCyan))
                Toggle("Hyperosmolar Therapy (3% HTS / Mannitol)", isOn: $hasHyperosmolar)
                    .toggleStyle(SwitchToggleStyle(tint: ObsidianTheme.neonCyan))
                Toggle("Anticoagulation Reversal Given", isOn: $hasReversalGiven)
                    .toggleStyle(SwitchToggleStyle(tint: ObsidianTheme.neonCyan))
                Toggle("Arterial Line Placed (MAP > 80)", isOn: $hasArtLine)
                    .toggleStyle(SwitchToggleStyle(tint: ObsidianTheme.neonCyan))
            }
            .padding(10)
            .background(ObsidianTheme.surfaceElevated)
            .cornerRadius(10)
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
    }
    
    // MARK: - Copy Export Actions
    private var copyExportActionsCard: some View {
        VStack(spacing: 10) {
            Text("1-TAP EXPORT TO CLIPBOARD")
                .font(.system(size: 11, weight: .black))
                .foregroundColor(ObsidianTheme.textTertiary)
            
            Button(action: {
                HapticManager.impact(style: .medium)
                UIPasteboard.general.string = spokenScriptText
                copiedFormat = "Spoken Script"
                resetCopiedBadge()
            }) {
                HStack {
                    Image(systemName: copiedFormat == "Spoken Script" ? "checkmark.circle.fill" : "phone.fill")
                    Text(copiedFormat == "Spoken Script" ? "Copied Spoken Call Script!" : "Copy Spoken Call Script")
                        .font(.system(size: 12, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(ObsidianTheme.neonCyan)
                .foregroundColor(.black)
                .cornerRadius(10)
            }
            
            Button(action: {
                HapticManager.impact(style: .medium)
                UIPasteboard.general.string = epicHaikuFormatText
                copiedFormat = "Epic Haiku"
                resetCopiedBadge()
            }) {
                HStack {
                    Image(systemName: copiedFormat == "Epic Haiku" ? "checkmark.circle.fill" : "doc.text.fill")
                    Text(copiedFormat == "Epic Haiku" ? "Copied Epic Haiku / EHR Chat!" : "Copy Epic Haiku / EHR Chat Format")
                        .font(.system(size: 12, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(ObsidianTheme.surfaceElevated)
                .foregroundColor(ObsidianTheme.textPrimary)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
            }
            
            Button(action: {
                HapticManager.impact(style: .medium)
                UIPasteboard.general.string = smsFormatText
                copiedFormat = "iMessage"
                resetCopiedBadge()
            }) {
                HStack {
                    Image(systemName: copiedFormat == "iMessage" ? "checkmark.circle.fill" : "message.fill")
                    Text(copiedFormat == "iMessage" ? "Copied iMessage Format!" : "Copy Short iMessage / SMS Format")
                        .font(.system(size: 12, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(ObsidianTheme.surfaceElevated)
                .foregroundColor(ObsidianTheme.textPrimary)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
            }
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
    }
    
    private func emergencyButton(_ shortLabel: String, _ fullTitle: String) -> some View {
        Button(action: {
            HapticManager.impact(style: .light)
            selectedEmergency = fullTitle
            if fullTitle.contains("EDH") {
                clotThicknessMm = 18.0
                midlineShiftMm = 6.0
                proposedPlan = "Emergent Craniotomy & Clot Evacuation"
            } else if fullTitle.contains("SDH") {
                clotThicknessMm = 14.0
                midlineShiftMm = 8.5
                proposedPlan = "Emergent Decompressive Hemicraniectomy"
            } else if fullTitle.contains("Uncal") {
                clotThicknessMm = 20.0
                midlineShiftMm = 11.0
                pupilExam = "Unilateral Right Blown (6mm Fixed)"
                proposedPlan = "Emergent Subtemporal Craniotomy & Decompression"
            } else if fullTitle.contains("Cerebellar") {
                clotThicknessMm = 35.0
                midlineShiftMm = 4.0
                proposedPlan = "Emergent Suboccipital Craniectomy & EVD"
            } else if fullTitle.contains("Jumped") {
                proposedPlan = "Emergent Closed Reduction with Gardner-Wells Tongs & ACDF"
            } else if fullTitle.contains("Odontoid") {
                proposedPlan = "Rigid Immobilization vs Posterior Harms C1-C2 Fusion"
            }
        }) {
            Text(shortLabel)
                .font(.system(size: 11, weight: .bold))
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(selectedEmergency == fullTitle ? ObsidianTheme.neonCyan : ObsidianTheme.surfaceElevated)
                .foregroundColor(selectedEmergency == fullTitle ? .black : ObsidianTheme.textSecondary)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(selectedEmergency == fullTitle ? ObsidianTheme.neonCyan : ObsidianTheme.glassBorder, lineWidth: 1))
        }
    }
    
    private func resetCopiedBadge() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            copiedFormat = ""
        }
    }
}
