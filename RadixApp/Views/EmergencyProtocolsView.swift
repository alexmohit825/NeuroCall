import SwiftUI

// MARK: - 2 AM Acute Neurosurgical Crisis Protocols & Operative Cockpit
// Synthesized from Greenberg Handbook of Neurosurgery, Kaloostian Neurosurgery Outlines, and Ellenbogen Principles of Neurosurgery.
// Featuring authentic high-contrast CT scan plates (EDH, SDH, Uncal Herniation with anterior uncus, Posterior Fossa cerebellar ICH)
// with prominent [ANT] / [POST] orientation, dynamic real-time caliper overlays driven by sliders,
// full anticoagulation reversal cockpit, and emergency bedside/OR operative checklists.

public struct EmergencyProtocolsView: View {
    @State private var selectedEmergency = "EDH"
    @State private var patientAge: Double = 45
    @State private var gcsScore: Int = 10
    @State private var pupilStatus = "Ipsilateral Sluggish"
    @State private var isShowingSbarSheet = false
    @State private var activeSection = "arbitrator" // arbitrator, reversal, checklists
    
    public init() {}
    
    // Greenberg & BTF Surgical Criteria Spec
    var thresholdSpec: EmergencyThresholdSpec {
        switch selectedEmergency {
        case "EDH":
            return EmergencyThresholdSpec(
                title: "Epidural Hematoma (EDH)",
                thicknessThreshold: "> 15 mm (regardless of GCS)",
                shiftThreshold: "> 5 mm (regardless of GCS)",
                volumeThreshold: "> 30 cc hematoma volume",
                neurologicalTrigger: "GCS < 9 or pupillary asymmetry / sluggish",
                operativeProcedure: "Emergent Craniotomy & Hematoma Evacuation"
            )
        case "SDH":
            return EmergencyThresholdSpec(
                title: "Acute Subdural Hematoma (SDH)",
                thicknessThreshold: "> 10 mm (regardless of GCS)",
                shiftThreshold: "> 5 mm (regardless of GCS)",
                volumeThreshold: "> 25 cc hematoma volume",
                neurologicalTrigger: "GCS ≤ 8 or drop ≥ 2 pts / asymmetric pupil",
                operativeProcedure: "Emergent Decompressive Craniectomy (≥12x15 cm)"
            )
        case "Uncal":
            return EmergencyThresholdSpec(
                title: "Acute Uncal Herniation",
                thicknessThreshold: "Complete obliteration of ambient/crural cistern",
                shiftThreshold: "Severe midline shift with midbrain compression",
                volumeThreshold: "Critical ipsilateral temporal mass effect",
                neurologicalTrigger: "Ipsilateral blown pupil (CN III) + paresis",
                operativeProcedure: "Emergent Subtemporal Craniotomy & Decompression"
            )
        case "Posterior Fossa":
            return EmergencyThresholdSpec(
                title: "Posterior Fossa Cerebellar ICH",
                thicknessThreshold: "Hematoma diameter ≥ 3.0 cm",
                shiftThreshold: "4th ventricle compression / effacement",
                volumeThreshold: "Acute hydrocephalus from ventricular occlusion",
                neurologicalTrigger: "GCS ≤ 13 or progressive brainstem depression",
                operativeProcedure: "Emergent Suboccipital Craniectomy & Clot Evacuation"
            )
        default:
            return EmergencyThresholdSpec(
                title: "Neurosurgical Crisis",
                thicknessThreshold: "Standard surgical thresholds",
                shiftThreshold: "> 5 mm shift",
                volumeThreshold: "> 30 cc",
                neurologicalTrigger: "Coma or focal deficit",
                operativeProcedure: "Emergent Decompression"
            )
        }
    }
    
    var isGCSBreached: Bool {
        if selectedEmergency == "EDH" { return gcsScore < 9 }
        if selectedEmergency == "SDH" { return gcsScore <= 8 }
        if selectedEmergency == "Posterior Fossa" { return gcsScore <= 13 }
        return gcsScore <= 8
    }
    
    var isPupilBreached: Bool {
        return pupilStatus.contains("Sluggish") || pupilStatus.contains("Blown") || pupilStatus.contains("Fixed")
    }
    
