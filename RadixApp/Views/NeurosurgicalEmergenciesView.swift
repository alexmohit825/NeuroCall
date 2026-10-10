import SwiftUI

public struct NeurosurgicalEmergenciesView: View {
    let emergencies = [
        ("cauda_equina", "Cauda Equina Syndrome (CES)", "Urgent Spine Decompression", "figure.walk", Color.red,
         "Acute disc herniation compressing lumbosacral nerve roots.",
         "Bilateral sciatica, saddle anesthesia, urinary retention (PVR > 200 mL), lax anal sphincter tone.",
         "Immediate non-contrast emergent lumbar MRI. Decompress within 24-48 hours of onset to prevent permanent bladder/bowel incontinence."),
        
        ("epidural_abscess", "Spinal Epidural Abscess (SEA)", "The Lethal Triad", "cross.fill", Color.orange,
         "Suppurative collection in spinal epidural space (often S. aureus).",
         "The Classic Triad: 1) Severe localized back pain; 2) Fever / night sweats; 3) Rapidly progressive neurological deficit / weakness.",
         "Total spine MRI with IV gadolinium contrast. STAT blood cultures. Do NOT perform LP through suspected abscess (meningitis seeding risk!). Urgent surgical evacuation + 6 weeks IV antibiotics."),
        
        ("sah_rupture", "Aneurysmal Subarachnoid Hemorrhage (aSAH)", "Thunderclap Cephalea", "waveform.path.ecg", Color.purple,
         "Rupture of intracranial berry aneurysm (ACom > PCom > MCA).",
         "'Worst headache of life' peaking within seconds, meningismus, GCS depression, subhyaloid retinal hemorrhages (Terson syndrome).",
         "Non-contrast Head CT (98% sensitive in first 6 hours). If CT negative and high suspicion, perform LP (xanthochromia). Target SBP < 140 mmHg. Start Nimodipine 60 mg q4h. STAT CTA head/neck for coiling vs clipping."),
        
        ("pituitary_apoplexy", "Pituitary Apoplexy", "Endocrine & Visual Crisis", "eye.fill", Color.indigo,
         "Acute infarction or hemorrhage into pre-existing pituitary macroadenoma.",
         "Sudden severe retro-orbital headache, bitemporal hemianopsia, ophthalmoplegia (CN III, IV, VI in cavernous sinus), acute adrenal crisis / hypotension.",
         "STAT Stress-dose Hydrocortisone (100 mg IV STAT) before imaging! Urgent Pituitary protocol MRI. Emergent transsphenoidal decompression if progressive visual loss."),
        
        ("cerebellar_stroke", "Acute Cerebellar Stroke / Bleed", "Posterior Fossa Compression", "brain.head.profile", Color.red,
         "PICA or AICA infarction or posterior fossa hypertensive hemorrhage.",
         "Acute vertigo, ataxia, vomiting, horizontal nystagmus, progressive drowsiness from 4th ventricle compression.",
         "Posterior fossa has rigid non-compliant volume. High risk of 4th ventricle effacement and obstructive hydrocephalus. Evacuate hematoma / suboccipital decompressive craniectomy if diameter > 3 cm or brainstem compression.")
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("THE 'CANNOT MISS' COMPENDIUM")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.red)
                    Text("Neurosurgical Emergencies & Red Flags")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Emergency Cards
                VStack(spacing: 14) {
                    ForEach(emergencies, id: \.0) { item in
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(item.4.opacity(0.12))
                                        .frame(width: 36, height: 36)
                                    Image(systemName: item.3)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(item.4)
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.1)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                                    Text(item.2)
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundColor(item.4)
                                }
                                Spacer()
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("HOW TO IDENTIFY:")
                                    .font(.system(size: 10, weight: .black))
                                    .foregroundColor(.secondary)
                                Text(item.6)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("CRITICAL ACTION & NOT-MISS RULE:")
                                    .font(.system(size: 10, weight: .black))
                                    .foregroundColor(item.4)
                                Text(item.7)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color(red: 0.15, green: 0.2, blue: 0.28))
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.04), radius: 6)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 24)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}
