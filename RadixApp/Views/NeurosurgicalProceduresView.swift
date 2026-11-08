import SwiftUI

// MARK: - Bedside Procedural Atlas & Hardware Suite
// Synthesized from Greenberg Handbook of Neurosurgery, Ellenbogen Principles of Neurosurgery,
// and Brain Trauma Foundation (BTF) Bedside Hardware Standards.
// Designed with Apple Pro-Tier Obsidian Dark Theme, high-contrast anatomical schematics,
// pinch-to-zoom vector diagrams, step-by-step technical guides, contraindications, and emergency troubleshooting.

public struct NeurosurgicalProceduresView: View {
    @State private var selectedProcedure = "evd"
    
    struct ProcedureItem: Identifiable {
        let id: String
        let title: String
        let subtitle: String
        let icon: String
        let accentColor: Color
    }
    
    let procedures: [ProcedureItem] = [
        ProcedureItem(id: "evd", title: "Kocher's EVD", subtitle: "Frontal Ventriculostomy", icon: "cross.fill", accentColor: ObsidianTheme.neonCyan),
        ProcedureItem(id: "camino_bolt", title: "Camino Bolt & ICP Waves", subtitle: "Parenchymal Probe & Lundberg", icon: "waveform.path.ecg", accentColor: Color.orange),
        ProcedureItem(id: "lumbar_puncture", title: "Lumbar Puncture (LP)", subtitle: "L3-L4 / L4-L5 Manometry", icon: "gauge.with.needle.fill", accentColor: Color.teal),
        ProcedureItem(id: "lumbar_drain", title: "Continuous Lumbar Drain", subtitle: "Tuohy Subarachnoid Diversion", icon: "arrow.down.to.line.compact", accentColor: Color.cyan),
        ProcedureItem(id: "art_line", title: "Radial Arterial Line", subtitle: "Modified Seldinger Cannulation", icon: "heart.pulse.fill", accentColor: Color.red),
        ProcedureItem(id: "cvc_line", title: "Ultrasound IJV CVC", subtitle: "Sedillot's Triangle Access", icon: "point.topleft.down.to.point.bottomright.curvepath.fill", accentColor: Color.purple)
    ]
    
    public init() {}
    