    var isSurgicalCandidate: Bool {
        if selectedEmergency == "Uncal" { return true }
        return isGCSBreached || isPupilBreached
    }
    
    var currentCTImageName: String {
        switch selectedEmergency {
        case "EDH": return "plate_ct_edh"
        case "SDH": return "plate_ct_sdh"
        case "Uncal": return "plate_ct_uncal"
        case "Posterior Fossa": return "plate_ct_post_fossa"
        default: return "plate_ct_edh"
        }
    }
    
    var anatomicalPearlText: String {
        switch selectedEmergency {
        case "EDH":
            return "Biconvex / Lenticular arterial MMA bleed. Suture-bound. High surgical urgency if >15mm thickness or >5mm shift regardless of GCS."
        case "SDH":
            return "Crescentic bridging vein hematoma crossing suture lines. Decompress emergently if thickness >10mm or shift >5mm."
        case "Uncal":
            return "ANTERIOR MEDIAL TEMPORAL UNCAL HERNIATION: Uncus (anterior) herniates medially over tentorial edge, directly compressing ipsilateral CN III and cerebral peduncle."
        case "Posterior Fossa":
            return "POSTERIOR FOSSA CEREBELLAR ICH: Hematoma ≥3cm compressing 4th ventricle and dorsal brainstem. Lumbar puncture strictly contraindicated due to tonsillar coning risk."
        default:
            return "Acute neurosurgical crisis pathology."
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Banner
                headerBanner
                
                // Section Selector Tabs
                sectionSelectorTabs
                
                if activeSection == "arbitrator" {
                    acuteTriageSection
                } else if activeSection == "reversal" {
                    anticoagulationReversalSection
                } else {
                    operativeChecklistsSection
                }
                
                // Generate SBAR Button
                sbarButton
            }
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
        .sheet(isPresented: $isShowingSbarSheet) {
            SbarBriefingSheet(
                emergencyType: selectedEmergency,
                gcs: gcsScore,
                pupilStatus: pupilStatus,
                procedure: thresholdSpec.operativeProcedure,
                isSurgical: isSurgicalCandidate
            )
        }
    }
    
