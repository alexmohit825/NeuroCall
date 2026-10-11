import SwiftUI

// MARK: - Atlas of Neurosurgery (Essential On-Call & Core Procedures)
public struct SurgicalAtlasView: View {
    @State private var selectedProcedure = "laminectomy"
    
    let procedureCategories = [
        ("laminectomy", "Lumbar Laminectomy", "Spine Decompression", "figure.walk", Color.blue),
        ("microdiscectomy", "Lumbar Microdiscectomy", "Nerve Root Axilla/Shoulder", "arrow.up.and.down.circle.fill", Color.indigo),
        ("pedicle_screws", "Thoracolumbar Pedicle Screws", "Anatomical Entry & Trajectories", "cross.case.fill", Color.orange),
        ("cervical_lateral_mass", "Cervical Lateral Mass Screws", "Magerl vs. Roy-Camille", "lines.measurement.horizontal", Color.teal),
        ("c1_c2_screws", "C1 Lateral Mass & C2 Pars", "Harms Technique & Vertebral Artery", "shield.lefthalf.filled", Color.purple),
        ("crani_sdh", "Craniotomy for Subdural", "Trauma Flap & Bridging Veins", "drop.fill", Color.red),
        ("crani_edh", "Craniotomy for Epidural", "MMA Ligation & Dural Tacks", "cross.fill", Color.pink),
        ("vp_shunt", "VP Shunt Placement", "Keen's vs. Kocher's & Peritoneal", "circle.hexagongrid.fill", Color.green),
        ("craniotomy_types", "Types of Craniotomies", "Pterional, Suboccipital, Bifrontal", "brain.head.profile", Color.cyan)
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("THE RESIDENT'S OPERATIVE ATLAS")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.blue)
                    Text("Essential Surgical Atlas")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Text("Core spine instrumentation, trauma craniotomies, and shunt techniques required on service.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Horizontal Procedure Selector Chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(procedureCategories, id: \.0) { proc in
                            Button(action: {
                                HapticManager.impact(style: .light)
                                selectedProcedure = proc.0
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: proc.3)
                                        .font(.system(size: 12, weight: .bold))
                                    Text(proc.1)
                                        .font(.system(size: 12, weight: .bold))
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(selectedProcedure == proc.0 ? proc.4 : Color.white)
                                .foregroundColor(selectedProcedure == proc.0 ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedProcedure == proc.0 ? proc.4 : Color.black.opacity(0.06), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.03), radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Active Procedure Detail Card
                Group {
                    switch selectedProcedure {
                    case "laminectomy":
                        LumbarLaminectomyCard()
                    case "microdiscectomy":
                        LumbarMicrodiscectomyCard()
                    case "pedicle_screws":
                        ThoracolumbarPedicleScrewsCard()
                    case "cervical_lateral_mass":
                        CervicalLateralMassCard()
                    case "c1_c2_screws":
                        C1C2InstrumentationCard()
                    case "crani_sdh":
                        CraniSubduralCard()
                    case "crani_edh":
                        CraniEpiduralCard()
                    case "vp_shunt":
                        VPShuntPlacementCard()
                    case "craniotomy_types":
                        CraniotomyTypesOverviewCard()
                    default:
                        LumbarLaminectomyCard()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 28)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}

// MARK: - 1. Lumbar Laminectomy Card
struct LumbarLaminectomyCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "LUMBAR SPINE DECOMPRESSION",
            color: .blue,
            title: "Lumbar Laminectomy & Canal Decompression",
            indication: "Lumbar spinal stenosis, neurogenic claudication, or exposure for intradural lesions/cauda equina.",
            steps: [
                ("1. Localization & Incision", "Confirm level via lateral fluoroscopy using an 18G needle placed into the interspinous ligament or spinous process. Midline incision through subcutaneous fat down to the thoracolumbar fascia."),
                ("2. Subperiosteal Dissection", "Incise fascia precisely on midline. Use Cobb elevators and monopolar cautery to strip erector spinae muscles subperiosteally lateral to the facet capsules. Pack sponges for hemostasis. Keep facet capsules intact to prevent post-op iatrogenic instability."),
                ("3. Interspinous Ligament & Spinous Process Resection", "Resect interspinous ligament and remove the spinous process with a Leksell rongeur down to the lamina base."),
                ("4. Laminotomy & Flavectomy", "Thin the caudal edge of the cephalad lamina and cephalad edge of caudal lamina using a high-speed matchstick burr or Kerrison rongeurs (3-4 mm). Dissect plane under Ligamentum Flavum with a Woodson or nerve hook. Reissue flavum entirely."),
                ("5. Lateral Recess & Foraminal Check", "Undercut the medial 1/3 of the superior articular process (SAP) to decompress the traversing nerve root in the lateral recess. Always confirm root mobilization with a ball-tipped probe into the neural foramen.")
            ],
            pimpingPearls: [
                "What is the landmark for the traversing vs. exiting root? The traversing root crosses medial to the pedicle into the lateral recess; the exiting root hugs under the pedicle in the neural foramen.",
                "How to repair an incidental durotomy? 4-0 or 5-0 Prolene or Nurolon continuous suture, Valsalva under saline to verify seal, DuraGen overlay, and fibrin sealant (Tisseel)."
            ]
        )
    }
}