    private func selectAdjacent(direction: Int) {
        guard let idx = procedures.firstIndex(where: { $0.id == selectedProcedure }) else { return }
        let nextIdx = (idx + direction + procedures.count) % procedures.count
        HapticManager.impact(style: .light)
        withAnimation(.easeInOut(duration: 0.22)) {
            selectedProcedure = procedures[nextIdx].id
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                headerView
                
                // Horizontal Procedure Selector Pills
                procedureSelectorBar
                
                // Active Procedure Detail Card
                Group {
                    switch selectedProcedure {
                    case "evd":
                        EVDDetailCard()
                    case "camino_bolt":
                        CaminoBoltDetailCard()
                    case "lumbar_puncture":
                        LumbarPunctureDetailCard()
                    case "lumbar_drain":
                        LumbarDrainDetailCard()
                    case "art_line":
                        RadialArterialLineDetailCard()
                    case "cvc_line":
                        InternalJugularCVCDetailCard()
                    default:
                        EVDDetailCard()
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 35)
                        .onEnded { value in
                            if value.translation.width < -40 {
                                selectAdjacent(direction: 1)
                            } else if value.translation.width > 40 {
                                selectAdjacent(direction: -1)
                            }
                        }
                )
                
                Spacer(minLength: 32)
            }
            .padding(.top, 8)
        }
        .background(ObsidianTheme.surfaceVoid)
    }
    
    // MARK: - Header
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Circle().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 8)
                Text("BEDSIDE PROCEDURAL ATLAS & HARDWARE")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.8)
                    .foregroundColor(ObsidianTheme.neonCyan)
            }
            Text("Frontline Neurosurgical Procedures")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Real-time anatomical landmarks, trajectory rules, transducer leveling, and emergency troubleshooting.")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    // MARK: - Selector Bar
    private var procedureSelectorBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(procedures) { proc in
                    Button(action: {
                        HapticManager.impact(style: .light)
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedProcedure = proc.id
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: proc.icon)
                                .font(.system(size: 11, weight: .bold))
                            Text(proc.title)
                                .font(.system(size: 11, weight: .bold))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(selectedProcedure == proc.id ? proc.accentColor : ObsidianTheme.surfaceGlass)
                        .foregroundColor(selectedProcedure == proc.id ? (proc.accentColor == ObsidianTheme.neonCyan ? .black : .white) : ObsidianTheme.textSecondary)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedProcedure == proc.id ? proc.accentColor : ObsidianTheme.borderSubtle, lineWidth: 1)
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - 1. EVD Kocher's Point Card
struct EVDDetailCard: View {
    @State private var zoomScale: CGFloat = 1.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Schematic Diagram with Pinch-to-Zoom
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.06, green: 0.08, blue: 0.12))
                    .frame(height: 220)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
                
                VStack(spacing: 8) {
                    ZStack {
                        // Skull Contour
                        Circle()
                            .stroke(ObsidianTheme.textMuted.opacity(0.4), lineWidth: 3)
                            .frame(width: 140, height: 140)
                        
                        // Coronal Suture Line
                        Rectangle()
                            .fill(ObsidianTheme.neonCyan.opacity(0.7))
                            .frame(width: 130, height: 2.5)
                            .offset(y: -18)
                        
                        // Sagittal Midline
                        Rectangle()
                            .fill(ObsidianTheme.neonCyan.opacity(0.7))
                            .frame(width: 2.5, height: 135)
                        
                        // Kocher's Point Entry (Burr Hole)
                        Circle()
                            .fill(Color.red)
                            .frame(width: 14, height: 14)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                            .offset(x: 30, y: -30)
                        
                        // Cannulation Trajectory Vector
                        Path { path in
                            path.move(to: CGPoint(x: 100, y: 40))
                            path.addLine(to: CGPoint(x: 70, y: 70))
                        }
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [4, 3]))
                    }
                    .scaleEffect(zoomScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { val in zoomScale = max(1.0, min(2.5, val)) }
                            .onEnded { _ in withAnimation { zoomScale = 1.0 } }
                    )
                    
                    Text("KOCHER'S POINT: 1 cm Ant. to Coronal Suture | 2.5-3.0 cm Lat. to Midline (Mid-Pupillary)")
                        .font(.system(size: 9, weight: .heavy, design: .monospaced))
                        .foregroundColor(ObsidianTheme.neonCyan)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                }
            }
            .padding(.horizontal)
            
            // Golden Trajectory Rules
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "compass.drawing")
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Text("THE 3 GOLDEN TRAJECTORY RULES")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    TrajectoryStepRow(number: "1", title: "Coronal Plane Target", detail: "Aimed strictly toward the **Ipsilateral Medial Canthus** (Inner eye corner).")
                    TrajectoryStepRow(number: "2", title: "Sagittal Plane Target", detail: "Perpendicular to skull curvature, aimed toward the **External Auditory Meatus (Tragus)**.")
                    TrajectoryStepRow(number: "3", title: "Depth Warning Limit", detail: "CSF flash typically at **4.5 - 5.0 cm** (Foramen of Monro). **NEVER advance beyond 6.0 cm** from outer skull cortex!")
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
            
            // Leveling & Troubleshooting
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                    Text("TRANSDUCER LEVELING & TROUBLESHOOTING")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.yellow)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("• **Zero Reference Point:** Level transducer chamber to the **External Auditory Meatus (Tragus)** (Foramen of Monro proxy).")
                        .font(.system(size: 11))
                        .foregroundColor(ObsidianTheme.textPrimary)
                    Text("• **Dampened Waveform / No Flow:** 1) Briefly lower drip chamber below head; 2) Confirm stopcock positions; 3) Check tubing for air or blood clots; 4) Flush **ONLY AWAY FROM HEAD**; **NEVER flush forcefully toward brain parenchyma!**")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(Color.red.opacity(0.9))
                }
            }
            .padding()
            .background(Color.yellow.opacity(0.06))
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.yellow.opacity(0.3), lineWidth: 1))
            .padding(.horizontal)
        }
    }
}