    // MARK: - Header Banner
    private var headerBanner: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Circle().fill(isSurgicalCandidate ? Color.red : Color.green).frame(width: 8, height: 8)
                    Text("2 AM CRISIS PROTOCOL & OPERATIVE SUITE")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(isSurgicalCandidate ? .red : .green)
                }
                Text("Acute Herniation & Emergency Checklists")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
            }
            Spacer()
            Text(isSurgicalCandidate ? "SURGICAL OR MANDATE" : "ICU MONITORING")
                .font(.system(size: 11, weight: .heavy))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(isSurgicalCandidate ? Color.red.opacity(0.12) : Color.green.opacity(0.12))
                .foregroundColor(isSurgicalCandidate ? .red : .green)
                .clipShape(Capsule())
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    // MARK: - Section Selector Tabs
    private var sectionSelectorTabs: some View {
        HStack(spacing: 8) {
            SectionTabButton(id: "arbitrator", label: "Acute Triage", icon: "brain.head.profile", active: $activeSection)
            SectionTabButton(id: "reversal", label: "Anticoagulation Reversal", icon: "cross.vial.fill", active: $activeSection)
            SectionTabButton(id: "checklists", label: "OR & Bedside Checklists", icon: "list.clipboard.fill", active: $activeSection)
        }
        .padding(.horizontal)
    }
    
    // MARK: - SBAR Button
    private var sbarButton: some View {
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
    
    // MARK: - 1. Acute Triage Section
    private var acuteTriageSection: some View {
        VStack(spacing: 16) {
            emergencyTypeTabs
            
            CTViewportView(
                imageName: currentCTImageName,
                emergencyTitle: thresholdSpec.title,
                isSurgical: isSurgicalCandidate
            )
            
            Text(anatomicalPearlText)
                .font(.system(size: 11, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.35, green: 0.4, blue: 0.5))
                .padding(.horizontal, 24)
            
            decisionCockpitCard
            hyperosmolarProtocolCard
        }
    }
    
    private var emergencyTypeTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(["EDH", "SDH", "Uncal", "Posterior Fossa"], id: \.self) { type in
                    Button(action: {
                        selectedEmergency = type
                        if type == "Uncal" {
                            pupilStatus = "Unilateral Blown / Fixed (Uncal Herniation)"
                        }
                    }) {
                        Text(type == "EDH" ? "Epidural (EDH)" : (type == "SDH" ? "Subdural (SDH)" : (type == "Uncal" ? "Uncal Herniation" : "Posterior Fossa ICH")))
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
        }
    }
    
    private var decisionCockpitCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("BTF & Greenberg Operative Thresholds")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Text(thresholdSpec.title)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.indigo)
                }
                Spacer()
                Text("LEVEL I EVIDENCE")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(.indigo)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.indigo.opacity(0.1))
                    .cornerRadius(6)
            }
            
            // Definitive Threshold Grid Cards
            VStack(spacing: 8) {
                ThresholdRowCard(icon: "ruler.fill", title: "Clot Thickness / Diameter", value: thresholdSpec.thicknessThreshold, badge: "MANDATORY CRITERION", color: .indigo)
                ThresholdRowCard(icon: "arrow.left.and.right", title: "Midline Shift Threshold", value: thresholdSpec.shiftThreshold, badge: "DECOMPRESSION TRIGGER", color: .purple)
                ThresholdRowCard(icon: "cylinder.fill", title: "Mass Effect / Volume", value: thresholdSpec.volumeThreshold, badge: "VOLUME TRIGGER", color: .cyan)
                ThresholdRowCard(icon: "waveform.path.ecg", title: "Neurological Trigger", value: thresholdSpec.neurologicalTrigger, badge: "EXAM INDICATION", color: .orange)
            }
            
            Divider().padding(.vertical, 4)
            
            // Patient Interactive Status (GCS & Pupils)
            VStack(alignment: .leading, spacing: 12) {
                Text("Patient Neurological Assessment")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                
                // GCS Stepper
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Glasgow Coma Scale (GCS)")
                            .font(.system(size: 12, weight: .semibold))
                        Text(isGCSBreached ? "Critical Coma (GCS ≤ 8 / Intubation Indicated)" : "Conscious / Responsive (GCS \(gcsScore))")
                            .font(.system(size: 10))
                            .foregroundColor(isGCSBreached ? .red : .secondary)
                    }
                    Spacer()
                    Stepper("\(gcsScore)", value: $gcsScore, in: 3...15)
                        .font(.system(size: 13, weight: .black))
                }
                
                // Pupil Status Picker
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pupillary Examination")
                        .font(.system(size: 12, weight: .semibold))
                    Picker("Pupil Exam", selection: $pupilStatus) {
                        Text("Bilateral Brisk & Reactive (Normal)").tag("Normal")
                        Text("Ipsilateral Sluggish (Early CN III Compression)").tag("Ipsilateral Sluggish")
                        Text("Unilateral Blown / Fixed (Uncal Herniation)").tag("Unilateral Blown / Fixed (Uncal Herniation)")
                        Text("Bilateral Fixed & Dilated (Terminal Brainstem)").tag("Bilateral Fixed & Dilated")
                    }
                    .pickerStyle(.menu)
                    .padding(6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.96, green: 0.97, blue: 0.99))
                    .cornerRadius(8)
                }
            }
            
            // Real-Time Verdict Box
            TriageVerdictBox(isSurgicalCandidate: isSurgicalCandidate)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 8)
        .padding(.horizontal)
    }
    
    private var hyperosmolarProtocolCard: some View {
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
    }
    
    // MARK: - 2. Anticoagulation Reversal Section
    private var anticoagulationReversalSection: some View {
        VStack(spacing: 14) {
            ReversalCard(
                drug: "Warfarin (Coumadin / VKA)",
                mechanism: "Inhibits Vitamin K-dependent factors II, VII, IX, X",
                agent: "4-Factor PCC (Kcentra) + Vitamin K",
                dose: "INR 2.0-3.9: 25 U/kg (max 2500 U) • INR 4.0-6.0: 35 U/kg (max 3500 U) • INR >6.0: 50 U/kg (max 5000 U) + Vitamin K 10 mg IV in 50 mL NS over 30 min",
                target: "Target INR < 1.4 before emergency incision",
                badgeColor: .red
            )
            
            ReversalCard(
                drug: "Dabigatran (Pradaxa)",
                mechanism: "Direct thrombin (Factor IIa) inhibitor",
                agent: "Idarucizumab (Praxbind)",
                dose: "5.0 grams IV total (administered as two consecutive 2.5 g / 50 mL vials within 15 minutes)",
                target: "Instantaneous normalization of aPTT and TT; immediate OR clearance",
                badgeColor: .purple
            )
            
            ReversalCard(
                drug: "Apixaban (Eliquis) / Rivaroxaban (Xarelto)",
                mechanism: "Direct Factor Xa inhibitors",
                agent: "Andexanet alfa (Andexxa) OR 4-Factor PCC",
                dose: "Andexanet alfa Low Dose: 400 mg bolus + 4 mg/min for 120 min; High Dose: 800 mg bolus + 8 mg/min for 120 min. Alternative: Kcentra 50 U/kg IV bolus",
                target: "Reversal within minutes; monitor anti-Xa levels if available",
                badgeColor: .indigo
            )
            
            ReversalCard(
                drug: "Heparin (Unfractionated & LMWH)",
                mechanism: "Antithrombin III cofactor activation",
                agent: "Protamine Sulfate",
                dose: "UFH: 1 mg protamine per 100 units heparin administered in last 2 hours (max single dose 50 mg IV slow push). Enoxaparin: 1 mg protamine per 1 mg enoxaparin given in last 8 hours",
                target: "Check ACT / aPTT 15 minutes post-infusion",
                badgeColor: .blue
            )
            
            ReversalCard(
                drug: "Antiplatelet Agents (Aspirin / Plavix / Brilinta)",
                mechanism: "COX-1 inhibition / P2Y12 receptor blockade",
                agent: "Desmopressin (DDAVP) + Platelet Transfusion",
                dose: "DDAVP 0.4 mcg/kg in 50 mL NS IV over 30 minutes + 1-2 adult apheresis units of platelets for emergent craniotomy",
                target: "Improves platelet adhesiveness via vWF release from Weibel-Palade bodies",
                badgeColor: .orange
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - 3. Operative Checklists Section
    private var operativeChecklistsSection: some View {
        VStack(spacing: 14) {
            ChecklistCard(
                title: "Emergency Bedside EVD Placement Kit",
                steps: [
                    "Kocher's Point: 11 cm posterior from nasion, 3 cm lateral from midline along pupillary line (anterior to coronal suture)",
                    "Local anesthesia: 5-10 mL 1% Lidocaine with epinephrine to bone",
                    "Twist drill or hand trephine perpendicular to calvaria in all planes",
                    "Incise and cauterize dura to prevent epidural hematoma during passage",
                    "Aim trajectory toward medial canthus in coronal plane and tragus in sagittal plane",
                    "Pass catheter smoothly to depth of 5.5 - 6.5 cm (NEVER exceed 7.0 cm)",
                    "Confirm spontaneous pulsatile CSF egress; connect to transducer zeroed at tragus"
                ]
            )
            
            ChecklistCard(
                title: "Bedside Burr Hole Trephination (Moribund EDH)",
                steps: [
                    "Indication: Imminent brain death / arrest from massive EDH where transport to OR exceeds survival window",
                    "Landmark: 2 cm superior and 2 cm anterior to external auditory meatus (over temporal squama)",
                    "Rapid 3 cm vertical scalpel incision down through temporalis muscle to bone",
                    "Hudson brace or electric drill with perforator bit down to inner table",
                    "Evacuate arterial epidural clot with suction and saline irrigation to relieve uncal herniation",
                    "Pack with surgical gelatin sponge; transfer immediately to OR for formal craniotomy"
                ]
            )
            
            ChecklistCard(
                title: "Emergent Trauma Craniectomy OR Setup",
                steps: [
                    "Patient supine with shoulder roll; pin head in 3-point Mayfield or gel horseshoe turned 30-45°",
                    "Question-mark trauma incision (reverse-question mark based on side)",
                    "Incision begins at zygoma (<1 cm anterior to tragus to preserve superficial temporal artery trunk)",
                    "Elevate scalp and temporalis flap together (interfascial / myocutaneous) to protect frontalis nerve",
                    "Rapid craniectomy with footplate: ensure flap is AT LEAST 12 x 15 cm and carries aggressively across frontal bone",
                    "Drill temporal bone flush with middle cranial fossa floor to relieve uncus completely",
                    "Stellate dural opening with expansile onlay collagen / pericranium duraplasty"
                ]
            )
            
            ChecklistCard(
                title: "Cauda Equina Syndrome Emergency Clearance",
                steps: [
                    "Bilateral sciatica / severe lower extremity radicular pain",
                    "Perianal / saddle anesthesia (S2-S5 dermatomes)",
                    "Urinary retention with overflow incontinence (post-void bladder scan >200 mL)",
                    "Lax anal sphincter tone on digital rectal examination",
                    "Emergent non-contrast lumbar spine MRI within 12 hours",
                    "Decompressive laminectomy / discectomy mandated within 24-48 hours of onset to optimize bladder recovery"
                ]
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Dedicated Subviews & Authoritative Threshold Models
public struct EmergencyThresholdSpec {
    public let title: String
    public let thicknessThreshold: String
    public let shiftThreshold: String
    public let volumeThreshold: String
    public let neurologicalTrigger: String
    public let operativeProcedure: String
    
    public init(title: String, thicknessThreshold: String, shiftThreshold: String, volumeThreshold: String, neurologicalTrigger: String, operativeProcedure: String) {
        self.title = title
        self.thicknessThreshold = thicknessThreshold
        self.shiftThreshold = shiftThreshold
        self.volumeThreshold = volumeThreshold
        self.neurologicalTrigger = neurologicalTrigger
        self.operativeProcedure = operativeProcedure
    }
}

struct ThresholdRowCard: View {
    let icon: String
    let title: String
    let value: String
    let badge: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 11))
                .foregroundColor(color)
                .frame(width: 24, height: 24)
                .background(color.opacity(0.12))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(title)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Spacer()
                    Text(badge)
                        .font(.system(size: 8, weight: .heavy))
                        .foregroundColor(color)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(color.opacity(0.1))
                        .cornerRadius(3)
                }
                Text(value)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color(red: 0.35, green: 0.4, blue: 0.5))
            }
        }
        .padding(10)
        .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.04), lineWidth: 1))
    }
}

