import SwiftUI

public struct EmergencyProtocolsView: View {
    @State private var selectedEmergency = "EDH"
    @State private var patientAge: Double = 45
    @State private var gcsScore: Int = 10
    @State private var midlineShiftMM: Double = 6.0
    @State private var clotThicknessMM: Double = 12.0
    @State private var pupilStatus = "Ipsilateral Sluggish"
    @State private var isShowingSbarSheet = false
    
    public init() {}
    
    var isSurgicalCandidate: Bool {
        if selectedEmergency == "EDH" {
            return clotThicknessMM > 10.0 || midlineShiftMM > 5.0 || gcsScore < 9
        } else if selectedEmergency == "SDH" {
            return clotThicknessMM > 10.0 || midlineShiftMM > 5.0 || (gcsScore <= 8)
        } else {
            return midlineShiftMM > 5.0
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Banner
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("2 AM CRISIS PROTOCOL")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.5)
                            .foregroundColor(.red)
                        Text("Acute Herniation & TBI Arbitrator")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    }
                    Spacer()
                    // Urgency Badge
                    Text(isSurgicalCandidate ? "SURGICAL OR" : "ICU MONITOR")
                        .font(.system(size: 11, weight: .heavy))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(isSurgicalCandidate ? Color.red.opacity(0.12) : Color.blue.opacity(0.12))
                        .foregroundColor(isSurgicalCandidate ? .red : .blue)
                        .clipShape(Capsule())
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Emergency Selector Tabs
                HStack(spacing: 8) {
                    ForEach(["EDH", "SDH", "Uncal"], id: \.self) { type in
                        Button(action: {
                            selectedEmergency = type
                        }) {
                            Text(type == "EDH" ? "Epidural (EDH)" : (type == "SDH" ? "Subdural (SDH)" : "Uncal Herniation"))
                                .font(.system(size: 12, weight: .bold))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(selectedEmergency == type ? Color.indigo : Color.white)
                                .foregroundColor(selectedEmergency == type ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.04), radius: 3)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Interactive Anatomic Head CT Slice Diagram
                VStack(spacing: 8) {
                    Text("Interactive CT Axial Slice Visualizer")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.55))
                    
                    BrainCTDiagramView(activeHerniation: $selectedEmergency)
                        .padding(.vertical, 4)
                    
                    Text(selectedEmergency == "EDH"
                         ? "Biconvex / Lenticular (Arterial MMA, limited by cranial sutures)"
                         : (selectedEmergency == "SDH" ? "Crescentic / Concave (Bridging veins, crosses cranial sutures)" : "Uncal transtentorial displacement with posterior cerebral artery / CN III compression"))
                        .font(.system(size: 11, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.55))
                        .padding(.horizontal, 24)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.04), radius: 8)
                .padding(.horizontal)
                
                // Real-Time Surgical Criteria Inputs
                VStack(alignment: .leading, spacing: 16) {
                    Text("Acute Triage Parameters")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    
                    // Clot Thickness Slider
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Clot Thickness")
                                .font(.system(size: 12, weight: .semibold))
                            Spacer()
                            Text("\(Int(clotThicknessMM)) mm")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(clotThicknessMM > 10.0 ? .red : .primary)
                        }
                        Slider(value: $clotThicknessMM, in: 1...30, step: 1)
                            .tint(clotThicknessMM > 10.0 ? .red : .indigo)
                    }
                    
                    // Midline Shift Slider
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Midline Shift")
                                .font(.system(size: 12, weight: .semibold))
                            Spacer()
                            Text("\(String(format: "%.1f", midlineShiftMM)) mm")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(midlineShiftMM > 5.0 ? .red : .primary)
                        }
                        Slider(value: $midlineShiftMM, in: 0...20, step: 0.5)
                            .tint(midlineShiftMM > 5.0 ? .red : .indigo)
                    }
                    
                    // GCS Stepper
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Glasgow Coma Scale (GCS)")
                                .font(.system(size: 12, weight: .semibold))
                            Text("Motor + Verbal + Eye opening")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Stepper("\(gcsScore)", value: $gcsScore, in: 3...15)
                            .font(.system(size: 13, weight: .black))
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.04), radius: 8)
                .padding(.horizontal)
                
                // Hyperosmolar Dosing & Emergency Resuscitation Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "cross.vial.fill")
                            .foregroundColor(.teal)
                        Text("Hyperosmolar Therapy Protocol")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("• Mannitol 20%: 1.0 g/kg IV bolus over 20 min (requires Foley catheter)")
                            .font(.system(size: 11, weight: .medium))
                        Text("• 3% Hypertonic Saline: 250 mL bolus over 15 min (target serum Na 145-155 mEq/L)")
                            .font(.system(size: 11, weight: .medium))
                        Text("• 23.4% Super-Saturated Saline: 30 mL central line push for acute pupillary arrest")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.red)
                    }
                    .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.38))
                }
                .padding()
                .background(Color(red: 0.94, green: 0.98, blue: 0.98))
                .cornerRadius(18)
                .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.teal.opacity(0.3), lineWidth: 1.5))
                .padding(.horizontal)
                
                // Generate SBAR Button
                Button(action: {
                    isShowingSbarSheet = true
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Generate 3 AM Attending Call Briefing (SBAR)")
                            .font(.system(size: 13, weight: .bold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(LinearGradient(colors: [Color.indigo, Color.purple], startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(color: Color.indigo.opacity(0.25), radius: 8, y: 4)
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
        .sheet(isPresented: $isShowingSbarSheet) {
            SbarBriefingSheet(
                emergencyType: selectedEmergency,
                gcs: gcsScore,
                shiftMM: midlineShiftMM,
                thicknessMM: clotThicknessMM,
                isSurgical: isSurgicalCandidate
            )
        }
    }
}

// MARK: - 3 AM SBAR Briefing Sheet
struct SbarBriefingSheet: View {
    let emergencyType: String
    let gcs: Int
    let shiftMM: Double
    let thicknessMM: Double
    let isSurgical: Bool
    @Environment(\.dismiss) var dismiss
    @State private var copied = false
    
    var sbarScript: String {
        return """
        SITUATION:
        "Dr. Mohit, I am calling about a 45-year-old patient in the trauma bay with an acute \(emergencyType). Current GCS is \(gcs) with \(shiftMM)mm midline shift."

        BACKGROUND:
        "Head CT demonstrates an acute \(emergencyType) with clot thickness of \(Int(thicknessMM))mm, effacing the basal cisterns."

        ASSESSMENT:
        "The patient meets \(isSurgical ? "DEFINITIVE CRITERIA FOR IMMEDIATE SURGICAL CRANIOTOMY / EVACUATION" : "CRITERIA FOR CLOSE NEURO-ICU PRESSURE MONITORING")."

        RECOMMENDATION:
        "\(isSurgical ? "I have alerted the OR team, administered hypertonic therapy, and placed an arterial line. I recommend taking the patient immediately for emergent decompression." : "I recommend continuing hourly neuro checks, maintaining MAP > 80, and repeat CT in 4 hours unless exam deteriorates.")"
        """
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Spoken Call Script for On-Call Attending")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(.top)
                
                ScrollView {
                    Text(sbarScript)
                        .font(.system(size: 13, design: .monospaced))
                        .padding()
                        .background(Color(red: 0.96, green: 0.97, blue: 0.98))
                        .cornerRadius(14)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    UIPasteboard.general.string = sbarScript
                    copied = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        copied = false
                    }
                }) {
                    HStack {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        Text(copied ? "Copied Script!" : "Copy Script to Clipboard")
                    }
                    .font(.system(size: 13, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Attending Call Briefing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
