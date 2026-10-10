import SwiftUI

public struct NeurosurgicalProceduresView: View {
    @State private var selectedProcedure = "evd"
    
    let procedures = [
        ("evd", "External Ventricular Drain (EVD)", "Kocher's Point Ventriculostomy", "cross.fill", Color.indigo),
        ("lumbar_drain", "Lumbar Drain Insertion", "L3-L4 / L4-L5 Subarachnoid Access", "arrow.down.to.line.compact", Color.teal),
        ("camino_bolt", "Camino / Intraparenchymal Bolt", "Direct Fiberoptic ICP Monitor", "bolt.shield.fill", Color.orange),
        ("icp_waveform", "ICP Waveforms (P1, P2, P3)", "Compliance & Lundberg Waves", "waveform.path.ecg", Color.red)
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("PROCEDURAL ATLAS & HARDWARE")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.indigo)
                    Text("Neurosurgical Procedures & ICP Monitoring")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Procedure Selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(procedures, id: \.0) { proc in
                            Button(action: { selectedProcedure = proc.0 }) {
                                HStack(spacing: 6) {
                                    Image(systemName: proc.3)
                                    Text(proc.0 == "evd" ? "EVD (Kocher's)" : (proc.0 == "lumbar_drain" ? "Lumbar Drain" : (proc.0 == "camino_bolt" ? "Camino Bolt" : "ICP Waves")))
                                }
                                .font(.system(size: 12, weight: .bold))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(selectedProcedure == proc.0 ? proc.4 : Color.white)
                                .foregroundColor(selectedProcedure == proc.0 ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.04), radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Dynamic Anatomic Diagram & Technical Step-by-Step
                if selectedProcedure == "evd" {
                    EVDDetailCard()
                } else if selectedProcedure == "lumbar_drain" {
                    LumbarDrainDetailCard()
                } else if selectedProcedure == "camino_bolt" {
                    CaminoBoltDetailCard()
                } else {
                    ICPWaveformDetailCard()
                }
            }
            .padding(.bottom, 24)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}

// MARK: - EVD Kocher's Point Card
struct EVDDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Schematic Drawing
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.94, green: 0.96, blue: 0.99))
                    .frame(height: 200)
                
                VStack(spacing: 6) {
                    // Skull profile
                    ZStack {
                        Circle()
                            .stroke(Color.slateBorder, lineWidth: 8)
                            .frame(width: 140, height: 140)
                        
                        // Coronal suture line
                        Rectangle()
                            .fill(Color.indigo.opacity(0.6))
                            .frame(width: 120, height: 3)
                            .offset(y: -15)
                        
                        // Sagittal midline
                        Rectangle()
                            .fill(Color.indigo.opacity(0.6))
                            .frame(width: 3, height: 130)
                        
                        // Kocher's Point Drill Hole
                        Circle()
                            .fill(Color.red)
                            .frame(width: 16, height: 16)
                            .offset(x: 28, y: -26)
                        
                        // Catheter trajectory vector
                        LineShape()
                            .stroke(Color.teal, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [4, 2]))
                            .frame(width: 50, height: 60)
                            .offset(x: 34, y: 10)
                    }
                    
                    Text("Kocher's Point: 1 cm anterior to Coronal Suture, 2.5–3 cm lateral to Midline (Mid-Pupillary Line)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.4))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            .padding(.horizontal)
            
            // Critical Anatomic Trajectory Rules
            VStack(alignment: .leading, spacing: 10) {
                Text("THE 3 GOLDEN TRAJECTORY RULES:")
                    .font(.system(size: 12, weight: .black))
                    .foregroundColor(.indigo)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Text("1.")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.indigo)
                        Text("Coronal Aim: Toward the **Ipsilateral Medial Canthus** (Inner eye corner).")
                            .font(.system(size: 12))
                    }
                    HStack(alignment: .top) {
                        Text("2.")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.indigo)
                        Text("Sagittal Aim: Perpendicular to skull, aimed toward **External Auditory Meatus (Tragus)**.")
                            .font(.system(size: 12))
                    }
                    HStack(alignment: .top) {
                        Text("3.")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.indigo)
                        Text("Depth Limit: **Never exceed 5.5 to 6.0 cm from inner table**. Ventricle is entered at 4.5–5.0 cm (Foramen of Monro).")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.red)
                    }
                }
                .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.04), radius: 6)
            .padding(.horizontal)
            
            // Troubleshooting & Zeroing
            VStack(alignment: .leading, spacing: 8) {
                Text("Transducer Leveling & Troubleshooting:")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.primary)
                Text("• **Zero Reference Point:** Level transducer chamber to the **External Auditory Meatus (Tragus)** (Foramen of Monro proxy).")
                    .font(.system(size: 11))
                Text("• **No CSF Flow / Dampened Waveform:** 1) Lower chamber briefly below head; 2) Check stopcock position; 3) Lower flush only AWAY from head; **NEVER flush toward brain!**")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.red)
            }
            .padding()
            .background(Color(red: 0.99, green: 0.95, blue: 0.95))
            .cornerRadius(16)
            .padding(.horizontal)
        }
    }
}

