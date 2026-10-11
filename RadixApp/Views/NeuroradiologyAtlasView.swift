import SwiftUI

// MARK: - Normal Neuroradiology Atlas (Spinal & Cranial Anatomy)
public struct NeuroradiologyAtlasView: View {
    @State private var selectedSystem = "cranial"
    
    let systems = [
        ("cranial", "Cranial Neuroradiology", "brain.head.profile", Color.purple),
        ("spinal", "Spinal Neuroradiology", "figure.walk", Color.blue)
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("NORMAL RADIOGRAPHIC ANATOMY")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.purple)
                    Text("Neuroradiology Atlas")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Text("Systematic normal CT and MRI anatomy to shine on rounds and recognize subtle pathology.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // System Segment Picker
                HStack(spacing: 12) {
                    ForEach(systems, id: \.0) { sys in
                        Button(action: {
                            HapticManager.impact(style: .light)
                            selectedSystem = sys.0
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: sys.2)
                                    .font(.system(size: 14, weight: .bold))
                                Text(sys.1)
                                    .font(.system(size: 13, weight: .bold))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedSystem == sys.0 ? sys.3 : Color.white)
                            .foregroundColor(selectedSystem == sys.0 ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(selectedSystem == sys.0 ? sys.3 : Color.black.opacity(0.06), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.03), radius: 4)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Content Section
                if selectedSystem == "cranial" {
                    CranialNeuroradiologyView()
                } else {
                    SpinalNeuroradiologyView()
                }
            }
            .padding(.bottom, 28)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}

// MARK: - Cranial Neuroradiology Section
struct CranialNeuroradiologyView: View {
    var body: some View {
        VStack(spacing: 16) {
            
            // 1. Basal Cisterns & Brainstem
            NeuroAnatomyCard(
                badge: "CRANIAL BASAL CISTERNS",
                color: .indigo,
                title: "Basal Cisterns & Ventricular System",
                description: "The primary markers of intracranial pressure and herniation on non-contrast Head CT.",
                landmarks: [
                    ("Suprasellar Cistern", "Star-shaped pentagon/hexagon cistern. Bounded anteriorly by rectus gyri, laterally by uncus/temporal lobes, posteriorly by pons. Contents: Optic chiasm, infundibulum, circle of Willis (PCom, A1). Loss of star shape = impending downward herniation."),
                    ("Ambient & Quadrigeminal Cisterns", "Wings flanking the midbrain. Tectum (quadrigeminal plate) forms anterior border of quadrigeminal cistern. Ambient cistern contains PCA (P2 segment) and trochlear nerve (CN IV)."),
                    ("Prepontine & Cerebellopontine Angle (CPA)", "CPA cistern contents: CN VII (facial), CN VIII (vestibulocochlear), AICA. Prepontine cistern contains basilar artery and CN VI (abducens)."),
                    ("Ventricular System Calibers", "Frontal horns: Bounded medially by septum pellucidum, laterally by caudate head. 3rd Ventricle: Width normally < 4 mm in young adults (< 7 mm in elderly). 4th Ventricle: Diamond-shaped, bounded anteriorly by pons/medulla, posteriorly by cerebellum.")
                ],
                roundsQuestion: "If the ambient cistern is asymmetric or effaced on one side, what is occurring? Early uncal herniation compressing the ipsilateral midbrain and posterior cerebral artery (PCA)."
            )
            
            // 2. Vascular Territories
            NeuroAnatomyCard(
                badge: "CEREBROVASCULAR TERRITORIES",
                color: .purple,
                title: "Arterial Watersheds & Vascular Distributions",
                description: "Understanding exact arterial territories prevents misdiagnosing territorial infarcts as encephalitis or tumor.",
                landmarks: [
                    ("Anterior Cerebral Artery (ACA)", "Supplies medial frontal and parietal lobes, corpus callosum (genu/body), cingulate gyrus, and superior frontal gyrus. Motor deficit affects contralateral lower extremity > upper extremity."),
                    ("Middle Cerebral Artery (MCA)", "Supplies lateral cerebral hemisphere, opercular cortex, and basal ganglia (lenticulostriate arteries). Deficit affects contralateral face & arm > leg, plus aphasia (dominant) or neglect (non-dominant)."),
                    ("Posterior Cerebral Artery (PCA)", "Supplies occipital lobe (calcarine fissure / primary visual cortex), thalamus (thalamoperforators), and inferior temporal lobe. Deficit: Contralateral homonymous hemianopsia with macular sparing."),
                    ("Watershed (Borderzone) Zones", "ACA-MCA watershed: High parasagittal convexity ('man-in-a-barrel' proximal limb weakness). MCA-PCA watershed: Temporo-occipital boundary (cortical blindness / visual processing defects).")
                ],
                roundsQuestion: "What is the earliest sign of acute MCA occlusion on non-contrast Head CT? Hyperdense MCA sign (acute thrombus in M1 segment) followed by loss of the insular ribbon and effacement of basal ganglia grey-white differentiation."
            )
            
            // 3. Normal Skull Base Foramina
            NeuroAnatomyCard(
                badge: "CRANIAL BASE FORAMINA",
                color: .pink,
                title: "Skull Base Foramina & Transiting Structures",
                description: "Essential cranial nerve and vascular conduits through the anterior, middle, and posterior skull base.",
                landmarks: [
                    ("Cribriform Plate", "Transits olfactory nerve fibers (CN I) from nasal cavity into anterior cranial fossa."),
                    ("Optic Canal", "Transits Optic nerve (CN II) and Ophthalmic artery through the sphenoid lesser wing."),
                    ("Superior Orbital Fissure (SOF)", "Transits CN III (oculomotor), CN IV (trochlear), CN V1 (ophthalmic branch: frontal, lacrimal, nasociliary), CN VI (abducens), and superior ophthalmic vein."),
                    ("Foramen Rotundum, Ovale, Spinosum (ROS)", "Rotundum: CN V2 (maxillary). Ovale: CN V3 (mandibular) & accessory meningeal artery. Spinosum: Middle Meningeal Artery (MMA) & recurrent branch of V3."),
                    ("Internal Auditory Canal (IAC) & Jugular Foramen", "IAC: CN VII (facial), CN VIII (vestibulocochlear), labyrinthine artery ('7-Up, Coke down'). Jugular Foramen: Pars nervosa (CN IX, inferior petrosal sinus) & Pars vascularis (CN X, CN XI, internal jugular vein).")
                ],
                roundsQuestion: "What structures pass through the foramen magnum? Medulla oblongata / spinal cord, spinal accessory nerves (CN XI ascending), vertebral arteries, anterior and posterior spinal arteries, and tectorial membrane."
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Spinal Neuroradiology Section
struct SpinalNeuroradiologyView: View {
    var body: some View {
        VStack(spacing: 16) {
            
            // 1. Normal Sagittal & Axial MRI Anatomy
            NeuroAnatomyCard(
                badge: "SPINAL CANAL ARCHITECTURE",
                color: .blue,
                title: "Normal Spinal Cord & Canal Dimensions",
                description: "Critical millimeter measurements that define true canal stenosis versus normal caliber.",
                landmarks: [
                    ("Cervical Canal AP Diameter", "Normal mid-cervical AP diameter: 17–18 mm. Relative stenosis: 10–13 mm. Absolute stenosis: < 10 mm. Pavlov-Torg ratio (Canal diameter / Vertebral body diameter): < 0.8 indicates developmental cervical stenosis."),
                    ("Lumbar Canal Dimensions", "Normal midsagittal AP diameter: 15–25 mm. Relative stenosis: 10–12 mm. Absolute stenosis: < 10 mm. Dural sac cross-sectional area (DSCA): Normal > 100 mm²; Moderate stenosis 75–100 mm²; Severe < 75 mm²."),
                    ("Normal Conus Medullaris Level", "Conus terminates at L1-L2 in 98% of adults. Termination below L2-L3 interspace indicates low-lying conus / tethered cord syndrome."),
                    ("Filum Terminale", "Normal thickness < 2 mm on axial T1 MRI at L5-S1. Filum lipoma or thickening > 2 mm suggests secondary tethered cord.")
                ],
                roundsQuestion: "On an axial lumbar T2 MRI, how do you locate the exiting vs. traversing root? The exiting root is positioned laterally inside the neural foramen beneath the pedicle; the traversing root lies medially in the lateral recess adjacent to the thecal sac."
            )
            
            // 2. Cervical & Lumbar Foraminal Calibers
            NeuroAnatomyCard(
                badge: "NEURAL FORAMINA & ROOTS",
                color: .teal,
                title: "Neural Foramina & Root Zones",
                description: "The 3 anatomical zones of root compression: Central canal, Lateral recess, and Foraminal/Extraforaminal.",
                landmarks: [
                    ("Zone 1: Central Canal", "Bounded anteriorly by posterior vertebral body / disc, laterally by medial facet edge, posteriorly by ligamentum flavum. Contains traversing cauda equina roots."),
                    ("Zone 2: Lateral Recess (Subarticular)", "Bounded anteriorly by superior endplate, laterally by pedicle, posteriorly by superior articular process (SAP). Normal depth ≥ 5 mm; stenosis when < 3 mm. Compresses the traversing root."),
                    ("Zone 3: Neural Foramen", "Bounded superiorly and inferiorly by pedicles, anteriorly by disc and vertebral body, posteriorly by facet joint. Compresses the exiting nerve root (far-out syndrome)."),
                    ("Zone 4: Extraforaminal (Far Lateral)", "Lateral to the pedicles. Far lateral disc herniations compress the EXITING root (e.g. Far lateral L4-L5 disc compresses the L4 root, NOT L5!).")
                ],
                roundsQuestion: "A patient has a classic L4 radiculopathy with absent patellar reflex and quad weakness, but the MRI shows a disc herniation at L4-L5. Where is the disc located? It is a far lateral (extraforaminal) disc herniation compressing the exiting L4 root, rather than a paracentral disc compressing the traversing L5 root."
            )
            
            // 3. Craniocervical Junction Stability Lines
            NeuroAnatomyCard(
                badge: "CRANIOCERVICAL JUNCTION (CCJ)",
                color: .orange,
                title: "CCJ Radiographic Alignment & Stability Lines",
                description: "Standard radiographic criteria on CT and lateral cervical spine films to evaluate atlanto-occipital and atlantoaxial dislocation.",
                landmarks: [
                    ("Basion-Dental Interval (BDI)", "Distance between basion (anterior foramen magnum) and tip of the dens. Normal: < 8.5 mm on CT in adults (< 12 mm on plain X-ray). Increased BDI indicates atlanto-occipital dissociation (AOD)."),
                    ("Basion-Axial Interval (BAI)", "Distance between basion and the superior continuation of the posterior C2 body line. Normal: < 12 mm. BDI or BAI > 12 mm = High suspicion of AOD (Harris Rule of 12)."),
                    ("Atlantodental Interval (ADI)", "Distance between posterior margin of anterior C1 arch and anterior cortex of the odontoid process. Normal: < 3 mm in adults (< 5 mm in children). ADI > 3 mm indicates rupture of the transverse atlantal ligament."),
                    ("Powers Ratio", "Ratio of (Basion to Posterior C1 arch) divided by (Opisthion to Anterior C1 arch). Ratio > 1.0 indicates anterior atlanto-occipital dislocation.")
                ],
                roundsQuestion: "What is the single most critical ligament preserving atlantoaxial stability? The Transverse Atlantal Ligament (TAL). If ruptured, C1-C2 fusion is indicated rather than external halo immobilization."
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Reusable NeuroAnatomy Card
struct NeuroAnatomyCard: View {
    let badge: String
    let color: Color
    let title: String
    let description: String
    let landmarks: [(String, String)]
    let roundsQuestion: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(badge)
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(color.opacity(0.12)))
                
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                
                Text(description)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(landmarks, id: \.0) { lm in
                    VStack(alignment: .leading, spacing: 3) {
                        Text(lm.0)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(color)
                        Text(lm.1)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 0.22, green: 0.27, blue: 0.36))
                            .lineSpacing(2)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                    .cornerRadius(8)
                }
            }
            
            // Rounding Pimping Alert
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "questionmark.circle.fill")
                    .foregroundColor(.purple)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.top, 2)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("PIMPING QUESTION OF THE DAY:")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(.purple)
                    Text(roundsQuestion)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                        .lineSpacing(2)
                }
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.purple.opacity(0.08)))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}