// MARK: - 2. Lumbar Microdiscectomy Card
struct LumbarMicrodiscectomyCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "MINIMALLY INVASIVE ROOT PRESERVATION",
            color: .indigo,
            title: "Lumbar Microdiscectomy",
            indication: "Herniated nucleus pulposus causing intractable radiculopathy or acute motor deficit.",
            steps: [
                ("1. Tubular or Micro Incision", "Small 1.5–2.5 cm paramedian or midline incision centered over the disc space under lateral fluoroscopy."),
                ("2. Interlaminar Window", "Clear soft tissue over the laminar edge. Use a 2 mm or 3 mm Kerrison rongeur to excise a crescent of the inferior margin of the cranial lamina to expose the superior edge of the ligamentum flavum."),
                ("3. Dural & Root Mobilization", "Carefully divide the ligamentum flavum longitudinally. Identify the lateral thecal sac margin and the traversing nerve root shoulder/axilla using a micro-nerve hook."),
                ("4. Shoulder vs. Axilla Retraction", "Gently retract the traversing root medially with a Love root retractor. If the disc is extruded in the axilla (between thecal sac and root), retract the thecal sac medially and root laterally."),
                ("5. Annulotomy & Fragment Evacuation", "Incise the annulus fibrosus with a #15 blade or micro-knife. Grasp the herniated disc fragment with a pituitary rongeur. Irrigate the space and inspect the nerve root from pedicle to pedicle to ensure complete decompression.")
            ],
            pimpingPearls: [
                "Batson's Plexus Bleeding: Epidural veins running anterior to the nerve root. Control with bipolar cautery, thrombin-soaked Gelfoam, and gentle cottonoid tamponade. Never suction blindly on epidural veins.",
                "Root anomaly: Always be watchful for a conjoined nerve root where two roots exit from a single dural sleeve."
            ]
        )
    }
}

// MARK: - 3. Thoracolumbar Pedicle Screws Card
struct ThoracolumbarPedicleScrewsCard: View {
    var body: some View {
        VStack(spacing: 16) {
            // Interactive Vector Schematic: Lumbar Vertebra & Calipers
            LumbarVertebraTrajectoryView()
            
            AtlasCardContainer(
                badge: "SPINAL INSTRUMENTATION",
                color: .orange,
                title: "Thoracolumbar Pedicle Screw Placement",
                indication: "Unstable fractures, spondylolisthesis, spinal deformity, and multi-level fusion constructs.",
                steps: [
                    ("1. Entry Point Identification (Roy-Camille / Weinstein)", "Lumbar: Intersection of the vertical line through the lateral border of the superior articular process (SAP) and the horizontal line bisecting the transverse process (at the mamillary process)."),
                    ("2. Thoracic Entry Point", "T1-T10: Junction of the superior border of the transverse process and the lateral 1/3 of the superior articular facet (base of the superior facet)."),
                    ("3. Cortical Breach & Gearshift Probing", "Decorticate the entry site with an awl or burr. Introduce the blunt Lenke pedicle probe with the tip directed laterally initially to avoid medial canal breach. Once in the pedicle body (15–20 mm), rotate probe medially to enter the vertebral body. Depth typically 35–45 mm."),
                    ("4. 5-Wall Ball-Tipped Palpation", "Inspect all 5 bony borders with a ball-tipped sound: Medial, Lateral, Superior, Inferior, and Anterior Floor. Ensure no soft tissue drop-off."),
                    ("5. Tapping & Screw Placement", "Tap 1 mm under the planned screw diameter. Insert polyaxial screw matching pedicle dimensions (typically 6.5 mm or 7.5 mm in lumbar, 5.0–6.0 mm in thoracic).")
                ],
                pimpingPearls: [
                    "Medial breach danger: Spinal canal impingement and traversing nerve root injury. Lateral breach: Psoas irritation or vascular injury (great vessels in anterior floor breach).",
                    "Triggered EMG testing: Screw stimulation threshold > 11–15 mA generally confirms an intact medial pedicle cortex; < 8 mA indicates a medial pedicle breach."
                ]
            )
        }
    }
}