// MARK: - 2. Camino Bolt & ICP Waveforms Card
struct CaminoBoltDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Waveform Anatomy Diagram
            VStack(alignment: .leading, spacing: 8) {
                Text("ICP PULSE MORPHOLOGY & COMPLIANCE")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(Color.orange)
                
                // Visual Waveform Curve
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(red: 0.06, green: 0.08, blue: 0.12))
                        .frame(height: 140)
                    
                    VStack {
                        HStack(spacing: 24) {
                            VStack(spacing: 2) {
                                Text("P1 (Percussion)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(ObsidianTheme.neonCyan)
                                Text("Arterial pulse")
                                    .font(.system(size: 8))
                                    .foregroundColor(ObsidianTheme.textMuted)
                            }
                            VStack(spacing: 2) {
                                Text("P2 (Tidal)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.orange)
                                Text("Brain Compliance")
                                    .font(.system(size: 8))
                                    .foregroundColor(ObsidianTheme.textMuted)
                            }
                            VStack(spacing: 2) {
                                Text("P3 (Dicrotic)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.purple)
                                Text("Venous outflow")
                                    .font(.system(size: 8))
                                    .foregroundColor(ObsidianTheme.textMuted)
                            }
                        }
                        .padding(.top, 8)
                        
                        // Schematic Wave Peak Curves
                        HStack(alignment: .bottom, spacing: 20) {
                            Capsule().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 75)
                            Capsule().fill(Color.orange).frame(width: 8, height: 55)
                            Capsule().fill(Color.purple).frame(width: 8, height: 40)
                            
                            Spacer().frame(width: 20)
                            
                            // Decompensated state
                            VStack(spacing: 2) {
                                Text("EXHAUSTED COMPLIANCE")
                                    .font(.system(size: 8, weight: .black))
                                    .foregroundColor(.red)
                                HStack(alignment: .bottom, spacing: 8) {
                                    Capsule().fill(ObsidianTheme.neonCyan.opacity(0.6)).frame(width: 6, height: 50)
                                    Capsule().fill(Color.red).frame(width: 8, height: 75)
                                    Capsule().fill(Color.purple.opacity(0.6)).frame(width: 6, height: 40)
                                }
                            }
                        }
                        .padding(.bottom, 8)
                    }
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
            
            // Lundberg Wave Classifications
            VStack(alignment: .leading, spacing: 10) {
                Text("LUNDBERG WAVE PATTERN RECOGNITION")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(ObsidianTheme.neonCyan)
                
                LundbergWaveRow(wave: "A (Plateau)", range: "50 - 100 mmHg (5 - 20 min)", meaning: "CRITICAL: Terminal intracranial decompensation. Immediate hyperosmolar or surgical rescue required!", color: .red)
                LundbergWaveRow(wave: "B (Oscillatory)", range: "Up to 50 mmHg (0.5 - 2 min)", meaning: "Cerebral vasospasm, unstable compliance, or Cheyne-Stokes respiration.", color: .orange)
                LundbergWaveRow(wave: "C (Rhythmic)", range: "Low amplitude (4 - 8 / min)", meaning: "Benign physiological Traube-Hering vasomotor fluctuations.", color: .green)
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
            
            // Bolt Insertion Technique
            VStack(alignment: .leading, spacing: 8) {
                Text("Bolt Insertion Protocol:")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Text("1. Drill perpendicular to skull with safety collar set to **1.0 cm**.")
                    .font(.system(size: 11))
                Text("2. Perforate dura with 18G needle; screw skull bolt snugly into bone.")
                    .font(.system(size: 11))
                Text("3. Advance fiberoptic probe **1.5 to 2.0 cm into white matter**; zero sensor prior to parenchymal insertion per manufacturer protocol.")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(ObsidianTheme.neonCyan)
            }
            .foregroundColor(ObsidianTheme.textSecondary)
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
        }
    }
}

// MARK: - 3. Lumbar Puncture Card
struct LumbarPunctureDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "gauge.with.needle.fill")
                        .foregroundColor(.teal)
                    Text("LUMBAR PUNCTURE & OPENING PRESSURE")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.teal)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    TrajectoryStepRow(number: "1", title: "Interspace Localization", detail: "Palpate superior iliac crests (Tuffier's line) identifying **L4 spinous process**. Target **L3-L4** or **L4-L5** interspace.")
                    TrajectoryStepRow(number: "2", title: "Needle Trajectory & Bevel", detail: "Aim 20G or 22G Quincke needle **10-15 degrees cephalad** toward the umbilicus. Bevel facing **sagittal / lateral** to separate rather than cut longitudinal dural fibers.")
                    TrajectoryStepRow(number: "3", title: "Opening Pressure Manometry", detail: "Legs must be **relaxed / straightened** before reading manometer. Normal OP: **10 - 20 cm H2O** (elevated if > 25 cm H2O).")
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
            
            // Contraindications Alert
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "xmark.octagon.fill")
                        .foregroundColor(.red)
                    Text("ABSOLUTE CONTRAINDICATIONS")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.red)
                }
                Text("• Intracranial mass lesion with midline shift or effaced basilar cisterns (Brain herniation risk!)")
                    .font(.system(size: 11))
                Text("• Severe coagulopathy: Platelets < 50k, INR > 1.4 (Spinal epidural hematoma risk)")
                    .font(.system(size: 11))
                Text("• Cellulitis or skin infection over intended needle puncture site")
                    .font(.system(size: 11))
            }
            .foregroundColor(ObsidianTheme.textPrimary)
            .padding()
            .background(Color.red.opacity(0.08))
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.red.opacity(0.3), lineWidth: 1))
            .padding(.horizontal)
        }
    }
}