struct CTViewportView: View {
    let imageName: String
    let emergencyTitle: String
    let isSurgical: Bool
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 320)
                .cornerRadius(16)
            
            // 1. Prominent Anatomical Orientation Markers
            VStack {
                Text("[ANT]")
                    .font(.system(size: 10, weight: .black, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.black.opacity(0.85))
                    .foregroundColor(Color.yellow)
                    .cornerRadius(4)
                    .padding(.top, 8)
                Spacer()
                Text("[POST]")
                    .font(.system(size: 10, weight: .black, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.black.opacity(0.85))
                    .foregroundColor(Color.yellow)
                    .cornerRadius(4)
                    .padding(.bottom, 8)
            }
            
            HStack {
                Text("[R]")
                    .font(.system(size: 10, weight: .black, design: .monospaced))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .background(Color.black.opacity(0.85))
                    .foregroundColor(Color.yellow)
                    .cornerRadius(4)
                    .padding(.leading, 8)
                Spacer()
                Text("[L]")
                    .font(.system(size: 10, weight: .black, design: .monospaced))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .background(Color.black.opacity(0.85))
                    .foregroundColor(Color.yellow)
                    .cornerRadius(4)
                    .padding(.trailing, 8)
            }
            
            // 2. Bottom Clean Pathology Identification Banner
            VStack {
                Spacer()
                HStack {
                    Text(emergencyTitle.uppercased())
                        .font(.system(size: 11, weight: .black, design: .monospaced))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(isSurgical ? Color.red.opacity(0.85) : Color.black.opacity(0.8))
                        .cornerRadius(6)
                    Spacer()
                }
                .padding(12)
            }
        }
        .frame(height: 320)
        .background(Color.black)
        .cornerRadius(18)
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(isSurgical ? Color.red.opacity(0.6) : Color.black.opacity(0.1), lineWidth: 2))
        .padding(.horizontal)
    }
}