// MARK: - 4. Cervical Lateral Mass Screws Card
struct CervicalLateralMassCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "POSTERIOR CERVICAL FIXATION (C3-C6)",
            color: .teal,
            title: "Cervical Lateral Mass Screw Placement",
            indication: "Cervical trauma, post-laminectomy kyphosis, cervical spondylotic myelopathy stabilization.",
            steps: [
                ("1. Lateral Mass Center Landmark", "Identify the 4 boundaries of the lateral mass: superior facet joint, inferior facet joint, medial junction with lamina, and lateral border."),
                ("2. Magerl Technique (Preferred for Vertebral Artery Safety)", "Entry point: 1–2 mm medial and cephalad to the center of the lateral mass. Trajectory: Angled 25°–30° laterally (to avoid vertebral artery) and 25°–30° cephalad (parallel to facet joint)."),
                ("3. Roy-Camille Technique (Alternative)", "Entry point: Exact center of the lateral mass. Trajectory: 10° lateral, 0° sagittal (perpendicular to cortex). Shorter screws (14 mm) compared to Magerl (16–18 mm)."),
                ("4. Drilling & Depth", "Drill bicortically or unicortically with a 2.5 mm drill bit with depth stop set at 14 mm. Tap with a 3.5 mm tap."),
                ("5. Screw Insertion", "Insert 3.5 mm diameter polyaxial screw. Verify facet joints are not violated by adjacent screws.")
            ],
            pimpingPearls: [
                "What is at risk with medial deviation? Vertebral artery resides in the foramen transversarium immediately lateral to the uncinate; medial deviation enters the spinal canal/cord.",
                "Why is C7 unique? The lateral mass of C7 is thin and transitional; C7 pedicle screws or C7 laminar screws are preferred over lateral mass screws."
            ]
        )
    }
}

// MARK: - 5. C1 Lateral Mass & C2 Pars/Pedicle Screws Card
struct C1C2InstrumentationCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "CRANIOVERTEBRAL JUNCTION FIXATION",
            color: .purple,
            title: "C1 Lateral Mass & C2 Pars/Pedicle Screws (Harms)",
            indication: "Atlantoaxial instability, odontoid non-union fractures, transverse ligament rupture.",
            steps: [
                ("1. Exposure & Greater Occipital Nerve", "Suboccipital midline exposure down to C1 arch and C2 lamina. Mobilize the C2 nerve root and the rich venous plexus between C1 and C2 inferior to the C1 posterior arch."),
                ("2. C1 Lateral Mass Entry (Goel-Harms)", "Landmark: Junction of the C1 posterior arch and the midpoint of the C1 lateral mass. Retract the C2 nerve root caudally. Trajectory: Aimed 10°–15° medially and directed straight toward the anterior tubercle of C1 under fluoroscopy."),
                ("3. C2 Pars Screw Technique", "Landmark: 2 mm superior and 2 mm medial to the C2-C3 facet joint. Trajectory: Angled 40°–45° cephalad and 10°–15° medially, paralleling the superior border of the C2 pars/isthmus to stay above the vertebral artery groove."),
                ("4. C2 Pedicle Screw Technique (Alternative)", "Entry 2 mm superior/lateral to the C2 pars entry; trajectory follows the pedicle axis 20°–30° medially and 20°–30° cephalad directly into the C2 body."),
                ("5. Rod Connection & Fusion", "Connect C1 and C2 screw heads with contoured 3.5 mm rods. Decorticate C1 arch and C2 lamina; pack autologous graft.")
            ],
            pimpingPearls: [
                "High-riding Vertebral Artery: Check pre-op CT angiogram! If the vertebral artery has an anomalous high-riding loop through C2 isthmus, a C2 pars/pedicle screw will lacerate it. In that scenario, use **C2 translaminar screws** (Wright technique) instead.",
                "C2 nerve root: Post-op occipital neuralgia can occur if the C2 nerve is excessively stretched; transection of the C2 root is often intentionally performed by surgeons for visualization and is generally well-tolerated."
            ]
        )
    }
}