// MARK: - Lumbar Drain Card
struct LumbarDrainDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Lumbar Subarachnoid Drain Insertion Protocol")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.teal)
                
                Text("Indications: Normal Pressure Hydrocephalus (NPH) trial tap, skull base CSF leak diversion, thoracoabdominal aneurysm spinal cord protection.")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("• **Target Space:** L3-L4 or L4-L5 (Tuffier's line connects superior iliac crests to L4 body/interspace).")
                        .font(.system(size: 12))
                    Text("• **Tuohy Needle Bevel:** Insert with bevel facing **CEPHALAD** (parallel to dural fibers) to minimize dural tear.")
                        .font(.system(size: 12))
                    Text("• **Catheter Insertion Depth:** Advance catheter **8 to 10 cm into subarachnoid space** beyond needle tip. Never pull catheter back through Tuohy needle (shearing risk).")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.indigo)
                    Text("• **Over-Drainage Warning:** Target 5–10 mL/hr. Excessive drainage causes subdural hematoma from bridging vein traction or transtentorial sagging.")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.red)
                }
                .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.04), radius: 6)
            .padding(.horizontal)
        }
    }
}

// MARK: - Camino Bolt Card
struct CaminoBoltDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Camino / Fiberoptic Intraparenchymal Bolt Placement")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.orange)
                
                Text("Indications: TBI monitoring when ventricles are slit-like/compressed and EVD cannot be cannulated.")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("• **Location:** Non-dominant frontal lobe (Right Kocher's point) or 2 cm anterior to coronal suture.")
                        .font(.system(size: 12))
                    Text("• **Hand Drill Technique:** Set drill safety stop to **1.0 cm**. Drill perpendicular to calvarium until inner table gives way.")
                        .font(.system(size: 12))
                    Text("• **Dural Puncture:** Pierce dura sharply with 18G needle before screwing bolt into bone.")
                        .font(.system(size: 12))
                    Text("• **Parenchymal Probe Depth:** Transducer fiberoptic tip rests **1.5 to 2.0 cm into white matter**. Do not bend fiberoptic cable.")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.indigo)
                }
                .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.04), radius: 6)
            .padding(.horizontal)
        }
    }
}

// MARK: - ICP Waveforms Card
struct ICPWaveformDetailCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Intracranial Pressure (ICP) Waveform Morphology")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.red)
                
                Text("Normal intracranial compliance displays **P1 > P2 > P3**. Loss of compliance reverses this hierarchy to **P2 > P1**.")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("• **P1 (Percussion Wave):** Arterial choroid plexus pulsation. Sharp peak.")
                        .font(.system(size: 12))
                    Text("• **P2 (Tidal Wave):** Cerebral brain tissue compliance. **If P2 elevates above P1, intracranial compliance is EXHAUSTED!**")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.red)
                    Text("• **P3 (Dicrotic Wave):** Aortic valve closure transmission. Venous drainage.")
                        .font(.system(size: 12))
                    Text("• **Lundberg A Waves (Plateau Waves):** Sudden steep ICP spike to 50–100 mmHg lasting 5–20 min. Premonitory sign of acute brain herniation.")
                        .font(.system(size: 12, weight: .heavy))
                        .foregroundColor(.red)
                }
                .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.04), radius: 6)
            .padding(.horizontal)
        }
    }
}

struct LineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        return path
    }
}

extension Color {
    static let slateBorder = Color(red: 0.85, green: 0.88, blue: 0.92)
}
