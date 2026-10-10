import SwiftUI

public struct ScanNavigatorView: View {
    @State private var selectedModality = "Head CT"
    @State private var currentStep = 0
    
    // Head CT 60-Second Reading System: "Blood Can Be Very Bad"
    let headCTSteps = [
        ("B", "Blood", "Hyperdense white collections", "Epidural (lens, does not cross sutures) vs Subdural (crescent, crosses sutures) vs SAH in basal cisterns vs IPH.", Color.red),
        ("C", "Cisterns", "Ambient, suprasellar, quadrigeminal", "Look for effacement. Obliteration of perimesencephalic cisterns is an ominous sign of impending transtentorial herniation.", Color.teal),
        ("B", "Brain", "Symmetrical gray-white junction", "Loss of insular ribbon, sulcal effacement, hyperdense MCA sign, acute territorial hypoattenuation indicating stroke.", Color.indigo),
        ("V", "Ventricles", "Symmetrical, temporal horns slit-like", "Hydrocephalus (temporal horns > 2mm indicates high ICP), intraventricular hemorrhage with cast formation, midline shift > 5mm.", Color.blue),
        ("B", "Bone", "Intact skull vault & base", "Use Bone Window (3000/500 HU). Examine petrous temporal bone, cribriform plate, sphenoid air sinus fluid (CSF leak indicator).", Color.orange)
    ]
    
    // Spine MRI System: Sagittal to Axial Canal Evaluation
    let spineMRISteps = [
        ("A", "Alignment", "Normal cervical/lumbar lordosis", "Spondylolisthesis (Meyerding grades I-IV), retrolisthesis, focal kyphotic deformity, PLL rupture.", Color.purple),
        ("B", "Bone & Disc", "Hydrated T2 hyperintense discs", "Disc height loss, Modic endplate changes (I: edema, II: fatty, III: sclerotic), extruded vs sequestered fragments.", Color.indigo),
        ("C", "Cord Signal", "Homogeneous intermediate T2 gray", "Intramedullary T2 hyperintensity (myelomalacia/edema), cord compression ratio, epidural abscess/hematoma collection.", Color.red),
        ("D", "Dura & Canal", "Canal diameter > 12mm", "Central stenosis (< 10mm absolute), lateral recess stenosis (< 3mm), ligamentum flavum hypertrophy.", Color.teal),
        ("F", "Foramina", "Normal keyhole shape with fat ring", "Lee Classification (Grade 0: normal, Grade 1: mild, Grade 2: moderate with root distortion, Grade 3: severe obliteration).", Color.orange)
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("SYSTEMATIC 60-SECOND NEUROIMAGING")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.indigo)
                    Text("CT & MRI Rapid Decision Navigator")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Modality Picker
                HStack(spacing: 8) {
                    Button(action: { selectedModality = "Head CT"; currentStep = 0 }) {
                        HStack {
                            Image(systemName: "brain.head.profile")
                            Text("Head CT ('Blood Can Be Very Bad')")
                        }
                        .font(.system(size: 12, weight: .bold))
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(selectedModality == "Head CT" ? Color.indigo : Color.white)
                        .foregroundColor(selectedModality == "Head CT" ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.04), radius: 4)
                    }
                    
                    Button(action: { selectedModality = "Spine MRI"; currentStep = 0 }) {
                        HStack {
                            Image(systemName: "figure.walk")
                            Text("Spine MRI (Cord & Canal)")
                        }
                        .font(.system(size: 12, weight: .bold))
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(selectedModality == "Spine MRI" ? Color.indigo : Color.white)
                        .foregroundColor(selectedModality == "Spine MRI" ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.04), radius: 4)
                    }
                }
                .padding(.horizontal)
                
                // Active Systemic Step Card
                let steps = selectedModality == "Head CT" ? headCTSteps : spineMRISteps
                let step = steps[currentStep]
                
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(step.4)
                                .frame(width: 44, height: 44)
                            Text(step.0)
                                .font(.system(size: 20, weight: .black))
                                .foregroundColor(.white)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Step \(currentStep + 1) of \(steps.count): \(step.1)")
                                .font(.system(size: 16, weight: .black))
                                .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                            Text("Normal: \(step.2)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.55))
                        }
                        Spacer()
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("ACUTE RED FLAGS & SURGICAL PITFALLS:")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(step.4)
                        Text(step.3)
                            .font(.system(size: 13, weight: .medium))
                            .lineSpacing(4)
                            .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                    }
                    
                    // Stepper controls
                    HStack {
                        Button(action: {
                            if currentStep > 0 { currentStep -= 1 }
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Previous")
                            }
                            .font(.system(size: 12, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(Color(red: 0.94, green: 0.95, blue: 0.97))
                            .foregroundColor(currentStep > 0 ? Color.primary : Color.secondary.opacity(0.5))
                            .cornerRadius(10)
                        }
                        .disabled(currentStep == 0)
                        
                        Spacer()
                        
                        Button(action: {
                            if currentStep < steps.count - 1 { currentStep += 1 }
                        }) {
                            HStack {
                                Text("Next Step")
                                Image(systemName: "chevron.right")
                            }
                            .font(.system(size: 12, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(step.4)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(currentStep == steps.count - 1)
                    }
                    .padding(.top, 4)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(22)
                .shadow(color: Color.black.opacity(0.04), radius: 8)
                .padding(.horizontal)
                
                // Windowing Cheat Sheet for Head CT
                if selectedModality == "Head CT" {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Standard Head CT Hounsfield Window Settings")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("Brain Window:")
                                    .font(.system(size: 12, weight: .bold))
                                Spacer()
                                Text("W: 80 / L: 40 HU")
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.indigo)
                            }
                            HStack {
                                Text("Subdural Window:")
                                    .font(.system(size: 12, weight: .bold))
                                Spacer()
                                Text("W: 130–300 / L: 50–100 HU")
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.teal)
                            }
                            HStack {
                                Text("Bone Window:")
                                    .font(.system(size: 12, weight: .bold))
                                Spacer()
                                Text("W: 3000 / L: 500 HU")
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.orange)
                            }
                            HStack {
                                Text("Stroke Window:")
                                    .font(.system(size: 12, weight: .bold))
                                Spacer()
                                Text("W: 30 / L: 30 HU (Enhances gray-white contrast)")
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
                        .cornerRadius(14)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.04), radius: 6)
                    .padding(.horizontal)
                } else {
                    // Spine Canal Calipers
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Canal & Foraminal Stenosis Diagnostic Thresholds")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("Cervical Mid-Sagittal Canal:")
                                    .font(.system(size: 12, weight: .bold))
                                Spacer()
                                Text("< 10 mm (Critical Stenosis)")
                                    .font(.system(size: 12, weight: .black))
                                    .foregroundColor(.red)
                            }
                            HStack {
                                Text("Torg-Pavlov Ratio:")
                                    .font(.system(size: 12, weight: .bold))
                                Spacer()
                                Text("< 0.82 (Significant Stenosis)")
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.indigo)
                            }
                            HStack {
                                Text("Lumbar Lateral Recess:")
                                    .font(.system(size: 12, weight: .bold))
                                Spacer()
                                Text("< 3 mm (Trefoil Entrapment)")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding()
                        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
                        .cornerRadius(14)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.04), radius: 6)
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 24)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}