// MARK: - 6. Craniotomy for Acute Subdural Hematoma Card
struct CraniSubduralCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "TRAUMA CRANIOTOMY",
            color: .red,
            title: "Trauma Craniotomy / Hemicraniectomy for Acute SDH",
            indication: "Clot thickness ≥ 10 mm, midline shift ≥ 5 mm, or GCS drop ≥ 2 in acute traumatic subdural hematoma.",
            steps: [
                ("1. Reverse Question Mark Incision (Trauma Flap)", "Begins 1 cm anterior to the tragus at the zygomatic root (preserve superficial temporal artery). Curves posteriorly over the auricle, then superiorly around the parietal tuber, and crosses midline 2 cm behind the frontal hairline."),
                ("2. Burr Holes & Bone Flap", "Place burr holes at: 1) Keyhole (pterion); 2) Posterior temporal; 3) Parietal; 4) Frontal. Elevate large fronto-temporo-parietal bone flap (minimum 12 x 15 cm) down to the middle cranial fossa floor."),
                ("3. Dural Opening", "Open dura in a rapid C-shaped or stellate fashion based on the superior sagittal sinus. Avoid aggressive suction directly on cortex."),
                ("4. Clot Evacuation & Hemostasis", "Irrigate clot gently with warm saline and bipolar cauterize bleeding cortical bridge veins. Never tug on adherent clot. Look for active cortical arterial lacerations."),
                ("5. Expansile Duraplasty vs. Bone Replacement", "If brain is relaxed, replace bone with titanium plates. If brain is swollen and herniating out of the craniotomy defect, perform **Decompressive Craniectomy** (leave bone out) and sew in an expansile DuraGen/pericranial patch.")
            ],
            pimpingPearls: [
                "Lacerated Bridging Veins: Most common origin of acute SDH is tearing of parasagittal bridging veins draining into the superior sagittal sinus.",
                "Decompressive flap rule: Never cut a small window. Flaps < 12 cm create edge herniation and strangulate cortical veins, causing hemorrhagic infarction."
            ]
        )
    }
}

// MARK: - 7. Craniotomy for Epidural Hematoma Card
struct CraniEpiduralCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "TEMPOROPARIETAL TRAUMA",
            color: .pink,
            title: "Craniotomy for Epidural Hematoma (EDH)",
            indication: "Clot volume > 30 cc, thickness > 15 mm, midline shift > 5 mm, or progressive anisocoria.",
            steps: [
                ("1. Question Mark or Horseshoe Incision", "Centered directly over the hematoma (typically temporoparietal over the squamosal suture and pterion)."),
                ("2. Rapid Burr Hole Over Clot", "Initial burr hole placed at the site of greatest thickness immediately vents the pressure and extrudes arterial clot under tension."),
                ("3. Bone Flap Elevation", "Fashion oval or rectangular craniotomy flap. Gently peel the stripped dura off the inner skull table."),
                ("4. Middle Meningeal Artery Ligation", "Identify the bleeding Middle Meningeal Artery (MMA) trunk or branch. Coagulate thoroughly with bipolar cautery. If bleeding stems from the foramen spinosum at the skull base, pack with bone wax or sterile cottonoid plug."),
                ("5. Circumferential Dural Hitch (Tack) Sutures", "Place multiple 4-0 Nurolon dural tack sutures around the bone margin and central dural tenting sutures through bone holes to prevent re-accumulation of epidural blood.")
            ],
            pimpingPearls: [
                "Lucid Interval: Classic presentation (brief unconsciousness, lucid period, then sudden catastrophic herniation with ipsilateral blown pupil).",
                "Why is EDH lens-shaped? Blood is bounded by dural attachments to cranial sutures; it cannot cross sutures unless there is an associated suture diastasis fracture."
            ]
        )
    }
}