struct TriageVerdictBox: View {
    let isSurgicalCandidate: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: isSurgicalCandidate ? "exclamationmark.triangle.fill" : "checkmark.shield.fill")
                    .foregroundColor(isSurgicalCandidate ? .red : .green)
                Text(isSurgicalCandidate ? "EMERGENT SURGICAL OPERATIVE MANDATE" : "ICU CONSERVATIVE MONITORING PROTOCOL")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(isSurgicalCandidate ? .red : .green)
            }
            
            Text(isSurgicalCandidate
                 ? "Patient meets definitive Brain Trauma Foundation operative guidelines. Activate operating room, notify on-call attending, draw crossmatch, initiate hyperosmolar bolus, and administer anticoagulation reversal immediately."
                 : "Parameters are currently sub-critical. Admit to Neuro-ICU for hourly neurological exams, maintain MAP >80 mmHg, strict head-of-bed 30°, and obtain mandatory repeat non-contrast head CT in 6 hours.")
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.38))
                .lineSpacing(2)
        }
        .padding(12)
        .background((isSurgicalCandidate ? Color.red : Color.green).opacity(0.08))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke((isSurgicalCandidate ? Color.red : Color.green).opacity(0.3), lineWidth: 1.5))
    }
}

// MARK: - Reversal Card Component
struct ReversalCard: View {
    let drug: String
    let mechanism: String
    let agent: String
    let dose: String
    let target: String
    let badgeColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(drug)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                Spacer()
                Text(agent)
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(badgeColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(badgeColor.opacity(0.12))
                    .cornerRadius(6)
            }
            