// MARK: - 4. Lumbar Drain Card
struct LumbarDrainDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "arrow.down.to.line.compact")
                        .foregroundColor(.cyan)
                    Text("CONTINUOUS LUMBAR SUBARACHNOID DRAIN")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.cyan)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    TrajectoryStepRow(number: "1", title: "Tuohy Needle Entry", detail: "14G Tuohy curved-tip needle entered at **L3-L4** with curve oriented cephalad.")
                    TrajectoryStepRow(number: "2", title: "Catheter Insertion", detail: "Thread subarachnoid catheter **8 - 10 cm beyond needle tip**. **NEVER pull catheter backward through needle** (shearing hazard).")
                    TrajectoryStepRow(number: "3", title: "Target Hourly Drainage", detail: "Maintain rate at **5 - 10 mL/hr** (never exceed 15-20 mL/hr). Level chamber to shoulder in lateral decubitus.")
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
            
            // Over-Drainage Warning
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: "exclamationmark.octagon.fill")
                        .foregroundColor(.orange)
                    Text("OVER-DRAINAGE TRAPPING & SAG")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.orange)
                }
                Text("Excessive CSF output leads to transtentorial brain sagging, tonsillar herniation, and subdural hematomas from bridging vein avulsion. Clamp drain immediately if patient reports severe headache or shows pupillary changes.")
                    .font(.system(size: 11))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding()
            .background(Color.orange.opacity(0.08))
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.orange.opacity(0.3), lineWidth: 1))
            .padding(.horizontal)
        }
    }
}

// MARK: - 5. Radial Arterial Line Card
struct RadialArterialLineDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "heart.pulse.fill")
                        .foregroundColor(.red)
                    Text("RADIAL ARTERIAL LINE PLACEMENT")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.red)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    TrajectoryStepRow(number: "1", title: "Wrist Positioning & Collateral Flow", detail: "Dorsiflex wrist 30-45 degrees with roll underneath. Palpate radial pulse 1-2 cm proximal to flexor crease.")
                    TrajectoryStepRow(number: "2", title: "Modified Seldinger / Angiocath", detail: "Enter skin at **30-45 degree angle**. Upon bright pulsatile flash, drop needle to **10-15 degrees**, advance 1 mm, and slide catheter over wire/needle.")
                    TrajectoryStepRow(number: "3", title: "Transducer Leveling & Phlebostatic Axis", detail: "Level pressure transducer to the **Phlebostatic Axis** (4th intercostal space, mid-axillary line) for systemic MAP or to **Tragus** for cerebral perfusion calculation.")
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
        }
    }
}

// MARK: - 6. Internal Jugular CVC Card
struct InternalJugularCVCDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "point.topleft.down.to.point.bottomright.curvepath.fill")
                        .foregroundColor(.purple)
                    Text("ULTRASOUND-GUIDED RIGHT IJV CENTRAL LINE")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.purple)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    TrajectoryStepRow(number: "1", title: "Sedillot's Triangle & Probe Placement", detail: "Between sternal and clavicular heads of SCM. Place high-frequency linear ultrasound probe with marker pointing to operator's left.")
                    TrajectoryStepRow(number: "2", title: "Vein vs Artery Confirmation", detail: "IJV is compressible, non-pulsatile, and expands with Trendelenburg / Valsalva. Carotid artery is medial, pulsatile, and thick-walled.")
                    TrajectoryStepRow(number: "3", title: "Seldinger Technique & Wire Control", detail: "Direct needle in-plane or out-of-plane into vein under direct visual guidance. Confirm dark non-pulsatile venous blood. Advance J-wire smoothly to 20 cm. **NEVER force wire against resistance!**")
                }
            }
            .padding()
            .background(ObsidianTheme.surfaceGlass)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            .padding(.horizontal)
        }
    }
}

// MARK: - Shared Helper Components
struct TrajectoryStepRow: View {
    let number: String
    let title: String
    let detail: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(number)
                .font(.system(size: 10, weight: .black))
                .foregroundColor(.black)
                .frame(width: 18, height: 18)
                .background(ObsidianTheme.neonCyan)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Text(LocalizedStringKey(detail))
                    .font(.system(size: 11))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
        }
    }
}

struct LundbergWaveRow: View {
    let wave: String
    let range: String
    let meaning: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Wave \(wave)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(color)
                Spacer()
                Text(range)
                    .font(.system(size: 10, weight: .semibold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textMuted)
            }
            Text(meaning)
                .font(.system(size: 10))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .padding(.vertical, 3)
    }
}