// MARK: - 8. VP Shunt Placement Card
struct VPShuntPlacementCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "CSF DIVERSION PROCEDURAL ATLAS",
            color: .green,
            title: "Ventriculoperitoneal (VP) Shunt Placement",
            indication: "Communicating or obstructive hydrocephalus, pseudotumor cerebri, normal pressure hydrocephalus.",
            steps: [
                ("1. Entry Point Selection (Keen's vs. Kocher's)", "Keen's Point (Parieto-occipital): 3 cm superior and 3 cm posterior to the pinna. Kocher's Point (Frontal): 11 cm posterior to nasion, 3 cm lateral to midline."),
                ("2. Peritoneal Exposure (Mini-Laparotomy or Trocar)", "Transverse right upper quadrant periumbilical or subcostal incision. Divide anterior rectus sheath, split rectus abdominis muscle, identify posterior rectus sheath and peritoneum."),
                ("3. Subcutaneous Tunneling", "Pass rigid shunt tunneler from cranial incision down to the retroauricular/cervical area, then to the abdominal incision. Pull the distal peritoneal catheter through."),
                ("4. Ventricular Cannulation & CSF Flash", "Drill burr hole, cauterize and cross-puncture dura. Pass ventricular catheter: For Keen's, aim toward contralateral medial canthus (depth 5–6 cm); for Kocher's, aim toward ipsilateral medial canthus and tragus (depth 5 cm). Confirm spontaneous CSF pulsatile dripping."),
                ("5. Valve Connection & Peritoneal Seating", "Connect ventricular catheter to programmable or fixed-pressure valve (verify directional arrow points toward abdomen!). Connect distal catheter and verify dripping at abdominal end. Pass 20–30 cm of peritoneal catheter into peritoneal cavity under direct vision.")
            ],
            pimpingPearls: [
                "Programmable Valve Setting Warning: Always record the initial setting and obtain a post-op skull X-ray verification. Inform patient to avoid strong magnetic fields (MRI recalibration needed).",
                "Slit Ventricle Syndrome: Chronic over-drainage creates collapsed ventricles, periodic severe headaches, and high risk of catheter occlusion."
            ]
        )
    }
}

// MARK: - 9. Types of Craniotomies Overview Card
struct CraniotomyTypesOverviewCard: View {
    var body: some View {
        AtlasCardContainer(
            badge: "CRANIAL APPROACH ANATOMY",
            color: .cyan,
            title: "Major Craniotomy Approaches Compendium",
            indication: "Comparative anatomical guide to operative corridors used in cranial neurosurgery.",
            steps: [
                ("1. Pterional (Frontotemporal-Sphenoidal)", "Workhorse cranial approach. Exposure of Sylvian fissure, Circle of Willis, ACom/MCA/PCom aneurysms, and sellar/suprasellar pathology. Requires drilling the sphenoid ridge down to the meningo-orbital band."),
                ("2. Suboccipital (Retrosigmoid)", "Corridor for cerebellopontine angle (CPA), vestibular schwannomas, microvascular decompression (trigeminal CN V, hemifacial CN VII). Craniectomy placed just posterior to the sigmoid sinus and inferior to the transverse sinus."),
                ("3. Bifrontal (Subfrontal)", "Used for anterior skull base tumors (olfactory groove meningiomas, planum sphenoidale) and anterior communicating artery aneurysms. Dissects along the frontal skull base floor; requires sinus cranialization if frontal sinus breached."),
                ("4. Interhemispheric Transcallosal", "Approach for intraventricular lesions (colloid cysts, third ventricle tumors). Midline parasagittal craniotomy taking care to preserve bridging cortical veins entering the superior sagittal sinus."),
                ("5. Far Lateral (Transcondylar)", "Approach to anterior foramen magnum and lower clivus pathology. Involves drilling the posterior 1/3 of the occipital condyle and mobilizing the V3 segment of the vertebral artery.")
            ],
            pimpingPearls: [
                "Pterion Anatomy: Junction of 4 bones: Frontal, Parietal, Temporal squama, and Greater wing of Sphenoid. Middle meningeal artery grooves the inner surface directly beneath it.",
                "Frontal Sinus breach rule: If the frontal sinus is opened during craniotomy, all mucosa must be completely exenterated with a diamond burr, the ostia plugged with muscle/fat/bone wax, and a vascularized pericranial flap draped over the skull base to prevent fatal CSF leak and meningitis."
            ]
        )
    }
}

// MARK: - Reusable Atlas Card Container
struct AtlasCardContainer: View {
    let badge: String
    let color: Color
    let title: String
    let indication: String
    let steps: [(String, String)]
    let pimpingPearls: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header Tag & Title
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(badge)
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(color.opacity(0.12)))
                    Spacer()
                }
                
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                
                Text(indication)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            // Step-by-Step Technical Instructions
            VStack(alignment: .leading, spacing: 12) {
                Text("STEP-BY-STEP OPERATIVE TECHNIQUE:")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(.primary)
                
                ForEach(steps, id: \.0) { step in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(step.0)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(color)
                        Text(step.1)
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                            .lineSpacing(2)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                    .cornerRadius(10)
                }
            }
            
            // Attending Pimping Pearls Banner
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(.orange)
                    Text("ROUNDING PEARLS & ATTENDING PIMPING QUESTIONS:")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.orange)
                }
                
                ForEach(pimpingPearls, id: \.self) { pearl in
                    HStack(alignment: .top, spacing: 6) {
                        Text("•")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.orange)
                        Text(pearl)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                    }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.orange.opacity(0.08)))
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}