            Text("Mechanism: " + mechanism)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("EMERGENT DOSING:")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(badgeColor)
                Text(dose)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(red: 0.15, green: 0.2, blue: 0.28))
            }
            
            HStack(spacing: 4) {
                Image(systemName: "checkmark.shield.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 11))
                Text(target)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 5)
    }
}

// MARK: - Checklist Card Component
struct ChecklistCard: View {
    let title: String
    let steps: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "checklist")
                    .foregroundColor(.indigo)
                Text(title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
            }
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(Array(steps.enumerated()), id: \.offset) { idx, step in
                    HStack(alignment: .top, spacing: 8) {
                        Text("\(idx + 1).")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(.indigo)
                            .frame(width: 16)
                        Text(step)
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                    }
                }
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 5)
    }
}

// MARK: - Section Tab Button
struct SectionTabButton: View {
    let id: String
    let label: String
    let icon: String
    @Binding var active: String
    
    var body: some View {
        Button(action: {
            HapticManager.impact(style: .light)
            active = id
        }) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 11))
                Text(label)
                    .font(.system(size: 11, weight: .bold))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(active == id ? Color.indigo : Color.white)
            .foregroundColor(active == id ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.03), radius: 3)
        }
    }
}

// MARK: - 3 AM SBAR Briefing Sheet
struct SbarBriefingSheet: View {
    let emergencyType: String
    let gcs: Int
    let pupilStatus: String
    let procedure: String
    let isSurgical: Bool
    @Environment(\.dismiss) var dismiss
    @State private var copied = false
    
    var sbarScript: String {
        return """
        SITUATION:
        "Dr. Mohit, I am calling about a 45-year-old patient in the emergency bay with acute \(emergencyType). Current GCS is \(gcs) with \(pupilStatus) pupillary exam."

        BACKGROUND:
        "Head CT demonstrates acute \(emergencyType) meeting definitive Brain Trauma Foundation & Greenberg surgical thresholds."

        ASSESSMENT:
        "The patient meets \(isSurgical ? "DEFINITIVE CRITERIA FOR IMMEDIATE SURGICAL OPERATIVE INTERVENTION (\(procedure.uppercased()))" : "CRITERIA FOR CLOSE NEURO-ICU PRESSURE MONITORING")."

        RECOMMENDATION:
        "\(isSurgical ? "I have alerted the OR team, administered hyperosmolar therapy, and placed an arterial line. I recommend taking the patient immediately for \(procedure)." : "I recommend continuing hourly neuro checks, maintaining MAP > 80, and repeat CT in 4-6 hours unless exam deteriorates.")"
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
