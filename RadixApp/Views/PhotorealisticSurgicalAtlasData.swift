//
//  PhotorealisticSurgicalAtlasData.swift
//  RadixApp
//
//  Created for NeuroCall Surgical Atlas
//  Copyright © 2026 A. Alex Mohit. All rights reserved.
//

import SwiftUI

public struct SurgicalCallout: Identifiable {
    public let id: String
    public let title: String
    public let structureType: String
    public let color: Color
    public let normalizedX: CGFloat
    public let normalizedY: CGFloat
    public let description: String
    public let surgicalPearl: String

    public init(id: String, title: String, structureType: String, color: Color, normalizedX: CGFloat, normalizedY: CGFloat, description: String, surgicalPearl: String = "") {
        self.id = id
        self.title = title
        self.structureType = structureType
        self.color = color
        self.normalizedX = normalizedX
        self.normalizedY = normalizedY
        self.description = description
        self.surgicalPearl = surgicalPearl
    }
}

public struct ApproachSequentialStep {
    public let stepNumber: Int
    public let title: String
    public let detail: String
}


extension SurgicalPlateType {
    public var callouts: [SurgicalCallout] {
        switch self {
        case .plate001:
            return [
                SurgicalCallout(
                    id: "plate_001_1",
                    title: "Membrana Tectoria",
                    structureType: "DEEP DURAL LIGAMENT",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.471,
                    normalizedY: 0.102,
                    description: "REFLECTED DURAL SHEATH: Cephalad continuation of the posterior longitudinal ligament, reflected to expose deep CCJ stabilizing complex.",
                    surgicalPearl: "Sharply incise and reflect membrana tectoria superiorly from C2 body to expose the transverse and alar check ligaments."
                ),
                SurgicalCallout(
                    id: "plate_001_2",
                    title: "Cruciate Ligament (Transverse Band)",
                    structureType: "PRIMARY ATLANTO-AXIAL STABILIZER",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.489,
                    normalizedY: 0.494,
                    description: "TRANSVERSE ATLANTO-AXIAL BAND: Strong horizontal ligament spanning between C1 lateral masses, securing the dens against the anterior C1 arch.",
                    surgicalPearl: "Transverse ligament disruption creates acute atlanto-axial instability (ADI > 3 mm in adults); mandates posterior C1-C2 fusion."
                ),
                SurgicalCallout(
                    id: "plate_001_3",
                    title: "Bilateral Alar Check Ligaments",
                    structureType: "ROTATIONAL CHECK LIGAMENT",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.382,
                    normalizedY: 0.365,
                    description: "OBLIQUE CRANIAL RESTRAINTS: Paired tough fibrous cords passing from the posterolateral dens apex to medial occipital condyles.",
                    surgicalPearl: "Alar ligaments check contralateral axial rotation and lateral bending; unilateral tear increases axial rotation to the opposite side."
                ),
                SurgicalCallout(
                    id: "plate_001_4",
                    title: "V3 Vertebral Artery in C1 Sulcus",
                    structureType: "VASCULAR BOUNDARY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.164,
                    normalizedY: 0.463,
                    description: "SUBOCCIPITAL V3 SEGMENT: Vertebral artery looping out of C1 transverse foramen and coursing medially in the sulcus arteriosus.",
                    surgicalPearl: "Dissect strictly on the superior surface of the posterior C1 arch; keep dissection <= 12 mm from midline to avoid V3 laceration."
                )
            ]
        case .plate002:
            return [
                SurgicalCallout(
                    id: "plate_002_1",
                    title: "Anterior Fontanelle Lateral Apex",
                    structureType: "CANONICAL PUNCTURE TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.152,
                    normalizedY: 0.380,
                    description: "CORONAL-METOPIC APEX: Puncture entry landmark 1.5-2.0 cm lateral to midline at coronal suture, safely avoiding the superior sagittal sinus.",
                    surgicalPearl: "Always enter at the lateral angle of the fontanelle; midline punctures risk direct puncture or laceration of the superior sagittal sinus."
                ),
                SurgicalCallout(
                    id: "plate_002_2",
                    title: "Coronal & Sagittal Sutures",
                    structureType: "NEONATAL OSTEOLOGICAL MARGIN",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.250,
                    normalizedY: 0.550,
                    description: "UNOSSIFIED CRANIAL MARGINS: Palpable fibrous margins of the coronal, metopic, and sagittal sutures framing the diamond-shaped bregma.",
                    surgicalPearl: "In hydrocephalus, palpate tense separated suture margins; bulging fontanelle serves as an acute intracranial pressure barometer."
                ),
                SurgicalCallout(
                    id: "plate_002_3",
                    title: "Frontal Horn Catheter Target",
                    structureType: "VENTRICULAR CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.750,
                    normalizedY: 0.450,
                    description: "VENTRICULAR LUMEN CORRIDOR: Catheter tracked perpendicular to brain surface into the frontal horn just anterior to the foramen of Monro.",
                    surgicalPearl: "Pass catheter perpendicular to calvarium to depth of 3.0-3.5 cm; CSF egress confirms entry without choroid plexus entrapment."
                ),
                SurgicalCallout(
                    id: "plate_002_4",
                    title: "Subcutaneous Rickham Reservoir",
                    structureType: "SUBCUTANEOUS TAP POCKET",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.583,
                    normalizedY: 0.087,
                    description: "ACCESSIBLE TAP CHAMBER: Low-profile dome reservoir seated in a subgaleal parietal pocket away from the fontanelle entry puncture.",
                    surgicalPearl: "Seat reservoir over rigid calvarial bone, never over open fontanelle, to allow safe percutaneous needle aspiration."
                )
            ]
        case .plate003:
            return [
                SurgicalCallout(
                    id: "plate_003_1",
                    title: "Suboccipital Craniectomy Frame",
                    structureType: "BEVELED BONE MARGIN",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.701,
                    normalizedY: 0.068,
                    description: "BONE WINDOW & DURAL STAY SUTURES: Beveled suboccipital bone window with diamond-reflected dural flaps held by peripheral stay sutures.",
                    surgicalPearl: "Craniectomy must reach the posterior rim of foramen magnum; leaving a caudal bony bar causes cerebellar impingement and brainstem compression."
                ),
                SurgicalCallout(
                    id: "plate_003_2",
                    title: "Cisterna Magna Arachnoid",
                    structureType: "PRIMARY CSF RELEASE CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.509,
                    normalizedY: 0.757,
                    description: "TRANSLUCENT ARACHNOID POOL: Fibrillar arachnoid membrane of cisterna magna sharply opened with micro-scissors over a clear CSF pool.",
                    surgicalPearl: "Sharply open the arachnoid of cisterna magna first; rapid CSF release relaxes posterior fossa contents spontaneously by gravity."
                ),
                SurgicalCallout(
                    id: "plate_003_3",
                    title: "PICA Tonsillomedullary Loops",
                    structureType: "VITAL ARTERIAL LOOPS",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.704,
                    normalizedY: 0.637,
                    description: "POSTERIOR INFERIOR CEREBELLAR ARTERY: Tortuous crimson loops coursing around cerebellar tonsils with critical brainstem perforators.",
                    surgicalPearl: "Never coagulate or retract PICA tonsillar hairpin loops; occlusion precipitates fatal Wallenberg lateral medullary syndrome."
                ),
                SurgicalCallout(
                    id: "plate_003_4",
                    title: "Inferior Vermis & Cerebellar Folia",
                    structureType: "MIDLINE POSTERIOR FOSSA",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.505,
                    normalizedY: 0.381,
                    description: "RELAXED MIDLINE CEREBELLUM: Bilateral cerebellar folia and central inferior vermis falling away following cisternal drainage.",
                    surgicalPearl: "Rely on gravitational cerebellar relaxation; fixed metallic retractors on unrelaxed cerebellum cause contusions and venous infarcts."
                )
            ]
        case .plate004:
            return [
                SurgicalCallout(
                    id: "plate_004_1",
                    title: "Tentorium & Petrosal Vein (Dandy)",
                    structureType: "SUPERIOR CORRIDOR BOUNDARY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.683,
                    normalizedY: 0.096,
                    description: "SUPERIOR CEILING & PETROSAL VEIN: Glistening fibrous tentorium cerebelli and bridging petrosal vein (Dandy) entering superior petrosal sinus.",
                    surgicalPearl: "Sacrifice of a dominant petrosal vein carries substantial risk of cerebellar venous engorgement, hemorrhage, or fatal edema."
                ),
                SurgicalCallout(
                    id: "plate_004_2",
                    title: "Trigeminal Nerve (CN V)",
                    structureType: "SUPERIOR CRANIAL NERVE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.651,
                    normalizedY: 0.310,
                    description: "PORUS TRIGEMINI TRUNK: Broad pearly-white sensory trunk coursing anterior-superiorly toward Meckel's cave beneath tentorium.",
                    surgicalPearl: "In microvascular decompression, mobilize offending SCA loops off the superior-medial root entry zone; strictly protect motor rootlets."
                ),
                SurgicalCallout(
                    id: "plate_004_3",
                    title: "Facial & Vestibulocochlear Nerves (CN VII/VIII)",
                    structureType: "INTERNAL ACOUSTIC CORRIDOR",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.555,
                    normalizedY: 0.532,
                    description: "MEATAL NERVE COMPLEX: CN VII (anterior-superior) and CN VIII (posterior-inferior) transiting across cisterna toward internal acoustic meatus.",
                    surgicalPearl: "Facial nerve (CN VII) lies anterior and hidden behind CN VIII; maintain continuous facial nerve EMG monitoring throughout dissection."
                ),
                SurgicalCallout(
                    id: "plate_004_4",
                    title: "Lower CNs",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.668,
                    normalizedY: 0.746,
                    description: "Operative landmark identified on visual review.",
                    surgicalPearl: "Maintain precise anatomical orientation."
                )
            ]
        case .plate005:
            return [
                SurgicalCallout(
                    id: "plate_005_1",
                    title: "Host Fronto-Temporal Defect",
                    structureType: "ORBITAL & SPHENOID BONY EXPOSURE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.191,
                    normalizedY: 0.204,
                    description: "RADICAL SKULL BASE DEFECT: Anterolateral view showing unroofed superior and lateral orbit, sphenoid ridge, and exposed temporal dura.",
                    surgicalPearl: "Unroofing the orbit and flattening the sphenoid ridge provides a low, flat trajectory to the interpeduncular and basilar cisterns."
                ),
                SurgicalCallout(
                    id: "plate_005_2",
                    title: "Detached Pterional Bone Flap",
                    structureType: "BONE PIECE 1: CALVARIAL FLAP",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.820,
                    normalizedY: 0.632,
                    description: "FIRST BONE SEGMENT: Standard frontotemporal craniotomy bone flap removed cleanly prior to osteotomies of the orbital bar.",
                    surgicalPearl: "Removing the calvarial flap as a separate first piece allows direct visual intracranial protection of the dura during orbital cuts."
                ),
                SurgicalCallout(
                    id: "plate_005_3",
                    title: "One-Piece Orbitozygomatic Bar",
                    structureType: "BONE PIECE 2: ORBITOZYGOMATIC STRUT",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.811,
                    normalizedY: 0.240,
                    description: "SECOND BONE SEGMENT: Single-piece resected superior and lateral orbital rims, orbital roof, and full zygomatic arch.",
                    surgicalPearl: "Protect the orbital periorbita with a moist malleable retractor; violating periorbita causes orbital fat herniation and severe visual field obstruction."
                ),
                SurgicalCallout(
                    id: "plate_005_4",
                    title: "Intact TMJ & Articular Eminence",
                    structureType: "ANATOMICAL PRESERVATION BOUNDARY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.115,
                    normalizedY: 0.502,
                    description: "CRANIOFACIAL ARTICULATION: Preserved temporomandibular joint capsule and articular eminence directly posterior to the zygomatic osteotomy.",
                    surgicalPearl: "Place the posterior zygomatic osteotomy immediately anterior to the articular eminence; violating TMJ capsule causes severe trismus and pain."
                )
            ]
        case .plate006:
            return [
                SurgicalCallout(
                    id: "plate_006_1",
                    title: "Suboccipital & C1 Arch Resection",
                    structureType: "CRANIOCERVICAL BONE WINDOW",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.512,
                    normalizedY: 0.374,
                    description: "BONY EXPOSURE: Lateral suboccipital craniectomy extending to foramen magnum rim and unroofed C1 transverse foramen trough.",
                    surgicalPearl: "Unroof the C1 transverse foramen into an open bony trough; this unlocks the vertebral artery for complete medial mobilization."
                ),
                SurgicalCallout(
                    id: "plate_006_2",
                    title: "Mobilized V3 Vertebral Artery",
                    structureType: "MOBILIZED VASCULAR CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.595,
                    normalizedY: 0.494,
                    description: "HORIZONTAL V3 SEGMENT: Suboccipital vertebral artery elevated from sulcus arteriosus and mobilized inferiorly with vessel loop.",
                    surgicalPearl: "Dissect V3 subperiosteally within the peri-arterial venous plexus; bipolar coagulate venous bleeding rather than packing with excessive pressure."
                )
            ]
        case .plate007:
            return [
                SurgicalCallout(
                    id: "plate_007_1",
                    title: "Normal Spinal Canal (Left Panel)",
                    structureType: "HEALTHY ANATOMICAL REFERENCE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.250,
                    normalizedY: 0.400,
                    description: "WIDE TRIANGULAR CANAL: Concentric annulus lamellae, hydrated nucleus pulposus, patent lateral recesses, and thin yellow ligamentum flavum.",
                    surgicalPearl: "Normal lateral recess height >= 5 mm; traversing nerve root glides freely past superior articular process without bony contact."
                ),
                SurgicalCallout(
                    id: "plate_007_2",
                    title: "Hypertrophic Superior Articular Process",
                    structureType: "BONY TREFOIL STENOSIS",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.885,
                    normalizedY: 0.484,
                    description: "SCLEROTIC SAP OVERGROWTH: Massive arthritic facet hypertrophy projecting medially and anteriorly into the subarticular gutter.",
                    surgicalPearl: "Undercut the medial 1/3 of the superior articular process with a high-speed burr or angled Kerrison; preserve >= 50% facet to prevent instability."
                ),
                SurgicalCallout(
                    id: "plate_007_3",
                    title: "Thickened Ligamentum Flavum",
                    structureType: "SOFT TISSUE COMPRESSION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.745,
                    normalizedY: 0.657,
                    description: "RUBBERY FLAVUM HYPERTROPHY: Hypertrophic yellow ligament buckling anteriorly into the dorsal thecal sac and lateral recess.",
                    surgicalPearl: "Dissect flavum cleanly off the anterior facet cortex before biting; adherent dura under hypertrophic flavum tears easily if pulled."
                ),
                SurgicalCallout(
                    id: "plate_007_4",
                    title: "Pinched Traversing Nerve Root",
                    structureType: "ENTRAPPED RADICULAR PATHOLOGY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.778,
                    normalizedY: 0.401,
                    description: "SUBARTICULAR NERVE ENTRAPMENT: Traversing L5 nerve root severely crushed between herniated disc anteriorly and hypertrophic SAP posteriorly.",
                    surgicalPearl: "Probe lateral recess with a ball-tipped micro-instrument after decompression; verify nerve root is completely mobile into the foramen."
                )
            ]
        case .plate008:
            return [
                SurgicalCallout(
                    id: "plate_008_1",
                    title: "Pterional Bone Rim & Dural Stay Sutures",
                    structureType: "OSTEOLOGICAL & DURAL FRAME",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.456,
                    normalizedY: 0.178,
                    description: "FLATTENED SPHENOID RIDGE: Beveled frontotemporal craniotomy rim with reflected sphenoid dural flap secured by black stay sutures.",
                    surgicalPearl: "Aggressive drilling of the sphenoid ridge down to meningo-orbital band aligns the surgical line of sight with the skull base floor."
                ),
                SurgicalCallout(
                    id: "plate_008_2",
                    title: "Prechiasmatic Optic Nerve & ICA",
                    structureType: "CAROTID-OPTIC CISTERN",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.469,
                    normalizedY: 0.371,
                    description: "DEEP ARTERIAL ANATOMY: Pearly-white optic nerve (CN II) and supraclinoid internal carotid artery bifurcating into A1 and M1 trunks.",
                    surgicalPearl: "Sharp release of the opticocarotid cistern discharges deep CSF, dramatically relaxing frontal lobe without fixed retractor pressure."
                ),
                SurgicalCallout(
                    id: "plate_008_3",
                    title: "PComA Aneurysm & Yasargil Clip",
                    structureType: "VASCULAR OBLITERATION TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.500,
                    normalizedY: 0.507,
                    description: "TITANIUM SPRING CLIP CLOSURE: Saccular posterolateral PComA aneurysm completely occluded at its neck by a titanium Yasargil clip.",
                    surgicalPearl: "Visually confirm the anterior choroidal artery is free behind the aneurysm neck before final clip release; clipping AChA causes dense hemiplegia."
                )
            ]
        case .plate009:
            return [
                SurgicalCallout(
                    id: "plate_009_1",
                    title: "Superficial Sylvian Venous Complex",
                    structureType: "VENOUS PRESERVATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.664,
                    normalizedY: 0.386,
                    description: "PRESERVED SYLVIAN VEINS: Dark-blue superficial Sylvian veins mobilized carefully toward the temporal operculum.",
                    surgicalPearl: "Dissect fissure strictly on the frontal side of the superficial Sylvian veins; keeping veins on the temporal lobe preserves main venous outflow."
                ),
                SurgicalCallout(
                    id: "plate_009_2",
                    title: "Arachnoid Trabeculae Dissection",
                    structureType: "MICROSURGICAL SHARP RELEASE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.617,
                    normalizedY: 0.603,
                    description: "TENSE ARACHNOID BANDS: Micro-scissors dividing stretched translucent arachnoid trabeculae under continuous micro-suction tension.",
                    surgicalPearl: "Keep micro-knife cutting edge facing away from brain parenchyma; tension applied by micro-suction tip exposes avascular arachnoid webs."
                ),
                SurgicalCallout(
                    id: "plate_009_3",
                    title: "Deep Carotid Cistern Floor",
                    structureType: "DEEP ANATOMICAL CORRIDOR",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.508,
                    normalizedY: 0.433,
                    description: "CAROTID-OPTIC FLOOR: Pearly-white optic nerve (CN II) and pink ICA pulsations visible in the deep, relaxed cisternal corridor.",
                    surgicalPearl: "Opening the deep chiasmatic cisterns releases intracranial CSF, dropping brain tension throughout both opercular banks."
                )
            ]
        case .plate010:
            return [
                SurgicalCallout(
                    id: "plate_010_1",
                    title: "3-Pin Mayfield Skull Fixation",
                    structureType: "RIGID CRANIAL STABILIZATION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.200,
                    normalizedY: 0.400,
                    description: "MILITARY CHIN-TUCK SETUP: Single anterior pin and dual posterior rocker pins, with neck flexed maintaining 2-finger jugular clearance.",
                    surgicalPearl: "Maintain >= 2 fingerbreadths between chin and sternum; excessive flexion compresses internal jugular veins, causing venous infarction."
                ),
                SurgicalCallout(
                    id: "plate_010_2",
                    title: "Asterion & Cranial Sutures",
                    structureType: "SURFACE OSTEOLOGICAL LANDMARK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.520,
                    normalizedY: 0.420,
                    description: "SURFACE SUTURE CONFLUENCE: Junction of lambdoid, parietomastoid, and occipitomastoid sutures overlying the transverse-sigmoid angle.",
                    surgicalPearl: "Asterion overlies transverse-sigmoid junction in only 60% of cases; in 40% it sits directly over transverse sinus. Always drill inferior-medial."
                ),
                SurgicalCallout(
                    id: "plate_010_3",
                    title: "Transverse-Sigmoid Sinus Junction",
                    structureType: "VITAL VENOUS SINUS CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.650,
                    normalizedY: 0.350,
                    description: "VENOUS ANGLE BOUNDARY: Blue dural sinuses showing horizontal transverse sinus turning into descending sigmoid sinus behind mastoid.",
                    surgicalPearl: "Expose the inferior edge of transverse and posterior edge of sigmoid sinus to maximize viewing angle without sinus laceration."
                ),
                SurgicalCallout(
                    id: "plate_010_4",
                    title: "Strategic Burr Hole & Craniectomy Window",
                    structureType: "PLANNED CRANIECTOMY WINDOW",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.600,
                    normalizedY: 0.550,
                    description: "KEYHOLE BURR HOLE: Initial burr hole placed 5 mm inferior-medial to asterion, opening directly into posterior fossa with zero sinus tear.",
                    surgicalPearl: "Drill initial burr hole strictly inferior-medial to asterion; dissect dura carefully off bone before expanding craniectomy rim."
                )
            ]
case .plate011:
            return [
                SurgicalCallout(
                    id: "plate_011_1",
                    title: "Posterior Radial Annular Fissure",
                    structureType: "ANNULAR TEAR (HIZ PATHOLOGY)",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.256,
                    normalizedY: 0.390,
                    description: "HIGH-INTENSITY ZONE PATHOLOGY: Full-thickness radial tear through concentric collagenous annular lamellae bordering vertebral canal.",
                    surgicalPearl: "Posterior annular tears release inflammatory cytokines directly onto the dorsal thecal sac, causing severe discogenic back pain."
                ),
                SurgicalCallout(
                    id: "plate_011_2",
                    title: "Nucleus Pulposus Matrix",
                    structureType: "DESICCATED CENTRAL NUCLEUS",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.172,
                    normalizedY: 0.458,
                    description: "CENTRAL MATRIX DEHYDRATION: Desiccated nucleus pulposus undergoing cleft formation and proteoglycan matrix degradation.",
                    surgicalPearl: "Pfirrmann grading on T2 MRI correlates with loss of central nuclear water signal and disk height collapse."
                ),
                SurgicalCallout(
                    id: "plate_011_3",
                    title: "Collapsed Degenerative Disc Space",
                    structureType: "SAGITTAL COLUMN COLLAPSE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.587,
                    normalizedY: 0.378,
                    description: "SEGMENTAL LOSS OF HEIGHT: Narrowed, collapsed degenerative disc space with anterior and posterior marginal osteophyte formation.",
                    surgicalPearl: "Severe disc space collapse produces secondary foraminal narrowing, kinking exiting spinal nerve roots beneath the pedicle."
                ),
                SurgicalCallout(
                    id: "plate_011_4",
                    title: "Hydrated Normal Disc Reference",
                    structureType: "HEALTHY CONTROLS",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.696,
                    normalizedY: 0.665,
                    description: "PRESERVED BLUE-WHITE NUCLEUS: Plump, hydrated intervertebral disc with wide intervertebral foramina and smooth endplates.",
                    surgicalPearl: "Compare degenerative disc mechanics directly against the preserved plump hydrated disc space at the adjacent normal level."
                )
            ]
        case .plate012:
            return [
                SurgicalCallout(
                    id: "plate_012_1",
                    title: "Frontotemporal Calvarial Rim",
                    structureType: "PTERIONAL BONE WINDOW",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.378,
                    normalizedY: 0.245,
                    description: "BEVELED DIPLOIC BONE RIM: Warm ivory frontotemporal craniotomy frame centered precisely over the Sylvian fissure cleft.",
                    surgicalPearl: "Bevel the cranial bone cut to facilitate rigid titanium plate fixation and anatomical cosmetic skull reconstruction."
                ),
                SurgicalCallout(
                    id: "plate_012_2",
                    title: "Frontal & Temporal Opercula",
                    structureType: "CORTICAL GYRAL INTERVAL",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.571,
                    normalizedY: 0.409,
                    description: "VASCULARIZED GYRAL INTERACTION: Frontal opercular cortex (left) and temporal operculum (right) separated by the Sylvian cleft.",
                    surgicalPearl: "Gentle opercular separation under operating microscope magnification exposes the insular cortex and M2/M3 arterial arborizations."
                )
            ]
        case .plate013:
            return [
                SurgicalCallout(
                    id: "plate_013_1",
                    title: "Suboccipital Craniectomy & C1 Laminectomy",
                    structureType: "POSTERIOR FOSSA DECOMPRESSION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.250,
                    normalizedY: 0.300,
                    description: "UNROOFED FORAMEN MAGNUM: Midline craniectomy rim and resected C1 arch stumps creating wide craniocervical decompression.",
                    surgicalPearl: "Suboccipital craniectomy width should span 3 cm; resect posterior C1 arch completely to decompress the herniated tonsillar tips."
                ),
                SurgicalCallout(
                    id: "plate_013_2",
                    title: "Herniated Peg-Like Cerebellar Tonsils",
                    structureType: "CHIARI I PATHOLOGY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.295,
                    normalizedY: 0.489,
                    description: "ECTOPIC TONSILLAR HERNIATION: Foliated, elongated cerebellar tonsils descending below foramen magnum down past the C1 ring.",
                    surgicalPearl: "Tonsils impinging on dorsal medulla block obex CSF flow; gentle pial coagulation or shrinkage restores Fourth ventricle patency."
                ),
                SurgicalCallout(
                    id: "plate_013_3",
                    title: "V3 Vertebral Artery Lateral Boundary",
                    structureType: "VASCULAR BOUNDARY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.163,
                    normalizedY: 0.472,
                    description: "SUBOCCIPITAL ARTERIAL LOOPS: Crimson V3 vertebral artery loops coursing over the lateral masses of C1.",
                    surgicalPearl: "Keep lateral bone dissection strictly medial to the C1 vertebral artery sulcus to prevent arterial injury."
                ),
                SurgicalCallout(
                    id: "plate_013_4",
                    title: "Expansile Triangular Duraplasty",
                    structureType: "EXPANSIVE RECONSTRUCTION",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.750,
                    normalizedY: 0.450,
                    description: "HERMETIC COLLAGEN GRAFT: Watertight triangular pericardial/collagen graft sutured with continuous 5-0 monofilament to expand cisterna magna.",
                    surgicalPearl: "Watertight dural closure prevents postoperative pseudomeningocele, CSF wound fistula, and aseptic meningitis."
                )
            ]
        case .plate014:
            return [
                SurgicalCallout(
                    id: "plate_014_1",
                    title: "C1 Lateral Mass Screw Trajectory",
                    structureType: "POLYAXIAL CRANIAL ANCHOR",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.300,
                    normalizedY: 0.350,
                    description: "GOEL-HARMS C1 TRAJECTORY: Polyaxial screw anchored into the center of the C1 lateral mass, angled 10-15 degrees convergent and slightly cephalad.",
                    surgicalPearl: "Palpate the medial border of C1 lateral mass; guide drill parallel to C1 arch plane toward anterior C1 tubercle."
                ),
                SurgicalCallout(
                    id: "plate_014_2",
                    title: "C2 Pedicle & Pars Screw Trajectory",
                    structureType: "SUBCRANIAL REID FIXATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.300,
                    normalizedY: 0.600,
                    description: "ANTEROMEDIAL C2 CORRIDOR: High-density polyaxial screw traversing C2 pedicle or pars into vertebral body, avoiding vertebral artery.",
                    surgicalPearl: "Check preoperative CTA for high-riding vertebral artery; an anatomical high-riding VA contraindicates transpedicular C2 screws."
                ),
                SurgicalCallout(
                    id: "plate_014_3",
                    title: "V3 Vertebral Artery Loop Preservation",
                    structureType: "VITAL ARTERIAL ARCHITECTURE",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.850,
                    normalizedY: 0.650,
                    description: "TRANSVERSE FORAMEN ARTERY: Vertebral artery ascending from C2 transverse foramen into C1 groove directly lateral to screw entry sites.",
                    surgicalPearl: "Retract the C2 nerve root and venous plexus gently inferiorly to expose C1 lateral mass without lacerating the vertebral artery."
                )
            ]
        case .plate015:
            return []
        case .plate016:
            return [
                SurgicalCallout(
                    id: "plate_016_1",
                    title: "Temporal Craniotomy Flush to Zygoma",
                    structureType: "SUBTEMPORAL BONE WINDOW",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.326,
                    normalizedY: 0.505,
                    description: "MIDDLE FOSSA BASAL ACCESS: Right temporal craniotomy drilled flush to the superior border of zygomatic arch and middle fossa floor.",
                    surgicalPearl: "Drilling craniectomy flush to the temporal floor eliminates brain retraction during subtemporal approaches to petrous apex."
                ),
                SurgicalCallout(
                    id: "plate_016_2",
                    title: "Middle Meningeal Artery (MMA) Anterior Trunk",
                    structureType: "EPIDURAL ARTERIAL ARCHITECTURE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.520,
                    normalizedY: 0.400,
                    description: "ANTERIOR MENINGEAL ARTERIAL DIVISION: Crimson anterior trunk of MMA traversing anterior temporal dura toward sphenoid ridge.",
                    surgicalPearl: "Coagulate and divide anterior MMA branches early along the skull base floor to gain epidural hemostasis and dural mobilization."
                ),
                SurgicalCallout(
                    id: "plate_016_3",
                    title: "MMA Posterior Squamosal Trunk",
                    structureType: "POSTERIOR ARTERIAL DIVISION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.427,
                    normalizedY: 0.436,
                    description: "POSTERIOR MENINGEAL RAMUS: Posterior branch of MMA running across squamosal temporal dura toward parietal convexity.",
                    surgicalPearl: "Bipolar cautery of posterior MMA branches prevents troublesome epidural hematoma accumulation beneath the craniotomy rim."
                )
            ]
        case .plate017:
            return [
                SurgicalCallout(
                    id: "plate_017_1",
                    title: "Left Frontotemporal (Pterional) Craniotomy",
                    structureType: "ANTEROLATERAL BONE WINDOW",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.350,
                    normalizedY: 0.300,
                    description: "PTERIONAL CALVARIAL WINDOW: Standard 3D osteological exposure centered over the pterion, coronal suture, and anterior Sylvian fissure.",
                    surgicalPearl: "Keyhole burr hole placed at McCarty's point (1 cm behind anterior orbital rim) safely exposes both frontal dura and orbital periorbita."
                ),
                SurgicalCallout(
                    id: "plate_017_2",
                    title: "Sylvian Fissure Cleft",
                    structureType: "ANATOMICAL CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.660,
                    normalizedY: 0.379,
                    description: "CENTRAL INTERLOBAR CLEAVAGE: The deep fissure dividing frontal motor/language operculum from auditory temporal operculum.",
                    surgicalPearl: "Sharp dissection along the Sylvian cleft provides rapid access to circle of Willis aneurysms and the insular corridor."
                )
            ]
        case .plate018:
            return [
                SurgicalCallout(
                    id: "plate_018_1",
                    title: "Bifrontal Calvarial Craniotomy",
                    structureType: "SYMMETRICAL ANTERIOR EXPOSURE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.552,
                    normalizedY: 0.078,
                    description: "MIDLINE BILATERAL BONE FLAP: Symmetrical craniotomy crossing midline directly above supraorbital rims, exposing both frontal poles.",
                    surgicalPearl: "Keep inferior osteotomy cut within 5 mm of the skull base floor to maximize subfrontal access with minimal brain retraction."
                ),
                SurgicalCallout(
                    id: "plate_018_2",
                    title: "Interhemispheric Longitudinal Fissure",
                    structureType: "MIDLINE SUBCORTICAL CORRIDOR",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.478,
                    normalizedY: 0.218,
                    description: "MIDLINE TRANSFALCINE CORRIDOR: Avascular plane between medial frontal lobes leading to corpus callosum and anterior communicating complex.",
                    surgicalPearl: "Rely on midline interhemispheric gravity dissection; avoid bilateral frontal lobe retraction to prevent catastrophic abulia."
                )
            ]
        case .plate019:
            return []
        case .plate020:
            return [
                SurgicalCallout(
                    id: "plate_020_1",
                    title: "Asterion Suture Confluence",
                    structureType: "SURFACE OSTEOLOGICAL TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.191,
                    normalizedY: 0.296,
                    description: "SUTURE INTERSECTION: Confluence of lambdoid, parietomastoid, and occipitomastoid sutures marking lateral posterior fossa entrance.",
                    surgicalPearl: "Asterion overlies transverse-sigmoid junction in 60% of skulls; in 40% it sits on transverse sinus. Place burr hole 5 mm inferior-medial."
                ),
                SurgicalCallout(
                    id: "plate_020_2",
                    title: "Keyhole Retrosigmoid Craniectomy",
                    structureType: "CRANIAL KEYHOLE DEFECT",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.496,
                    normalizedY: 0.399,
                    description: "SURGICAL BONE WINDOW: Beveled 2.5-3.0 cm craniectomy defect exposing posterior fossa dura immediately behind the sigmoid sinus.",
                    surgicalPearl: "Wax any exposed mastoid air cells immediately with bone wax to eliminate postoperative CSF rhinorrhea via eustachian tube."
                )
            ]
case .plate021:
            return []
        case .plate022:
            return [
                SurgicalCallout(
                    id: "plate_022_1",
                    title: "Pineal Region Mass & Tectal Plate",
                    structureType: "QUADRIGEMINAL TUMOR TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.663,
                    normalizedY: 0.607,
                    description: "QUADRIGEMINAL CISTERN MASS: Lobulated pineal tumor compressing tectal colliculi and obstructing the cerebral aqueduct of Sylvius.",
                    surgicalPearl: "Pineal tumors compress tectal colliculi causing Parinaud syndrome (upward gaze palsy, light-near pupillary dissociation)."
                ),
                SurgicalCallout(
                    id: "plate_022_2",
                    title: "Great Vein of Galen Confluence",
                    structureType: "VITAL DEEP VENOUS TRUNK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.704,
                    normalizedY: 0.436,
                    description: "DEEP VENOUS COMPLEX: Internal cerebral veins and basal veins of Rosenthal uniting into Great Vein of Galen draped over tumor apex.",
                    surgicalPearl: "Never sacrifice or heavily retract the Vein of Galen or internal cerebral veins; occlusion precipitates fatal bilateral thalamic infarction."
                ),
                SurgicalCallout(
                    id: "plate_022_3",
                    title: "Supracerebellar Infratentorial Corridor",
                    structureType: "PRIMARY SUBTENTORIAL TRAJECTORY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.814,
                    normalizedY: 0.631,
                    description: "SUPRACEREBELLAR CORRIDOR: Operative midline plane between the dorsal tentorial surface of cerebellum and tentorium cerebelli.",
                    surgicalPearl: "Position sitting or park-bench; gravity drops the cerebellum downward, opening a direct operative tunnel below the deep venous complex."
                ),
                SurgicalCallout(
                    id: "plate_022_4",
                    title: "Occipital Transtentorial Trajectory",
                    structureType: "ALTERNATIVE SUPRATENTORIAL ROUTE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.853,
                    normalizedY: 0.474,
                    description: "TRANSTENTORIAL CORRIDOR: Supratentorial trajectory along the straight sinus and incised tentorium for tumors with dorsal extension.",
                    surgicalPearl: "Transtentorial approach provides superior visualization of tumors extending above the vein of Galen into the third ventricle."
                )
            ]
        case .plate023:
            return [
                SurgicalCallout(
                    id: "plate_023_1",
                    title: "Ponte Posterior Column Resection",
                    structureType: "SCHWAB GRADE 2 OSTEOTOMY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.28,
                    normalizedY: 0.35,
                    description: "OPEN WEDGE FACETECTOMY: Complete V-shaped resection of bilateral inferior and superior articular processes, flavum, and adjacent laminae.",
                    surgicalPearl: "Resect bilateral facet joints completely including lateral capsule; incomplete facet resection prevents lordotic closure."
                ),
                SurgicalCallout(
                    id: "plate_023_2",
                    title: "Unroofed Neural Foramen",
                    structureType: "RADICULAR SAFEGUARD",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.28,
                    normalizedY: 0.60,
                    description: "FORAMINAL DECOMPRESSION: Exiting and traversing nerve roots widely unroofed following complete facet complex excision.",
                    surgicalPearl: "Generously decompress the exiting nerve root in the foramen; closing the osteotomy wedge narrows the neural foramen by 2-3 mm."
                ),
                SurgicalCallout(
                    id: "plate_023_3",
                    title: "Closed Bone-on-Bone Apposition",
                    structureType: "POSTERIOR COLUMN CLOSURE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.72,
                    normalizedY: 0.35,
                    description: "SEGMENTAL LORDOTIC CLOSURE: Posterior compression bringing cut laminar surfaces into flush contact, hinging on anterior disc.",
                    surgicalPearl: "Each SPO/Ponte osteotomy level provides 8-10 degrees of segmental lordosis if the anterior intervertebral disc is mobile and flexible."
                ),
                SurgicalCallout(
                    id: "plate_023_4",
                    title: "Restored Segmental Lordosis",
                    structureType: "SAGITTAL REALIGNMENT",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.72,
                    normalizedY: 0.60,
                    description: "CORRECTED SAGITTAL CONTOUR: Restored posterior column shortening with intact anterior disc height and open patent neural foramen.",
                    surgicalPearl: "Multi-level Ponte osteotomies (3-4 levels) distribute thoracic kyphosis reduction smoothly across harmonious, multi-segment curves."
                )
            ]
        case .plate024:
            return []
        case .plate025:
            return [
                SurgicalCallout(
                    id: "plate_025_1",
                    title: "Anterior Temporal Lobectomy (ATL Resection Limit)",
                    structureType: "ANTERIOR RESECTION BOUNDARY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.749,
                    normalizedY: 0.200,
                    description: "NEOCORTICAL RESECTION MARGIN: Standard lateral resection measuring 3.5 cm in dominant hemisphere or 4.5 cm in non-dominant hemisphere.",
                    surgicalPearl: "Respect 3.5 cm limit on dominant left temporal lobe to prevent permanent receptive language deficit (Wernicke dysphasia)."
                ),
                SurgicalCallout(
                    id: "plate_025_2",
                    title: "Temporal Horn & Hippocampus Exposure",
                    structureType: "VENTRICULAR CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.260,
                    normalizedY: 0.193,
                    description: "VENTRICULAR EPENDYMA: Opening temporal horn of lateral ventricle to visualize hippocampus along the medial floor and choroid plexus.",
                    surgicalPearl: "Entering the temporal horn confirms anatomical location: choroidal fissure marks the medial safety boundary against brainstem."
                ),
                SurgicalCallout(
                    id: "plate_025_3",
                    title: "Selective Amygdalohippocampectomy (SelAH)",
                    structureType: "PARAFASCICULAR MESIAL RESECTION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.085,
                    normalizedY: 0.582,
                    description: "TARGETED MESIAL RESECTION: Selective subpial resection of uncus, amygdala, and anterior 2.5-3.0 cm of hippocampus, sparing lateral neocortex.",
                    surgicalPearl: "SelAH preserves lateral temporal neocortex and verbal memory while achieving high seizure freedom in mesial temporal sclerosis."
                ),
                SurgicalCallout(
                    id: "plate_025_4",
                    title: "Optic Radiation (Meyer Loop) & Brainstem Margin",
                    structureType: "NEUROLOGICAL BOUNDARY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.750,
                    normalizedY: 0.650,
                    description: "VISUAL TRACT SAFETY: Meyer loop visual fibers coursing over temporal horn roof; arachnoid of ambient cistern shielding brainstem.",
                    surgicalPearl: "Stay subpial along the medial hippocampal sulcus; crossing the pial boundary damages the posterior cerebral artery and crus cerebri."
                )
            ]
        case .plate026:
            return [
                SurgicalCallout(
                    id: "plate_026_1",
                    title: "Resected Medial Rib & Transverse Process",
                    structureType: "COSTOTRANSVERSECTOMY BONE WINDOW",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.30,
                    normalizedY: 0.35,
                    description: "EXTRAPLEURAL BONE ENTRY: 3-4 cm resection of rib head, neck, and transverse process, unroofing extrapleural space.",
                    surgicalPearl: "Subperiosteal dissection of the rib head off the costovertebral joint avoids tearing parietal pleura and entering thoracic cavity."
                ),
                SurgicalCallout(
                    id: "plate_026_2",
                    title: "Swept Parietal Pleura",
                    structureType: "PULMONARY TISSUE SPARING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.30,
                    normalizedY: 0.60,
                    description: "EXTRAPLEURAL RETROPERITONEAL PLANE: Intact parietal pleura swept ventrally with moist cottonoids, exposing lateral vertebral body.",
                    surgicalPearl: "Working strictly in the extrapleural plane maintains pulmonary biomechanics and completely avoids need for postoperative chest tube."
                ),
                SurgicalCallout(
                    id: "plate_026_3",
                    title: "Posterolateral Corpectomy Cavity",
                    structureType: "VENTRAL DECOMPRESSION CAVITY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.70,
                    normalizedY: 0.45,
                    description: "CIRCUMFERENTIAL RESECTION DEFECT: Complete resection of pathological vertebral body and discs between adjacent healthy endplates.",
                    surgicalPearl: "Drill vertebral body down to contralateral pedicle; full 360-degree dural untethering restores spinal cord microcirculation."
                ),
                SurgicalCallout(
                    id: "plate_026_4",
                    title: "Expandable Cage & Posterior Fixation",
                    structureType: "STRUCTURAL COLUMN RESTORATION",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.45,
                    description: "ANTERIOR LOAD SHARING: In-situ expandable titanium cage paired with multi-level bilateral pedicle screw fixation.",
                    surgicalPearl: "Expand cage strictly under fluoroscopy until firm purchase into endplates is achieved; verify no graft retropulsion into canal."
                )
            ]
        case .plate027:
            return [
                SurgicalCallout(
                    id: "plate_027_1",
                    title: "Deep Ganglionic / Thalamic Hematoma Target",
                    structureType: "INTRACEREBRAL HEMORRHAGE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.30,
                    normalizedY: 0.35,
                    description: "DEEP HYPERTENSIVE ICH: Large hypertensive hematoma in basal ganglia/thalamus exerting mass effect and midline shift.",
                    surgicalPearl: "Early MIPS evacuation (< 24 hours) relieves toxic thrombin mass effect and prevents secondary perihematomal edema."
                ),
                SurgicalCallout(
                    id: "plate_027_2",
                    title: "Transparent Tubular Transsulcal Port",
                    structureType: "PARAFASCICULAR RETRACTION PORT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.45,
                    normalizedY: 0.55,
                    description: "PARAFASCICULAR CANNULA: Transparent tubular port (BrainPath) introduced along white matter fiber tracts with zero cutting.",
                    surgicalPearl: "Introduce port along major tract trajectories (parallel to corticospinal tract) to displace rather than transect axonal fibers."
                ),
                SurgicalCallout(
                    id: "plate_027_3",
                    title: "Microsurgical Suction Clot Evacuation",
                    structureType: "INTERNAL DECOMPRESSION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.70,
                    normalizedY: 0.45,
                    description: "LUMINAL CLOT ASPIRATION: Dedicated micro-suction cannula and bipolar under high illumination gently evacuating burgundy thrombus.",
                    surgicalPearl: "Evacuate mobile clot inside the cavity; never vigorously scrape adherent clot on cavity walls to prevent active re-bleeding."
                ),
                SurgicalCallout(
                    id: "plate_027_4",
                    title: "Preserved Pale Subcortical Wall",
                    structureType: "TISSUE PRESERVATION BOUNDARY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.45,
                    description: "HEALTHY PARENCHYMAL MARGIN: Glistening pale subcortical brain wall visible through transparent cannula upon complete evacuation.",
                    surgicalPearl: "Line cavity with microfibrillar hemostatic collagen and warm saline; confirm absence of active arterial bleeder before withdrawing port."
                )
            ]
        case .plate028:
            return [
                SurgicalCallout(
                    id: "plate_028_1",
                    title: "True Right Lateral Decubitus Orientation",
                    structureType: "SURGICAL POSITIONING",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "OPERATIVE FLANK UP: Patient positioned in true right lateral decubitus, table flexed to widen space between iliac crest and rib cage.",
                    surgicalPearl: "True orthogonal lateral positioning ensures biplanar fluoroscopy displays perpendicular vertebral axes without rotational distortion."
                ),
                SurgicalCallout(
                    id: "plate_028_2",
                    title: "Anterior Retroperitoneal Sweep (Aorta/IVC)",
                    structureType: "GREAT VESSEL SAFETY ZONE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.25,
                    normalizedY: 0.65,
                    description: "VASCULAR CLEARANCE: Peritoneal envelope, aorta, and IVC resting on anterior disc margin, swept safely away from retractor channel.",
                    surgicalPearl: "Keep retractor docked strictly posterior to the anterior longitudinal ligament; anterior drift endangers aorta and vena cava."
                ),
                SurgicalCallout(
                    id: "plate_028_3",
                    title: "Psoas Split & Lumbar Plexus Safety",
                    structureType: "TRANSPSOAS NEUROLOGICAL WINDOW",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.45,
                    description: "ANTERIOR-THIRD CORRIDOR: Psoas split in anterior 1/3; traversing femoral nerve and lumbar plexus protected in posterior 2/3.",
                    surgicalPearl: "Utilize continuous directional EMG; nerve proximity alerts prevent direct mechanical compression of the femoral nerve trunk."
                ),
                SurgicalCallout(
                    id: "plate_028_4",
                    title: "Wide-Footprint Transverse Interbody Cage",
                    structureType: "INDIRECT DECOMPRESSION CAGE",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.80,
                    normalizedY: 0.45,
                    description: "APOPHYSEAL SPANNING ARTHRODESIS: Wide lordotic cage spanning bilateral cortical apophyseal rings, restoring foraminal height.",
                    surgicalPearl: "Spanning both cortical apophyseal rings resists subsidence and tenses the posterior annulus, indirectly decompressing the spinal canal."
                )
            ]
        case .plate029:
            return [
                SurgicalCallout(
                    id: "plate_029_1",
                    title: "Unilateral Complete Facetectomy Defect",
                    structureType: "POSTEROLATERAL BONY CORRIDOR",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.35,
                    normalizedY: 0.35,
                    description: "KAMBIN TRIANGLE UNROOFING: Resection of inferior articular process and superior articular process exposing the neuroforamen.",
                    surgicalPearl: "Complete facetectomy unroofs Kambin's triangle, providing safe transforaminal trajectory with zero thecal sac traction."
                ),
                SurgicalCallout(
                    id: "plate_029_2",
                    title: "Exiting & Traversing Nerve Roots",
                    structureType: "CRITICAL NEURAL BOUNDARIES",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.45,
                    normalizedY: 0.55,
                    description: "FORAMINAL NEURAL FRAME: Exiting root courses under cranial pedicle; traversing root courses medially over disc space into subarticular gutter.",
                    surgicalPearl: "Protect exiting root cranially and traversing root medially; working strictly within Kambin's triangle avoids nerve injury."
                ),
                SurgicalCallout(
                    id: "plate_029_3",
                    title: "Curved TLIF Interbody Spacer",
                    structureType: "BANANA/BULLET ARTHRODESIS CAGE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.65,
                    normalizedY: 0.45,
                    description: "ANTERIOR LOAD SHARING: Curved lordotic interbody cage inserted transforaminally and rotated anteriorly into the disc space.",
                    surgicalPearl: "Guide cage across anterior disc space to restore lumbar lordosis; verify cage does not migrate posteriorly against the thecal sac."
                ),
                SurgicalCallout(
                    id: "plate_029_4",
                    title: "Bilateral Pedicle Screw-Rod Construct",
                    structureType: "POSTERIOR NEUTRALIZATION",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.45,
                    description: "RIGID INSTRUMENTATION: Bilateral polyaxial pedicle screws and contoured titanium rods providing immediate segmental stability.",
                    surgicalPearl: "Apply gentle posterior compression across pedicle screws to lock the interbody cage in lordosis and tension the anterior ligament."
                )
            ]
        case .plate030:
            return [
                SurgicalCallout(
                    id: "plate_030_1",
                    title: "Sella Turcica & Dural Opening",
                    structureType: "PITUITARY SELLAR TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.48,
                    normalizedY: 0.45,
                    description: "CRUCIFORM SELLAR OPENING: Opened sellar dura exposing the adenoma and normal gland within the sella turcica.",
                    surgicalPearl: "Incise sellar dura in a cruciform manner; always aspirate with a fine needle first to confirm absence of intraglandular aneurysm."
                ),
                SurgicalCallout(
                    id: "plate_030_2",
                    title: "Medial Optico-Carotid Recess (mOCR)",
                    structureType: "KEY ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.35,
                    normalizedY: 0.35,
                    description: "OPTICO-CAROTID TRIANGLE: Bony recess at the junction of the optic canal, carotid prominence, and lateral sellar wall.",
                    surgicalPearl: "The medial optico-carotid recess is the key surgical landmark demarcating the optic nerve superiorly and paraclinoid ICA laterally."
                ),
                SurgicalCallout(
                    id: "plate_030_3",
                    title: "Suprasellar Optic Chiasm (CN II)",
                    structureType: "VISUAL APPARATUS",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.22,
                    description: "CHIASMATIC DECOMPRESSION: Optic chiasm and optic nerves resting above the tuberculum sellae, decompressed upon adenoma removal.",
                    surgicalPearl: "Adenoma removal allows the compressed optic chiasm to descend; verify diaphragmatic descent under high-definition endoscopy."
                ),
                SurgicalCallout(
                    id: "plate_030_4",
                    title: "Parasellar Cavernous Carotid Prominences",
                    structureType: "VITAL ARTERIAL BOUNDARY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.65,
                    normalizedY: 0.45,
                    description: "CAVERNOUS CAROTID SIPHON: Lateral bony prominences overlying the internal carotid arteries flanking the sellar walls.",
                    surgicalPearl: "Use Doppler ultrasound probe to localize carotid arteries behind the lateral sellar bone before any lateral bone removal."
                )
            ]
case .plate031:
            return [
                SurgicalCallout(
                    id: "plate_031_1",
                    title: "Lateral C2–T1 Root Hierarchy",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.28,
                    normalizedY: 0.32,
                    description: "Numbered cervical roots C1–C8 and T1 emerging relative to pedicles and neural foramina; note C8 exits between C7 and T1."
                ),
                SurgicalCallout(
                    id: "plate_031_2",
                    title: "C7–T1 Laminectomy Defect",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.72,
                    normalizedY: 0.34,
                    description: "Midline posterior bone removal unroofing the lower cervical thecal sac with preservation of facet integrity for stabilization."
                ),
                SurgicalCallout(
                    id: "plate_031_3",
                    title: "Unroofed C8 Foraminotomy",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.68,
                    normalizedY: 0.70,
                    description: "Unroofing of medial 50% of the C7–T1 facet joint to fully decompress the exiting C8 nerve root as it passes under the C7 pedicle."
                ),
                SurgicalCallout(
                    id: "plate_031_4",
                    title: "C7 Pedicle & T1 Mass Screws",
                    structureType: "INSTRUMENTATION",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.32,
                    normalizedY: 0.74,
                    description: "Transition instrumentation utilizing lateral mass screws at C6/C7 and pedicle screw fixation at T1 to resist cervicothoracic shear."
                )
            ]
        case .plate032:
            return [
                SurgicalCallout(
                    id: "plate_032_1",
                    title: "Anterior Retroperitoneal (ALIF)",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.25,
                    normalizedY: 0.30,
                    description: "Ventral trajectory between common iliac vessels for L5–S1 and left retroperitoneal corridor for L4–L5 providing widest cage footprint."
                ),
                SurgicalCallout(
                    id: "plate_032_2",
                    title: "Oblique / Pre-Psoas (OLIF/ATP)",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "Anterolateral corridor anterior to the psoas muscle and lateral to aorta/iliac vessels, avoiding lumbar plexus injury."
                ),
                SurgicalCallout(
                    id: "plate_032_3",
                    title: "Direct Lateral Transpsoas (LLIF)",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.26,
                    normalizedY: 0.72,
                    description: "Orthogonal lateral transpsoas trajectory spanning dense cortical apophyseal rings with real-time neuromonitoring of lumbosacral plexus."
                ),
                SurgicalCallout(
                    id: "plate_032_4",
                    title: "Posterolateral Kambin & TLIF",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.75,
                    normalizedY: 0.70,
                    description: "Posterior corridors through Kambin's triangle (endoscopic) or transforaminal facetectomy allowing direct neural decompression and cage placement."
                )
            ]
        case .plate033:
            return [
                SurgicalCallout(
                    id: "plate_033_1",
                    title: "MacCarty's Keypoint Burr Hole",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.28,
                    normalizedY: 0.30,
                    description: "Burr hole placed along anterior temporal line directly behind frontozygomatic suture, exposing both anterior fossa and orbital dura."
                ),
                SurgicalCallout(
                    id: "plate_033_2",
                    title: "Subfrontal Keyhole Osteotomy",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.72,
                    normalizedY: 0.32,
                    description: "Mini-craniotomy bone flap (~20x15 mm) flush with superior orbital rim and orbital roof to minimize frontal lobe retraction."
                ),
                SurgicalCallout(
                    id: "plate_033_3",
                    title: "Supraorbital Notch & Nerve",
                    structureType: "CRITICAL STRUCTURE",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.30,
                    normalizedY: 0.72,
                    description: "Supraorbital neurovascular bundle exiting the supraorbital notch/foramen; protected and preserved during medial periorbital mobilization."
                ),
                SurgicalCallout(
                    id: "plate_033_4",
                    title: "Frontal Dural Window",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.74,
                    normalizedY: 0.70,
                    description: "Curvilinear dural incision hinged inferiorly along orbital rim, granting subfrontal corridor to chiasmatic cistern and ACom complex."
                )
            ]
        case .plate034:
            return [
                SurgicalCallout(
                    id: "plate_034_1",
                    title: "Locked C6–C7 Facet Dislocation",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Parasagittal CT and dissection view showing C6 inferior articular facet perched and locked anterior to C7 superior articular process."
                ),
                SurgicalCallout(
                    id: "plate_034_2",
                    title: "Severe Anterolisthesis & Kyphosis",
                    structureType: "BIOMECHANICAL FAILURE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "50% anterior translation with acute traumatic kyphosis reflecting complete disruption of anterior and posterior ligamentous complexes."
                ),
                SurgicalCallout(
                    id: "plate_034_3",
                    title: "Intramedullary Cord Contusion / Edema",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "High-intensity sagittal T2 cord signal pinched between posterosuperior C7 vertebral body and displaced C6 posterior arch."
                ),
                SurgicalCallout(
                    id: "plate_034_4",
                    title: "Disrupted Posterior Ligament Complex",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Gross widening of C6–C7 interspinous distance indicating complete rupture of supraspinous, interspinous, and ligamentum flavum fibers."
                )
            ]
        case .plate035:
            return [
                SurgicalCallout(
                    id: "plate_035_1",
                    title: "Type I Apical / Alar Avulsion",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Oblique avulsion fracture of dens tip above transverse ligament; inherently stable with 95-100% union in rigid cervical orthosis."
                ),
                SurgicalCallout(
                    id: "plate_035_2",
                    title: "Type II Dens Waist Watershed Fracture",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "Transverse fracture through hypovascular waist of the dens; high nonunion risk (45-70%) requiring anterior screw or posterior C1-C2 fusion."
                ),
                SurgicalCallout(
                    id: "plate_035_3",
                    title: "Type III C2 Body Extension",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "Fracture line extending deep into cancellous body of the axis; high surface area with 85-93% union rate in rigid orthosis/halo."
                ),
                SurgicalCallout(
                    id: "plate_035_4",
                    title: "C1–C2 Motion Preservation Biomechanics",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Anterior odontoid screw preserves 50% of normal cervical rotation; posterior Harms C1 lateral mass / C2 pedicle fusion sacrifices rotation for union."
                )
            ]
        case .plate036:
            return [
                SurgicalCallout(
                    id: "plate_036_1",
                    title: "Centrifugal Burst Retropulsion",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Axial CT demonstrating comminuted middle-column failure with posterosuperior cortical fragment retropulsed >50% into spinal canal."
                ),
                SurgicalCallout(
                    id: "plate_036_2",
                    title: "Traumatic Kyphosis & Height Loss",
                    structureType: "BIOMECHANICAL FAILURE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "Sagittal reconstruction showing 45% anterior column collapse and focal traumatic angulation at the thoracolumbar junction (T12-L1)."
                ),
                SurgicalCallout(
                    id: "plate_036_3",
                    title: "Conus / Cauda Compression",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "Sagittal 3D correlation illustrating retropulsed bone fragment compressing and tenting the thecal sac / conus against posterior lamina."
                ),
                SurgicalCallout(
                    id: "plate_036_4",
                    title: "Pedicle Splaying & Laminar Split",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Bilateral splaying of pedicles with longitudinal greenstick split of posterior lamina indicating middle and posterior column involvement."
                )
            ]
        case .plate037:
            return [
                SurgicalCallout(
                    id: "plate_037_1",
                    title: "Massive Extruded Disc Sequestrum",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Diagnostic sagittal T2 MRI demonstrating huge extruded disc fragment filling >80% of spinal canal with complete CSF block at L4–L5."
                ),
                SurgicalCallout(
                    id: "plate_037_2",
                    title: "Compressed Cauda Equina Roots",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "Axial cross-section showing cauda equina nerve rootlets flattened into an ischemic crescentic band against posterior lamina."
                ),
                SurgicalCallout(
                    id: "plate_037_3",
                    title: "Annular Defect & Ruptured PLL",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "3D midsagittal cutaway illustrating intervertebral disc origin through disrupted posterior annulus and elevated/torn posterior longitudinal ligament."
                ),
                SurgicalCallout(
                    id: "plate_037_4",
                    title: "Intact Endplates & Vertebral Bodies",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Well-preserved L4 and L5 cancellous bone and cortical endplates differentiating primary disc extrusion from infectious/neoplastic collapse."
                )
            ]
        case .plate038:
            return [
                SurgicalCallout(
                    id: "plate_038_1",
                    title: "T8 Pathologic Fracture & Height Loss",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Osteolytic metastatic tumor destroying cancellous bone with anterior column collapse and focal pathologic kyphosis on sagittal MRI."
                ),
                SurgicalCallout(
                    id: "plate_038_2",
                    title: "Circumferential Cord Compression (Bilsky 3)",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "Complete obliteration of subarachnoid space with circumferential cord indentation and intrinsic T2-hyperintense intramedullary cord edema."
                ),
                SurgicalCallout(
                    id: "plate_038_3",
                    title: "Pedicle & Epidural Tumor Infiltration",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "Transverse cutaway showing tumor expansion through left pedicle and into epidural space creating a 180° dorsal and ventral cord pincer."
                ),
                SurgicalCallout(
                    id: "plate_038_4",
                    title: "Spared Contiguous Vertebrae (T7/T9)",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Healthy adjacent vertebrae providing solid pedicle purchase for multi-level rigid posterior stabilization and separation surgery."
                )
            ]
        case .plate039:
            return [
                SurgicalCallout(
                    id: "plate_039_1",
                    title: "Dural Tear Fistula Defect",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Linear or stellate laceration in posterior lumbar thecal sac allowing pressurized CSF egress into surrounding dead space."
                ),
                SurgicalCallout(
                    id: "plate_039_2",
                    title: "Subcutaneous Fluid Collection (MRI)",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "High-contrast sagittal T2 MRI showing large, non-enhancing hyperintense CSF collection dissecting through lumbodorsal fascia."
                ),
                SurgicalCallout(
                    id: "plate_039_3",
                    title: "Encapsulated Pseudocyst Wall",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "Fibrous pseudo-epithelial capsule forming the wall of pseudomeningocele lacking true arachnoid/ependymal lining."
                ),
                SurgicalCallout(
                    id: "plate_039_4",
                    title: "Multilayer Watertight Reconstruction",
                    structureType: "SURGICAL TECHNIQUE",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Primary continuous 4-0/5-0 monofilament dural suture reinforced with collagen matrix onlay patch and hydrogel/fibrin polymer sealant."
                )
            ]
        case .plate040:
            return [
                SurgicalCallout(
                    id: "plate_040_1",
                    title: "Star of Death Cisternal Cast (Head CT)",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Non-contrast head CT showing dense hyperdense acute blood filling basal cisterns, Sylvian fissures, and ambient cisterns in classic star pattern."
                ),
                SurgicalCallout(
                    id: "plate_040_2",
                    title: "ACom Aneurysm Rupture Site",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "3D skull base dissection showing irregular saccular anterior communicating artery aneurysm at A1-A2 junction with crimson clot on fundus."
                ),
                SurgicalCallout(
                    id: "plate_040_3",
                    title: "Biventricular Hydrocephalus",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "Ballooned temporal horns and rounded frontal horn angles caused by dense cisternal clot obstructing arachnoid villi and CSF outflow."
                ),
                SurgicalCallout(
                    id: "plate_040_4",
                    title: "Circle of Willis Cisternal Anatomy",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Preserved bilateral ICA bifurcations, M1/M2 Sylvian trunks, and basilar apex defining corridors for microsurgical clipping or coiling."
                )
            ]
        case .plate041:
            return [
                SurgicalCallout(
                    id: "plate_041_1",
                    title: "Putaminal ICH & Perilesional Edema",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Hyperdense parenchymal hematoma in putamen/external capsule from ruptured Charcot-Bouchard microaneurysms on lenticulostriate perforators."
                ),
                SurgicalCallout(
                    id: "plate_041_2",
                    title: "Intraventricular Hemorrhage Cast (IVH)",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "Trans-ependymal rupture causing dense cast of frontal horn, third ventricle, and dependent clot sedimentation in occipital horns."
                ),
                SurgicalCallout(
                    id: "plate_041_3",
                    title: "Internal Capsule Displacement",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "Posterior limb of internal capsule compressed and shifted medially by hematoma, explaining contralateral dense hemiplegia."
                ),
                SurgicalCallout(
                    id: "plate_041_4",
                    title: "Foramina of Monro Outflow Obstruction",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Obstructive hydrocephalus at Monro-third ventricle interface with ballooning of lateral ventricles requiring urgent ventricular drainage."
                )
            ]
        case .plate042:
            return [
                SurgicalCallout(
                    id: "plate_042_1",
                    title: "Multilevel Retrolisthesis & Disc Bars",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.26,
                    normalizedY: 0.30,
                    description: "Sagittal T2 MRI demonstrating broad-based disc-osteophyte bars across C3-C7 narrowing anteroposterior canal diameter to <10 mm."
                ),
                SurgicalCallout(
                    id: "plate_042_2",
                    title: "Ligamentum Flavum Pincer Buckling",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.74,
                    normalizedY: 0.32,
                    description: "Hypertrophied, folded dorsal ligamentum flavum creating dynamic spinal cord compression during cervical extension."
                ),
                SurgicalCallout(
                    id: "plate_042_3",
                    title: "Intramedullary Myelomalacia T2 Signal",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.28,
                    normalizedY: 0.72,
                    description: "Focal intramedullary high T2 signal at C4–C5 and C5–C6 reflecting irreversible ischemic injury, gliosis, and loss of anterior horn cells."
                ),
                SurgicalCallout(
                    id: "plate_042_4",
                    title: "Boomerang Cord Decompression Corridor",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.72,
                    normalizedY: 0.70,
                    description: "Transverse cutaway showing severe lateral and circumferential cord compression with preserved transverse foramina for vertebral arteries."
                )
            ]
        case .plate043:
            return [
                SurgicalCallout(
                    id: "plate_043_1",
                    title: "Cock-Robin Torticollis Presentation",
                    structureType: "CLINICAL HALLMARK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.18,
                    normalizedY: 0.45,
                    description: "Head tilted toward ipsilateral shoulder with chin rotated toward contralateral shoulder. Contralateral SCM in reactive spasm (opposing deformity), distinguishing AARS from congenital muscular torticollis.",
                    surgicalPearl: "Often triggered by Grisel's syndrome (pharyngovertebral venous hyperemia after URI / ENT surgery) or minor sports trauma."
                ),
                SurgicalCallout(
                    id: "plate_043_2",
                    title: "C1–C2 Rotatory Lock & Subluxation",
                    structureType: "BONY KINEMATICS",
                    color: Color.red,
                    normalizedX: 0.65,
                    normalizedY: 0.42,
                    description: "C1 ring rotated 25°–30° on C2. One C1 lateral mass subluxates anteriorly onto the anterior slope of C2 superior articular facet (exposing cartilage); contralateral mass displaced posteriorly.",
                    surgicalPearl: "Diagnostic Gold Standard: Dynamic Cervical 3D-CT (head turned left, neutral, right) showing non-reducing fixed C1–C2 rotational angle."
                ),
                SurgicalCallout(
                    id: "plate_043_3",
                    title: "Fielding Classification & TAL Sling",
                    structureType: "STABILIZING LIGAMENTS",
                    color: Color.cyan,
                    normalizedX: 0.58,
                    normalizedY: 0.35,
                    description: "Type I: Rotatory fixation without anterior shift (AADI ≤ 3 mm, TAL intact). Type II: 3–5 mm anterior translation (TAL deficient). Type III: > 5 mm bilateral shift. Type IV: Posterior subluxation.",
                    surgicalPearl: "Intact Transverse Atlantal Ligament preserves upper canal diameter, protecting the spinal cord from compression in Type I."
                )
            ]
        case .plate044:
            return [
                SurgicalCallout(
                    id: "plate_044_1",
                    title: "Type I: Nondisplaced Pars Fracture",
                    structureType: "STABLE INJURY",
                    color: Color.green,
                    normalizedX: 0.13,
                    normalizedY: 0.50,
                    description: "Vertical bilateral C2 pars fracture with < 3 mm anterior translation and 0° angulation. C2–C3 disc and ALL/PLL are completely intact. Stable injury.",
                    surgicalPearl: "Managed non-operatively with rigid cervical collar (Miami J/Aspen) for 8–12 weeks. >95% osseous union rate."
                ),
                SurgicalCallout(
                    id: "plate_044_2",
                    title: "Type II: Displaced with Disc Rupture",
                    structureType: "UNSTABLE TRANSLATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.50,
                    description: "Hyperextension-rebound flexion. Anterior displacement > 3 mm over C3 with moderate angulation (< 10°). C2–C3 disc ruptured with stripped PLL.",
                    surgicalPearl: "Requires inpatient traction reduction (5–10 lbs) under fluoroscopy, followed by Halo vest for 12 weeks or anterior C2–C3 ACDF."
                ),
                SurgicalCallout(
                    id: "plate_044_3",
                    title: "Type IIA: Flexion-Distraction (Traction Hazard)",
                    structureType: "CRITICAL DANGER TRAP",
                    color: Color.red,
                    normalizedX: 0.63,
                    normalizedY: 0.50,
                    description: "Severe kyphotic angulation (> 10°) with minimal/no translation. Wide posterior C2–C3 disc gaping with intact ALL anterior hinge.",
                    surgicalPearl: "TRACTION IS STRICTLY CONTRAINDICATED: Longitudinal pull causes catastrophic cord distraction. Treat with gentle extension reduction without traction."
                ),
                SurgicalCallout(
                    id: "plate_044_4",
                    title: "Type III: Bilateral Locked Facets",
                    structureType: "GROSS INSTABILITY",
                    color: Color.purple,
                    normalizedX: 0.88,
                    normalizedY: 0.50,
                    description: "Severe displacement and angulation combined with bilateral jumped/locked C2–C3 facet dislocation. Complete disruption of all disc and ligamentous restraints.",
                    surgicalPearl: "Closed reduction rarely succeeds. Requires urgent open posterior reduction of locked facets + C2–C3 instrumented fusion."
                )
            ]
        case .plate045:
            return [
                SurgicalCallout(
                    id: "plate_045_1",
                    title: "Subfalcine (Cingulate) Herniation",
                    structureType: "DURAL NOTCH DISPLACEMENT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.25,
                    normalizedY: 0.25,
                    description: "Cingulate gyrus wedged beneath the inferior free margin of the rigid falx cerebri. Compresses pericallosal and callosomarginal ACA branches, causing contralateral lower-extremity paresis.",
                    surgicalPearl: "Often early and clinically silent until severe ACA ischemia ensues. High risk of converting to secondary uncal herniation."
                ),
                SurgicalCallout(
                    id: "plate_045_2",
                    title: "Uncal (Lateral Transtentorial) Herniation",
                    structureType: "INCISURAL HERNIATION",
                    color: Color.red,
                    normalizedX: 0.75,
                    normalizedY: 0.25,
                    description: "Medial temporal uncus herniates over the sharp tentorial edge. Compresses ipsilateral CN III (blown pupil), PCA (hemianopia), and contralateral cerebral peduncle (Kernohan's notch false localizing sign).",
                    surgicalPearl: "Immediate neurosurgical emergency: demands osmotherapy bolus and emergent surgical decompression within minutes."
                ),
                SurgicalCallout(
                    id: "plate_045_3",
                    title: "Central Transtentorial (Duret Hemorrhages)",
                    structureType: "ROSTROCAUDAL DISPLACEMENT",
                    color: Color.purple,
                    normalizedX: 0.25,
                    normalizedY: 0.75,
                    description: "Bilateral downward displacement of diencephalon and midbrain. Mechanical traction shears basilar paramedian perforators, producing fatal Duret brainstem hemorrhages.",
                    surgicalPearl: "Progressive rostrocaudal deterioration: small reactive pupils become midposition fixed; decorticate rigidity progresses to decerebrate posturing."
                ),
                SurgicalCallout(
                    id: "plate_045_4",
                    title: "Tonsillar Herniation ('Coning')",
                    structureType: "FORAMEN MAGNUM CONING",
                    color: Color.red,
                    normalizedX: 0.75,
                    normalizedY: 0.75,
                    description: "Cerebellar tonsils impacted > 5 mm through the foramen magnum, compressing the dorsal medulla oblongata (cardiorespiratory center). Causes Cushing's triad and sudden apnea.",
                    surgicalPearl: "Lumbar puncture is STRICTLY CONTRAINDICATED in the presence of mass effect due to the catastrophic risk of precipitating fatal tonsillar coning."
                )
            ]
        case .plate046:
            return [
                SurgicalCallout(
                    id: "plate_046_1",
                    title: "Normal Conus & Slender Filum",
                    structureType: "NORMAL LUMBOSACRAL ANATOMY",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.40,
                    description: "Conus medullaris tapers normally and terminates at L1–L2. Slender filum terminale (<2 mm) with vertically draping cauda equina rootlets. Posterior bony elements, fascia, and overlying skin are intact.",
                    surgicalPearl: "Normal conus level must be confirmed by counting down from T12/ribs or up from S1 to avoid misidentifying low-lying cord on sagittal MRI."
                ),
                SurgicalCallout(
                    id: "plate_046_2",
                    title: "Filar Lipoma (Tethered Cord)",
                    structureType: "OCCULT SPINAL DYSRAPHISM",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.375,
                    normalizedY: 0.65,
                    description: "Conus medullaris pathologically low-lying (descending to L4–L5). Thickened, bright golden-yellow fibroadipose filum (>2 mm) tethering the conus under mechanical traction with taut horizontal nerve roots.",
                    surgicalPearl: "Microsurgical sectioning of the fatty filum immediately relaxes traction. Intraoperative nerve stimulation must confirm absent motor response before bipolaring and transecting the filum."
                ),
                SurgicalCallout(
                    id: "plate_046_3",
                    title: "Lipomyelomeningocele",
                    structureType: "CLOSED SPINAL DYSRAPHISM",
                    color: Color.orange,
                    normalizedX: 0.625,
                    normalizedY: 0.50,
                    description: "Spina bifida with dorsal laminar defect (L4–S2) beneath intact skin (subcutaneous fatty dome). Subcutaneous lipoma enters the spinal canal through the fascial defect and fuses directly into the dorsal aspect of the tethered placode.",
                    surgicalPearl: "NEVER attempt complete resection of the lipoma into cord tissue; debulk only the extraneous mass and untether the placode. Aggressive parenchymal resection causes permanent paraplegia or neurogenic bladder."
                ),
                SurgicalCallout(
                    id: "plate_046_4",
                    title: "Open Myelomeningocele",
                    structureType: "SPINA BIFIDA APERTA",
                    color: Color.red,
                    normalizedX: 0.875,
                    normalizedY: 0.48,
                    description: "Failure of primary neurulation with complete absence of posterior bony arches, fascia, and skin. Exposed, raw, highly vascular neural placode elevated on a fluid-filled arachnoid sac with ventral nerve roots traversing the cystic cavity.",
                    surgicalPearl: "Demands urgent neonatal repair within 24–48 hours to prevent ventriculitis and ascending meningitis. Reconstitute neural placode into a tube (tubulation) and perform watertight multilayered closure."
                )
            ]
        case .plate047:
            return [
                SurgicalCallout(
                    id: "plate_047_1",
                    title: "Normal C1–C2 Anatomy & Wide CSF Cistern",
                    structureType: "NORMAL CRANIOCERVICAL ALIGNMENT",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.35,
                    description: "Freestanding oval C1 anterior arch, intact conical dens, and C1 posterior arch ring. Wide perimedullary and prepontine subarachnoid space (CSF) cushioning an uncompressed brainstem and spinal cord. AADI is strictly < 3 mm.",
                    surgicalPearl: "Anterior atlantodental interval (AADI) > 3 mm in adults is pathognomonic of transverse atlantal ligament incompetency and atlantoaxial instability."
                ),
                SurgicalCallout(
                    id: "plate_047_2",
                    title: "Retro-Odontoid Pannus & Crowned Dens",
                    structureType: "PATHOLOGICAL PSEUDOTUMOR",
                    color: Color.red,
                    normalizedX: 0.375,
                    normalizedY: 0.35,
                    description: "Crowned dens with multi-lobulated calcific deposits at the dens tip. A bulky, fleshy retro-odontoid pseudotumor mass expands into the spinal canal. The cord is caught in a pincer between the anterior pannus and forward-shifted C1 posterior arch, with focal intramedullary myelomalacia.",
                    surgicalPearl: "Pannus develops as an inflammatory fibrocartilaginous pseudotumor secondary to repetitive atlantoaxial micromotion (seen in CPPD, rheumatoid arthritis, or chronic non-union)."
                ),
                SurgicalCallout(
                    id: "plate_047_3",
                    title: "Rigid Goel-Harms Fixation In Situ",
                    structureType: "POSTERIOR C1-C2 ARTHRODESIS",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.625,
                    normalizedY: 0.40,
                    description: "Posterior titanium C1 lateral mass screw (angled 10-15° cephalad) connected via a longitudinal rod to a C2 pedicle screw (angled 25-30° cephalad). Vascularized morselized autograft packed between C1 and C2. The retro-odontoid mass is deliberately left in situ without anterior resection.",
                    surgicalPearl: "Direct transoral or transnasal resection carries up to a 10% risk of CSF leak and fatal meningitis. Posterior stabilization alone reliably cures the condition."
                ),
                SurgicalCallout(
                    id: "plate_047_4",
                    title: "Spontaneous Involution & Solid Bony Fusion",
                    structureType: "12-MONTH POST-OP ARTHRODESIS",
                    color: Color.blue,
                    normalizedX: 0.875,
                    normalizedY: 0.35,
                    description: "The pseudotumor pannus has completely regressed and disappeared following elimination of mechanical micromotion. The prepontine and premedullary CSF space has fully reopened, the spinal cord has re-expanded, and the posterior bone graft has consolidated into a solid bony bridge.",
                    surgicalPearl: "MRI at 6 to 12 months post-fixation routinely confirms over 90% to 100% volumetric reduction of the retro-odontoid pannus without requiring any anterior decompression."
                )
            ]
        case .plate048:
            return [
                SurgicalCallout(
                    id: "plate_048_1",
                    title: "Normal Dorsal Microvasculature",
                    structureType: "PHYSIOLOGICAL DRAINAGE",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.35,
                    description: "Slender, straight, non-dilated posterior median spinal vein (cobalt blue) with a delicate coronal venous plexus. Normal radicular vein draining smoothly through the lateral dural sleeve into the epidural venous plexus. Normal cord caliber.",
                    surgicalPearl: "Normal spinal venous drainage is low-pressure and valveless; cord perfusion depends entirely on the arteriovenous pressure gradient."
                ),
                SurgicalCallout(
                    id: "plate_048_2",
                    title: "Arterialized Serpentine Veins & Foix-Alajouanine",
                    structureType: "CONGESTIVE MYELOPATHY",
                    color: Color.red,
                    normalizedX: 0.375,
                    normalizedY: 0.35,
                    description: "Fistulous nidus inside the dural root sleeve shunts high-pressure arterial blood retrogradely into the coronal venous plexus. Grossly dilated, hyper-convoluted, serpentine arterialized veins and severe congestive cord swelling (Foix-Alajouanine myelopathy).",
                    surgicalPearl: "Presents insidiously with ascending lower extremity paraparesis, sensory level, and sphincter dysfunction, frequently misdiagnosed as lumbar spinal stenosis or transverse myelitis."
                ),
                SurgicalCallout(
                    id: "plate_048_3",
                    title: "Intraoperative ICG Videoangiography",
                    structureType: "MICROSURGICAL LOCALIZATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.625,
                    normalizedY: 0.40,
                    description: "Under high microscope magnification, intense arterial-phase fluorescence reveals the radiculomeningeal arterial feeder entering the dural sleeve and shunting directly into the single arterialized medullary bridging vein before cord capillaries fill.",
                    surgicalPearl: "ICG videoangiography definitively differentiates the pathological arterialized draining vein from adjacent normal radicular veins."
                ),
                SurgicalCallout(
                    id: "plate_048_4",
                    title: "Micro-Clip Interruption & Decompression",
                    structureType: "DEFINITIVE SURGICAL CURE",
                    color: Color.blue,
                    normalizedX: 0.875,
                    normalizedY: 0.35,
                    description: "A single titanium aneurysm micro-clip placed across the arterialized bridging vein right at its dural exit immediately halts the shunt. The serpentine dorsal veins instantly collapse, darken to blue, and de-arterialize; the cord begins rapid decongestion.",
                    surgicalPearl: "NEVER resect or coagulate the engorged veins on the cord surface (causes fatal venous infarction); simple interruption of the single bridging vein at the dura cures the fistula."
                )
            ]
        case .plate049:
            return [
                SurgicalCallout(
                    id: "plate_049_1",
                    title: "Normal C1 Ring & Intact TAL",
                    structureType: "PHYSIOLOGICAL ALIGNMENT",
                    color: Color.green,
                    normalizedX: 0.125,
                    normalizedY: 0.20,
                    description: "Intact, continuous C1 ring with stout Transverse Atlantal Ligament (TAL) holding the C2 dens tightly against the anterior arch. Superior axial view shows generous canal space; anterior coronal view demonstrates flush lateral masses (0 mm overhang).",
                    surgicalPearl: "Normal lateral atlantodental intervals (LADI) are strictly symmetric; combined lateral mass overhang is 0 mm."
                ),
                SurgicalCallout(
                    id: "plate_049_2",
                    title: "Stable Burst (TAL Intact, Overhang < 6.9 mm)",
                    structureType: "STABLE JEFFERSON (DICKMAN I)",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.375,
                    normalizedY: 0.20,
                    description: "4-part burst fracture through the anterior and posterior arches. The Transverse Atlantal Ligament remains 100% intact, preventing lateral mass splaying. Combined lateral mass overhang on coronal view is strictly < 6.9 mm. Spinal cord is uncompromised.",
                    surgicalPearl: "Stable fractures with intact TAL can be treated conservatively in a rigid cervical collar (Miami J / Aspen) or Halo-vest for 8–12 weeks."
                ),
                SurgicalCallout(
                    id: "plate_049_3",
                    title: "Unstable Burst (TAL Ruptured, Overhang ≥ 7 mm)",
                    structureType: "UNSTABLE JEFFERSON (DICKMAN II)",
                    color: Color.red,
                    normalizedX: 0.625,
                    normalizedY: 0.20,
                    description: "Severe comminuted burst with mid-substance rupture and shredding of the Transverse Atlantal Ligament. Both lateral masses splay widely outward (> 7 mm combined overhang, positive Rule of Spence). The dens retropulses into the canal, indenting the spinal cord.",
                    surgicalPearl: "Combined lateral mass overhang ≥ 7.0 mm on open-mouth view or coronal CT proves TAL disruption, indicating gross mechanical instability requiring surgical stabilization."
                ),
                SurgicalCallout(
                    id: "plate_049_4",
                    title: "Anatomical Reduction & Arthrodesis",
                    structureType: "SURGICAL REDUCTION & RESTORATION",
                    color: Color.blue,
                    normalizedX: 0.875,
                    normalizedY: 0.20,
                    description: "Closed traction reduction or posterior instrumented reduction brings the splayed lateral masses back inward. Coronal overhang is eliminated (0 mm overhang), the C1 ring circumference is restored, and the cervical spinal cord is fully decompressed.",
                    surgicalPearl: "Posterior C1–C2 Goel-Harms instrumented fusion (C1 lateral mass to C2 pedicle/pars screws) provides immediate rigid biomechanical stability and high fusion rates."
                )
            ]

        case .plate050:
            return [
                SurgicalCallout(
                    id: "plate_050_1",
                    title: "Midsagittal OPLL & Cord Tenting",
                    structureType: "CONTINUOUS TSUYAMA OPLL",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.15,
                    normalizedY: 0.45,
                    description: "Dense continuous ivory ossified mass extending along the posterior borders of C2–C5, causing critical anterior cord indentation (>60% canal occupancy) and severe focal cord narrowing.",
                    surgicalPearl: "Tsuyama continuous type has the highest rate of progression and severe compressive myelopathy; canal occupancy >60% strongly favors direct anterior resection/floating or combined 360° stabilization."
                ),
                SurgicalCallout(
                    id: "plate_050_2",
                    title: "Intramedullary Myelomalacia Core",
                    structureType: "COMPRESSIVE CORD ISCHEMIA",
                    color: Color.red,
                    normalizedX: 0.18,
                    normalizedY: 0.50,
                    description: "Focal pale ischemic core within the central gray and anterior white columns at the apex of compression (C3–C4), representing irreversible or semi-reversible cord edema, gliosis, and microvascular ischemia.",
                    surgicalPearl: "Preoperative focal intramedullary T2 hyperintensity coupled with T1 hypointensity (double-signal sign) correlates with poorer neurological recovery and calls for prompt surgical decompression."
                ),
                SurgicalCallout(
                    id: "plate_050_3",
                    title: "8K Bone CT & K-Line Analysis",
                    structureType: "K-LINE (-) / CANAL OCCUPANCY >65%",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.48,
                    normalizedY: 0.45,
                    description: "Thin-cut bone window CT confirms thick, uninterrupted retrovertebral ossification. The K-line (line connecting mid-canal C2 to C7) is touched and breached by the OPLL apex (K-line negative), indicating that indirect posterior decompression alone will leave persistent cord tenting.",
                    surgicalPearl: "In K-line negative patients, posterior laminoplasty alone fails to achieve backward cord drift; anterior corpectomy (ACCF) or posterior lordosis restoration + anterior release is required."
                ),
                SurgicalCallout(
                    id: "plate_050_4",
                    title: "8K T2-MRI Subarachnoid Effacement",
                    structureType: "COMPLETE CSF BLOCKS & CORD PINCH",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.45,
                    description: "3T Sagittal T2 MRI demonstrates total loss of anterior and posterior subarachnoid CSF envelopes across C3–C5 with conspicuous high-signal intramedullary myelomalacia at C3–C4. Normal CSF columns are preserved at C1–C2 and C6–T1.",
                    surgicalPearl: "Evaluate thin-cut axial CT for the 'C-sign' or 'double-layer sign' (dural ossification). When dura is ossified into the OPLL, aggressive resection tears the dura; the anterior floating technique with diamond burr prevents CSF fistula."
                )
            ]

        case .plate051:
            return [
                SurgicalCallout(
                    id: "plate_051_1",
                    title: "MMA Trunk & Foramen Spinosum",
                    structureType: "ANGIOGRAPHIC TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.22,
                    normalizedY: 0.35,
                    description: "Middle meningeal artery entering middle cranial fossa through foramen spinosum before bifurcating into frontal and parietal branches.",
                    surgicalPearl: "Carefully inspect MMA origin for dangerous anastomoses with ophthalmic artery (meningolacrimal branch) prior to embolization."
                ),
                SurgicalCallout(
                    id: "plate_051_2",
                    title: "Superselective MMA Catheterization",
                    structureType: "ENDOVASCULAR CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.45,
                    description: "Microcatheter navigation into anterior and posterior convex convexity branches distal to petrosal / facial nerve arcade.",
                    surgicalPearl: "Ensure microcatheter tip is well past petrosal branch of MMA to prevent inadvertent facial nerve palsy from embolic reflux."
                ),
                SurgicalCallout(
                    id: "plate_051_3",
                    title: "Onyx Liquid Embolic Membrane Cast",
                    structureType: "EMBOLIZATION CAST",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.78,
                    normalizedY: 0.40,
                    description: "Controlled liquid embolic penetration (Onyx / PHIL / particles) penetrating fragile neovascular dural capillary membranes of CSDH.",
                    surgicalPearl: "Penetration into the distal capillary network of the outer subdural membrane is essential to arrest recurring micro-hemorrhages."
                ),
                SurgicalCallout(
                    id: "plate_051_4",
                    title: "Chronic Subdural Liquefied Collection",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.78,
                    normalizedY: 0.75,
                    description: "Subdural collection demonstrating progressive spontaneous resorption and mass effect resolution following neovascular devascularization.",
                    surgicalPearl: "MMA embolization reduces CSDH recurrence rates from > 20% down to < 5%, avoiding repeat open burr hole evacuation."
                )
            ]

        case .plate090:
            return [
                SurgicalCallout(
                    id: "plate_090_1",
                    title: "Diagnostic Imaging & Palmar Surface Landmarks",
                    structureType: "ULTRASOUND, T2 MRI & KAPLAN'S CARDINAL LINE",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.35,
                    description: "Panel 1 details preoperative neuroimaging and surface landmark mapping. Transverse high-frequency ultrasound confirms severe median nerve compression at the pisiform level (cross-sectional area CSA = 15 mm², normal < 10 mm²) with hypoechoic edema and the classic notch sign. Axial T2 MRI confirms flattening under the taut transverse carpal ligament. Palmar landmarks delineate Kaplan's Cardinal Line, the longitudinal fourth-ray axis (ring finger axis / safe incision corridor), wrist flexion creases, and the radial-sided Palmar Cutaneous Branch of the Median Nerve (PCBMN).",
                    surgicalPearl: "Always design the incision along the axis of the fourth ray (ring finger); this maximizes safety clearance from the radial-sided motor branch and protects the palmar cutaneous nerve."
                ),
                SurgicalCallout(
                    id: "plate_090_2",
                    title: "Complete Retinacular Release & Distal Fat Pad",
                    structureType: "ULNAR-SIDED RELEASE & ANTEBRACHIAL FASCIA DIVISION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Panel 2 demonstrates high-definition operative release of the right carpal tunnel (Proximal/Forearm = Bottom, Distal/Palm = Top). Proximally at the wrist, the distal antebrachial fascia is divided across the wrist crease. Centrally in the carpal canal, the Transverse Carpal Ligament is divided step-by-step strictly along its ulnar border, fully unroofing the glistening decompressed median nerve with preserved longitudinal vasa nervorum. Distally in the palm, division extends completely to expose the transverse yellow Distal Palmar Fat Pad, with the curved Superficial Palmar Arterial Arch protected just distal to it.",
                    surgicalPearl: "The distal palmar fat pad is the definitive landmark of complete transverse carpal ligament release; dividing ligament fibers until this fat pad is reached ensures zero persistent compression."
                ),
                SurgicalCallout(
                    id: "plate_090_3",
                    title: "Thenar Motor Branch Anatomy & Canonical Variants",
                    structureType: "EXTRALIGAMENTOUS, SUBLIGAMENTOUS & TRANSLIGAMENTOUS",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.50,
                    description: "Panel 3 maps the recurrent thenar motor branch innervating thenar muscles (APB, OP, FPB) and defines the three classic anatomical variants: (A) Extraligamentous (~50%): arises distal to the transverse carpal ligament and loops recurrently; (B) Subligamentous (~30%): arises beneath the ligament and courses under its distal edge; and (C) Transligamentous (~20%): pierces directly THROUGH the ligament fibers, carrying the highest risk of accidental transection. The Palmar Cutaneous Branch (PCBMN) courses safely on the radial side, protected by the ulnar-sided approach.",
                    surgicalPearl: "Anticipate a transligamentous thenar motor branch in 1 out of 5 patients; dividing the ligament strictly on its ulnar border provides maximum protective distance from these radial motor fibers."
                ),
                SurgicalCallout(
                    id: "plate_090_4",
                    title: "Three Concise Resident Pearls",
                    structureType: "HAND SURGERY HARBORS & PEARLS",
                    color: Color.blue,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom bar highlights three cardinal hand surgery rules: (1) Ulnar-Sided Retinacular Release: Always divide the transverse carpal ligament strictly along its ulnar border in line with the ring finger ray to prevent iatrogenic thenar motor branch transection; (2) Distal Fat Pad Landmark: Continue dividing ligament fibers distally until the transverse fat pad is visualized overlying the superficial palmar arch; and (3) Palmar Cutaneous Branch Safe Zone: Never extend incisions radial to the palmaris longus or across the thenar eminence to prevent disabling neuroma formation.",
                    surgicalPearl: "After complete release, gently pass a blunt probe proximally beneath the antebrachial fascia and distally beneath the palmar aponeurosis to verify total absence of residual fascial bands."
                )
            ]


        case .plate091:
            return [
                SurgicalCallout(
                    id: "plate_091_1",
                    title: "Retrovertebral Cord Compression",
                    structureType: "CERVICAL MYELOPATHY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "RETROVERTEBRAL MYELOMALACIA: Preoperative T2 MRI confirming severe central cord compression and signal change behind C6 vertebral body.",
                    surgicalPearl: "Multi-level retrovertebral osteophytes behind the vertebral body mandate formal corpectomy rather than standard discectomy."
                ),
                SurgicalCallout(
                    id: "plate_091_2",
                    title: "C6 Complete Corpectomy Defect",
                    structureType: "VENTRAL DECOMPRESSION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.40,
                    normalizedY: 0.45,
                    description: "CORPECTOMY TROUGH & PLL EXCISION: Radical high-speed burr resection of C6 body between uncinates, unroofing the ventral dura completely.",
                    surgicalPearl: "Preserve the thin lateral cortical shell of each uncinate process to serve as an anatomical barrier shielding the vertebral arteries."
                ),
                SurgicalCallout(
                    id: "plate_091_3",
                    title: "Expandable Titanium Strut Cage",
                    structureType: "STRUCTURAL COLUMN RECONSTRUCTION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.65,
                    normalizedY: 0.50,
                    description: "IN-SITU EXPANDABLE CAGE: Telescoping porous titanium corpectomy cage expanded between prepared C5 and C7 subchondral endplates.",
                    surgicalPearl: "Expand cage strictly under lateral fluoroscopy; verify firm endplate engagement while preventing over-distraction and endplate breach."
                ),
                SurgicalCallout(
                    id: "plate_091_4",
                    title: "Bridging Anterior Locking Plate",
                    structureType: "RIGID FIXATION & 5 MM RULE",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.88,
                    normalizedY: 0.40,
                    description: "BRIDGING DUAL-LEVEL FIXATION: Heavy-duty anterior cervical plate bridging from C5 to C7, maintaining >= 5 mm clearance from adjacent discs.",
                    surgicalPearl: "Strictly preserve >= 5 mm clearance from adjacent mobile disc spaces (C4-C5 and C7-T1) to prevent adjacent segment ossification."
                )
            ]
        case .plate092:
            return [
                SurgicalCallout(
                    id: "plate_092_1",
                    title: "Upper Trunk Rupture (Erb's Point)",
                    structureType: "BRACHIAL PLEXUS TRACTION LESION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.22,
                    normalizedY: 0.35,
                    description: "Complete traction rupture of C5–C6 roots at Erb's point resulting in deltoid/biceps paralysis; intact C7–T1 roots preserved.",
                    surgicalPearl: "Upper trunk rupture creates classic Erb-Duchenne 'waiter's tip' posture with loss of shoulder abduction and elbow flexion."
                ),
                SurgicalCallout(
                    id: "plate_092_2",
                    title: "Bicipital Groove Medial Arm Corridor",
                    structureType: "SURGICAL EXPOSURE",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.45,
                    description: "Operative corridor along medial bicipital groove exposing median, ulnar, and musculocutaneous nerve branches.",
                    surgicalPearl: "Identify biceps and brachialis motor branches as they enter muscle bellies 12–15 cm distal to acromion."
                ),
                SurgicalCallout(
                    id: "plate_092_3",
                    title: "Oberlin I & II Coaptation Sites",
                    structureType: "DOUBLE NERVE TRANSFER",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.78,
                    normalizedY: 0.40,
                    description: "Tension-free end-to-end coaptation using 9-0 nylon of ulnar FCU fascicle to biceps branch (I) and median FCR fascicle to brachialis branch (II).",
                    surgicalPearl: "Double transfer achieves MRC grade >= 4 elbow flexion in > 90% of cases compared to single transfer alone."
                ),
                SurgicalCallout(
                    id: "plate_092_4",
                    title: "Intraoperative Fascicular Mapping",
                    structureType: "ELECTROPHYSIOLOGY MONITORING",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.78,
                    normalizedY: 0.75,
                    description: "Handheld bipolar stimulation (0.5–1.0 mA) confirming redundant wrist flexion before harvesting donor fascicle.",
                    surgicalPearl: "Never harvest donor fascicles without electrophysiological verification of redundant motor innervation to preserve distal hand function."
                )
            ]
        case .plate093:
            return [
                SurgicalCallout(
                    id: "plate_093_1",
                    title: "M1 Middle Cerebral Artery LVO",
                    structureType: "LARGE VESSEL OCCLUSION",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "ACUTE M1 OCCLUSION: Catheter angiography demonstrating abrupt truncation of the proximal middle cerebral artery trunk with penumbral mismatch.",
                    surgicalPearl: "Target mismatch on CT perfusion (large penumbra, small ischemic core) confirms viable salvageable brain tissue prior to groin puncture."
                ),
                SurgicalCallout(
                    id: "plate_093_2",
                    title: "Balloon Guide Catheter (BGC)",
                    structureType: "PROXIMAL FLOW ARREST",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.25,
                    description: "CERVICAL FLOW ARREST: 8F balloon guide catheter inflated in the high cervical internal carotid artery to arrest antegrade flow during clot retrieval.",
                    surgicalPearl: "Temporary balloon occlusion of the cervical ICA completely arrests forward flow, preventing distal embolization into new vascular territories."
                ),
                SurgicalCallout(
                    id: "plate_093_3",
                    title: "Distal Aspiration Catheter",
                    structureType: "CONTACT ASPIRATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.50,
                    description: "LARGE-BORE DIRECT CONTACT: 0.068-inch aspiration catheter navigated directly to the proximal face of the thrombus over microcatheter.",
                    surgicalPearl: "Navigating the aspiration catheter directly against the clot face maximizes vacuum suction force during stent-retriever retraction."
                ),
                SurgicalCallout(
                    id: "plate_093_4",
                    title: "Nitinol Stent-Retriever Mesh",
                    structureType: "THROMBUS ENTRAPMENT",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.45,
                    description: "EN-BLOC CLOT RETRIEVAL: Self-expanding laser-cut nitinol stent-retriever deployed across thrombus, capturing clot into structural struts.",
                    surgicalPearl: "Allow 3-5 minutes of integration time after deployment to permit stent struts to embed deeply into the clot matrix before withdrawal."
                )
            ]
        case .plate094:
            return [
                SurgicalCallout(
                    id: "plate_094_1",
                    title: "Dorsal Column Sweet Spot",
                    structureType: "NEUROMODULATION TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.40,
                    description: "T9-T10 NEUROMODULATION SWEET SPOT: Physiologic midline dorsal column target for lower extremity and low back neuropathic pain coverage.",
                    surgicalPearl: "Placement at the physiological midline of T9-T10 delivers maximal bilateral radicular and axial low-back paresthesia coverage."
                ),
                SurgicalCallout(
                    id: "plate_094_2",
                    title: "Minimal Hemilaminotomy Window",
                    structureType: "CONSERVATIVE ACCESS",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.35,
                    normalizedY: 0.25,
                    description: "CONSERVATIVE EPIDURAL ACCESS: Conservative 10-12 mm inferior laminotomy unroofing flavum while preserving facet joints and interspinous ligament.",
                    surgicalPearl: "Preserve the midline interspinous-supraspinous ligamentous complex to eliminate post-laminectomy kyphosis and facet destabilization."
                ),
                SurgicalCallout(
                    id: "plate_094_3",
                    title: "16-Contact Directional Paddle",
                    structureType: "DORSAL COLUMN PADDLE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.55,
                    normalizedY: 0.45,
                    description: "MULTI-COLUMN DORSAL STIMULATION: Wide-footprint 16-contact directional paddle advanced cephalad in the thoracic dorsal epidural space.",
                    surgicalPearl: "Advance paddle gently under direct fluoroscopic guidance; never force against scarred epidural adhesions to prevent cord compression."
                ),
                SurgicalCallout(
                    id: "plate_094_4",
                    title: "Anchored Silicone Collar & IPG",
                    structureType: "STRAIN RELIEF & IPG",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.82,
                    normalizedY: 0.65,
                    description: "STRAIN RELIEF & POCKET TUNNELING: Heavy-duty silicone anchor locked to supraspinous fascia, tunneled to subcutaneous gluteal IPG pocket.",
                    surgicalPearl: "Multiple non-absorbable fascial anchoring sutures eliminate caudal lead migration, the leading cause of surgical revision."
                )
            ]
        case .plate095:
            return [
                SurgicalCallout(
                    id: "plate_095_1",
                    title: "Neural Placode Interface",
                    structureType: "EXPOSED NEURAL TUBE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "EXPOSED NON-NEURULATED PLACODE: Dorsal midline neural placode with functional ventral motor roots; preserve strict moisture.",
                    surgicalPearl: "Keep the placode constantly irrigated with warm sterile isotonic saline; intraoperative drying causes immediate irreversible conduction failure."
                ),
                SurgicalCallout(
                    id: "plate_095_2",
                    title: "Junctional Epithelial Margin",
                    structureType: "UNTETHERING INTERFACE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.35,
                    normalizedY: 0.50,
                    description: "EPITHELIAL UNTETHERING INTERFACE: Sharp micro-dissection zone separating squamous skin epithelium from non-neurulated neural tissue.",
                    surgicalPearl: "Dissect strictly at the junctional zone; leaving cutaneous squamous rests inside the closure risks devastating delayed epidermoid tumors."
                ),
                SurgicalCallout(
                    id: "plate_095_3",
                    title: "Tubularized Neural Tube",
                    structureType: "PIAL-TO-PIAL RECONSTRUCTION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.35,
                    description: "PIAL-TO-PIAL CYLINDRICAL RESTORATION: Fine interrupted 7-0 monofilament sutures re-approximating lateral pial margins to recreate a closed tube.",
                    surgicalPearl: "Re-tubularizing the neural placode prevents direct adherences between neural tissue and the overlying dural patch, eliminating recurrent cord tethering."
                ),
                SurgicalCallout(
                    id: "plate_095_4",
                    title: "Watertight Duraplasty & Flaps",
                    structureType: "HERMETIC CLOSURE",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.55,
                    description: "WATERTIGHT MULTI-LAYER REPAIR: Running 5-0 dural reconstruction reinforced with bilateral paraspinous lumbodorsal fascial advancement flaps.",
                    surgicalPearl: "Watertight dural closure backed by vascularized myofascial advancement eliminates neonatal CSF fistulae and fatal bacterial meningitis."
                )
            ]
        case .plate096:
            return [
                SurgicalCallout(
                    id: "plate_096_1",
                    title: "Anterolateral & Skull Base Corridors",
                    structureType: "CRANIAL SURGICAL VECTORS",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.25,
                    normalizedY: 0.35,
                    description: "Pterional, orbitozygomatic (FTOZ), and subtemporal trajectories accessing anterior/middle skull base, Circle of Willis, and basilar apex.",
                    surgicalPearl: "Orbitozygomatic osteotomy flattens the cranial base approach angle, reducing brain retraction by up to 30%."
                ),
                SurgicalCallout(
                    id: "plate_096_2",
                    title: "Posterolateral & CPA Corridors",
                    structureType: "POSTERIOR FOSSA VECTORS",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.25,
                    normalizedY: 0.70,
                    description: "Retrosigmoid, far-lateral transcondylar, and supracerebellar infratentorial pathways to the cerebellopontine angle, clivus, and pineal region.",
                    surgicalPearl: "Early cisterna magna drainage induces immediate gravity cerebellar relaxation, minimizing mechanical retraction injury."
                ),
                SurgicalCallout(
                    id: "plate_096_3",
                    title: "360° Spinopelvic Alignment Vectors",
                    structureType: "SPINAL BIOMECHANICAL ALIGNMENT",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.75,
                    normalizedY: 0.35,
                    description: "Ventral (ALIF), lateral (LLIF), and posterior (TLIF/PSF) reconstruction restoring PI-LL mismatch < 10° and SVA < 4 cm.",
                    surgicalPearl: "Restoring physiological lordosis at L4-S1 (accounting for 67% of total lumbar lordosis) prevents proximal junctional failure."
                ),
                SurgicalCallout(
                    id: "plate_096_4",
                    title: "Precision Neural & Functional Targets",
                    structureType: "FUNCTIONAL & PERIPHERAL CORRIDORS",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.75,
                    normalizedY: 0.70,
                    description: "Deep brain stimulation (STN/GPi), cortical mapping corridors, and targeted peripheral nerve reinnervation pathways.",
                    surgicalPearl: "Sub-millimetric stereotactic precision and continuous intraoperative neurophysiology are essential to optimize therapeutic window."
                )
            ]
        case .plate097:
            return [
                SurgicalCallout(
                    id: "plate_097_1",
                    title: "Type II Odontoid Fracture",
                    structureType: "HIGH CERVICAL TRAUMA",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "ANDERSON-D'ALONZO TYPE II FRACTURE: Acute transverse fracture through the base/waist of the odontoid process with dens displacement.",
                    surgicalPearl: "Type II fractures have high pseudoarthrosis rates with conservative immobilization; direct anterior lag screw fixation preserves C1-C2 rotation."
                ),
                SurgicalCallout(
                    id: "plate_097_2",
                    title: "Retropharyngeal Corridor",
                    structureType: "LOW TRAJECTORY APPROACH",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.60,
                    description: "LOW SMITH-ROBINSON INTERVAL: Low C5-C6 skin crease incision tunneling cephalad retropharyngeally to access the C2-C3 disc space.",
                    surgicalPearl: "A low skin incision at C5-C6 is mandatory to achieve the steep cranial trajectory required to align the screw with the odontoid long axis."
                ),
                SurgicalCallout(
                    id: "plate_097_3",
                    title: "Anterior-Inferior C2 Entry Point",
                    structureType: "DRILL SLEEVE DOCKING",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.40,
                    description: "MIDLINE ENTRY SITE: Cannulated guide sleeve docked precisely at the anterior-inferior midline lip of the C2 vertebral body.",
                    surgicalPearl: "Excise the anterior-superior lip of C3 and shallowly notch the C2 anterior-inferior rim to prevent anterior screw head kick-out."
                ),
                SurgicalCallout(
                    id: "plate_097_4",
                    title: "Cannulated Lag Screw & Apical Purchase",
                    structureType: "RIGID COMPRESSION FIXATION",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.25,
                    description: "BICORTICAL APICAL PURCHASE: Partially threaded 4.0 mm cannulated screw traversing fracture line and engaging dense apical cortex.",
                    surgicalPearl: "Threads must completely cross the fracture line into the odontoid tip to achieve true lag compression across the fracture gap."
                )
            ]
        case .plate098:
            return [
                SurgicalCallout(
                    id: "plate_098_1",
                    title: "C5-C6 Paracentral Herniation",
                    structureType: "CERVICAL RADICULOPATHY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "RADICULOPATHY TARGET PATHOLOGY: High-resolution sagittal T2 MRI demonstrating soft focal disc herniation without severe facet arthrosis.",
                    surgicalPearl: "Ideal indication for motion preservation: soft disc herniation with preserved disc height and absent facet joint degeneration."
                ),
                SurgicalCallout(
                    id: "plate_098_2",
                    title: "Parallel Endplate Shaping",
                    structureType: "SUBCHONDRAL PRESERVATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.45,
                    description: "PARALLEL CARTILAGE PREPARATION: Meticulous flat subchondral preparation preserving dense apophyseal ring cortical bone to prevent subsidence.",
                    surgicalPearl: "Never violate the dense cortical bone of the apophyseal ring; burring into cancellous bone precipitates early implant subsidence."
                ),
                SurgicalCallout(
                    id: "plate_098_3",
                    title: "Posterior Dural & Foraminal Release",
                    structureType: "CORD & ROOT LIBERATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.62,
                    normalizedY: 0.35,
                    description: "RADICAL THECAL UNROOFING: Complete resection of posterior longitudinal ligament and uncovertebral spurs ensuring unrestricted root mobility.",
                    surgicalPearl: "Decompress bilateral foramina completely; retained uncinate spurs cause persistent dynamic radicular impingement during lateral bending."
                ),
                SurgicalCallout(
                    id: "plate_098_4",
                    title: "Mobile-Bearing Disc Prosthesis",
                    structureType: "MOTION ARTHROPLASTY",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.50,
                    description: "KINEMATIC MOTION PRESERVATION: Semi-constrained mobile-bearing artificial disc prosthesis centered precisely on anatomic vertebral midline.",
                    surgicalPearl: "Strict midline prosthesis insertion under fluoroscopy prevents asymmetrical uncinate loading and accelerated facet joint arthrosis."
                )
            ]
        case .plate099:
            return [
                SurgicalCallout(
                    id: "plate_099_1",
                    title: "Rigid Cervicothoracic Kyphosis",
                    structureType: "CHIN-ON-CHEST DEFORMITY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "FIXED SAGITTAL DEFORMITY: Severe rigid cervicothoracic kyphosis causing horizontal gaze impairment, dysphagia, and neurological deficits.",
                    surgicalPearl: "Rigid ankylosing spondylitis or severe post-laminectomy kyphosis requires formal 3-column osteotomy for horizontal gaze restoration."
                ),
                SurgicalCallout(
                    id: "plate_099_2",
                    title: "C7 Pedicle Subtraction Osteotomy",
                    structureType: "3-COLUMN CLOSING WEDGE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.40,
                    normalizedY: 0.50,
                    description: "SYMMETRICAL C7 WEDGE RESECTION: Resection of C7 posterior arch, bilateral pedicles, and wedge of vertebral body down to anterior cortex.",
                    surgicalPearl: "C7 is the preferred cervical PSO level due to wide pedicles, spacious canal, and avoidance of the vertebral artery in most anatomies."
                ),
                SurgicalCallout(
                    id: "plate_099_3",
                    title: "Bilateral C8 Root Decompression",
                    structureType: "FORAMINAL NERVE PRESERVATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.62,
                    normalizedY: 0.40,
                    description: "C8 FORAMINAL LIBERATION: Complete unroofing and mobilization of bilateral C8 nerve roots prior to closing the osteotomy wedge.",
                    surgicalPearl: "Perform aggressive uncinatectomies and foraminotomies for both C8 roots; osteotomy closure narrows foramina and risks hand intrinsic palsy."
                ),
                SurgicalCallout(
                    id: "plate_099_4",
                    title: "Multi-Rod Cervicothoracic Fixation",
                    structureType: "MULTI-ROD NEUTRALIZATION",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.60,
                    description: "RIGID MULTI-SEGMENT STABILIZATION: Dual primary rods reinforced by satellite outrigger rods spanning C3-C5 lateral mass to T2-T4 pedicle screws.",
                    surgicalPearl: "Quad-rod construction spanning across the C7 osteotomy junction prevents fatigue failure and catastrophic rod breakage."
                )
            ]
        case .plate100:
            return [
                SurgicalCallout(
                    id: "plate_100_1",
                    title: "Oblique Retroperitoneal Corridor",
                    structureType: "PRE-PSOAS ATRAUMATIC WINDOW",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.30,
                    description: "ANTERIOR TO PSOAS (ATP): Natural avascular retroperitoneal interval developed between the anterior psoas border and left common iliac vessels.",
                    surgicalPearl: "Working in the pre-psoas ATP corridor eliminates muscle dissection, completely sparing the traversing lumbar plexus from retraction injury."
                ),
                SurgicalCallout(
                    id: "plate_100_2",
                    title: "Great Vessel Boundary Margin",
                    structureType: "VASCULAR PROTECTION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.55,
                    description: "VASCULAR MOBILIZATION: Abdominal aorta and left common iliac vein mobilized medially under gentle hand-held retractor protection.",
                    surgicalPearl: "Always identify and sweep the left common iliac vein gently across the midline; never place sharp pin retractors near vessel margins."
                ),
                SurgicalCallout(
                    id: "plate_100_3",
                    title: "Contralateral Annular Release",
                    structureType: "LIGAMENTOUS REALIGNMENT",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.45,
                    description: "COMPLETE ANNULAR RELEASE: Complete division of contralateral annulus fibrosus releasing rigid coronal scoliosis and opening disc height.",
                    surgicalPearl: "Releasing the tough contralateral annulus allows the collapsed disc space to open symmetrically under cage distraction."
                ),
                SurgicalCallout(
                    id: "plate_100_4",
                    title: "Hyperlordotic Interbody Cage",
                    structureType: "CORONAL & SAGITTAL CORRECTION",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.50,
                    description: "WIDE-FOOTPRINT APICAL CAGE: Insertion of wide lordotic cage spanning bilateral cortical apophyseal rings for indirect decompression.",
                    surgicalPearl: "Spanning across the dense lateral apophyseal rings prevents implant subsidence and delivers robust indirect neural foraminal decompression."
                )
            ]
        case .plate101:
            return [
                SurgicalCallout(
                    id: "plate_101_1",
                    title: "Prone Hip Extension Position",
                    structureType: "SAGITTAL LORDOSIS",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.30,
                    description: "SAGITTAL REALIGNMENT SETUP: Patient positioned prone on radiolucent frame with downward thigh extension to naturally accentuate lordosis.",
                    surgicalPearl: "Downward thigh angulation locks the pelvis and restores natural lumbar lordosis prior to interbody cage placement."
                ),
                SurgicalCallout(
                    id: "plate_101_2",
                    title: "Gravitational Visceral Clearance",
                    structureType: "RETROPERITONEAL CLEARANCE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.55,
                    description: "ANTERIOR VISCERAL DROPOFF: Prone gravity causes the peritoneal sac and abdominal viscera to fall anteriorly away from the spine.",
                    surgicalPearl: "Gravity pulls the peritoneal envelope ventrally, opening a spacious avascular corridor into the retroperitoneal space."
                ),
                SurgicalCallout(
                    id: "plate_101_3",
                    title: "Orthogonal Retractor Docking",
                    structureType: "TRANSPSOAS CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.40,
                    description: "DIRECT ORTHOGONAL DOCKING: Rigid blade retractor docked squarely on the disc space under biplanar fluoroscopy and directional EMG.",
                    surgicalPearl: "Docking in the anterior third of the disc space under directional EMG eliminates traction on the traversing lumbosacral plexus."
                ),
                SurgicalCallout(
                    id: "plate_101_4",
                    title: "Simultaneous 360° Stabilization",
                    structureType: "SINGLE-POSITION ARTHRODESIS",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.60,
                    description: "CIRCUMFERENTIAL SINGLE-POSITION FUSION: Insertion of wide-footprint lordotic cage paired with concurrent posterior percutaneous screw fixation.",
                    surgicalPearl: "Simultaneous lateral interbody and posterior percutaneous screw placement eliminates repositioning time and maximizes segmental lordosis."
                )
            ]
        case .plate102:
            return [
                SurgicalCallout(
                    id: "plate_102_1",
                    title: "Severe Rigid Gibbus Deformity",
                    structureType: "ANGULAR KYPHOSIS APEX",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.10,
                    normalizedY: 0.38,
                    description: "SHARP ANGULAR RESECTION TARGET: Severe focal angular kyphosis causing mechanical cord draping and anterior vascular compromise.",
                    surgicalPearl: "Resection of the apical 3-column apex is required to eliminate rigid cord stretch and allow harmonious sagittal realignment."
                ),
                SurgicalCallout(
                    id: "plate_102_2",
                    title: "Temporary Stabilizing Rod",
                    structureType: "BIOMECHANICAL SAFEGUARD",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.28,
                    normalizedY: 0.20,
                    description: "SHEAR TRANSLATION SAFEGUARD: Rigid unilateral rod locked to pedicle screws above and below prior to any circumferential bone removal.",
                    surgicalPearl: "Never breach bilateral columns without a locked stabilizing rod; sudden cord transection from subluxation can occur in seconds."
                ),
                SurgicalCallout(
                    id: "plate_102_3",
                    title: "Suspended Thecal Tube",
                    structureType: "360° CIRCUMFERENTIAL LIBERATION",
                    color: ObsidianTheme.neonPurple,
                    normalizedX: 0.48,
                    normalizedY: 0.35,
                    description: "CIRCUMFERENTIALLY FLOATING SPINAL CORD: Dural tube completely mobilized 360° following apical laminectomy and bilateral root ligation.",
                    surgicalPearl: "Ligate 1-2 non-critical thoracic nerve roots (T2-T10) to facilitate gentle mobilization around the thecal sac with zero spinal cord traction."
                ),
                SurgicalCallout(
                    id: "plate_102_4",
                    title: "Expandable Anterior Cage & Quad-Rod",
                    structureType: "ANTERIOR LOAD SHARING & STABILIZATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.75,
                    normalizedY: 0.40,
                    description: "STRUCTURAL RECONSTRUCTION & MULTI-ROD LOCK: Expandable titanium corpectomy cage deployed anteriorly, neutralized by quad-rod posterior fixation.",
                    surgicalPearl: "Accessory outrigger rods linked with dominos across the VCR defect are essential to resist enormous fatigue moments and eliminate rod breakage."
                )
            ]
        case .plate103:
            return [
                SurgicalCallout(
                    id: "plate_103_1",
                    title: "T8 Metastatic Vertebral Collapse",
                    structureType: "SPINE ONCOLOGY PATHOLOGY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.10,
                    normalizedY: 0.38,
                    description: "PATHOLOGIC COMPRESSION FRACTURE: Osteolytic metastatic destruction of T8 with circumferential canal retropulsion and Bilsky 3 cord compression.",
                    surgicalPearl: "SINS score >= 13 denotes gross instability; complete ventral decompression combined with multi-level instrumentation is mandatory."
                ),
                SurgicalCallout(
                    id: "plate_103_2",
                    title: "Costotransversectomy Corridor",
                    structureType: "EXTRAPLEURAL WINDOW",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.28,
                    normalizedY: 0.25,
                    description: "EXTRAPLEURAL TRAJECTORY: Resection of 3-4 cm medial 8th rib including head, neck, and T8 transverse process down to vertebral body.",
                    surgicalPearl: "Work strictly in the extrapleural plane with moist cottonoids to avoid pleural violation, pneumothorax, and chest tube placement."
                ),
                SurgicalCallout(
                    id: "plate_103_3",
                    title: "Circumferential Thecal Sac Liberation",
                    structureType: "VENTRAL CORD DECOMPRESSION",
                    color: ObsidianTheme.neonPurple,
                    normalizedX: 0.52,
                    normalizedY: 0.48,
                    description: "360° EPIDURAL TUMOR RESECTION: Total T8 corpectomy between T7 inferior and T9 superior endplates, fully freeing ventral dura.",
                    surgicalPearl: "Complete removal of dorsal vertebral cortex and PLL restores dural expansion and brisk microvascular pulsations."
                ),
                SurgicalCallout(
                    id: "plate_103_4",
                    title: "Expandable Titanium Cage & Posterior Construct",
                    structureType: "STRUCTURAL RECONSTRUCTION",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.80,
                    normalizedY: 0.45,
                    description: "ANTERIOR LOAD SHARING & T6-T10 NEUTRALIZATION: In-situ expandable cage expanded between intact endplates, protected by posterior pedicle screws.",
                    surgicalPearl: "Fluoroscopic verification ensures cage teeth engage subchondral bone without violating osteoporotic T7 or T9 endplates."
                )
            ]
        case .plate104:
            return [
                SurgicalCallout(
                    id: "plate_104_1",
                    title: "Acute Supra-Adjacent Fracture (UIV+1)",
                    structureType: "JUNCTIONAL KYPHOTIC COLLAPSE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.08,
                    normalizedY: 0.35,
                    description: "ACUTE JUNCTIONAL FAILURE: Anterior wedge collapse and superior endplate impaction of the mobile vertebra immediately above the cemented UIV.",
                    surgicalPearl: "Cement augmentation stiffens index UIV but transfers massive cantilever bending moments to the mobile level above."
                ),
                SurgicalCallout(
                    id: "plate_104_2",
                    title: "Axial Domino Rod Connectors",
                    structureType: "REVISION COUPLING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.45,
                    normalizedY: 0.60,
                    description: "TANDEM AXIAL ROD LINKAGE: Heavy-duty cylindrical domino connectors rigidly coupling existing lumbosacral rods to new cranial extension rods.",
                    surgicalPearl: "Torque domino set screws to manufacturer specifications; domino slippage is a primary cause of early revision construct failure."
                ),
                SurgicalCallout(
                    id: "plate_104_3",
                    title: "Upper Thoracic Foundation (T2–T4)",
                    structureType: "PROXIMAL THORACIC FIXATION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.25,
                    description: "RIGID UPPER THORACIC ANCHORS: Extension of bilateral pedicle screws to T2, sheltered by the rigid rib cage to eliminate junctional shear.",
                    surgicalPearl: "Stopping a revision construct in the mid-thoracic kyphosis apex invites re-failure; extending to T2-T3 ensures lasting biomechanical stability."
                ),
                SurgicalCallout(
                    id: "plate_104_4",
                    title: "Multi-Rod Transition Outriggers",
                    structureType: "FATIGUE RESISTANCE",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.75,
                    normalizedY: 0.50,
                    description: "4-ROD TRANSITION BRIDGING: Accessory outrigger rods spanning across domino connectors to distribute cantilever loads and prevent rod fracture.",
                    surgicalPearl: "Four-rod constructs spanning the revision junction reduce rod strain by > 50%, virtually eliminating fatigue breakage prior to solid union."
                )
            ]
        case .plate105:
            return [
                SurgicalCallout(
                    id: "plate_105_1",
                    title: "Split Symmetrical Hemicords",
                    structureType: "NEURAL DYSRAPHISM (PANG TYPE I)",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.08,
                    normalizedY: 0.22,
                    description: "DUAL HEMICORDS: Symmetrical hemicords, each containing independent central canal and anterior spinal artery; strictly avoid neural traction.",
                    surgicalPearl: "Each hemicord possesses separate microvasculature; never retract or dissect between hemicords until the central bony spur is fully excised."
                ),
                SurgicalCallout(
                    id: "plate_105_2",
                    title: "Median Osseous Spur",
                    structureType: "TETHERING BONY SEPTUM",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.26,
                    normalizedY: 0.38,
                    description: "CORTICATED MIDLINE SPUR: Dense osseous septum arising from dorsal vertebral body, bisecting the thecal sac into duplicate dural tubes.",
                    surgicalPearl: "The spur anchors ventrally to the vertebral body and dorsally to the lamina, acting as a rigid anvil that progressively tethers the spinal cord."
                ),
                SurgicalCallout(
                    id: "plate_105_3",
                    title: "Diamond Burr Extradural Resection",
                    structureType: "MICROSURGICAL DRILLOUT",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.50,
                    normalizedY: 0.22,
                    description: "EXTRADURAL DRILLING PLANE: High-speed diamond burr under continuous irrigation thin-shelling the spur down to the anterior canal floor.",
                    surgicalPearl: "Always drill the spur completely extradurally before opening dura; bone dust inside the arachnoid space causes severe arachnoiditis."
                ),
                SurgicalCallout(
                    id: "plate_105_4",
                    title: "Unified Thecal Sac Duraplasty",
                    structureType: "UNTETHERED RECONSTRUCTION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.75,
                    normalizedY: 0.35,
                    description: "RECONSTITUTED SINGLE THECAL TUBE: Excision of medial dural sleeves and running 5-0 closure, converting dual sacs into a single pulsatile CSF chamber.",
                    surgicalPearl: "Resecting the inner median dural cuffs prevents fibrous septum re-formation and allows the freed hemicords to float together in a single CSF pool."
                )
            ]
        case .plate106:
            return [
                SurgicalCallout(
                    id: "plate_106_1",
                    title: "Sacroiliac Joint Articulation",
                    structureType: "PELVIC JOINT LINE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.15,
                    normalizedY: 0.35,
                    description: "PELVIC ARTICULATION TARGET: High-resolution pelvic CT confirming joint sclerosis, subchondral erosions, and diagnostic anesthetic relief.",
                    surgicalPearl: "Preoperative confirmation of >= 75% pain relief following fluoroscopy-guided intra-articular block is mandatory before fusion."
                ),
                SurgicalCallout(
                    id: "plate_106_2",
                    title: "Sacral Ala Safe Corridor",
                    structureType: "ANTERIOR BOUNDARY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.38,
                    normalizedY: 0.25,
                    description: "ANTERIOR SACRAL SAFE ZONE: Transarticular corridor bounded anteriorly by the sacral ala cortex; avoid penetration into L5 nerve root.",
                    surgicalPearl: "Never breach the anterior sacral cortex; over-drilling or anterior implant migration endangers the L5 ventral ramus and internal iliac vessels."
                ),
                SurgicalCallout(
                    id: "plate_106_3",
                    title: "Greater Sciatic Notch Safety Limit",
                    structureType: "CAUDAL BOUNDARY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.60,
                    normalizedY: 0.55,
                    description: "CAUDAL BOUNDARY LIMIT: Inferior bony safety margin housing superior gluteal neurovascular bundle; maintain >= 15 mm clearance.",
                    surgicalPearl: "Keep starting trajectories strictly >= 15 mm cranial to the greater sciatic notch to eliminate risk of superior gluteal artery laceration."
                ),
                SurgicalCallout(
                    id: "plate_106_4",
                    title: "Tri-Planar Triangular Implants",
                    structureType: "SACROPELVIC ARTHRODESIS",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.85,
                    normalizedY: 0.45,
                    description: "TRI-PLANAR TRANSARTICULAR FIXATION: Three porous titanium triangular implants traversing the SI joint into the dense sacral body.",
                    surgicalPearl: "Triangular cross-section design prevents rotational micro-motion across the joint, achieving rapid biologic osseointegration."
                )
            ]
        case .plate089:
            return [
                SurgicalCallout(
                    id: "plate_089_1",
                    title: "Five Ulnar Compression Zones",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.16,
                    normalizedY: 0.35,
                    description: "Arcade of Struthers, medial intermuscular septum, retrocondylar groove, Osborne's ligament, and deep FCU aponeurosis.",
                    surgicalPearl: "Always excise 2–3 cm of medial intermuscular septum when transposing; failure to excise septum creates severe secondary kinking."
                ),
                SurgicalCallout(
                    id: "plate_089_2",
                    title: "In-Situ Neurolysis & FCU Motor Branch",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.35,
                    description: "Complete epineurial unroofing from retrocondylar groove distally, carefully sparing first motor branch to flexor carpi ulnaris.",
                    surgicalPearl: "Use intraneural micro-dissection to mobilize FCU motor branch proximally; gains 2–3 cm of transposition slack without sacrificing fibers."
                ),
                SurgicalCallout(
                    id: "plate_089_3",
                    title: "Elevated Flexor-Pronator Muscular Bed",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.84,
                    normalizedY: 0.35,
                    description: "Z-lengthened detachment of flexor-pronator muscle origin from medial epicondyle, creating deep submuscular bed.",
                    surgicalPearl: "Place transposed nerve directly on brachialis muscle belly beneath re-approximated flexor mass without any angulation."
                ),
                SurgicalCallout(
                    id: "plate_089_4",
                    title: "Medial Antebrachial Cutaneous Nerve (MACN)",
                    structureType: "CRITICAL STRUCTURE",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.84,
                    normalizedY: 0.75,
                    description: "Anterior and posterior branches of MACN crossing curved incision line; meticulously preserved to prevent painful neuroma.",
                    surgicalPearl: "Transection of MACN branches produces an excruciating sensory neuroma along medial forearm; identify and mobilize both branches."
                )
            ]

        case .plate088:
            return [
                SurgicalCallout(
                    id: "plate_088_1",
                    title: "Craniocervical Instability Metrics (BDI/BAI)",
                    structureType: "PATHOLOGY / DIAGNOSTIC",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.16,
                    normalizedY: 0.35,
                    description: "Basilar invagination with cranial settling and pannus compressing cervicomedullary junction (BDI > 10 mm, BAI > 10 mm).",
                    surgicalPearl: "Lock skull in functional neutral gaze alignment (O-C2 angle 14°–16°); fixating in hyper-extension causes severe dysphagia and airway obstruction."
                ),
                SurgicalCallout(
                    id: "plate_088_2",
                    title: "Suboccipital Craniectomy & C1 Arch Resection",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.50,
                    normalizedY: 0.35,
                    description: "2.5–3.0 cm wide suboccipital decompression and C1 posterior arch removal unroofing foramen magnum and relieving brainstem compression.",
                    surgicalPearl: "Stay strictly within medial 12 mm on superior border of C1 arch; lateral dissection risks lacerating V3 vertebral artery."
                ),
                SurgicalCallout(
                    id: "plate_088_3",
                    title: "V3 Vertebral Artery Sulcus Arteriosus",
                    structureType: "VASCULAR BOUNDARY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.84,
                    normalizedY: 0.35,
                    description: "Vertebral artery V3 loop coursing horizontally along dorsal C1 ring groove before piercing atlanto-occipital membrane.",
                    surgicalPearl: "Subperiosteally dissect superior C1 ring from medial to lateral, maintaining bone between dissector and sulcus arteriosus."
                ),
                SurgicalCallout(
                    id: "plate_088_4",
                    title: "Midline Occipital Keel Plate & C1-C4 Screws",
                    structureType: "RECONSTRUCTION",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.84,
                    normalizedY: 0.75,
                    description: "Thick midline occipital keel plate (12–15 mm cortical purchase) connected via contoured rods to C1 lateral mass and C2-C4 screws.",
                    surgicalPearl: "Midline occipital keel provides dense bicortical bone up to 15 mm thick; lateral occipital bone thins to <4 mm with poor purchase."
                )
            ]

        case .plate087:
            return [
                SurgicalCallout(
                    id: "plate_087_1",
                    title: "Left Paramedian Retroperitoneal Exposure",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.16,
                    normalizedY: 0.35,
                    description: "Transversalis fascia divided and peritoneal sac mobilized medially, retracting ureter safely with posterior peritoneum.",
                    surgicalPearl: "Keep the ureter attached to the swept posterior peritoneum; never dissect ureter free to avoid devascularization."
                ),
                SurgicalCallout(
                    id: "plate_087_2",
                    title: "Aortic Bifurcation & Common Iliac Confluence",
                    structureType: "VASCULAR BOUNDARY",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.50,
                    normalizedY: 0.35,
                    description: "Bifurcation triangle over L5–S1. Left common iliac vein mobilized medially; middle sacral vessels clipped and divided.",
                    surgicalPearl: "Strictly avoid monopolar electrocautery over promontory; thermal spread to superior hypogastric plexus causes retrograde ejaculation."
                ),
                SurgicalCallout(
                    id: "plate_087_3",
                    title: "Total Discectomy & ALL Division",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.84,
                    normalizedY: 0.35,
                    description: "Complete annulotomy, anterior longitudinal ligament release, and endplate clearance preserving subchondral bone.",
                    surgicalPearl: "Resect anterior longitudinal ligament and release posterior annulus completely to allow full expansion of hyperlordotic cage."
                ),
                SurgicalCallout(
                    id: "plate_087_4",
                    title: "Hyperlordotic Cage & Divergent Fixation",
                    structureType: "RECONSTRUCTION",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.84,
                    normalizedY: 0.75,
                    description: "Wide-footprint lordotic PEEK/titanium cage seated on dense peripheral apophyseal ring with integrated locking screws.",
                    surgicalPearl: "Engage the dense anterior apophyseal ring of S1; never countersink past the cortical edge to prevent subsidence."
                )
            ]

        case .plate086:
            return [
                SurgicalCallout(
                    id: "plate_086_1",
                    title: "Kocher's Point Stereotactic Trajectory",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.16,
                    normalizedY: 0.35,
                    description: "Entry 2.5 cm lateral to midline and 1 cm anterior to coronal suture, angled toward ipsilateral foramen of Monro and mammillary bodies.",
                    surgicalPearl: "Coronal trajectory passes through Monro without shearing anterior column of fornix, avoiding permanent anterograde amnesia."
                ),
                SurgicalCallout(
                    id: "plate_086_2",
                    title: "Foramen of Monro & Venous Landmarks",
                    structureType: "ENDOSCOPIC LANDMARK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.35,
                    description: "Choroid plexus entering foramen of Monro with junction of thalamostriate vein and anterior septal vein confirming orientation.",
                    surgicalPearl: "Choroid plexus always leads to foramen of Monro; use it as your infallible guide in distorted or asymmetric ventricles."
                ),
                SurgicalCallout(
                    id: "plate_086_3",
                    title: "Premamillary Tuber Cinereum Target Zone",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.84,
                    normalizedY: 0.35,
                    description: "Translucent attenuated floor of third ventricle situated midway between infundibular recess anteriorly and mammillary bodies posteriorly.",
                    surgicalPearl: "Target attenuated premamillary membrane strictly in midline; perforating lateral to mammillary bodies damages CN III or hypothalamus."
                ),
                SurgicalCallout(
                    id: "plate_086_4",
                    title: "Fogarty Balloon Dilation & Basilar Apex",
                    structureType: "SURGICAL TECHNIQUE",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.84,
                    normalizedY: 0.75,
                    description: "3 Fr Fogarty balloon catheter dilated with fluid creating a 4-5 mm stoma into prepontine cistern, visualizing basilar artery.",
                    surgicalPearl: "Inspect basilar apex and clivus beneath floor before balloon inflation; ensure balloon tip is completely free of basilar perforators."
                )
            ]

        case .plate085:
            return [
                SurgicalCallout(
                    id: "plate_085_1",
                    title: "Diagnostic MRI & Resection Margins",
                    structureType: "T2 MRI & MARGIN CLASSIFICATION",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.35,
                    description: "Panel 1 presents diagnostic MRI and oncologic margin classification. Sagittal and axial T2 MRI reveal a large, lobulated, markedly T2-hyperintense sacral chordoma with fibrous septations expanding the lower sacrum and extending into the presacral pelvic space, displacing the rectum. The margin classification defines: (1) High Sacrectomy (S1–S2): Osteotomy above S2 or through S1 removes the entire distal sacrum en bloc (S1–S5 red), uncoupling the spine from the pelvis and sacrificing lower sacral roots; and (2) Low Sacrectomy (Below S3): Osteotomy below S3 preserves S1–S3 roots (bone tan) and resects S4–S5 (red), preserving voluntary bowel, bladder, and sexual continence.",
                    surgicalPearl: "In high sacrectomy, an en-bloc oncologic margin (R0) requires complete removal of all sacral segments distal to the osteotomy line; sparing at least one S2 and one S3 root preserves functional continence."
                ),
                SurgicalCallout(
                    id: "plate_085_2",
                    title: "Combined Anterior-Posterior Surgical Release",
                    structureType: "TWO-STAGE RETROPERITONEAL & POSTERIOR EN-BLOC CORRIDORS",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Panel 2 details the two-stage surgical release. Stage 1 (Anterior Retroperitoneal Release): Supine/retroperitoneal exposure with lateral mobilization of the bifurcating common and internal iliac vessels, identification and lateralization of bilateral ureters, anterior mobilization of the rectum away from the presacral tumor pseudocapsule, and insertion of a protective synthetic spacer in the presacral plane. Stage 2 (Posterior En-Bloc Resection): Prone posterior midline approach dividing the sacrotuberous and sacrospinous ligaments, high-speed burr osteotomy through the bilateral sacroiliac joints and sacrum into the anterior spacer, and delivery of the intact tumor-bearing sacral specimen en bloc with negative margins.",
                    surgicalPearl: "Never attempt high sacrectomy posteriorly without prior anterior mobilization of the iliac vessels and rectum; the anterior spacer provides a safe stopping barrier for posterior osteotomy burrs."
                ),
                SurgicalCallout(
                    id: "plate_085_3",
                    title: "Spinopelvic Reconstruction & Soft Tissue Closure",
                    structureType: "TRIANGULAR SPINOPELVIC FRAME & GLUTEUS MAXIMUS FLAP",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.50,
                    description: "Panel 3 illustrates definitive mechanical reconstruction and soft-tissue dead space management. Triangular Spinopelvic Fixation: Dual bilateral L3–L5 pedicle screws (6 screws) connected via dual divergent longitudinal rods to quad bilateral iliac screws (4 screws total, 2 per iliac wing), triangulated by a transverse pelvic cross-link connector bar. An expandable porous titanium mesh cage spans the vertical defect from the L5 inferior endplate to the pelvic bar to resist downward axial shear forces. Soft-tissue closure is achieved via bilateral gluteus maximus myocutaneous advancement flaps (V-Y advancement) mobilized medially to obliterate dead space and prevent pelvic herniation.",
                    surgicalPearl: "High sacrectomy completely disrupts the posterior pelvic ring; quad iliac screws combined with dual-rod triangulation and a structural anterior column cage are mandatory to prevent early mechanical failure."
                ),
                SurgicalCallout(
                    id: "plate_085_4",
                    title: "Three Concise Resident Pearls",
                    structureType: "ONCOLOGIC RESECTION & PELVIC STABILITY RULES",
                    color: Color.blue,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom bar highlights three cardinal surgical oncology rules: (1) Continence Preservation: Sparing at least one S2 and one S3 nerve root maintains functional urinary and fecal continence; bilateral sacrifice above S3 causes permanent neurogenic incontinence; (2) Anterior Vascular Release: Never attempt high sacrectomy posteriorly without prior anterior mobilization of the iliac vessels and rectum; prevents catastrophic vascular injury; and (3) Triangular Spinopelvic Fixation: High sacrectomy completely breaks the pelvic ring; quad iliac screws with dual-rod triangulation are mandatory to prevent early hardware failure.",
                    surgicalPearl: "Sacral chordoma has a high propensity for local recurrence (>80% with intralesional capsular violation vs <10% with wide R0 margins); en-bloc resection with pristine microscopic negative margins is the sole determinant of long-term disease-free survival."
                )
            ]

        case .plate084:
            return [
                SurgicalCallout(
                    id: "plate_084_1",
                    title: "Diagnostic 3D CTA & Paraclinoid Anatomy",
                    structureType: "3D CTA & LATERAL DSA ANGIOARCHITECTURE",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.30,
                    description: "Panel 1 details vascular diagnostics and 3D anatomy. 3D CTA and lateral DSA reveal a large paraclinoid aneurysm originating from the superior/medial wall of the ophthalmic segment of the ICA (C6), indenting and elevating the undersurface of the optic nerve (CN II). Paraclinoid (C6) microanatomy is organized into 4 critical zones: (1) Ophthalmic artery origin; (2) Carotid cave (subdural dural recess medial to clinoid segment); (3) Superior hypophyseal artery (SHA) arising medially; and (4) Clinoid segment (C6) bounded between proximal and distal dural rings.",
                    surgicalPearl: "Paraclinoid aneurysms project superiorly directly under the optic nerve, stretching the nerve against the sharp falciform fold and causing progressive visual field deficits (typically an inferior nasal quadrantanopsia)."
                ),
                SurgicalCallout(
                    id: "plate_084_2",
                    title: "Extradural Clinoidectomy & Optic Strut Drilling",
                    structureType: "DOLENC TECHNIQUE & OPTIC STRUT CORING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Panel 2 demonstrates the 4-step Dolenc extradural clinoidectomy: (1) Extradural drilling of the lesser sphenoid wing and orbital roof; (2) Diamond burr drilling of the optic strut—the critical bony bridge of the lesser wing separating the optic canal from the superior orbital fissure; (3) En-bloc or core removal of the devitalized anterior clinoid process (ACP), unlocking the clinoid carotid space; and (4) Unroofing the optic canal and sharply incising the falciform ligament to release the optic nerve.",
                    surgicalPearl: "Drilling the optic strut completely disconnects the anterior clinoid process from the sphenoid body. Copious continuous saline irrigation during drilling is mandatory to avoid thermal optic neuropathy."
                ),
                SurgicalCallout(
                    id: "plate_084_3",
                    title: "Distal Dural Ring Dissection & Clip Occlusion",
                    structureType: "CIRCUMFERENTIAL DDR DIVISION & PRESERVATION OF FLOW",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.50,
                    description: "Panel 3 illustrates the microsurgical intradural corridor. Micro-scissors sharply divide the fibrous distal dural ring (DDR) around the anterior and lateral circumference of the ICA, mobilizing the clinoid carotid into the subarachnoid space and exposing the true proximal neck of the aneurysm. An angled microsurgical aneurysm clip is applied flush across the neck, achieving complete aneurysm obliteration while preserving 100% patency of the parent supraclinoid ICA and the ophthalmic artery origin.",
                    surgicalPearl: "Sharp circumferential division of the distal dural ring (DDR) is the single key maneuver that transforms an inaccessible extradural clinoid segment into an intradural corridor, providing safe proximal vascular control."
                ),
                SurgicalCallout(
                    id: "plate_084_4",
                    title: "Three Concise Resident Pearls",
                    structureType: "NEUROSURGICAL SAFETY & VASCULAR PRESERVATION",
                    color: Color.blue,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom bar highlights three mandatory skull base rules: (1) Continuous Irrigation: Maintain copious saline cooling during optic strut and ACP drilling to prevent thermal optic nerve injury; (2) DDR Mobilization: Sharp division of the DDR is required for proximal clip placement; and (3) Ophthalmic Artery Preservation: Always verify flow in the ophthalmic artery with micro-Doppler or ICG angiography before permanent clipping to prevent monocular blindness.",
                    surgicalPearl: "Never apply permanent clip blades without verifying the ophthalmic artery origin is spared; accidental clip occlusion causes immediate, irreversible ipsilateral central retinal artery infarction."
                )
            ]

        case .plate083:
            return [
                SurgicalCallout(
                    id: "plate_083_1",
                    title: "Diagnostic MRI & Kambin's Triangle Geometry",
                    structureType: "AXIAL/SAGITTAL T2 MRI & KAMBIN ANATOMICAL BORDERS",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel 1 establishes radiological indications and the safe transforaminal corridor. Axial T2 MRI (L4–L5) demonstrates an extruded paracentral/foraminal disc fragment compressing the traversing L5 nerve root and impinging the exiting L4 root within the neural foramen. Kambin's Triangle defines the safe posterolateral access window to the disc without retracting the thecal sac: (1) Hypotenuse: exiting L4 nerve root running anterolaterally; (2) Base: superior endplate of L5; and (3) Height: traversing L5 nerve root and lateral thecal sac.",
                    surgicalPearl: "Kambin's triangle is a strict boundary-defined corridor. Staying within the safe zone prevents dural puncture and permanent motor radiculopathy, while avoiding the exiting root prevents severe post-discectomy dysesthesia."
                ),
                SurgicalCallout(
                    id: "plate_083_2",
                    title: "Docking & SAP Foraminoplasty Engine",
                    structureType: "POSTEROLATERAL TRAJECTORY & CROWN REAMER UNDERCUTTING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Panel 2 details the transforaminal approach vector (35°–45° from horizontal, skin entry 8–10 cm from midline). Crown reamers perform targeted foraminoplasty by undercutting only the ventral and inferior non-articulating tip of the Superior Articular Process (SAP), widening the foraminal aperture. The beveled working cannula is docked firmly at the ventral facet border with the bevel oriented dorsolaterally to act as a rigid mechanical shield protecting the exiting L4 nerve root.",
                    surgicalPearl: "Never ream the dorsal facet joint or pars interarticularis; undercutting only the ventral tip of the SAP enlarges the foramen while preserving 100% of segmental biomechanical stability."
                ),
                SurgicalCallout(
                    id: "plate_083_3",
                    title: "HD Endoscopic Intra-Canal Decompression",
                    structureType: "ENDOSCOPIC VISUALIZATION, FRAGMENTECTOMY & RF HEMOSTASIS",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.50,
                    description: "Panel 3 illustrates the high-definition circular endoscopic operative view under continuous saline irrigation. Micro-pituitary rongeurs extract a pearly-white extruded nucleus pulposus fragment from the epidural space through the annular defect. The pulsating, glistening thecal sac and traversing L5 root are completely decompressed medially with visible microvascular pulsations, while radiofrequency (RF) bipolar probes achieve meticulous hemostasis without thermal injury to neural elements.",
                    surgicalPearl: "Always inspect the traversing nerve root from the pedicle above to the pedicle below. A free, mobile root with brisk arterial pulsations confirms complete fragment extraction and adequate decompression."
                ),
                SurgicalCallout(
                    id: "plate_083_4",
                    title: "Three Concise Resident Pearls",
                    structureType: "OPERATIVE SAFETY & IRRIGATIVE PHYSICS",
                    color: Color.blue,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom bar highlights three essential surgical rules: (1) Exiting Root Protection: Keep cannula bevel directed toward the SAP to shield the nerve from instruments; (2) SAP Foraminoplasty: Under-ream only the ventral SAP tip to protect the facet joint; and (3) Fluid Dynamics: Maintain gentle gravity saline irrigation (<30 mmHg) to clear bone dust without causing epidural intracranial hypertension.",
                    surgicalPearl: "High-pressure mechanical irrigation pumps (>50–60 mmHg) risk driving fluid through occult dural tears into the subarachnoid space, precipitating acute intracranial hypertension and seizures."
                )
            ]

        case .plate082:
            return [
                SurgicalCallout(
                    id: "plate_082_1",
                    title: "Diagnostic MRI & Obstructive Hydrocephalus",
                    structureType: "SAGITTAL 3T CONTRAST MRI & TRIVENTRICULAR EXPANSION",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.30,
                    description: "Panel 1 establishes preoperative radiology. Sagittal T1 contrast-enhanced MRI demonstrates a large, heterogeneously enhancing, lobulated mass occupying the fourth ventricle, causing marked fourth ventricular expansion, brainstem compression anteriorly, and superior displacement of the vermis. The mass obstructs the exit pathways (foramina of Luschka and Magendie), producing severe triventricular obstructive hydrocephalus with massive dilation of the lateral and third ventricles.",
                    surgicalPearl: "In acute obstructive hydrocephalus from fourth ventricular tumors, an urgent preoperative external ventricular drain (EVD) or endoscopic third ventriculostomy (ETV) may be required to stabilize intracranial pressure before definitive tumor resection."
                ),
                SurgicalCallout(
                    id: "plate_082_2",
                    title: "The Vermis-Sparing Rule",
                    structureType: "TRANSVERMIAN VS. TELOVELAR CORRIDORS",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.16,
                    normalizedY: 0.65,
                    description: "Panel 1 schematics contrast the historical Transvermian approach (red X) against the modern Telovelar approach (green checkmark). The transvermian route incises the inferior vermis/nodule to gain access, directly precipitating cerebellar mutism syndrome (posterior fossa syndrome) with severe speech apraxia and ataxia. The telovelar approach enters naturally via the cerebellomedullary fissure by mobilizing both tonsils laterally and superiorly, providing complete access from obex to aqueduct without splitting neural tissue.",
                    surgicalPearl: "The inferior vermis must never be split. Bilateral opening of the tela choroidea and inferior medullary velum along the taenia provides panoramic access to the entire fourth ventricle with zero vermian disruption."
                ),
                SurgicalCallout(
                    id: "plate_082_3",
                    title: "The Telovelar Dissection Engine",
                    structureType: "TONSILLAR MOBILIZATION, TELA CHOROIDEA & PICA LOOP",
                    color: Color.blue,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Panel 2 illustrates the microsurgical corridor through a suboccipital exposure. Bilateral cerebellar tonsils are gently mobilized laterally with dynamic speculum retractors, opening the cerebellomedullary fissure. Fine micro-scissors sharply incise the transparent, vascularized tela choroidea and glistening inferior medullary velum (IMV) along the taenia. The telovelotonsillar segment of the PICA loops within the cleft, with meticulous preservation of all choroidal branches supplying the fourth ventricle choroid plexus.",
                    surgicalPearl: "Always dissect in the subarachnoid plane of the cerebellomedullary fissure before opening the tela choroidea. Coagulating or occluding the telovelotonsillar PICA branches causes lateral medullary or cerebellar hemispheric infarction."
                ),
                SurgicalCallout(
                    id: "plate_082_4",
                    title: "Rhomboid Fossa & Floor Preservation",
                    structureType: "RHOMBOID FOSSA LANDMARKS & TUMOR CYTOREDUCTION",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.50,
                    description: "Panel 3 depicts intraventricular tumor resection and pristine rhomboid fossa preservation. The suction tip debulks the lobulated tumor mass superolaterally away from the floor. Floor landmarks are fully exposed and strictly unviolated: Aqueduct of Sylvius at the cranial apex, paired facial colliculi in the facial triangle (harboring the CN VI nucleus and looping CN VII motor fibers), transverse striae medullares, hypoglossal trigone, and V-shaped obex at the central canal entry.",
                    surgicalPearl: "The floor of the fourth ventricle (rhomboid fossa) is a strict zero-touch zone: never apply aggressive bipolar cautery, traction, or rigid suction to the facial colliculus or obex to prevent permanent facial diplegia and autonomic hemodynamic collapse."
                )
            ]

        case .plate081:
            return [
                SurgicalCallout(
                    id: "plate_081_1",
                    title: "Radiographic Alignment & Spinopelvic Harmony",
                    structureType: "FULL-SPINE EOS & SPINOPELVIC FORMULA",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel 1 contrasts pre-operative flatback deformity against post-operative global realignment. Pre-op full-spine lateral radiograph demonstrates severe loss of lumbar lordosis, compensatory pelvic retroversion (high pelvic tilt), and positive sagittal vertical axis (SVA) causing forward trunk tilt. Post-op radiograph confirms long-segment T10-to-pelvis instrumentation restoring harmonious lordosis with the C7 plumbline centered directly over the sacral promontory. The core spinopelvic rule mandates restoring lumbar lordosis to within 10° of pelvic incidence (PI - LL < 10°).",
                    surgicalPearl: "The golden formula of spinal deformity is PI = PT + SS. Failure to restore lumbar lordosis to match pelvic incidence (PI - LL < 10°) forces compensatory pelvic retroversion (PT > 20°) and guarantees proximal junctional failure (PJF)."
                ),
                SurgicalCallout(
                    id: "plate_081_2",
                    title: "The Correction Engine: Osteotomies & Interbody",
                    structureType: "SCHWAB GRADE 2 PONTE & HYPERLORDOTIC CAGES",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Panel 2 details the two biomechanical workhorses of sagittal restoration: (1) Asymmetric Ponte Osteotomy (Schwab Grade 2): complete bilateral facetectomies (resecting superior and inferior articular processes) and flavectomy across L1–L5, exposing bleeding cancellous bone to allow posterior column compression shortening yielding 5°–10° of lordosis per level; and (2) Hyperlordotic Interbody Cages (LLIF/TLIF): anterior column height restoration in the disc space, providing anterior column lengthening, opening neuroforamina indirectly, and establishing anterior load-sharing.",
                    surgicalPearl: "Combining anterior column lengthening (hyperlordotic cages) with posterior column shortening (Ponte osteotomies) acts as an active cantilever force couple, maximizing lordosis restoration while minimizing blood loss and operating time."
                ),
                SurgicalCallout(
                    id: "plate_081_3",
                    title: "Operative Construct & S2AI Pelvic Foundation",
                    structureType: "T10–PELVIS, QUAD-ROD & S2AI SCREWS",
                    color: Color.blue,
                    normalizedX: 0.83,
                    normalizedY: 0.50,
                    description: "Panel 3 illustrates the complete posterior T10-to-Pelvis instrumentation: (1) T10 Upper Instrumented Vertebra (UIV): preserving the supraspinous and interspinous ligaments above T10 to create a soft landing; (2) Dual Titanium Rods providing continuous coronal and sagittal realignment; (3) S1 Screws with Quad-Rod Satellite Bridge: accessory multi-rods bridged across L4–S1 with domino connectors to eliminate rod fatigue and prevent lumbosacral pseudarthrosis; and (4) Bilateral S2-Alar-Iliac (S2AI) Screws anchored across the sacroiliac joint into dense supra-acetabular iliac bone.",
                    surgicalPearl: "In long constructs ending at the sacrum, the L5–S1 junction experiences massive cantilever flexural stresses exceeding 100 Nm; standalone S1 bicortical screws fail in over 40% of cases without bilateral S2AI or iliac screw triangulation."
                ),
                SurgicalCallout(
                    id: "plate_081_4",
                    title: "Concise Surgical Pearls & Deformity Mandates",
                    structureType: "THE THREE GOLDEN RULES OF REALIGNMENT",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom bar codifies The Three Golden Rules: (1) Spinopelvic Harmony: Reconstitute lordosis to match pelvic incidence (PI - LL < 10°); (2) Pelvic Foundation: Always anchor long constructs to the pelvis using S2AI screws to prevent S1 hardware failure; and (3) Soft Landing at T10: Never stop fusion in the apex of thoracic kyphosis. Management protocols mandate continuous multimodal tcMEP/SSEP monitoring and maintaining MAP > 85 mmHg during rod reduction.",
                    surgicalPearl: "Terminating a fusion construct at the apex of thoracic kyphosis (T7–T9) creates a severe stress concentration that triggers catastrophic proximal junctional kyphosis and hardware pullout."
                )
            ]

        case .plate080:
            return [
                SurgicalCallout(
                    id: "plate_080_1",
                    title: "Neuroimaging, K-Line Biomechanics & Cord Drift",
                    structureType: "SAGITTAL CT/MRI & FUJIYOSHI K-LINE MATRIX",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A establishes radiological indications and biomechanics. Sagittal bone CT demonstrates continuous-type OPLL from C2 to C6 with preserved subaxial lordosis (Cobb > 12°). Sagittal T2 MRI shows severe cord compression, circumferential CSF obliteration, and intramedullary myelomalacia at C4–C5. The K-Line Assessment Matrix contrasts K-line (+) [OPLL does not breach the line connecting C2 and C7 canal midpoints in lordosis, enabling >3–4 mm posterior cord drift -> laminoplasty indicated] against K-line (-) [kyphosis or massive OPLL crosses K-line, preventing cord drift -> contraindication]. Axial biomechanical comparisons detail how Open-Door (>30° tilt, >40% canal area expansion) and French-Door (symmetrical midline split with trapezoidal spacer) decompress the cord away from ventral osteophytes.",
                    surgicalPearl: "The K-line is the supreme prognostic determinant: laminoplasty on a K-line negative or kyphotic cervical spine is an anatomical error, resulting in zero posterior cord drift and persistent neurological decline."
                ),
                SurgicalCallout(
                    id: "plate_080_2",
                    title: "Operative Exposure & The Two Cardinal Techniques",
                    structureType: "C2/C7 MUSCLE SPARING, OPEN-DOOR VS. FRENCH-DOOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.40,
                    description: "Panel B illustrates prone Mayfield positioning (avoiding hyperflexion to protect the myelopathic cord) and cardinal paraspinal muscle preservation: strictly sparing the deep semispinalis cervicis insertion on the C2 bifid process and the C7 muscular attachments to eliminate postoperative swan-neck kyphosis and axial pain. Detailed high-magnification insets contrast the two techniques: (1) Open-Door (Hirabayashi): 3 mm diamond burr full bicortical osteotomy at the open-side lamina-facet junction with ligamentum flavum division, plus contralateral unicortical hinge trough thinned down to pliable inner cortex, elevating the roof by 4–5 mm; and (2) French-Door (Kurokawa): midline sagittal trough splitting spinous processes down to dura, combined with bilateral lateral unicortical gutters opening symmetrically like double doors.",
                    surgicalPearl: "Detaching the semispinalis cervicis tendon from C2 destroys the primary dynamic extensor tendon of the neck, precipitating delayed progressive kyphosis in up to 30% of patients."
                ),
                SurgicalCallout(
                    id: "plate_080_3",
                    title: "16× Reconstruction & C5 Tethering Prevention",
                    structureType: "C3–C7 TITANIUM MINIPLATES & C4–C5 FORAMINOTOMY",
                    color: Color.blue,
                    normalizedX: 0.83,
                    normalizedY: 0.40,
                    description: "Panel C showcases a 16× microsurgical field spanning C3 to C7. Exactly 5 low-profile titanium laminoplasty miniplates bridge the open osteotomy gap from elevated laminae to lateral masses, each secured with 4 self-tapping screws (2 on lateral mass, 2 on lamina). A widely decompressed, pulsatile thecal sac is visible with epidural venous oozing controlled using fine bipolar cautery and hemostatic matrix. Insets illustrate: (1) French-Door reconstruction with a trapezoidal hydroxyapatite ceramic spacer maintaining midline expansion, and (2) The C5 Root Tethering Mechanism: C5 has the shortest horizontal trajectory; excessive posterior cord drift (>4–5 mm) creates traction against the superior articular process (SAP), precipitating delayed deltoid/biceps paresis. Prophylactic microscopic keyhole foraminotomy at C4–C5 unroofs the foramen and eliminates root traction.",
                    surgicalPearl: "Performing a prophylactic microscopic keyhole foraminotomy unroofing the superior articular process at C4–C5 reduces the incidence of delayed C5 motor palsy from ~10% down to <1%."
                ),
                SurgicalCallout(
                    id: "plate_080_4",
                    title: "The Three Cardinal Rules & Postoperative Protocols",
                    structureType: "SURGICAL MANDATES & COMPLICATION SURVEILLANCE",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom panels codify The Three Cardinal Rules: (1) The Lordosis & K-Line Mandate (operate strictly on lordotic spines with positive K-line); (2) Strict C2 & C7 Muscular Preservation (sparing extensor insertions); and (3) Controlled Hinge Thinning with Rigid Miniplate Fixation (eliminating spring-back re-closure). Management protocols detail daily deltoid/biceps motor surveillance, subfascial closed-suction drainage to prevent epidural hematoma, and immediate unbraced/soft-collar mobilization on postoperative day 1 to prevent muscular disuse atrophy.",
                    surgicalPearl: "Rigid titanium miniplate fixation provides immediate biomechanical stability, making prolonged rigid collars unnecessary and dramatically reducing chronic axial neck stiffness."
                )
            ]

        case .plate079:
            return [
                SurgicalCallout(
                    id: "plate_079_1",
                    title: "Stereotactic Trajectory & Basal Ganglia Circuitry",
                    structureType: "SYNTHETIC CORONAL/AXIAL MRI & ALBIN-DELONG MODEL",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A establishes stereotactic trajectory planning and neurocircuitry. A1 (coronal T1 MRI) displays bilateral steep stereotactic trajectories (~12°–15° coronal arc angle) entering through precoronal burr holes and coursing safely lateral to the frontal horn of the lateral ventricle, landing in the biconvex STN (cyan outline) directly superior to the Substantia Nigra (SNr, magenta outline). A2 (axial FGATIR) confirms the target in the dorsolateral motor STN, bounded medially by the Red Nucleus (RN) and laterally by the Posterior Limb of the Internal Capsule (PLIC). A3 illustrates the classical Albin-DeLong basal ganglia model: loss of SNpc dopamine disinhibits the STN, creating pathological beta-band (13–30 Hz) hypersynchrony driving excessive GPi/SNr thalamic inhibition; high-frequency DBS (~130 Hz) disrupts this pathological bursting.",
                    surgicalPearl: "Planning the coronal trajectory strictly lateral to the frontal horn ependyma is essential; violating the ventricle triggers rapid CSF egress, intracranial air entry (pneumocephalus), and brain sag that displaces the subthalamic target by up to 3–4 mm."
                ),
                SurgicalCallout(
                    id: "plate_079_2",
                    title: "Awake OR Setup & Microelectrode Recording (MER)",
                    structureType: "LEKSELL STEREOTAXY & MULTI-UNIT ELECTROPHYSIOLOGY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.40,
                    description: "Panel B depicts the awake operating theater with the patient secured semi-sitting in a Leksell stereotactic frame under a clear drape for continuous clinical motor examination. The Ben-Gun 5-channel microdrive advances microelectrodes through a right precoronal burr hole. The electrophysiological stack illustrates the 3 definitive stages: (1) Zona Incerta / Forel's Field: quiet background with low-amplitude sparse spikes; (2) Dorsolateral Motor STN (0 to -4.5 mm): abrupt multi-unit noise explosion and dense, irregular 35–50 Hz bursting with movement-responsive kinesthetic units; and (3) Substantia Nigra pars reticulata (SNr, > -5 mm): transition to high-frequency regular tonic firing (>60–80 Hz) marking the ventral target exit.",
                    surgicalPearl: "An optimal trajectory requires a minimum of ≥4.5 mm of robust motor STN firing span on MER before lead deployment. If the motor span is <4.0 mm, parallel Ben-Gun tracks (anterior or lateral) must be probed."
                ),
                SurgicalCallout(
                    id: "plate_079_3",
                    title: "Directional Lead Placement & Threshold Boundary Matrix",
                    structureType: "1-3-3-1 DIRECTIONAL LEAD & 4 BOUNDARY THRESHOLDS",
                    color: Color.blue,
                    normalizedX: 0.83,
                    normalizedY: 0.40,
                    description: "Panel C details modern directional segmented lead implantation (1-3-3-1 octapolar configuration) in the dorsolateral motor STN, with electric current steering away from the internal capsule. The Boundary Threshold Matrix defines intraoperative safety limits: (1) Therapeutic Window (1.0–2.5 mA): tremor arrest, rigidity reduction, and rapid finger tapping; (2) Capsular Side Effect: contralateral face/hand contraction and dysarthria (threshold must exceed >3.5 mA); (3) Lemniscal Side Effect: contralateral paresthesias; and (4) Oculomotor Side Effect: diplopia, ptosis, or downward gaze palsy indicating ventral breach into CN III fascicles (mandates immediate lead retraction).",
                    surgicalPearl: "Directional current steering allows asymmetric electrical field shaping toward the motor STN while shielding the posterior limb of the internal capsule, drastically expanding the therapeutic window when leads are close to the capsular boundary."
                ),
                SurgicalCallout(
                    id: "plate_079_4",
                    title: "Hardware Assembly & Postoperative Programming",
                    structureType: "FULL DBS SYSTEM & PROTOCOL MILESTONES",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Lower panels display the complete DBS hardware assembly: cranial lead secured with a Stimloc burr-hole cap, subcutaneous strain-relief loop behind the auricle, extension cable tunneled down the lateral neck, and dual-channel IPG in an infraclavicular pocket. The Three Cardinal Rules mandate dorsolateral motor targeting, ventricular avoidance, and strict avoidance of monopolar cautery. Postoperative milestones dictate general anesthesia for tunneling, 3D O-arm confirmation, and delayed initial programming (3–4 weeks) following micro-lesion edema resolution.",
                    surgicalPearl: "Never activate monopolar electrocautery anywhere on a patient with implanted DBS hardware. Radiofrequency and high-voltage current induction down the lead can cause thermal coagulation of the brainstem and irreversible neurological deficits."
                )
            ]

        case .plate078:
            return [
                SurgicalCallout(
                    id: "plate_078_1",
                    title: "Burst Fracture Morphology & Load-Sharing Matrix",
                    structureType: "SYNTHETIC CT/MRI & MCCORMACK CLASSIFICATION",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A establishes a complete L1 burst fracture (AO Spine A4). A1 (sagittal and coronal bone CT) shows comminution of both endplates, >50% anterior height loss, 22° post-traumatic kyphosis, vertical coronal split, and interpedicular widening. A2 (axial CT) demonstrates a retropulsed posterior wall cortical fragment causing ~50% spinal canal compromise with conus medullaris crowding. A3 (sagittal T2 MRI) confirms an intact Posterior Ligamentous Complex (PLC), qualifying the injury for short-segment instrumentation. The lower insets contrast AO Spine A3 vs. A4 and detail the McCormack Load-Sharing score (≥7), which mandates intermediate screws.",
                    surgicalPearl: "McCormack Load-Sharing score ≥7 reflects severe anterior column comminution and load-bearing insufficiency. In such cases, traditional 2-level short-segment constructs fail in over 50% of patients; placing intermediate screws into the fractured index level restores construct stiffness and prevents hardware failure."
                ),
                SurgicalCallout(
                    id: "plate_078_2",
                    title: "Prone Corridor & Intermediate Pedicle Screw Placement",
                    structureType: "PARASPINAL CORRIDOR & 4-POINT BENDING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.40,
                    description: "Panel B illustrates posterior exposure from T12 to L2 under Jackson table positioning and multimodal SSEP/MEP neuromonitoring. The operative field shows a true 3-level construct (6 pedicle screws): T12 superior anchors, L2 inferior anchors, and bilateral intermediate pedicle screws placed directly into the intact pedicles of the fractured L1 vertebra. The lower insets provide: (1) A parasagittal cutaway illustrating the intermediate screw traversing the intact L1 pedicle isthmus into the comminuted body without entering the spinal canal, and (2) Intraoperative biplane fluoroscopy confirming exact 3-level screw convergence.",
                    surgicalPearl: "Intermediate screws placed into the fractured vertebra act as an active anterior-posterior cantilever fulcrum, increasing construct stiffness by >80% and eliminating the classic 'parallelogram toggling' that causes screw breakage in short-segment fixation."
                ),
                SurgicalCallout(
                    id: "plate_078_3",
                    title: "Cantilever Reduction & Ligamentotaxis Canal Remodeling",
                    structureType: "LIGAMENTOTAXIS MECHANISM & 3-LEVEL RADIOGRAPHS",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.40,
                    description: "Panel C enforces the cardinal rule: 'LIGAMENTOTAXIS WINDOW: PERFORM WITHIN 72 HOURS BEFORE PLL RESORPTION'. The biomechanical sagittal cutaway details the ligamentotaxis mechanism: pre-reduction slack PLL vs. post-reduction tensioned PLL pulling the retropulsed bone fragment anteriorly out of the canal, restoring canal space. Post-op radiographs confirm an exact 3-level construct (T12–L2) with 3 screws on Lateral (correcting kyphosis from 22° to 4° lordosis) and 3 pairs on AP. Post-op axial CT demonstrates canal clearance from ~50% down to <15% residual compromise.",
                    surgicalPearl: "Indirect decompression via ligamentotaxis relies on an intact, taut posterior longitudinal ligament and annulus. Beyond 72–96 hours from trauma, fracture hematoma consolidation and fibrous adhesion prevent indirect reduction, requiring formal canal laminectomy."
                ),
                SurgicalCallout(
                    id: "plate_078_4",
                    title: "The Three Principles & Postoperative Management",
                    structureType: "SURGICAL PRINCIPLES & MOBILIZATION PROTOCOL",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom panels summarize The Three Principles of Burst Fixation: (1) The Intermediate Screw Principle (rigid 4-point construct prevents screw fatigue), (2) The Ligamentotaxis Golden Window (intervene within 48–72 hours), and (3) Integrity of the PLC (PLC disruption dictates long-segment fixation). Postoperative management protocols dictate immediate unbraced mobilization, serial lower extremity motor/sphincter exams, and upright standing radiography at 6 and 12 weeks confirming maintained lordosis.",
                    surgicalPearl: "With a rigid 6-screw 4-point construct, external orthoses (TLSO) are unnecessary. Immediate ambulation prevents recumbency complications without risking loss of reduction."
                )
            ]

        case .plate077:
            return [
                SurgicalCallout(
                    id: "plate_077_1",
                    title: "Tectal Cavernoma MRI & Zabramski Classification Matrix",
                    structureType: "SYNTHETIC T2/SWI & ZABRAMSKI TYPES 1–4",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A exhibits multimodal neuroimaging of a dorsal mesencephalic/tectal cavernoma. Axial and sagittal T2 MRI demonstrate a classic Zabramski Type II 'popcorn' lesion with a reticulated mixed-signal core and hypointense hemosiderin halo, causing aqueductal obstruction and triventricular hydrocephalus. Axial T1+C outlines an associated Developmental Venous Anomaly (DVA) with caput medusae radial veins converging into a dominant collector. Axial SWI confirms marked blooming artifact and demonstrates multiple cerebral micro-cavernomas ('black dots') characteristic of familial CCM. The Zabramski matrix details Types 1–4, and the 3D surface diagram maps the quadrigeminal plate with the infracollicular safe entry zone.",
                    surgicalPearl: "Brainstem cavernomas should be resected only if they have bled and present directly at a pial or ependymal surface. Transgressing normal brainstem parenchyma to access deep non-presenting lesions carries unacceptable neurological morbidity."
                ),
                SurgicalCallout(
                    id: "plate_077_2",
                    title: "Prone Concorde Corridor & DVA Preservation Mandate",
                    structureType: "SCIT CORRIDOR & SACRED DVA COLLECTOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.40,
                    description: "Panel B depicts patient positioning in the prone Concorde position in a Mayfield skull clamp with head flexed and elevated in reverse Trendelenburg. Intraoperative neuromonitoring tracks SSEP, MEP, Brainstem Auditory Evoked Responses (BAER), and CN III/IV/VI oculomotor EMG. The supracerebellar infratentorial (SCIT) corridor unroofs the quadrigeminal cistern beneath the straight sinus as the cerebellar culmen descends under gravity. Sharp arachnoid dissection exposes the deep galenic complex. The lower inset enforces the cardinal rule: 'DO NOT COAGULATE OR DIVIDE THE DVA — DVA OCCLUSION CAUSES FATAL BRAINSTEM VENOUS INFARCTION'.",
                    surgicalPearl: "A Developmental Venous Anomaly provides critical anomalous venous outflow to surrounding normal brainstem tissue. Coagulating or resecting a DVA produces massive, often fatal brainstem venous congestion, edema, and hemorrhagic infarction."
                ),
                SurgicalCallout(
                    id: "plate_077_3",
                    title: "16× Infracollicular Evacuation & Hemosiderin Sparing",
                    structureType: "16× MICROSURGICAL FIELD & GOLDEN HEMOSIDERIN BED",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.40,
                    description: "Panel C enforces the cardinal mandate: 'PRESERVE DVA & LEAVE HEMOSIDERIN RING — DO NOT CURETTE ELOQUENT BRAINSTEM'. Under 16× magnification, the superior and inferior colliculi, delicate trochlear nerve (CN IV), and patent basal vein of Rosenthal frame the dark bluish-purple 'mulberry' cavernoma presenting at the infracollicular pial surface. Sequential insets detail: (1) 2–3 mm micro-pial incision with a #11 micro-blade at the infracollicular zone, (2) Piecemeal micro-pituitary evacuation of organized thrombus and vascular caverns, collapsing the lesion inward, and (3) The cleanly emptied cavity with the golden-yellow hemosiderin glial ring left completely intact.",
                    surgicalPearl: "The golden-yellow hemosiderin rim represents eloquent brainstem parenchyma infiltrated by hemosiderin-laden macrophages, NOT active vascular lesion. Aggressive scraping or curettage of this ring damages underlying reticular activating pathways, oculomotor fibers, or corticospinal tracts."
                ),
                SurgicalCallout(
                    id: "plate_077_4",
                    title: "The Three Cardinal Rules & Parinaud Surveillance",
                    structureType: "SURGICAL AXIOMS & POSTOPERATIVE NEUROLOGICAL CARE",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom panels detail The Three Cardinal Rules: (1) Surface Presentation Only (operate only on lesions presenting at a pial/ependymal surface), (2) Leave the Hemosiderin Ring (do not curette eloquent brainstem tissue), and (3) The DVA is Sacred (never coagulate or resect the DVA). Postoperative surveillance protocols focus on vertical gaze palsy and pupillary light-near dissociation (Parinaud syndrome), trochlear nerve (CN IV) vertical diplopia with head tilt, serial BAER tracking, and early post-op MRI verifying gross total resection and aqueductal patency.",
                    surgicalPearl: "Transient postoperative upward gaze palsy (Parinaud syndrome) or trochlear paresis is common from local tectal traction and edema, typically improving over 3–6 months if the hemosiderin ring and safe entry zone were respected."
                )
            ]

        case .plate076:
            return [
                SurgicalCallout(
                    id: "plate_076_1",
                    title: "Synthetic Neuroimaging & Dual Compression Pathomechanism",
                    structureType: "SYNTHETIC CT/MRI & DUAL AXIAL COMPRESSION",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A integrates multimodal cervical neuroimaging and pathomechanisms at C5–C6. A1 (axial CT/T2 MRI) shows severe right foraminal stenosis caused by an uncinate process osteophyte and posterolateral soft disc herniation impinging on the C6 nerve root. A2 (sagittal T2 MRI) confirms focal foraminal disc extrusion with preserved subaxial lordosis and normal cord signal. A3 illustrates the dual compression cross-section: Mechanism I (uncinate spur compressing the dorsal root ganglion/root in the foramen) and Mechanism II (disc fragment abutting the ventrolateral thecal sac). A4 maps the posterior 'V-point' target centered at the laminar-facet junction. The lower inset defines the strict ≤50% facet resection limit based on lateral mass height (A) and width (B).",
                    surgicalPearl: "Posterior cervical foraminotomy is the gold-standard motion-preserving procedure for lateral soft disc herniations and foraminal spurring. Preserving the motion segment avoids adjacent segment degeneration and eliminates fusion hardware complications."
                ),
                SurgicalCallout(
                    id: "plate_076_2",
                    title: "Prone Concorde Corridor & V-Point High-Speed Drilling",
                    structureType: "KEYHOLE CORRIDOR & V-POINT FLAVECTOMY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.40,
                    description: "Panel B depicts patient positioning in the prone Concorde position in a Mayfield skull clamp with slight cervical flexion and 10°–15° reverse Trendelenburg to lower epidural venous pressure. Multimodal SSEP, MEP, and free-running EMG monitor the C5–C7 roots. The tubular keyhole corridor focuses a 3 mm high-speed diamond burr under cold irrigation at the V-point, systematically thinning the caudal edge of C5 lamina, cranial edge of C6 lamina, and the medial half of the inferior and superior articular processes. The lower inset illustrates micro-flavectomy using a 1–2 mm Kerrison punch to unroof the glistening blue-gray dural root sleeve.",
                    surgicalPearl: "The anatomical 'V-point' is the most reliable landmark for keyhole laminoforaminotomy. Centering the burr on this inverted V ensures direct access to the medial edge of the facet joint and lateral thecal sac while strictly adhering to the 50% facet preservation rule."
                ),
                SurgicalCallout(
                    id: "plate_076_3",
                    title: "16× Microsurgical Decompression & Fragmentectomy",
                    structureType: "16× BONE CLEARED WINDOW & FRAGMENT EXTRACTION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.40,
                    description: "Panel C enforces the cardinal rule: 'ZERO RETRACTION ON SPINAL CORD — DISSECT ALONG NERVE ROOT AXIS'. The main 16× microscope view displays the 6–8 mm completed keyhole window ('Bone Cleared'). The C6 nerve root (3–4 mm caliber) is completely unroofed from the lateral thecal sac to the lateral pedicle border, with clear preservation of the lateral 50% of the facet joint. Bottom insets detail micro-dissection: (1) Blunt micro-nerve hook mobilizing the root axilla without neural traction, (2) Micro-pituitary rongeur extracting the extruded subligamentous pearl-white soft disc fragment, and (3) Ball-tipped micro-probe freely traversing the decompressed neural foramen.",
                    surgicalPearl: "Never retract the cervical spinal cord medially to see a disc herniation. All micro-dissection vectors must be directed laterally along the shoulder or axilla of the nerve root into the neural foramen."
                ),
                SurgicalCallout(
                    id: "plate_076_4",
                    title: "The Three Cardinal Rules & Radiculopathy Outcomes",
                    structureType: "SURGICAL PRINCIPLES & CLINICAL PEARLS",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom panels detail The Three Cardinal Rules: (1) The 50% Facet Rule (resecting >50% of the facet joint destroys the posterior tension band and causes progressive segmental kyphosis), (2) Zero cord retraction, and (3) Epidural venous control using fine micro-bipolar cautery and thrombin-soaked gelatin matrix without blind packing. Clinical indications highlight posterior foraminotomy as an ideal option for isolated radiculopathy, avoiding anterior approach morbidity (dysphagia, recurrent laryngeal nerve palsy, fusion pseudoarthrosis).",
                    surgicalPearl: "Radicular arm pain relief is virtually immediate postoperatively. Mild transient numbness in the dermatome is common from decompression hyperemia and resolves spontaneously."
                )
            ]

        case .plate075:
            return [
                SurgicalCallout(
                    id: "plate_075_1",
                    title: "Grade V Spondyloptosis & Sagittal Geometry",
                    structureType: "SYNTHETIC CT/MRI & SPINOPELVIC PARAMETERS",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A establishes true Meyerding Grade V spondyloptosis (100% anterior translation) at L5–S1. A1 (pre-op sagittal CT) shows the trapezoidal L5 body completely displaced into the pelvic brim anterior and inferior to the rounded S1 dome, with an acute 91° kyphotic slip angle. A2 (sagittal T2 MRI) reveals the cauda equina making a sharp 90° right-angle kink over the posterosuperior sacral dome with severe thecal crowding and a floating posterior arch. A3 details 3D dysplastic morphology with elongated pedicles and bilateral pars defects. A4 graphs high pelvic incidence (PI 78°), compensatory pelvic retroversion (PT 34°), and severe PI–LL mismatch (28°).",
                    surgicalPearl: "High-grade spondylolisthesis is a multiplanar kyphotic deformity, not just simple translation. Restoring the lumbosacral slip angle and pelvic balance is vastly more important for long-term clinical outcome than achieving 100% translational reduction."
                ),
                SurgicalCallout(
                    id: "plate_075_2",
                    title: "Gill Laminectomy & Sacral Dome Osteotomy",
                    structureType: "POSTERIOR EXPOSURE & S1 DOME BEVELING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.40,
                    description: "Panel B illustrates posterior midline exposure under continuous multimodal neuromonitoring (SSEP and L5/S1 EMG). A complete Gill laminectomy resects the detached fibrocartilaginous L5 posterior arch, unroofing the compressed thecal sac. Realistic 4–5 mm caliber L5 nerve roots are skeletonized as they drape under extreme tension over the sacral alae. The lower inset demonstrates two-stage sacral dome osteotomy: a 4 mm curved diamond burr systematically bevels the rounded, convex posterosuperior S1 promontory, transforming the sharp thecal kinking fulcrum into a flat cancellous landing shelf.",
                    surgicalPearl: "Never attempt reduction before performing a sacral dome osteotomy. Resecting the posterosuperior S1 dome shortens the lumbosacral column, directly relieving cauda equina and L5 nerve root tension before applying any reduction force."
                ),
                SurgicalCallout(
                    id: "plate_075_3",
                    title: "Bohlman Trans-Sacral Cage & Triangular Spinopelvic Fixation",
                    structureType: "MICROSURGICAL REDUCTION & BOHLMAN ARTHRODESIS",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.40,
                    description: "Panel C enforces the cardinal rule: 'PREVENT L5 TRACTION NEUROPRAXIA — AVOID OVER-REDUCTION'. The 16× microscope view confirms a relaxed, untethered L5 root with zero EMG firing. The fixation field exhibits a triangular spinopelvic construct: bilateral L4, L5, and bicortical S1 pedicle screws anchored by deep S2-alar-iliac (S2AI) screws crossing the SI joint into the supracetabular iliac corridor. Post-op sagittal CT confirms the modified Bohlman technique: a threaded structural cage drilled trans-sacrally through S1 into L5 across the shear plane, correcting the slip angle from 91° to 105°.",
                    surgicalPearl: "The modified Bohlman trans-sacral interbody technique creates a rigid biomechanical bridge directly traversing the lumbosacral shear plane, eliminating the need for hazardous 100% translation and preventing S1 screw pullout."
                ),
                SurgicalCallout(
                    id: "plate_075_4",
                    title: "Cardinal Principles & Post-Op Neurological Protocol",
                    structureType: "SURGICAL PRINCIPLES & NERVE ROOT SURVEILLANCE",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Bottom panels detail The Three Cardinal Rules: (1) Decompress first (Gill laminectomy and bilateral L5 foraminotomy) before reduction, (2) Realignment and slip angle correction take precedence over complete translational reduction, and (3) Triangular spinopelvic fixation (S2AI or iliac screws) is mandatory against massive shear forces. The postoperative protocol establishes serial wake-up motor checks for EHL/TA (L5) and immediate return to the OR for hardware release if acute foot drop manifests.",
                    surgicalPearl: "Postoperative L5 motor deficit (foot drop) occurs in up to 10–15% of high-grade spondylolisthesis reductions due to traction neuropraxia. Partial reduction with restored lordosis yields superior clinical and neurological results compared to anatomical translation with a paralyzed foot."
                )
            ]

        case .plate074:
            return [
                SurgicalCallout(
                    id: "plate_074_1",
                    title: "Neuroimaging & Al-Mefty Classification Matrix",
                    structureType: "SYNTHETIC CT/MRI, ANGIOGRAPHY & AL-MEFTY MATRIX",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A synthesizes multimodal neuroimaging and the definitive Al-Mefty classification for medial sphenoid wing/clinoidal meningiomas. A1 (coronal T1+C) and A3 (axial T1+C) demonstrate a right clinoidal meningioma encasing the internal carotid artery (ICA) bifurcation and compressing the optic nerve. A2 (bone CT) reveals profound hyperostosis of the right sphenoid wing, orbital roof, and optic strut. A4 (catheter angiogram) shows ICA and MCA (M1) encasement with rich tumor blush. Lower insets delineate Al-Mefty Groups: Group I (origin distal to carotid cistern ring, no arachnoid plane between tumor and ICA adventitia), Group II (origin from superior/lateral clinoid, arachnoid plane present between tumor and ICA), and Group III (origin at optic canal unroofing/strut).",
                    surgicalPearl: "In Al-Mefty Group I meningiomas, tumor invades the adventitia of the ICA directly without an intervening arachnoid plane. Aggressive pursuit of a Simpson Grade 1 resection in Group I invariably results in catastrophic carotid laceration or middle cerebral artery stroke; subtotal resection with adjuvant stereotactic radiosurgery is the standard of care."
                ),
                SurgicalCallout(
                    id: "plate_074_2",
                    title: "Extradural Sphenoid Drilling & MOB Peeling",
                    structureType: "EXTRADURAL SKULL BASE & MENINGO-ORBITAL BAND",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.48,
                    normalizedY: 0.38,
                    description: "Panel B depicts the critical extradural phase of the pterional/orbitozygomatic approach. A high-speed diamond burr with continuous cold saline irrigation systematically flattens the hyperostotic sphenoid ridge down to the superior orbital fissure (SOF). Peeling and sharply dividing the meningo-orbital band (MOB) detaches the frontotemporal dura from the periorbita, unlocking the anterior clinoid space. Lower insets detail 270° optic canal unroofing, resection of the optic strut, and anterior clinoidectomy, decompressing CN II and exposing the clinoidal segment of the ICA before opening the dura.",
                    surgicalPearl: "Extradural optic canal unroofing and anterior clinoidectomy decompress the optic nerve prior to any intradural tumor manipulation and devascularize the primary tumor blood supply from the middle meningeal and ophthalmic collateral branches."
                ),
                SurgicalCallout(
                    id: "plate_074_3",
                    title: "16× Microsurgical Resection & Perforator Preservation",
                    structureType: "MICROSURGICAL RESECTION & PERFORATING BRUSH",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C enforces the cardinal mandate: 'PRESERVE PERFORATORS & ADVENTITIAL CLEAVAGE PLANES'. Under 16× magnification, ultrasonic cavitation (CUSA) debulks the firm pink tumor mass. High-power views display complete exposure of CN II, supraclinoid ICA, anterior choroidal artery (AChA) takeoff, M1/M2 bifurcation, and the delicate brush of lateral lenticulostriate perforators. Insets illustrate dural attachment coagulation, the exact MOB peeling plane, and meticulous micro-dissection sparing every perforator.",
                    surgicalPearl: "The Achilles' heel of medial sphenoid wing meningioma resection is the lenticulostriate brush and AChA. Stripping adherent tumor off these vessels causes capsular infarction and permanent dense hemiplegia. Preserve the adventitial plane and leave tumor flecks on perforating vessels."
                ),
                SurgicalCallout(
                    id: "plate_074_4",
                    title: "Three Operative Principles & Postoperative Surveillance",
                    structureType: "OPERATIVE PRINCIPLES & CRANIAL NERVE PROTOCOL",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.90,
                    description: "Lower panels summarize The Three Operative Principles: (1) Early extradural optic canal decompression when indicated, (2) Leave adherent tumor if no safe ICA cleavage plane exists, and (3) Consider intraoperative visual evoked potential (VEP) monitoring in selected cases. The surveillance panel details postoperative protocols monitoring visual acuity, visual fields, extraocular motility (CN III, IV, VI palsies), trigeminal sensation (V1), CSF rhinorrhea, and sellar endocrine axes.",
                    surgicalPearl: "Postoperative visual deterioration is often caused by microvascular ischemia to the optic chiasm/nerve rather than direct mechanical traction. Protect the superior hypophyseal and ophthalmic collateral vessels."
                )
            ]

        case .plate073:
            return [
                SurgicalCallout(
                    id: "plate_073_1",
                    title: "Synthetic Neuroimaging & Monster Disc Pathology",
                    structureType: "SYNTHETIC CT/MRI & PATHOLOGY SPECTRUM",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A exhibits synthetic bone-window CT (sagittal and axial, W4000/L700) and T2 MRI at T8–T9 displaying a compact, calcified disc-osteophyte complex occupying ~45–50% of the spinal canal cross-section with severe ventral thecal sac encroachment. The thoracic cord is compressed into an anatomical crescent with bright intramedullary T2 hyperintensity (compressive myelomalacia). Lower insets contrast central versus right-paracentral herniation and detail the risk of intradural calcification eroding the ventral dura.",
                    surgicalPearl: "Giant thoracic disc herniations (>50% canal compromise) are almost invariably calcified and densely adherent to the ventral dura. Posterior laminectomy alone is strictly contraindicated because it cannot access the ventral pathology without requiring cord retraction."
                ),
                SurgicalCallout(
                    id: "plate_073_2",
                    title: "Posterolateral Transpedicular Corridor & Trenching",
                    structureType: "OPERATIVE APPROACH & DOWN-AND-AWAY DRILLING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Panel B depicts prone positioning with active multi-modal SSEP/MEP monitoring (maintaining MAP >85–90 mmHg). The operative field shows a right-sided posterolateral transpedicular approach: T8 hemilaminectomy, medial facetectomy, and complete T8 pediculectomy exposing the lateral thecal sac and exiting T8 nerve root. The lower view demonstrates vertebral body trenching: a 3 mm diamond burr drills a deep cavity in the posterior third of T8/T9 vertebral bodies ventral and inferior to the disc before touching the calcified fragment.",
                    surgicalPearl: "Vertebral body trenching is the non-negotiable prerequisite of thoracic discectomy. Always hollow out a deep bony decompression cavity beneath the disc first; the calcified fragment must be pushed down into this empty space rather than pulled backward against the cord."
                ),
                SurgicalCallout(
                    id: "plate_073_3",
                    title: "16× Micro-Cavitation & Zero Cord Retraction",
                    structureType: "MICROSURGICAL CAVITATION & ZERO RETRACTION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C enforces the cardinal mandate: '⚠️ ZERO SPINAL CORD RETRACTION'. Under 16× magnification, a reverse-angle micro-curette gently pushes the hard calcified fragment down and away into the pre-drilled trench, collapsing it away from the pristine, untouched thecal sac. Following decompression, the thecal sac re-expands with restored dural vascularity. Insets detail multi-layer ventral dural repair (collagen matrix, fat/muscle graft, fibrin glue) and short-segment pedicle screw instrumentation bridging the pediculectomy.",
                    surgicalPearl: "Never insert an instrument between the ventral dura and a calcified thoracic disc. The cord in the thoracic spine has a precarious watershed vascular supply (Artery of Adamkiewicz); even 1 mm of medial cord retraction triggers irreversible paraplegia."
                ),
                SurgicalCallout(
                    id: "plate_073_4",
                    title: "The Three Cardinal Rules & Intradural Adhesions",
                    structureType: "SURGICAL AXIOMS & INTRADURAL ALGORITHM",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Lower panels detail The Three Cardinal Rules of Thoracic Disc Surgery: (1) Absolute prohibition of spinal cord retraction, (2) Deep ventral bone cavitation before decompression, and (3) Continuous SSEP/MEP neuromonitoring. The right inset provides the algorithm for ventral intradural adhesions: if a microscopic calcified shell is densely fused to the pia/cord, leave it in situ rather than risking catastrophic cord avulsion.",
                    surgicalPearl: "A thin microscopic eggshell of calcification adherent to the anterior cord pia is completely harmless once the mass behind it is evacuated. Attempting to peel it off the cord leads to anterior spinal artery avulsion and permanent paralysis."
                )
            ]

                                                                        case .plate072:
            return [
                SurgicalCallout(
                    id: "plate_072_1",
                    title: "Brain MRI Signs of SIH & Lateral Decubitus DSM",
                    structureType: "NEUROIMAGING & DYNAMIC MYELOGRAPHY",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A contrasts the classic cranial 'SEEPS' signs of spontaneous intracranial hypotension (diffuse pachymeningeal enhancement, tonsillar descent/pseudo-Chiari, flattened pons, effaced prepontine cistern, and engorged venous sinuses) with the definitive spinal diagnostic modality: lateral decubitus Digital Subtraction Myelography (DSM). The DSM captures an immediate contrast jet from the nerve root sleeve opacifying an undulating paraspinal/intercostal vein draining into the azygos system, with ZERO extradural CSF leak.",
                    surgicalPearl: "CSF-venous fistulas (Schievink Type 3) NEVER produce an epidural fluid collection on spine MRI. Routine supine spine MRIs are completely normal; definitive diagnosis requires rapid, high-frame-rate lateral decubitus CT myelography or DSM with the leak-side dependent."
                ),
                SurgicalCallout(
                    id: "plate_072_2",
                    title: "Aberrant Arachnoid Granulation & Transvenous Coiling",
                    structureType: "MICRO-ANATOMY & ENDOVASCULAR EMBOLIZATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Panel B reveals the microscopic patho-anatomy: an aberrant, hypertrophied spinal arachnoid granulation herniating directly through the dural root sleeve into an adjacent radicular/paraspinal vein at the neural foramen, shunting CSF into Batson's and azygos venous plexuses. The lower panel illustrates transvenous endovascular embolization via femoral/jugular access navigating the azygos vein and posterior intercostal vein, deploying platinum micro-coils and a liquid embolic cast (Onyx/Squid) to occlude the fistulous dural junction.",
                    surgicalPearl: "Transvenous embolization is a safe, minimally invasive first-line curative option. The key is occluding the exact dural junction of the draining vein with micro-coils and liquid embolic without allowing material to reflux into anterior or posterior spinal cord medullary veins."
                ),
                SurgicalCallout(
                    id: "plate_072_3",
                    title: "16× Microsurgical Clip Ligation & Resection",
                    structureType: "MICROSURGICAL LIGATION & POST-OP RESOLUTION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C depicts the 16× microsurgical field via a targeted unilateral hemilaminectomy. The dorsal root ganglion (DRG) and dural root sleeve are exposed, and the engorged fistulous vein is selectively clipped at its dural takeoff using a titanium microvascular clip and sharply divided distal to the clip, permanently obliterating the shunt while preserving the nerve root. Inset verifies complete post-op MRI resolution of brainstem sagging, tonsillar herniation, and pachymeningeal enhancement.",
                    surgicalPearl: "Microsurgical clip ligation provides a 100% immediate cure for CVF. Meticulously dissect the draining vein off the nerve root sleeve, apply the microvascular clip flush against the dural cuff, and divide the vein distally to eliminate any possibility of recanalization."
                ),
                SurgicalCallout(
                    id: "plate_072_4",
                    title: "Schievink Classification & Rebound Intracranial Hypertension",
                    structureType: "CSF LEAK TAXONOMY & POST-OP COMPLICATIONS",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Lower panels: Inset 1 contrasts Schievink Type 1 (ventral spur tear), Type 2 (ruptured meningeal diverticulum), and Type 3 (CSF-venous fistula, zero extradural fluid). Inset 2 outlines the Rebound Intracranial Hypertension (RIH) Protocol: over 50% of successfully closed CVFs develop severe post-closure intracranial hypertension due to restored CSF volume and reset venous resistance, presenting with paradoxical supine headache and papilledema requiring acetazolamide.",
                    surgicalPearl: "Warn patients before treatment about Rebound Intracranial Hypertension (RIH). When the fistula is sealed, their chronically elevated CSF production causes acute intracranial pressure spikes; initiating Diamox (acetazolamide) early prevents papilledema and intractable headache."
                )
            ]

                                                                        case .plate071:
            return [
                SurgicalCallout(
                    id: "plate_071_1",
                    title: "Authentic Bone-Window CT & 3-Column Chalk-Stick Fracture",
                    structureType: "SYNTHETIC CT RADIOLOGY & LEVER-ARM BIOMECHANICS",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A displays a high-resolution synthetic bone-window sagittal CT (W4000/L700) demonstrating complete bamboo spine ankylosis with flowing anterior syndesmophytes, auto-fused posterior elements ('dagger sign'), and a transverse 3-column hyperextension 'chalk-stick' fracture with anterior gapping and posterior step-off. Sagittal T2 MRI reveals compressive retrovertebral epidural hematoma and intra-medullary cord contusion/edema (myelomalacia). Inset illustrates the Rigid Lever-Arm Principle: an ankylosed spine behaves like an osteoporotic long bone, converting minor ground-level falls into massive shear torque.",
                    surgicalPearl: "Ankylosed spines cannot dissipate energy across multiple motion segments. Minor low-energy falls concentrate bending moments into a single transverse shear plane, causing catastrophic 3-column chalk-stick fractures with a >50% incidence of concurrent epidural hematoma."
                ),
                SurgicalCallout(
                    id: "plate_071_2",
                    title: "Jackson Table Positioning & 3-Above / 3-Below Exposure",
                    structureType: "OPERATIVE POSITIONING & MULTI-LEVEL POSTERIOR EXPOSURE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Panel B highlights critical prone positioning on the Jackson table: customized multi-level chest and pelvic bolsters strictly preserve the patient's fixed rigid kyphosis without attempting bed flattening or neck extension (preventing iatrogenic cord distraction/transection). The posterior exposure reveals fused porcelain-white laminae and the raw horizontal fracture gap at T12, followed by bilateral multi-level pedicle screw instrumentation spanning 3 levels above (T-3 to T-1) and 3 levels below (L-1 to L-3), totaling 12 screws.",
                    surgicalPearl: "Never position an AS fracture patient on a flat operating table. Bolsters must be built up to accommodate fixed pre-morbid thoracic kyphosis and chin-on-chest deformity; any forced neck or trunk extension during positioning risks instant, irreversible spinal cord transection."
                ),
                SurgicalCallout(
                    id: "plate_071_3",
                    title: "16× Micro-Decompression & Pre-Contoured Fixation",
                    structureType: "MICROSURGICAL DECOMPRESSION & RIGID DUAL-ROD HARDWARE",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C illustrates 16× microsurgical laminectomy with micro-suction and curved dissector evacuation of compressive, dark retrovertebral epidural hematoma, restoring a glistening, expansile dural sac. The final construct shows dual heavy titanium rods pre-contoured to match native thoracic kyphosis without acute lordotic reduction, locked across 12 pedicle screws with a rigid transverse cross-link bridging the fracture for torsional resistance. Post-op CT confirms preserved native sagittal alignment.",
                    surgicalPearl: "Short-segment constructs (<3 levels above and below) carry a catastrophic failure rate >60% in ankylosed spines due to enormous lever-arm forces. Always fix minimum 3 levels above and 3 levels below, pre-contour rods to the pre-injury curve, and lock a cross-link across the fracture."
                ),
                SurgicalCallout(
                    id: "plate_071_4",
                    title: "Epidural Hematoma Protocol & Three Golden Rules",
                    structureType: "CLINICAL SAFETY PROTOCOL & BIOMECHANICAL AXIOMS",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Lower panels: Inset 1 illustrates the axial anatomy of compressive epidural hematoma arising from ruptured Batson plexus and high-flow cancellous fracture margins, establishing the mandatory rule for whole-spine CT/MRI in any trauma. Inset 2 articulates The Three Golden Rules of AS Fracture Fixation: (1) Minimum 3-above / 3-below long-segment fixation, (2) Pre-contour rods to native deformity with zero acute reduction, and (3) Rigid sagittal cross-link fixation.",
                    surgicalPearl: "Never attempt to 'straighten' an ankylosed spine at an acute fracture site. Forcing reduction risks vascular rupture of scarred anterior great vessels (aorta/cava) or catastrophic posterior cord impingement."
                )
            ]

                                                                        case .plate070:
            return [
                SurgicalCallout(
                    id: "plate_070_1",
                    title: "3D Synthetic DTI Tractography & Language Networks",
                    structureType: "SYNTHETIC NEUROIMAGING & TRACTOGRAPHY",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A exhibits synthetic axial and coronal T1-contrast scans of a left frontal-opercular glioblastoma (WHO Grade 4) with ring enhancement and central necrosis. The 3D DTI tractography reconstruction maps the surrounding critical white matter tracts: Corticospinal Tract (CST) descending vertically in royal blue, Arcuate Fasciculus (AF) / SLF II–III looping in magenta/crimson, Inferior Fronto-Occipital Fasciculus (IFOF) in dark violet, and Uncinate Fasciculus (UF) in green. Inset details DES stimulation endpoints (AF = repetition errors; IFOF = semantic paraphasias; CST = motor arrest).",
                    surgicalPearl: "Subcortical language organization is dual-stream: the dorsal stream (AF/SLF) subserves phonological processing and repetition, while the ventral stream (IFOF) subserves semantic comprehension. Preserving both streams is required to prevent permanent postoperative aphasia."
                ),
                SurgicalCallout(
                    id: "plate_070_2",
                    title: "Awake Craniotomy & Cortical DES Mapping Standard",
                    structureType: "OPERATIVE MAPPING & PERISYLVIAN ANATOMY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Panel B depicts the awake asleep-awake-asleep field with regional scalp block and the patient alert performing DO-80 naming tasks. An Ojemann bipolar probe (60 Hz, 1.5–3.5 mA) stimulates perisylvian gyri under ECoG monitoring. Numbered sterile tags mark critical landmarks: [1] Speech arrest (Broca area / IFG), [2] Semantic paraphasia / anomia (Wernicke / STG), [3] Phonological paraphasia (supramarginal gyrus), [4] Contralateral hand motor arrest (precentral motor strip), and [5]/[6] Negative silent cortex marking the safe subpial corticotomy corridor.",
                    surgicalPearl: "Direct electrical stimulation (DES) remains the gold standard for defining eloquent brain. A 1 cm functional margin around positive language sites prevents permanent postoperative language deficits."
                ),
                SurgicalCallout(
                    id: "plate_070_3",
                    title: "16× Subcortical DES, 5-ALA Fluorescence & Tract Sparing",
                    structureType: "SUBCORTICAL DISSECTION & WHITE MATTER PRESERVATION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C illustrates the cavity under 405 nm violet-blue illumination. The glioblastoma core exhibits intense ruby-magenta Protoporphyrin IX (PpIX) fluorescence debulked by CUSA. A subcortical monopolar ball-tip probe actively stimulates deep cavity walls, identifying the glistening striated white fiber bundles of the Arcuate Fasciculus on the deep lateral wall and the Corticospinal Tract (CST) on the posterior-medial floor, defining the functional boundary of supratotal resection.",
                    surgicalPearl: "5-ALA fluorescence visualizes tumor tissue beyond MRI gadolinium margins, but fluorescence must always be subordinated to subcortical stimulation: when a positive motor or language response occurs, tumor resection must halt regardless of residual pink fluorescence."
                ),
                SurgicalCallout(
                    id: "plate_070_4",
                    title: "Intraoperative Seizure Abort & WHO Grade 4 Neuropathology",
                    structureType: "SEIZURE EMERGENCY PROTOCOL & NEUROPATHOLOGY",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Lower panels: Inset 1 details the Seizure Abort Protocol: immediate cold/iced Ringer's irrigation (4–10°C) directly onto the cortex to terminate after-discharges and electrographic seizures, backed by IV levetiracetam and propofol rescue. Inset 2 demonstrates diagnostic WHO Grade 4 Glioblastoma neuropathology on H&E (40×): marked nuclear pleomorphism/cellular atypia, florid microvascular glomeruloid endothelial proliferation, and diagnostic pseudopalisading necrosis.",
                    surgicalPearl: "Iced Ringer's solution must be immediately available at the scrub table before the stimulator touches the brain. Cold irrigation terminates >95% of stimulation-induced seizures without requiring intravenous anticonvulsants or general anesthesia induction."
                )
            ]

                                                                        case .plate069:
            return [
                SurgicalCallout(
                    id: "plate_069_1",
                    title: "3D Contrast MRI & Sindou Classification Matrix",
                    structureType: "NEUROIMAGING & SSS INVASION MATRIX",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A exhibits pre- and post-operative 3T contrast MRI of a spherical middle-third parasagittal/falcine meningioma compressing the rolandic cortex and invading the superior sagittal sinus (SSS). Complete Simpson resection with patent SSS on post-op imaging. The bottom matrix details the Sindou Classification (Types I through VI) defining the surgical strategy: from outer dural coagulation (Type I) and lateral wall repair with patch duraplasty (Types II–IV) to saphenous bypass (Type V) or en-bloc sinus resection (Type VI).",
                    surgicalPearl: "The Sindou Classification dictates the limits of safe oncological resection. Invasion of the lateral wall (Types II–IV) permits complete Simpson Grade I resection when paired with meticulous autologous patch reconstruction, avoiding sinus sacrifice."
                ),
                SurgicalCallout(
                    id: "plate_069_2",
                    title: "SSS-Crossing Craniotomy & Rolandic Bridging Vein Sparing",
                    structureType: "SURGICAL EXPOSURE & VENOUS TOPOGRAPHY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Panel B demonstrates surgical planning and exposure: (1) Vertex topography illustrating 4 burr holes straddling the midline SSS for safe dural peeling without sinus tear; (2) D-shaped dural flap hinged medially along the SSS. The large operative field reveals the central rolandic vein and vein of Trolard meticulously skeletonized and preserved as they enter the lateral lacunae, alongside devascularization of middle meningeal artery branches along the convexity.",
                    surgicalPearl: "Never sacrifice dominant rolandic bridging veins in the middle or posterior third of the SSS. Occluding or tearing the central rolandic vein triggers devastating hemorrhagic infarction of the motor cortex with permanent contralateral hemiplegia."
                ),
                SurgicalCallout(
                    id: "plate_069_3",
                    title: "16× Cavitation, Falx Resection & Triangular SSS Wall Repair",
                    structureType: "MICROSURGICAL RESECTION & SINUS RECONSTRUCTION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C details the 5 sequential stages: (1) CUSA internal debulking collapsing the tumor capsule away from the motor cortex arachnoid plane; (2) Falx cerebri resection down to the inferior sagittal sinus; (3) Cross-sectional delineation of the triangular SSS lumen (superior wall, invaded lateral wall, medial falcine wall); (4) Reconstruction of the lateral wall defect using an autologous pericranial patch sewn watertight with continuous 7-0 monofilament; (5) Patent, laminar sinus flow confirmed via green ICG videoangiography and micro-Doppler.",
                    surgicalPearl: "Maintain continuous lumen patency during lateral wall resection by using temporary micro-clips and placing continuous 7-0 monofilament sutures through healthy dural margins. Confirm absence of intraluminal thrombus before tying the final knot."
                ),
                SurgicalCallout(
                    id: "plate_069_4",
                    title: "Bridging Vein Rule & Venous Air Embolism Protocol",
                    structureType: "CRITICAL SAFETY & ANESTHETIC PROTOCOLS",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Lower panels detail essential safety guidelines: (1) Bridging Vein Safety Rule explicitly warning against sacrificing rolandic drainage to prevent malignant cerebral swelling and hemiplegia; (2) Venous Air Embolism (VAE) Protocol detailing 15° head elevation, temporary intraoperative PEEP elevation (+5–10 cm H2O) during sinus opening, Surgiflo/Gelfoam packing with gentle pressure, and low-power bipolar hemostasis.",
                    surgicalPearl: "Elevating PEEP (+5–10 cm H2O) immediately prior to opening the SSS increases venous pressure, converting negative sinus pressure to positive pressure and preventing lethal venous air embolism (VAE)."
                )
            ]

                                                                        case .plate068:
            return [
                SurgicalCallout(
                    id: "plate_068_1",
                    title: "3D Multi-Modal MRI, Eden Classification & Corridor Biomechanics",
                    structureType: "NEUROIMAGING & AXIAL RESECTION VECTOR",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A illustrates multi-planar 3T MRI of an Eden Type II/III thoracic dumbbell schwannoma showing intradural cord compression with CSF capping, foraminal waist widening, and paravertebral soft-tissue extension. The axial cross-section demonstrates the costotransversectomy corridor: resection of the transverse process, rib head, proximal 3–5 cm rib, pedicle, and lateral vertebral body, creating a 180° posterolateral trajectory directly to the lateral thecal sac and posterior mediastinum with zero spinal cord retraction. Inset details Eden Types I through IV.",
                    surgicalPearl: "The costotransversectomy corridor eliminates the need for thoracic spinal cord retraction. Resecting the proximal rib head and pedicle converts a deep, high-risk traction corridor into a flat, tangential working trajectory."
                ),
                SurgicalCallout(
                    id: "plate_068_2",
                    title: "Posterolateral Exposure, Extrapleural Corridor & Dumbbell Lobes",
                    structureType: "OPERATIVE FIELD & TRIPLE-COMPARTMENT TOPOGRAPHY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Panel B reveals the deep operative exposure from rostral T1 to caudal T3. Bilateral pedicle screws with rods provide rigid biomechanical stabilization. The lobulated yellow-tan dumbbell tumor is cleanly differentiated into three continuous compartments: intradural (spinal canal), foraminal, and extraforaminal thoracic (paravertebral). Parietal pleura is mobilized extrapleurally and protected with moist gauze. The intercostal neurovascular bundle (vein, artery, nerve) tracks along the rib margin into the neural foramen next to the costal stump (3–5 cm rib resection).",
                    surgicalPearl: "Always dissect in the extrapleural plane. Gentle blunt mobilization of the parietal pleura with a moist sponge avoids pleural laceration and prevents postoperative pneumothorax or hemothorax."
                ),
                SurgicalCallout(
                    id: "plate_068_3",
                    title: "5-Step Resection, Watertight Dural Repair & Arthrodesis",
                    structureType: "16× MICROSURGICAL NARRATIVE & COLUMN RECONSTRUCTION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C details the 5 sequential operative stages: (1) Thecal sac durotomy & intradural arachnoid dissection, sacrificing the non-functional dorsal root of origin while sparing ventral rootlets; (2) CUSA internal debulking of foraminal and extrapleural tumor; (3) En-bloc capsule delivery with spontaneous cord re-expansion; (4) Watertight running dural closure reinforced with an onlay collagen matrix patch and fibrin glue to prevent CSF-pleural fistula; (5) Column reconstruction with anterior expandable/mesh titanium cage and rigid posterior screw-rod arthrodesis.",
                    surgicalPearl: "Watertight dural repair reinforced with collagen matrix and fibrin sealant is mandatory. Negative intrathoracic pleural pressure creates a powerful siphon effect that can turn even a pinhole dural tear into an intractable, life-threatening CSF-pleural fistula."
                ),
                SurgicalCallout(
                    id: "plate_068_4",
                    title: "Artery of Adamkiewicz, Schwannoma Pathology & Pleural Protocol",
                    structureType: "VASCULAR SAFETY, PATHOLOGY & PLEURAL TESTING",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Lower insets: Inset 1 maps the Great Anterior Radiculomedullary Artery of Adamkiewicz (T9–L2, typically left-sided), emphasizing the rule to avoid coagulating lower thoracic intercostal arteries near the foramen without proving absence of ASA supply. Inset 2 (H&E 40×) shows WHO Grade I schwannoma with Antoni A spindle cells forming palisading Verocay bodies and loose Antoni B myxoid tissue. Inset 3 illustrates the saline immersion air-leak test with positive-pressure recruitment (Valsalva) to confirm zero pleural leak.",
                    surgicalPearl: "Always perform a saline immersion test under positive-pressure lung recruitment (Valsalva to 30 cm H2O) before closure. If bubbles appear, place a chest tube under direct vision through the surgical corridor."
                )
            ]

                                                                        case .plate067:
            return [
                SurgicalCallout(
                    id: "plate_067_1",
                    title: "3D CT Angiography & Condylar Resection Biomechanics",
                    structureType: "ANGIOPATHOLOGY & SKULL BASE BIOMECHANICS",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Panel A shows 3D CT angiography of the left vertebral artery (VA) ascending from horizontal V3 into intradural V4, giving off the anterior spinal artery (ASA) and basilar artery. A saccular aneurysm arises at the VA-PICA junction, projecting posterolaterally toward the lower cranial nerves. PICA segments (anterior medullary, lateral medullary, tonsillomedullary) loop gracefully. Bottom inset contrasts the narrow ~60° retrocondylar viewing angle against the flat ~90° corridor achieved by resecting the posterior 1/3 of the occipital condyle, opening a 30° wider surgical window without brainstem retraction.",
                    surgicalPearl: "Partial condylectomy (posterior 1/3) provides a flat, shallow corridor directly along the anterior surface of the medulla. It converts a deep, high-risk traction corridor into a direct, line-of-sight exposure of the aneurysm neck."
                ),
                SurgicalCallout(
                    id: "plate_067_2",
                    title: "Far-Lateral Suboccipital Triangle & Condylar Drilling",
                    structureType: "EXTRADURAL V3 & SKULL BASE EXPOSURE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Panel B illustrates the far-lateral transcondylar approach via a retroauricular hockey-stick incision. Layered muscular reflection exposes the suboccipital triangle (rectus capitis posterior major, superior oblique, and inferior oblique). The V3 horizontal segment of the vertebral artery loops across the C1 posterior arch groove, enveloped by a dense suboccipital venous plexus. Bony resection encompasses lateral suboccipital craniectomy unroofing the sigmoid sinus down to the jugular bulb, C1 lateral hemilaminectomy, and high-speed diamond burr drilling of the posterior 1/3 of the occipital condyle, preserving the hypoglossal canal.",
                    surgicalPearl: "The V3 segment must be identified and mobilized early. Bipolar coagulation and hemostatic packing (Surgiflo) of the suboccipital venous plexus prevents air embolism and maintains a bloodless field during condylar drilling."
                ),
                SurgicalCallout(
                    id: "plate_067_3",
                    title: "16× Microsurgical Corridor, Lower CNs & PICA Clipping",
                    structureType: "INTRADURAL MICROSURGERY & PERFUSION RECONSTRUCTION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Panel C operating microscope view under 16× magnification. The medulla, olive, and preolivary/postolivary sulci are pristine. CN XII rootlets emerge from the preolivary sulcus, while CN IX, X, and XI cascade through the postolivary sulcus toward the jugular foramen. A curved mini-Yasargil titanium clip reconstructs the aneurysm neck at the VA-PICA junction, preserving the parent V4 lumen and PICA origin. A micro-Doppler probe confirms robust downstream pulsatile flow in the PICA (>20 cm/s).",
                    surgicalPearl: "PICA aneurysms are intimately intertwined with the rootlets of CN IX, X, and XI. Dissect the arachnoid bands sharply around these rootlets rather than retracting them; blunt traction causes severe postoperative vocal cord paralysis and dysphagia."
                ),
                SurgicalCallout(
                    id: "plate_067_4",
                    title: "Intraoperative Neuromonitoring & Condylar Safety Rule",
                    structureType: "NEUROMONITORING & CRANIOCERVICAL BIOMECHANICS",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Dual insets: Inset 1 displays continuous intraoperative MEP, SSEP, and free-running/triggered EMG for the lower cranial nerves (CN X vocal cord, CN XII tongue, CN XI trapezius). Inset 2 details the Condylar Safety Rule: resecting up to 1/3–50% of the occipital condyle preserves craniocervical stability; resections >50% mandate upfront occipitocervical fusion to prevent postoperative basilar invagination.",
                    surgicalPearl: "Strictly adhere to the 50% condylectomy limit. Routine far-lateral transcondylar approaches require drilling only the posterior-medial 1/3 of the condyle to obtain an unobstructed flat view of the anterior medulla."
                )
            ]

                                                                        case .plate066:
            return [
                SurgicalCallout(
                    id: "plate_066_1",
                    title: "3T Contrast MRI & Skull Base Lesion Comparison",
                    structureType: "ANTERIOR SKULL BASE NEUROIMAGING",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Sagittal 3T contrast MRI demonstrates a giant (~6 cm) homogeneously enhancing subfrontal olfactory groove meningioma with hyperostotic downward remodeling into the ethmoid sinus. Displaces the frontal lobe superiorly/posteriorly and drapes bilateral A2 ACA trunks over the posterior dome. Bottom inset contrasts olfactory groove meningiomas (push optic chiasm down/back) against tuberculum sellae meningiomas (push optic chiasm up/lateral).",
                    surgicalPearl: "The displacement of the optic chiasm is the defining anatomical difference: olfactory groove tumors arise anterior to the chiasm and push it posteroinferiorly, whereas tuberculum sellae tumors arise directly beneath the chiasm and elevate it. Draped ACAs require patient extracapsular microdissection."
                ),
                SurgicalCallout(
                    id: "plate_066_2",
                    title: "Bifrontal Exposure & Extradural Devascularization",
                    structureType: "EXTRADURAL DEVASCULARIZATION CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Low bifrontal craniotomy drilled flush with orbital roofs and nasion. A large vascularized pericranial flap is preserved and reflected anteriorly. Extradural elevation of frontal dura exposes the crista galli, cribriform plate, and planum sphenoidale. Bipolar cautery divides the anterior ethmoidal artery at the fronto-ethmoidal suture and posterior ethmoidal artery near the optic canal, cutting off >80% of tumor vascularity before durotomy.",
                    surgicalPearl: "Extradural coagulation of the anterior and posterior ethmoidal arteries is the hallmark of the transbasal approach. Devascularizing the tumor from its skull base attachments converts a high-tension, vascular tumor into a soft, ischemic, easily aspirable mass."
                ),
                SurgicalCallout(
                    id: "plate_066_3",
                    title: "16× CUSA Debulking, ACA Sparing & Simpson Grade I Repair",
                    structureType: "INTRADURAL MICROSURGERY & SKULL BASE REPAIR",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "16× operating microscope view. Ultrasonic aspiration (CUSA) hollows out the firm fibrous core of the meningioma, collapsing the capsule inward away from frontal cortex. Extracapsular arachnoid dissection mobilizes and preserves the draped bilateral A2 ACAs and frontopolar branches, decompressing the optic apparatus. Simpson Grade I reconstruction removes hyperostotic crista galli and cribriform floor, sealed with the vascularized pericranial flap and fibrin glue.",
                    surgicalPearl: "Always dissect in the arachnoid cleavage plane. The ACAs and their frontopolar branches are separated from the tumor by an intact arachnoid layer; pulling or coagulating on the tumor capsule blindly risks anterior cerebral artery thrombosis and profound bilateral frontal lobe infarction."
                ),
                SurgicalCallout(
                    id: "plate_066_4",
                    title: "Meningothelial Neuropathology & CSF Leak Protocol",
                    structureType: "NEUROPATHOLOGY & MULTILAYER CLOSURE",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Dual insets: Inset 1 (H&E 40×) illustrates classic WHO Grade I meningothelial/transitional meningioma showing syncytial cell lobules, intranuclear pseudo-inclusions, and laminated calcified Psammoma bodies. Inset 2 (Anterior Skull Base Protocol) details the 6-point checklist for permanent CSF leak prevention: extradural devvascularization, hyperostotic bone drilling, vascularized pericranial flap buttress, watertight closure, and fibrin sealant.",
                    surgicalPearl: "The vascularized pericranial flap is the single most effective barrier against postoperative CSF rhinorrhea and ascending bacterial meningitis. Never sacrifice or desiccate the pericranium during initial scalp opening."
                )
            ]

                                                                        case .plate065:
            return [
                SurgicalCallout(
                    id: "plate_065_1",
                    title: "Pre/Post-Op Imaging & Coronal Ventricular Corridors",
                    structureType: "NEUROIMAGING & APPROACH CORRIDORS",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Preoperative non-contrast CT demonstrates a well-circumscribed hyperdense round mass centered at the foramen of Monro causing acute biventricular obstructive hydrocephalus. Preoperative T1 MRI shows a hyperintense/isointense mucinous cyst; postoperative CT confirms complete excision and ventriculomegaly resolution. Coronal schematic illustrates the 3 third ventricular corridors: (1) Transforaminal, (2) Interforniceal, and (3) Transchoroidal (subchoroidal).",
                    surgicalPearl: "CT hyperdensity reflects high protein and mucin viscosity within the cyst, which often resists needle aspiration and requires sharp fenestration and micro-curettage. Preoperative imaging must assess fornix splaying to select between transforaminal and interforniceal entry."
                ),
                SurgicalCallout(
                    id: "plate_065_2",
                    title: "Right Transcallosal Exposure & Foramen of Monro Anatomy",
                    structureType: "INTRAVENTRICULAR MICROSURGICAL ANATOMY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Right frontoparietal parasagittal craniotomy with interhemispheric corridor along the falx. Limited 1.5–2.0 cm anterior callosotomy between pericallosal arteries entering the right lateral ventricle. Definitive intraventricular landmarks: pearly-white septum pellucidum with the vertical septal vein medially, arching ivory fornix column, thalamostriate vein coursing to the venous angle, glomerular choroid plexus along the choroidal fissure, and the yellowish-amber colloid cyst bulging through the foramen.",
                    surgicalPearl: "Limiting anterior callosotomy to <2.0 cm strictly anterior to the coronal suture prevents disconnection syndromes (interhemispheric transfer deficits). Sparing bridging veins entering the superior sagittal sinus avoids hemorrhagic venous infarction of the motor strip."
                ),
                SurgicalCallout(
                    id: "plate_065_3",
                    title: "16× Cyst Evacuation, Capsule Dissection & Restored Foramen",
                    structureType: "4-STEP CYST RESECTION & FORAMEN RESTORATION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "Progressive 4-step microsurgical sequence: (1) Cyst fenestration and micro-aspiration of viscous mucinous contents; (2) Capsule mobilization peeling the fibrous wall off the third ventricle roof; (3) Preservation of bilateral forniceal columns and deep internal cerebral veins in the velum interpositum; (4) Widely patent, communicating bilateral foramina of Monro restoring normal cerebrospinal fluid dynamics.",
                    surgicalPearl: "Never pull vigorously on the cyst capsule where it adheres to the third ventricular roof; the internal cerebral veins run immediately adjacent within the velum interpositum. Cauterizing the capsule gently shrinks it away from the deep venous system without risking torrential deep intraventricular hemorrhage."
                ),
                SurgicalCallout(
                    id: "plate_065_4",
                    title: "H&E Neuropathology & Forniceal / Venous Angle Safety",
                    structureType: "NEUROPATHOLOGY & SAFETY PROTOCOL",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Dual insets: Inset 1 (H&E 40×) illustrates a fibrovascular connective tissue cyst wall lined by a single layer of ciliated columnar and mucin-secreting epithelial cells with PAS-positive mucin droplets. Inset 2 (Venous Angle Safety) demonstrates micro-Doppler interrogation of the internal cerebral veins and outlines safety mandates: avoiding bilateral forniceal traction (>1–2 mm) and preserving the thalamostriate vein.",
                    surgicalPearl: "Bilateral forniceal traction or thermal injury causes devastating, irreversible anterograde amnesia (inability to form new memories, Korsakoff-like syndrome). Occluding the thalamostriate vein risks venous infarction of the caudate and thalamus (drowsiness, mutism, hemiplegia)."
                )
            ]

                                                                        case .plate064:
            return [
                SurgicalCallout(
                    id: "plate_064_1",
                    title: "3T MRI Pathoanatomy & The Hemosiderin Cap Sign",
                    structureType: "MRI DIAGNOSTICS & POLAR CAPS",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.50,
                    description: "Sagittal T1 contrast MRI demonstrates a well-circumscribed, homogeneously enhancing central intramedullary cervical mass (C4–C6) flanked by rostral and caudal polar syrinx cysts. Sagittal T2WI reveals the pathognomonic 'hemosiderin cap sign' (jet-black hypointense rims capping superior and inferior poles from chronic microhemorrhages). Axial cutaway contrasts central encapsulated ependymoma against infiltrative astrocytoma.",
                    surgicalPearl: "The presence of polar syrinx cysts and T2 hemosiderin caps is highly predictive of ependymoma over astrocytoma, indicating a surgically cleavable capsule that permits gross total resection with curative potential."
                ),
                SurgicalCallout(
                    id: "plate_064_2",
                    title: "Posterior Cervical Exposure & Posterior Median Sulcus Myelotomy",
                    structureType: "POSTERIOR MYELOTOMY CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Multi-level posterior cervical exposure (C3–C6 laminectomy) with dura opened mid-dorsally. Symmetrically swollen cord with engorged coronal venous plexus. A diamond micro-knife incises the avascular posterior median sulcus strictly between the dorsal columns (fasciculus gracilis and cuneatus). Fine 6-0/7-0 monofilament pial stay sutures gently tent the posterior columns open to expose the reddish-tan encapsulated tumor.",
                    surgicalPearl: "Always identify the dorsal median sulcus by inspecting the convergence of posterior surface micro-vessels or using a dorsal column mapping probe. Incising off-midline into the fasciculus cuneatus causes severe ipsilateral posterior column sensory ataxia and loss of proprioception."
                ),
                SurgicalCallout(
                    id: "plate_064_3",
                    title: "Gliotic Cleavage Dissection & En-Bloc Resection Bed",
                    structureType: "EN-BLOC RESECTION & ASA SPARING",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "High-magnification (16×) view demonstrating the distinct gliotic cleavage plane separating the encapsulated reddish-tan ependymoma from normal white matter tracts. Polar mobilization allows the tumor to be rolled en-bloc from rostral to caudal while tiny ventral feeding sulcal branches from the Anterior Spinal Artery (ASA) are coagulated and divided, leaving an empty, glistening resection bed.",
                    surgicalPearl: "Never apply forceful traction or use gross internal debulking if the tumor can be delivered en-bloc. Ventral feeders must be coagulated precisely on the tumor capsule to avoid thermal or traction injury to the main ASA trunk running on the anterior median fissure floor."
                ),
                SurgicalCallout(
                    id: "plate_064_4",
                    title: "Real-Time IONM (D-Wave/MEP/SSEP) & Histopathology",
                    structureType: "NEUROMONITORING & WHO GRADE II HISTOLOGY",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Dual insets: Inset 1 (IONM) displays continuous Epidural D-Wave, Transcranial MEP, and SSEP monitoring. D-wave amplitude preservation >50% confirms intact functional corticospinal tracts and predicts preserved long-term ambulation. Inset 2 (H&E 40×) illustrates classic perivascular pseudorosettes and true ependymal rosettes on a dense fibrillary glial background (WHO Grade II).",
                    surgicalPearl: "D-wave monitoring is the single most reliable predictor of permanent motor deficits in intramedullary surgery. If TcMEP is lost but D-wave remains >50%, surgery can safely proceed with high confidence of full motor recovery within weeks."
                )
            ]

                                                                        case .plate063:
            return [
                SurgicalCallout(
                    id: "plate_063_1",
                    title: "Vertebral DSA & Basilar Bifurcation Height Classification",
                    structureType: "ANGIOGRAPHY & HEIGHT CLASSIFICATION",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.55,
                    description: "Catheter DSA (Towne's/RAO view) demonstrating the vertebral confluence, basilar trunk, AICA, SCA, and saccular basilar apex aneurysm between bilateral P1 PCAs. Correlative sagittal classification defines 3 tiers relative to the dorsum sellae: Normal Apex (within 5 mm above dorsum sellae), High-Riding Apex (>5–10 mm above clinoid, invaginating third ventricle), and Low-Riding Apex (below posterior clinoid, hidden behind clivus).",
                    surgicalPearl: "Bifurcation height dictates surgical strategy: a normal apex is accessible via standard transsylvian/pterional corridors; a high-riding apex requires an orbitocranial or subtemporal approach with posterior clinoidectomy; a low-riding apex requires a transcavernous or anterior petrosectomy (Kawase) approach."
                ),
                SurgicalCallout(
                    id: "plate_063_2",
                    title: "Right Pterional Transsylvian & Trans-Liliequist Corridor",
                    structureType: "MICROSURGICAL OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Right pterional transsylvian exposure with flattened sphenoid ridge and reflected dural apron. Carotid-oculomotor and opticocarotid triangles are opened following division of both carotid and diencephalic leaves of Liliequist's membrane. A temporary clip is applied on the mid-basilar trunk below the SCA origins for proximal hemodynamic control. The oculomotor nerve (CN III) is cleanly mobilized between P1 and SCA.",
                    surgicalPearl: "CN III is the sentinel landmark of the upper basilar complex, passing precisely between P1 above and SCA below. Gentle mobilization without traction prevents post-operative third nerve palsy (ptosis, mydriasis, and down-and-out diplopia)."
                ),
                SurgicalCallout(
                    id: "plate_063_3",
                    title: "16× Interpeduncular Dissection & Permanent Clip Application",
                    structureType: "CLIP RECONSTRUCTION & PERFORATOR SPARING",
                    color: Color.blue,
                    normalizedX: 0.81,
                    normalizedY: 0.38,
                    description: "High-magnification (16×) view of the interpeduncular fossa. A curved titanium Yasargil/Sugita clip is placed flush across the basilar neck parallel to the P1-P1 plane, completely excluding the aneurysm with visible collapse and purplish darkening of the sac. Complete preservation of bilateral P1s, SCAs, CN III, and the critical posterior thalamoperforators.",
                    surgicalPearl: "Meticulous microscopic inspection behind the basilar apex is required before and after clip closure. The posterior thalamoperforating micro-arteries (paramedian mesencephalic branches) supply the midbrain and thalami; inadvertent clipping causes devastating coma, akinetic mutism, or bilateral paramedian thalamic infarction."
                ),
                SurgicalCallout(
                    id: "plate_063_4",
                    title: "Intraoperative ICG Videoangiography & Micro-Doppler Verification",
                    structureType: "FLOW PATENCY & EXCLUSION CONFIRMATION",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Dual-modality flow verification: Inset 1 (ICG videoangiography) confirms complete exclusion of the basilar tip aneurysm (jet black non-filling void) with robust fluorescent green flow in the basilar trunk, bilateral SCAs, P1s, and posterior thalamoperforators. Inset 2 (Micro-Doppler) confirms high-velocity laminar flow in P1 (V ≈ 32 cm/s, >25 cm/s patency threshold).",
                    surgicalPearl: "Micro-Doppler interrogation of both P1 branches and both SCAs confirms that the clip blades have not kinked or stenosed the posterior circulation outflow. Symmetric laminar flow eliminates the risk of occipital and brainstem infarction."
                )
            ]

                                                                        case .plate062:
            return [
                SurgicalCallout(
                    id: "plate_062_1",
                    title: "Catheter DSA Angioarchitecture & M1 Lenticulostriate Anatomy",
                    structureType: "ANGIOGRAPHY & BRANCHING CLASSIFICATION",
                    color: Color.red,
                    normalizedX: 0.17,
                    normalizedY: 0.38,
                    description: "Right internal carotid catheter DSA (lateral/oblique view) displaying the horizontal sphenoidal M1 trunk, fine candle-flame lateral lenticulostriate perforating arteries (LsA) arising from the dorsal aspect of M1, and a saccular aneurysm at the MCA bifurcation (limen insulae) dividing into superior (frontal) and inferior (temporal) M2 trunks.",
                    surgicalPearl: "Preoperative 4-vessel angiography or high-resolution 3D rotational DSA is mandatory to identify early branching (e.g. early anterior temporal artery mimicking bifurcation) and to map the relationship of the lateral lenticulostriate arteries, which supply the posterior limb of the internal capsule."
                ),
                SurgicalCallout(
                    id: "plate_062_2",
                    title: "Right Pterional Transsylvian Exposure & Distal-to-Proximal Corridor",
                    structureType: "MICROSURGICAL OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Right frontotemporal pterional craniotomy with sphenoid ridge drilled flat to the meningo-orbital band. Frontal and temporal opercula are gently separated with self-retaining retractor blades across the Sylvian fissure. Superficial Sylvian veins are preserved on the temporal bank. A temporary clip is placed on the horizontal M1 trunk for proximal hemodynamic control during bifurcation dissection.",
                    surgicalPearl: "The distal-to-proximal transsylvian approach traces M2 opercular branches retrograde down to the bifurcation, which minimizes frontal lobe retraction. Always apply temporary clips on M1 only after identifying and sparing all dorsal lenticulostriate perforators."
                ),
                SurgicalCallout(
                    id: "plate_062_3",
                    title: "16× Multi-Clip Tandem Reconstruction & Sac Incision",
                    structureType: "TANDEM CLIP RECONSTRUCTION & EXCLUSION",
                    color: Color.blue,
                    normalizedX: 0.82,
                    normalizedY: 0.38,
                    description: "High-magnification (16×) view of the MCA bifurcation. A complex, broad-based aneurysm neck is reconstructed using multiple interlocking titanium Yasargil/Sugita clips applied in tandem. The excluded aneurysm sac is sharply incised and decompressed, proving complete flow obliteration. Both superior M2 (frontal motor) and inferior M2 (temporal language) trunks remain widely patent.",
                    surgicalPearl: "In broad-necked MCA aneurysms, a single straight clip risks dog-ear residual or stenosis of the daughter trunks. Applying a tandem or fenestrated clip construct reconstructs the native arterial carina. Puncturing or incising the dome confirms complete exclusion before releasing temporary clips."
                ),
                SurgicalCallout(
                    id: "plate_062_4",
                    title: "Intraoperative ICG Videoangiography & Micro-Doppler Verification",
                    structureType: "FLOW PATENCY & EXCLUSION CONFIRMATION",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Dual-modality flow verification: Inset 1 (ICG videoangiography) confirms complete exclusion of the aneurysm sac (jet black non-filling void) with robust fluorescent green filling in M1, lenticulostriates, and both M2 daughter branches. Inset 2 (Micro-Doppler) confirms high-velocity laminar flow in both Superior M2 (Vmean = 28 cm/s) and Inferior M2 (Vmean = 32 cm/s).",
                    surgicalPearl: "Micro-Doppler flow measurement (>20 cm/s in both M2 branches) provides instant verification that clip blades have not kinked or narrowed either outflow trunk. Stenosis of the superior M2 causes contralateral hand/face weakness and motor aphasia; stenosis of the inferior M2 causes Wernicke aphasia and superior quadrantanopia."
                )
            ]

                                                                        case .plate061:
            return [
                SurgicalCallout(
                    id: "plate_061_1",
                    title: "AComA Aneurysm 4-Projection Classification & CTA MIP",
                    structureType: "ANGIOGRAPHIC MORPHOLOGY & CTA",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.55,
                    description: "Axial CTA MIP and four canonical projection profiles: (a) Anteroinferior (projects toward prechiasmatic cistern/optic chiasm; prone to rupture during initial frontal lobe retraction), (b) Superior/Interhemispheric (projects upward between bilateral A2s), (c) Posterosuperior (projects toward lamina terminalis/hypothalamus; high perforator risk), and (d) Complex/Inferior-Dorsal (adherent to dorsal chiasm).",
                    surgicalPearl: "Preoperative 3D CTA and rotational DSA define the dominant feeding A1 (present in >80% of AComA aneurysms due to asymmetric circle of Willis flow dynamics). Pterional craniotomy is chosen on the side of the dominant A1 to secure early proximal control."
                ),
                SurgicalCallout(
                    id: "plate_061_2",
                    title: "Right Pterional Transsylvian Approach & Gyrus Rectus Corridor",
                    structureType: "MICROSURGICAL OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.38,
                    description: "Right frontotemporal pterional craniotomy with sphenoid ridge drilled flat to the meningo-orbital band. The Sylvian fissure is widely split, releasing CSF from the carotid-optic cistern. A temporary clip is placed on the dominant Right A1 for proximal hemodynamic protection. A minimal 5 mm subpial resection of the gyrus rectus medial to the olfactory tract exposes the AComA complex and contralateral A1/A2 without brain retraction injury.",
                    surgicalPearl: "Subpial gyrus rectus resection must remain strictly medial to the olfactory tract and anterior to the anterior communicating artery to avoid damaging the olfactory striae, optic chiasm, or hypothalamic nuclei. Preserving the pial cuff prevents venous infarction."
                ),
                SurgicalCallout(
                    id: "plate_061_3",
                    title: "16× Microdissection & Permanent Yasargil Clip Application",
                    structureType: "CLIP RECONSTRUCTION & PERFORATOR SPARING",
                    color: Color.blue,
                    normalizedX: 0.81,
                    normalizedY: 0.38,
                    description: "High-magnification (16×) view showing 360° circumferential skeletonization of the aneurysm neck. A titanium Sugita/Yasargil spring clip completely occludes the neck flush with the parent AComA vessel, causing visible collapse and darkening of the excluded sac. Complete preservation of bilateral A2 trunks, the Recurrent Artery of Heubner (RAH), and posterior hypothalamic/chiasmatic perforating micro-arterioles.",
                    surgicalPearl: "The clip blades must span 1–2 mm beyond the far neck margin to ensure complete closure without leaving a residual neck dog-ear. Meticulously inspect the tips behind the neck to confirm that the contralateral A2, Heubner's artery, and hypothalamic perforators are completely free before releasing proximal temporary clips."
                ),
                SurgicalCallout(
                    id: "plate_061_4",
                    title: "Intraoperative ICG Videoangiography & Micro-Doppler Verification",
                    structureType: "FLOW PATENCY & EXCLUSION CONFIRMATION",
                    color: Color.green,
                    normalizedX: 0.50,
                    normalizedY: 0.88,
                    description: "Dual-modality intraoperative hemodynamic verification: Inset 1 (ICG videoangiography) confirms complete exclusion of the aneurysm (jet black non-filling void) with robust fluorescent green flow in bilateral A1, A2, and recurrent artery of Heubner. Inset 2 (Micro-Doppler) verifies pulsatile laminar flow (>15 cm/s, measured at 24 cm/s) across both A2 segments.",
                    surgicalPearl: "Always perform microscopic inspection combined with ICG and micro-Doppler interrogation of both A2 branches before final closure. Inadvertent kinking or occlusion of an A2 trunk causes profound anterior cerebral artery territory infarction, leading to lower extremity diplegia, abulia, and mutism."
                )
            ]

                                                                        case .plate060:
            return [
                SurgicalCallout(
                    id: "plate_060_1",
                    title: "Suzuki Staging & 'Puff of Smoke' Basal Angioarchitecture",
                    structureType: "PATHOLOGICAL ANGIOGRAPHY & STAGING",
                    color: Color.red,
                    normalizedX: 0.17,
                    normalizedY: 0.40,
                    description: "Chronic progressive stenosis/occlusion of the terminal supraclinoid ICA (carotid fork) triggering extensive lenticulostriate and thalamoperforating collateral telangiectasias at the skull base ('moyamoya' or puff of smoke). Progresses from early bifurcation narrowing (Stage I) through florid basal collaterals (Stage III) to complete ICA occlusion and dependence on ECA vault collaterals (Stage VI).",
                    surgicalPearl: "Fragile moyamoya collateral microvessels are prone to microaneurysm formation and rupture, causing catastrophic adult intracerebral/intraventricular hemorrhage. Revascularization reduces hemodynamic stress on these fragile basal networks."
                ),
                SurgicalCallout(
                    id: "plate_060_2",
                    title: "STA-MCA End-to-Side Micro-Anastomosis (16× Magnification)",
                    structureType: "MICROSURGICAL BYPASS FIELD",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.52,
                    normalizedY: 0.35,
                    description: "Direct end-to-side anastomosis between the donor superficial temporal artery (STA, ~1.5–2.0 mm caliber) and recipient cortical middle cerebral artery (M4 / angular branch, ~1.0 mm caliber). A green rubber contrast sheet elevates the vessel. Paired temporary micro-clips isolate a 5–7 mm recipient segment with a 1.5–2.0 mm linear arteriotomy.",
                    surgicalPearl: "Fish-mouth the donor STA tip at 45° to match the oval arteriotomy and prevent anastomotic stenosis. Place foundational heel and toe 10-0 nylon anchor sutures first, followed by 5–6 interrupted 10-0 monofilament sutures per side with intimal eversion."
                ),
                SurgicalCallout(
                    id: "plate_060_3",
                    title: "EDAS (Encephalo-Duro-Arterio-Synangiosis) Indirect Revascularization",
                    structureType: "INDIRECT SYNANGIOSIS CORRIDOR",
                    color: Color.blue,
                    normalizedX: 0.84,
                    normalizedY: 0.42,
                    description: "The intact, pulsating parietal branch of the STA is mobilized with a wide (~1 cm) galea-periosteal cuff along 7–8 cm. Through a linear dural slit with micro-fenestrated arachnoid, the adventitia of the artery and galeal cuff are anchored flush against the bare ischemic cerebral cortex using interrupted 8-0 nylon dural sutures.",
                    surgicalPearl: "Maintain continuous anterograde flow through the intact STA; do not cauterize or strip the perivascular adventitia, which carries critical VEGF and bFGF angiogenic factors essential for spontaneous transdural neovascular sprouting over 3–6 months."
                ),
                SurgicalCallout(
                    id: "plate_060_4",
                    title: "Intraoperative ICG Videoangiography & Flow Verification",
                    structureType: "FLOW HEMODYNAMICS & PATENCY",
                    color: Color.green,
                    normalizedX: 0.25,
                    normalizedY: 0.88,
                    description: "Fluorescent infrared videoangiography confirms instantaneous bypass patency: bright intravascular dye surges through the STA donor and briskly fills both proximal (retrograde) and distal (anterograde) M4 cortical branches with zero anastomotic leak, stenosis, or intraluminal thrombus.",
                    surgicalPearl: "Use a 1.5 mm transit-time microvascular ultrasonic flow probe (Charbel probe) to measure quantitative flow (cut-flow index >0.5, flow >20 mL/min). An abrupt flow drop indicates anastomotic kink, intimal flap, or micro-thrombus requiring immediate heparinized saline flush and revision."
                )
            ]
case .plate059:
            return [
                SurgicalCallout(
                    id: "plate_059_1",
                    title: "Knosp Cavernous Sinus Classification & Tangent Lines",
                    structureType: "SURGICAL RESECTABILITY MATRIX",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.16,
                    normalizedY: 0.65,
                    description: "Based on coronal T1 contrast MRI: Medial line (Grade 0/1 boundary), Inter-carotid line (Grade 2 boundary), and Lateral line (Grade 3/4 boundary). Grade 3A projects into the superior cavernous compartment above the horizontal ICA; Grade 3B into the inferior compartment; Grade 4 completely encases the ICA (360°).",
                    surgicalPearl: "Grades 0–2 achieve >90% biochemical and gross-total resection via standard transsellar corridor; Grades 3–4 require extended transcavernous/transpterygoid corridors or planned residual adjuvant stereotactic radiosurgery."
                ),
                SurgicalCallout(
                    id: "plate_059_2",
                    title: "Chiasmatic Elevation & Bitemporal Hemianopsia",
                    structureType: "CORONAL 3T MRI CORRIDOR",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.22,
                    description: "Suprasellar tumor extension stretches and thins the optic chiasm upward into a characteristic convex crescent. Compression of crossing decussating nasal retinal fibers causes classic bitemporal hemianopsia.",
                    surgicalPearl: "Decompressing the central tumor debulking core allows the suprasellar capsule and chiasm to descend, restoring optic nerve perfusion and visual field deficits."
                ),
                SurgicalCallout(
                    id: "plate_059_3",
                    title: "Endoscopic Sphenoid Bony Landmarks & OCR Keyhole",
                    structureType: "SURGICAL SKULL BASE LANDMARKS",
                    color: Color.blue,
                    normalizedX: 0.48,
                    normalizedY: 0.40,
                    description: "Visualizes the sellar floor, tuberculum sellae, planum sphenoidale, and clivus. Bilaterally, the optic protuberance and parasellar/paraclival carotid protuberances converge at the medial and lateral opticocarotid recesses (OCR).",
                    surgicalPearl: "The medial OCR corresponds internally to the optic strut, precisely demarking the junction between the optic nerve superiorly and the paraclinoid internal carotid artery inferiorly."
                ),
                SurgicalCallout(
                    id: "plate_059_4",
                    title: "Extracapsular Pseudocapsule Dissection & Hadad Flap",
                    structureType: "ENDOSCOPIC RESECTION & RECONSTRUCTION",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.40,
                    description: "Dissecting in the clean cleavage plane between the tumor pseudocapsule and sellar dura maximizes complete removal while preserving normal compressed pituitary gland tissue. Multilayer closure is reinforced with a pedicled vascularized nasoseptal (Hadad-Bassagasteguy) flap.",
                    surgicalPearl: "Extracapsular pseudocapsule dissection significantly increases rates of endocrine biochemical remission in functioning adenomas (Cushing's, acromegaly) compared to piecemeal curettage alone."
                )
            ]
        case .plate058:
            return [
                SurgicalCallout(
                    id: "plate_058_1",
                    title: "Spondylodiscitis Epicenter & Marrow Edema",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.22,
                    normalizedY: 0.35,
                    description: "Severe endplate destruction and disc collapse on sagittal MRI with purulent PLL rupture into ventral epidural space.",
                    surgicalPearl: "Identify whether infection is mature liquid pus (surgical emergency) vs. vascularized phlegmon (potential medical candidate)."
                ),
                SurgicalCallout(
                    id: "plate_058_2",
                    title: "Circumferential Thecal Sac Compression",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.50,
                    normalizedY: 0.35,
                    description: "Dense epidural pus obliterating subarachnoid space with central T2-hyperintense intramedullary cord edema.",
                    surgicalPearl: "SEA can spread skip-levels over 5–10 segments via Batson's valveless plexus; complete whole-spine contrast MRI is mandatory."
                ),
                SurgicalCallout(
                    id: "plate_058_3",
                    title: "Targeted Laminectomy & Pus Evacuation",
                    structureType: "SURGICAL CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.78,
                    normalizedY: 0.35,
                    description: "Focused unroofing at maximum compression epicenter, aspirating liquid purulence and debriding dorsal granulation tissue.",
                    surgicalPearl: "Avoid wide multi-level laminectomies in septic patients with spondylodiscitis to prevent acute postoperative kyphotic collapse."
                ),
                SurgicalCallout(
                    id: "plate_058_4",
                    title: "Catheter-Directed Epidural Saline Lavage",
                    structureType: "SURGICAL TECHNIQUE",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.78,
                    normalizedY: 0.75,
                    description: "Passage of soft 5-8 Fr pediatric feeding tube cephalad and caudad in epidural space for gentle pulsed saline irrigation.",
                    surgicalPearl: "Never force the lavage catheter against resistance; resistance indicates solid granulation or dural adhesion—forcing tears dura."
                )
            ]
        case .plate057:
            return [
                SurgicalCallout(
                    id: "plate_057_1",
                    title: "3T FIESTA Prepontine Cistern & REZ Neurovascular Conflict",
                    structureType: "HIGH-RESOLUTION 3T NEUROIMAGING",
                    color: Color.red,
                    normalizedX: 0.15,
                    normalizedY: 0.28,
                    description: "Axial 3T FIESTA/CISS MRI demonstrates a sharp, hypointense vascular loop of the superior cerebellar artery (SCA) impinging directly onto the root entry zone (REZ) of the left trigeminal nerve at the Obersteiner-Redlich transition zone.",
                    surgicalPearl: "High-resolution 3D steady-state sequences (FIESTA/CISS) correlate with intraoperative findings in >95% of patients, confirming cross-compression and focal nerve indentation."
                ),
                SurgicalCallout(
                    id: "plate_057_2",
                    title: "Park-Bench Positioning & Keyhole Craniectomy",
                    structureType: "SURGICAL POSITIONING & BONE WINDOW",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.15,
                    normalizedY: 0.78,
                    description: "Park-bench/lateral position with vertex flexed and rotated 10–15° contralaterally. A small quarter-sized (2.0–2.5 cm) craniectomy is placed flush against the inferior edge of the transverse sinus and posterior border of the sigmoid sinus.",
                    surgicalPearl: "Placing the bone window flush with the sinus confluence eliminates the need for brain retraction, providing an unobstructed suboccipital corridor along the tentorial surface."
                ),
                SurgicalCallout(
                    id: "plate_057_3",
                    title: "Trigeminal REZ & Superior Petrosal Vein (Dandy) Preservation",
                    structureType: "CPA NEUROVASCULAR ARCHITECTURE",
                    color: Color.blue,
                    normalizedX: 0.48,
                    normalizedY: 0.45,
                    description: "CN V emerges from the mid-pons and courses toward Meckel's cave. The SCA loop compresses the nerve rostrally and medially. The superior petrosal vein (Vein of Dandy) courses laterally into the superior petrosal sinus and must be meticulously preserved.",
                    surgicalPearl: "Never coagulate or divide the main superior petrosal vein trunk indiscriminately; sacrifice can trigger catastrophic cerebellar venous infarction, brainstem swelling, and hearing loss."
                ),
                SurgicalCallout(
                    id: "plate_057_4",
                    title: "Multi-Modal Decompression: Interposition & Transposition",
                    structureType: "JANNETTA DECOMPRESSION MODALITIES",
                    color: Color.green,
                    normalizedX: 0.82,
                    normalizedY: 0.40,
                    description: "Offloading the REZ can be achieved via: (1) Classic shredded Teflon interposition pledgets, (2) Teflon felt anchor transposition to petrous dura, or (3) Dural/pericranial sling transposition anchoring the SCA to the tentorium with micro-sutures.",
                    surgicalPearl: "Transposition using a tentorial sling completely mobilizes the vessel away without foreign material resting on the nerve, reducing long-term Teflon granuloma or recurrence."
                )
            ]
        case .plate056:
            return [
                SurgicalCallout(
                    id: "plate_056_1",
                    title: "Direct Arteriovenous Shunt & High-Flow Angiopathy",
                    structureType: "HEMODYNAMIC SHUNT ARCHITECTURE",
                    color: Color.red,
                    normalizedX: 0.16,
                    normalizedY: 0.35,
                    description: "Absence of the intervening high-resistance capillary bed creates a low-resistance, high-flow arteriovenous fistula. Massive arterial runoff into thin-walled, arterialized draining veins drives progressive venous ectasia, turbulent shear stress, and recruitment of hypertrophied feeding arteries.",
                    surgicalPearl: "High-flow shunting induces chronic hypoperfusion in adjacent normal brain (cerebral steal), making surrounding parenchyma exquisitely susceptible to ischemia or hyperemic breakthrough."
                ),
                SurgicalCallout(
                    id: "plate_056_2",
                    title: "Spetzler-Martin Grading System & Eloquence Mapping",
                    structureType: "SURGICAL RISK CLASSIFICATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.40,
                    description: "Three-tier anatomical risk scoring: Nidus Size (<3 cm = 1, 3–6 cm = 2, >6 cm = 3); Eloquence of adjacent brain (Non-eloquent = 0, Eloquent = 1: motor, sensory, language, visual, thalamus, internal capsule, brainstem); Venous Drainage (Superficial only = 0, Deep components = 1). Total Grade I–V correlates directly with surgical morbidity and mortality.",
                    surgicalPearl: "Grades I and II are ideal microsurgical candidates (<3% deficit); Grade III represents a mixed management dilemma often requiring staged embolization; Grades IV and V carry prohibitive surgical morbidity and are usually managed conservatively."
                ),
                SurgicalCallout(
                    id: "plate_056_3",
                    title: "Circumferential Feeder Dissection (The 'Vein Last' Rule)",
                    structureType: "MICROSURGICAL CARDINAL AXIOM",
                    color: Color.blue,
                    normalizedX: 0.84,
                    normalizedY: 0.35,
                    description: "Microsurgical circumdissection advances 360° along the gliotic hemosiderin border plane. Pial and sulcal feeders are individually skeletonized, bipolared, and divided at the nidus margin while strictly preserving the main arterialized draining vein.",
                    surgicalPearl: "The cardinal rule of AVM surgery: NEVER occlude the primary draining vein prematurely. Premature venous occlusion transforms the high-flow shunt into a closed pressure cooker, triggering immediate catastrophic intraoperative explosive rupture."
                ),
                SurgicalCallout(
                    id: "plate_056_4",
                    title: "Dry Resection Bed & En-Passage Vessel Preservation",
                    structureType: "POST-RESECTION GLIOTIC MARGIN",
                    color: Color.green,
                    normalizedX: 0.86,
                    normalizedY: 0.82,
                    description: "Following circumferential isolation and devascularization, the nidus softens and shifts from pulsating scarlet to dark burgundy. The primary draining vein is only then clipped and divided, enabling en-bloc removal and revealing a completely dry, hemosiderin-stained parenchymal bed.",
                    surgicalPearl: "Vessels of passage ('en-passage' arteries) traversing adjacent brain to normal tissue must be meticulously spared; clipping an en-passage artery causes remote hemispheric infarction."
                )
            ]
        case .plate055:
            return [
                SurgicalCallout(
                    id: "plate_055_1",
                    title: "Kawase's Rhomboid Triangle & Petrous Apex",
                    structureType: "ANTERIOR PETROSECTOMY BONE WINDOW",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.52,
                    normalizedY: 0.45,
                    description: "Bounded anterolaterally by GSPN/V3, posterolaterally by the arcuate eminence (superior semicircular canal), medially by the superior petrosal sinus (SPS), and anteromedially by Meckel's cave. Drilling this triangle opens a direct 10–12 mm extradural corridor to the posterior fossa dura medial to the IAC.",
                    surgicalPearl: "Drilling must remain strictly medial to the GSPN and anterior to the arcuate eminence to protect the cochlea and vestibular labyrinth."
                ),
                SurgicalCallout(
                    id: "plate_055_2",
                    title: "Horizontal Petrous ICA & GSPN",
                    structureType: "VASCULAR DANGER ZONE",
                    color: Color.red,
                    normalizedX: 0.48,
                    normalizedY: 0.32,
                    description: "The horizontal segment of the petrous internal carotid artery lies directly deep to the GSPN. In up to 30% of patients, the carotid canal roof is dehiscent.",
                    surgicalPearl: "Elevate the middle fossa dura strictly from posterior to anterior; anterior-to-posterior dissection can snag a dehiscent ICA or avulse the GSPN from the geniculate ganglion, causing facial palsy."
                ),
                SurgicalCallout(
                    id: "plate_055_3",
                    title: "Subsurface Cochlea & Labyrinth Protection",
                    structureType: "AUDITORY SPARING ZONE",
                    color: Color.blue,
                    normalizedX: 0.54,
                    normalizedY: 0.72,
                    description: "The cochlea is hidden in the bone within the apex between the GSPN, geniculate ganglion, and internal auditory canal fundus. The superior semicircular canal lies directly under the arcuate eminence.",
                    surgicalPearl: "Never drill lateral to the line connecting the facial hiatus to the IAC fundus; violation of the otic capsule causes immediate permanent sensorineural hearing loss."
                ),
                SurgicalCallout(
                    id: "plate_055_4",
                    title: "Tentorial Division & Trochlear Nerve (CN IV) Sparing",
                    structureType: "TRANS-TENTORIAL CORRIDOR",
                    color: Color.green,
                    normalizedX: 0.88,
                    normalizedY: 0.18,
                    description: "The superior petrosal sinus is clipped and divided. The tentorium is incised from the petrous ridge toward the incisura, directed strictly posterior to the dural entry of CN IV.",
                    surgicalPearl: "Directing the tentorial cut posterior to the incisural entry of CN IV prevents superior oblique denervation and debilitating vertical diplopia."
                )
            ]
        case .plate054:
            return [
                SurgicalCallout(
                    id: "plate_054_1",
                    title: "The Sato Axial Classification",
                    structureType: "AXIAL CT & MRI SPECTRUM",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.18,
                    normalizedY: 0.42,
                    description: "Progression from Type I (Lateral capsular), Type II (Extended interlaminar), Type III (Diffuse laminar), to Type IV/V (Fused nodular beak). In Type V, massive bilateral cauliflower ossification meets in the midline, pinching the cord into a thin transverse crescent with >60% canal compromise.",
                    surgicalPearl: "Type IV and V have high incidence of dural ossification (tram-track sign); attempting circumferential dissection without thinning will tear the dura."
                ),
                SurgicalCallout(
                    id: "plate_054_2",
                    title: "The Floating Island / Thin-Shell Technique",
                    structureType: "MICROSURGICAL PROTOCOL",
                    color: Color.green,
                    normalizedX: 0.88,
                    normalizedY: 0.45,
                    description: "Bilateral pedicle troughs are cut down to the inner cortex with an ultrasonic bone scalpel. The central ossified mass is thinned to a translucent paper-thin shell with a diamond burr and left floating on pulsating dura, avoiding violent peeling from adherent dura.",
                    surgicalPearl: "The floating shell expands outward with restored CSF pulsation; dissecting fused bone off ossified dura is unnecessary and causes giant pseudomeningoceles."
                ),
                SurgicalCallout(
                    id: "plate_054_3",
                    title: "Zero-Plunging Under-Shelf Mandate",
                    structureType: "CRITICAL SAFETY ZONE",
                    color: Color.red,
                    normalizedX: 0.88,
                    normalizedY: 0.22,
                    description: "Strict prohibition against inserting Kerrison rongeur footplates underneath the ossified ligament shelf. The thoracic canal has zero reserve volume; sliding any footplate under the shelf exerts immediate focal compression onto the ischemic thoracic cord.",
                    surgicalPearl: "All bone resection must be strictly extra-cavitary (from superficial to deep) using diamond burrs or ultrasonic aspirators until the bone is eggshell thin."
                ),
                SurgicalCallout(
                    id: "plate_054_4",
                    title: "Sagittal Patterns & Compressive Myelomalacia",
                    structureType: "LONGITUDINAL MORPHOLOGY",
                    color: Color.blue,
                    normalizedX: 0.52,
                    normalizedY: 0.32,
                    description: "Sagittal categorization into Circumscribed (focal T10–T11 beak), Continuous (multi-level bridge), and Intermittent (skip lesions). The focal hyperintense T2 intramedullary signal at the apex denotes severe ischemic myelopathy.",
                    surgicalPearl: "The lower thoracic junction (T10–L1) experiences maximum mechanical torque, making it the most frequent and severe site of symptomatic T-OLF."
                )
            ]
        case .plate053:
            return [
                SurgicalCallout(
                    id: "plate_053_1",
                    title: "The DESH Sign & Callosal Angle < 90°",
                    structureType: "CORONAL MRI HALLMARK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.42,
                    normalizedY: 0.24,
                    description: "Disproportionately Enlarged Subarachnoid Space Hydrocephalus (DESH) is characterized by cavernous Sylvian fissures, severe parasagittal high-convexity sulcal crowding ('vertex crowding'), and an acute callosal angle < 90° (measuring 68° vs. > 110° in ex-vacuo atrophy).",
                    surgicalPearl: "DESH has >80% positive predictive value for shunt responsiveness; diffuse cortical sulcal enlargement across the vertex signifies Alzheimer atrophy, where shunting confers zero benefit and high subdural risk."
                ),
                SurgicalCallout(
                    id: "plate_053_2",
                    title: "The Evans Index (> 0.30)",
                    structureType: "AXIAL VENTRICULOMEGALY CALIPER",
                    color: Color.blue,
                    normalizedX: 0.16,
                    normalizedY: 0.28,
                    description: "Ratio of the maximum frontal horn transverse diameter (48 mm) to the maximum inner biparietal skull diameter at the same axial level (137 mm), yielding an Evans Index of 0.35 (> 0.30 threshold). Faint periventricular halos represent transependymal CSF resorption.",
                    surgicalPearl: "The Evans Index is a mandatory screening metric for ventriculomegaly, but must always be paired with coronal DESH to prevent shunting patients with neurodegenerative cortical atrophy."
                ),
                SurgicalCallout(
                    id: "plate_053_3",
                    title: "Kocher's Point Frontal Trajectory",
                    structureType: "BURR HOLE ENTRY SITE",
                    color: Color.green,
                    normalizedX: 0.74,
                    normalizedY: 0.16,
                    description: "Right frontal burr hole located 1 cm anterior to the coronal suture and 2.5–3.0 cm lateral to midline in the mid-pupillary line. Trajectory perpendicular to cranial curvature aimed towards the medial canthus of the ipsilateral eye and external auditory meatus.",
                    surgicalPearl: "Never plunge beyond 5.5–6.0 cm from the outer cortex; the ventricular catheter tip must remain cleanly inside the frontal horn anterior to the foramen of Monro."
                ),
                SurgicalCallout(
                    id: "plate_053_4",
                    title: "Programmable Valve & Gravitational Anti-Siphon Unit",
                    structureType: "RETROAURICULAR HARDWARE",
                    color: Color.orange,
                    normalizedX: 0.94,
                    normalizedY: 0.28,
                    description: "Adjustable differential-pressure valve (Codman Hakim / Strata) coupled in series with an inline gravitational anti-siphon unit containing vertical tantalum weight balls that engage automatically when the patient stands.",
                    surgicalPearl: "The gravitational unit prevents posture-dependent low-pressure over-drainage, virtually eliminating the 15–20% historical risk of chronic subdural hematomas in elderly NPH patients."
                )
            ]
        case .plate052:
            return [
                SurgicalCallout(
                    id: "plate_052_1",
                    title: "Safe Intracapsular Debulking Zone",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.22,
                    normalizedY: 0.35,
                    description: "Avascular posterior tumor dome incised and systematically debulked using ultrasonic aspiration (CUSA) to loosen capsular adhesions.",
                    surgicalPearl: "Stay strictly intracapsular during initial debulking to avoid premature traction on the stretched, attenuated facial nerve."
                ),
                SurgicalCallout(
                    id: "plate_052_2",
                    title: "Facial Nerve (CN VII) Ventral Trajectory",
                    structureType: "CRITICAL CRANIAL NERVE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.50,
                    normalizedY: 0.45,
                    description: "Stretched, splayed facial nerve displaced onto anterior-inferior tumor capsule; mapped continuously with handheld monopolar stimulator.",
                    surgicalPearl: "Preserve the thin arachnoid dissection plane between tumor capsule and facial nerve; leave a thin tumor remnant if adherent."
                ),
                SurgicalCallout(
                    id: "plate_052_3",
                    title: "Drilled Porus Acusticus & IAC Fundus",
                    structureType: "OSTEOLOGICAL DECOMPRESSION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.78,
                    normalizedY: 0.40,
                    description: "High-speed diamond drilling of posterior IAC lip under continuous cold irrigation, unroofing fundus and exposing transverse crest and Bill's bar.",
                    surgicalPearl: "Bill's bar (vertical crest) separates CN VII anterosuperiorly from superior vestibular nerve posterosuperiorly at the IAC fundus."
                ),
                SurgicalCallout(
                    id: "plate_052_4",
                    title: "AICA Loop & Lower Cranial Nerves",
                    structureType: "NEUROVASCULAR BOUNDARY",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.78,
                    normalizedY: 0.75,
                    description: "Anterior inferior cerebellar artery (AICA) meatal loop and lower cranial nerves (IX–XI) along the caudal tumor pole.",
                    surgicalPearl: "Occlusion of AICA meatal loop causes lateral pontine infarction, ipsilateral deafness, and severe ataxia."
                )
            ]
        }
    }

    public var steps: [ApproachSequentialStep] {
        switch self {
        case .plate001:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Exposure & Tectorial Reflection", detail: "Midline suboccipital-to-C3 incision; resect posterior C1 arch and reflect membrana tectoria superiorly off C2 body to expose deep ligaments."),
                ApproachSequentialStep(stepNumber: 2, title: "Cruciate & Alar Ligament Microdissection", detail: "Examine horizontal transverse ligament and vertical crura under magnification; mobilize bilateral alar check ligaments anchoring dens to condyles."),
                ApproachSequentialStep(stepNumber: 3, title: "V3 Vertebral Artery Preservation & Reconstruction", detail: "Identify vertebral artery in C1 transverse groove; maintain dissection strictly subperiosteal <= 12 mm from midline, verifying stability.")
            ]
        case .plate002:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Fontanelle Landmark & Surgical Prep", detail: "Palpate open bregma framing metopic, coronal, and sagittal sutures; mark entry point at lateral fontanelle corner 1.5-2.0 cm off midline."),
                ApproachSequentialStep(stepNumber: 2, title: "Perpendicular Ventricular Catheter Puncture", detail: "Direct styletted catheter perpendicular to skull surface into frontal horn of lateral ventricle to depth of 3.0-3.5 cm; confirm clear CSF egress."),
                ApproachSequentialStep(stepNumber: 3, title: "Subgaleal Reservoir Seating & Tunneling", detail: "Tunnel proximal catheter subcutaneously to low-profile Rickham reservoir seated over intact parietal calvarium; secure with non-absorbable ties.")
            ]
        case .plate003:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Craniectomy & Foramen Magnum Unroofing", detail: "Suboccipital craniectomy spanning bilateral cerebellar hemispheres; remove posterior foramen magnum rim and place peripheral dural stay sutures."),
                ApproachSequentialStep(stepNumber: 2, title: "Cisterna Magna Drainage & Tonsillar Elevation", detail: "Sharply incise cisterna magna arachnoid to drain CSF; gently elevate tonsils to expose fourth ventricle floor and vermis under gravity."),
                ApproachSequentialStep(stepNumber: 3, title: "PICA Preservation & Watertight Duraplasty", detail: "Mobilize PICA loops strictly preserving brainstem perforators; close dura with continuous monofilament running suture or expansile patch.")
            ]
        case .plate004:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retromastoid Craniectomy & Dural Reflection", detail: "Perform retrosigmoid craniectomy exposing transverse-sigmoid junction; reflect dura anteriorly toward sigmoid sinus with stay sutures."),
                ApproachSequentialStep(stepNumber: 2, title: "Lateral Cisternal CSF Drainage & CPA Exposure", detail: "Drain lateral cerebellomedullary cistern to relax cerebellum; mobilize bridging petrosal veins carefully and expose trigeminal nerve."),
                ApproachSequentialStep(stepNumber: 3, title: "Neurovascular Mobilization & Acoustic Canal Exposure", detail: "Dissect AICA loops off CN VII/VIII complex; visualize cranial nerves V through XI, ensuring zero stretch on facial nerve fibers.")
            ]
        case .plate005:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Pterional Calvarial Craniotomy (Piece 1)", detail: "Perform frontotemporal craniotomy; elevate pterional calvarial bone flap cleanly, preserving underlying dura under direct visualization."),
                ApproachSequentialStep(stepNumber: 2, title: "Orbitozygomatic Osteotomies (Piece 2)", detail: "Protect periorbita with malleable retractor; perform zygomatic, lateral orbital wall, and orbital roof osteotomies to remove single-piece OZ bar."),
                ApproachSequentialStep(stepNumber: 3, title: "Sphenoid Flattening & Two-Piece Plating", detail: "Flatten residual sphenoid ridge down to meningo-orbital band; upon closure, rigidly fix both pieces with low-profile titanium mini-plates.")
            ]
        case .plate006:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Hockey-Stick Exposure & C1 Hemilaminectomy", detail: "Inverted hockey-stick incision; expose suboccipital bone and C1 arch, unroofing the C1 transverse foramen into an open lateral trough."),
                ApproachSequentialStep(stepNumber: 2, title: "V3 Vertebral Artery Mobilization & Condylectomy", detail: "Mobilize horizontal V3 artery inferiorly with vessel loop; resect posterior 1/3 of occipital condyle with high-speed diamond burr."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & Foramen Magnum Liberation", detail: "Curved dural incision around foramen magnum; expose anterolateral brainstem, PICA origin, and cranial nerve XII without brain retraction.")
            ]
        case .plate007:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Exposure & Flavectomy", detail: "Perform midline lumbosacral exposure; detach paraspinal muscles subperiosteally and resect hypertrophic ligamentum flavum."),
                ApproachSequentialStep(stepNumber: 2, title: "Subarticular Undercutting & SAP Resection", detail: "Undercut the hypertrophic superior articular process with 45-degree Kerrison rongeur, unroofing the lateral recess completely."),
                ApproachSequentialStep(stepNumber: 3, title: "Traversing Root Mobilization & Foraminal Check", detail: "Mobilize traversing nerve root medially; palpate neural foramen with ball-tipped probe to confirm complete multi-planar decompression.")
            ]
        case .plate008:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Pterional Craniotomy & Sphenoid Drilling", detail: "Frontotemporal craniotomy with extensive sphenoid wing osteotomy down to superior orbital fissure, flattening anterior skull base floor."),
                ApproachSequentialStep(stepNumber: 2, title: "Transsylvian Dissection & CSF Drainage", detail: "Sharply split proximal Sylvian fissure; open opticocarotid cistern to drain CSF, exposing prechiasmatic optic nerve and supraclinoid ICA."),
                ApproachSequentialStep(stepNumber: 3, title: "PComA Aneurysm Dissection & Clip Occlusion", detail: "Identify PComA and anterior choroidal artery; dissect aneurysm neck 360 degrees and apply Yasargil spring clip across the neck.")
            ]
        case .plate009:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Opercular Exposure & Arachnoid Tensing", detail: "Expose frontal and temporal opercula under microscope; apply gentle counter-traction with cottonoids and fenestrated suction tip."),
                ApproachSequentialStep(stepNumber: 2, title: "Sharp Sylvian Arachnoid Division", detail: "Divide arachnoid trabeculae sharply with micro-scissors strictly on frontal side of superficial Sylvian veins, mobilizing veins temporally."),
                ApproachSequentialStep(stepNumber: 3, title: "Deep Cisternal Unroofing & Vascular Exposure", detail: "Progress from distal fissure to proximal carotid cistern; open deep arachnoid membranes to expose M1, ICA bifurcation, and optic nerve.")
            ]
        case .plate010:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "3-Pin Fixation in Military Chin-Tuck", detail: "Apply 3-pin Mayfield skull clamp; position neck flexed with 2-finger chin-to-sternum clearance and rotate head 15-20 degrees away."),
                ApproachSequentialStep(stepNumber: 2, title: "Surface Landmark Registration & Incision", detail: "Palpate mastoid tip, external occipital protuberance, and asterion; mark retroauricular curvilinear incision 1 cm medial to asterion."),
                ApproachSequentialStep(stepNumber: 3, title: "Keyhole Burr Hole & Sinus Skeletonization", detail: "Drill initial burr hole 5 mm inferior-medial to asterion; expand craniectomy rim to unroof edges of transverse and sigmoid sinuses.")
            ]
case .plate011:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Diagnostic Annular & Endplate Assessment", detail: "Examine high-resolution axial and sagittal T2 MRI; identify high-intensity zone posterior annular fissure and disc height collapse."),
                ApproachSequentialStep(stepNumber: 2, title: "Subchondral Endplate & Facet Analysis", detail: "Assess subchondral bone sclerosis, Modic inflammatory changes, and hypertrophic facet subarticular narrowing pinching traversing root."),
                ApproachSequentialStep(stepNumber: 3, title: "Surgical Corridor Planning", detail: "Formulate decompression strategy (microdiscectomy vs interbody fusion) depending on segmental instability and mechanical disc collapse.")
            ]
        case .plate012:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Pterional Exposure & Calvarial Elevation", detail: "Elevate frontotemporal bone flap centered over pterion; flatten sphenoid wing down to orbital roof to create flat skull base window."),
                ApproachSequentialStep(stepNumber: 2, title: "Curvilinear Dural Opening & Stay Sutures", detail: "Incise dura in a C-shaped flap hinged on sphenoid ridge; reflect dural margins with stay sutures under constant irrigation."),
                ApproachSequentialStep(stepNumber: 3, title: "Sylvian Fissure Opening & Opercular Dissection", detail: "Under operative microscope, divide arachnoid membranes across the Sylvian cleft, mobilizing superficial veins to open corridor.")
            ]
        case .plate013:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Suboccipital Craniectomy & C1 Laminectomy", detail: "Midline suboccipital exposure; resect 3 cm suboccipital bone rim and posterior C1 arch, exposing thickened fibrous band of foramen magnum."),
                ApproachSequentialStep(stepNumber: 2, title: "Y-Shaped Dural Opening & Tonsillar Release", detail: "Incise dura in a Y-shaped fashion; explore herniated tonsils and verify restored CSF outflow from Fourth ventricle obex under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Watertight Expansile Duraplasty", detail: "Suture triangular pericardial or collagen matrix graft into dural defect with running 5-0 monofilament, reconstituting a spacious cisterna magna.")
            ]
        case .plate014:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Midline Posterior Exposure & C2 Root Retraction", detail: "Midline incision Occiput-C3; expose C1 lateral mass and C2 pedicle, gently mobilizing C2 nerve root and venous plexus with bipolar cautery."),
                ApproachSequentialStep(stepNumber: 2, title: "C1 Lateral Mass & C2 Pedicle Screw Placement", detail: "Insert 3.5 mm polyaxial screws into C1 lateral mass (10-15 deg convergent) and C2 pedicle/pars under biplanar fluoroscopic guidance."),
                ApproachSequentialStep(stepNumber: 3, title: "Rod Linkage, Compression & Arthrodesis", detail: "Contour bilateral titanium rods into screw heads; apply gentle compression to restore atlanto-dental interval, torque set screws, and decorticate.")
            ]
        case .plate015:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Smith-Robinson Approach & Retraction", detail: "Develop interval between trachea/esophagus medially and carotid laterally; elevate longus colli subperiosteally to seat toothed blades safely."),
                ApproachSequentialStep(stepNumber: 2, title: "Complete Discectomy & Foraminotomy", detail: "Evacuate disc space; resect PLL and uncinate process under magnification until exiting nerve root and dura are palpably free past pedicle."),
                ApproachSequentialStep(stepNumber: 3, title: "Lordotic Cage Arthrodesis & Plating", detail: "Insert structural interbody cage recessed 1-2 mm behind anterior cortex; anchor low-profile plate with >= 5 mm clearance from adjacent discs.")
            ]
        case .plate016:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Question-Mark Incision & Zygomatic Flush Craniotomy", detail: "Curvilinear temporal skin incision; elevate temporal bone flap flush to the superior border of the zygomatic arch and middle fossa floor."),
                ApproachSequentialStep(stepNumber: 2, title: "Middle Meningeal Artery Coagulation", detail: "Identify and bipolar coagulate anterior and posterior divisions of MMA along the skull base floor to secure epidural hemostasis."),
                ApproachSequentialStep(stepNumber: 3, title: "Subtemporal Extradural Elevation", detail: "Gently elevate temporal dura extradurally toward foramen spinosum and petrous ridge, identifying and preserving the GSPN.")
            ]
        case .plate017:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Frontotemporal Craniotomy & Sphenoid Resection", detail: "Perform standard frontotemporal calvarial craniotomy; drill sphenoid wing flat down to the superior orbital fissure and meningo-orbital band."),
                ApproachSequentialStep(stepNumber: 2, title: "Meningo-Orbital Band Incision", detail: "Sharply divide meningo-orbital band connecting temporal dura to periorbita; untether dura to expose anterior clinoid and cavernous sinus."),
                ApproachSequentialStep(stepNumber: 3, title: "Sylvian Fissure Exposure & Dural Plating", detail: "Open dura in curvilinear flap across the sphenoid ridge, exposing proximal Sylvian fissure and carotid-optic cisterns.")
            ]
        case .plate018:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Coronal Incision & Bifrontal Calvarial Window", detail: "Bicoronal scalp flap; elevate symmetrical bilateral frontal bone flap crossing midline within 5 mm of supraorbital rims."),
                ApproachSequentialStep(stepNumber: 2, title: "Frontal Sinus Exenteration & Cranialization", detail: "Completely drill away posterior wall of frontal sinuses; exenterate all sinus mucosa, pack nasofrontal ducts, and seal with pericranial flap."),
                ApproachSequentialStep(stepNumber: 3, title: "Superior Sagittal Sinus Ligation & Subfrontal Access", detail: "Ligate and divide rostral sagittal sinus at crista galli; gently retract both frontal lobes to open panoramic subfrontal corridor.")
            ]
        case .plate019:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Horseshoe Scalp Flap & Parietal Craniotomy", detail: "Mark horseshoe scalp incision; perform parietal craniotomy centered behind coronal suture with medial burr holes placed over sagittal sinus."),
                ApproachSequentialStep(stepNumber: 2, title: "Epidural Tack-Up & U-Shaped Dural Opening", detail: "Place peripheral dural stay sutures; incise dura in a U-shaped flap hinged on superior sagittal sinus, preserving bridging cortical veins."),
                ApproachSequentialStep(stepNumber: 3, title: "Cortical Mapping & Transsulcal Approach", detail: "Map somatosensory cortex and vein of Trolard; enter chosen cortical sulcus under microscope to access subcortical pathology.")
            ]
        case .plate020:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retromastoid Incision & Burr Hole Placement", detail: "Retroauricular curvilinear incision; drill initial burr hole 5 mm inferior-medial to asterion, exposing posterior fossa dura safely."),
                ApproachSequentialStep(stepNumber: 2, title: "Sinus Skeletonization & Keyhole Resection", detail: "Expand craniectomy with Kerrison rongeurs to unroof inferior edge of transverse sinus and posterior edge of sigmoid sinus."),
                ApproachSequentialStep(stepNumber: 3, title: "Mastoid Air Cell Waxing & Dural Opening", detail: "Copiously pack all unroofed mastoid air cells with bone wax; open dura parallel to sigmoid sinus with stay sutures directed anteriorly.")
            ]
case .plate021:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Trauma Question-Mark Scalp Incision", detail: "Make large reverse question-mark incision; elevate full-thickness myocutaneous scalp flap, exposing frontal, temporal, and parietal calvarium."),
                ApproachSequentialStep(stepNumber: 2, title: "Frontotemporoparietal Craniectomy", detail: "Drill craniectomy >= 12x15 cm crossing pterion; drill temporal bone flush to middle cranial fossa floor and zygomatic root to unroof uncus."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & Expansile Patch Duroplasty", detail: "Open dura widely in stellate fashion; place circumferential tack-up sutures and suture expansive collagen/pericranial patch watertight.")
            ]
        case .plate022:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Torcular Craniectomy", detail: "Position sitting or concord; perform suboccipital craniectomy exposing bilateral cerebellar hemispheres and transverse sinus/torcula."),
                ApproachSequentialStep(stepNumber: 2, title: "Supracerebellar Cisternal Dissection", detail: "Incise dura; gravity lowers cerebellum, opening the avascular corridor between dorsal vermis and tentorium directly to quadrigeminal cistern."),
                ApproachSequentialStep(stepNumber: 3, title: "Arachnoid Release & Tumor Resection", detail: "Release thick arachnoid of quadrigeminal cistern; dissect tumor off tectal plate and internal cerebral veins under direct microscopic vision.")
            ]
        case .plate023:
            return []
        case .plate024:
            return []
        case .plate025:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Question-Mark Flap & Pterional Craniotomy", detail: "Curvilinear temporal incision; perform frontotemporal craniotomy flush to middle fossa floor, exposing anterior and middle temporal gyri."),
                ApproachSequentialStep(stepNumber: 2, title: "Anterior Neocortical Resection Limit", detail: "Resect anterior temporal lobe neocortex measuring strictly <= 3.5 cm in dominant hemisphere or <= 4.5 cm in non-dominant hemisphere."),
                ApproachSequentialStep(stepNumber: 3, title: "Mesial Temporal Resection (Amygdala & Hippocampus)", detail: "Open temporal horn; perform subpial resection of uncus, amygdala, and anterior 2.5 cm of hippocampus, verifying intact choroidal fissure.")
            ]
        case .plate026:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterolateral Incision & Rib Resection", detail: "Curvilinear paramedian incision; resect medial 3-4 cm of rib head and transverse process, unroofing the extrapleural corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Extrapleural Mobilization & Corpectomy", detail: "Gently sweep parietal pleura ventrally; perform corpectomy through posterolateral window, decompressing the thecal sac circumferentially."),
                ApproachSequentialStep(stepNumber: 3, title: "Expandable Cage & Posterior Neutralization", detail: "Deploy expandable titanium cage anteriorly; lock posterior bilateral pedicle screw construct spanning two segments above and below.")
            ]
        case .plate027:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Neuronavigation Registration & Sulcal Planning", detail: "Register stereotactic navigation; plan transsulcal parafascicular trajectory parallel to corticospinal tracts into the long axis of the ICH."),
                ApproachSequentialStep(stepNumber: 2, title: "Craniotomy & Cannula Introduction", detail: "Perform 3 cm mini-craniotomy; introduce transparent BrainPath cannula along chosen sulcus into hematoma under stereotactic guidance."),
                ApproachSequentialStep(stepNumber: 3, title: "Illuminated Evacuation & Cavity Hemostasis", detail: "Evacuate hematoma under microscope/exoscope vision with micro-suction; achieve cavity wall hemostasis and withdraw port under visualization.")
            ]
        case .plate028:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Right Lateral Decubitus & Retractor Docking", detail: "Position true right lateral decubitus; make flank incision, sweep retroperitoneum anteriorly, and split anterior 1/3 of psoas under directional EMG."),
                ApproachSequentialStep(stepNumber: 2, title: "Complete Transverse Discectomy", detail: "Dock orthogonal retractor; perform complete discectomy across transverse axis of disc space with complete contralateral annular release."),
                ApproachSequentialStep(stepNumber: 3, title: "Wide Interbody Cage Arthrodesis", detail: "Insert wide-footprint lordotic porous titanium cage spanning bilateral cortical ring apophyses, verifying indirect decompression under fluoroscopy.")
            ]
        case .plate029:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Exposure & Pedicle Screw Placement", detail: "Midline lumbar exposure; place bilateral pedicle screws at index levels and expose unilateral facet joint complex."),
                ApproachSequentialStep(stepNumber: 2, title: "Unilateral Facetectomy & Kambin Decompression", detail: "Perform complete unilateral facetectomy to expose Kambin's triangle; mobilize traversing root medially and exiting root cranially."),
                ApproachSequentialStep(stepNumber: 3, title: "Discectomy, Curved Cage Insertion & Compression", detail: "Evacuate disc; pack anterior autograft, insert curved lordotic cage transforaminally, and apply posterior compression across rods.")
            ]
        case .plate030:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Nasal Phase & Sphenoidotomy", detail: "Binostril endoscopic approach; resect posterior septum and vomer, and perform wide anterior sphenoidotomy exposing the sellar floor."),
                ApproachSequentialStep(stepNumber: 2, title: "Sellar Unroofing & Micro-Doppler Check", detail: "Thin and resect sellar bone between carotid prominences; verify carotid locations with micro-Doppler probe and incise dura in cruciform shape."),
                ApproachSequentialStep(stepNumber: 3, title: "Adenoma Resection & Skull Base Reconstruction", detail: "Resect adenoma with ring curettes until optic chiasm descends; reconstruct sellar floor with mucosal nasoseptal flap if CSF leak occurs.")
            ]
case .plate031:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Subperiosteal Exposure", detail: "Midline exposure of C6 through T2 posterior elements with lateral subperiosteal dissection to facet borders."),
                ApproachSequentialStep(stepNumber: 2, title: "Laminectomy & Foraminotomy", detail: "High-speed burr troughs along medial aspect of lateral masses, elevating C7-T1 laminas and completing C8 foraminotomy."),
                ApproachSequentialStep(stepNumber: 3, title: "Instrumented Stabilization", detail: "Placement of lateral mass and pedicle screws connected via contoured rods across cervicothoracic junction.")
            ]
        case .plate032:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Vector Alignment & Retroperitoneal Access", detail: "Establish targeted anatomical corridor (anterior, oblique, or transpsoas) with neuromonitoring and vessel mobilization."),
                ApproachSequentialStep(stepNumber: 2, title: "Comprehensive Disc Resection & Prep", detail: "Complete annulotomy, disc clearance, and thorough endplate preparation preserving dense subchondral bone."),
                ApproachSequentialStep(stepNumber: 3, title: "Interbody Reconstruction & Crown", detail: "Deploy lordotic interbody spacer packed with biologics spanning apophyseal rings, supplemented by posterior fixation.")
            ]
        case .plate033:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Superciliary Incision & Burr Hole", detail: "Curvilinear incision through eyebrow lateral to supraorbital notch; placement of burr hole at MacCarty's keypoint."),
                ApproachSequentialStep(stepNumber: 2, title: "Basal Mini-Craniotomy", detail: "Perform ~20x15 mm osteotomy flush with orbital roof; flatten inner orbital rim with diamond burr for flat trajectory."),
                ApproachSequentialStep(stepNumber: 3, title: "Dural Opening & Cisternal Release", detail: "Open dura in C-shape based toward orbit; release CSF from optico-carotid cisterns to achieve brain relaxation without fixed retractors.")
            ]
        case .plate034:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Emergent Neurological & Radiographic Triage", detail: "Assess ASIA neurological status; obtain emergent MRI to rule out retropulsed herniated disc before attempting reduction."),
                ApproachSequentialStep(stepNumber: 2, title: "Closed Cranial Traction vs. Open Reduction", detail: "Perform cautious awake serial Gardner-Wells tong traction; if disc herniation is present, proceed to emergent anterior discectomy first."),
                ApproachSequentialStep(stepNumber: 3, title: "360° Realignment & Instrumented Fusion", detail: "Complete reduction of locked facets, anterior cervical decompression/fusion (ACDF), and posterior stabilization if PLC is grossly torn.")
            ]
        case .plate035:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Classification & Risk Stratification", detail: "Classify fracture on thin-cut CT; evaluate age (>50y), fracture gap (>1mm), translation (>5mm), and angulation (>10°)."),
                ApproachSequentialStep(stepNumber: 2, title: "Approach Selection (Anterior vs. Posterior)", detail: "Select anterior screw for acute Type II with intact transverse ligament; select posterior C1-C2 fusion for comminution, osteopenia, or nonunion."),
                ApproachSequentialStep(stepNumber: 3, title: "Surgical Fixation & Alignment", detail: "Execute bicortical lag screw fixation under dual biplanar fluoroscopy or Harms posterior instrumented polyaxial screw-rod construction.")
            ]
        case .plate036:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Canal Decompression & Indirect Reduction", detail: "Ligamentotaxis via intraoperative distraction and lordosis restoring vertebral height and pulling retropulsed fragments from canal."),
                ApproachSequentialStep(stepNumber: 2, title: "Direct Decompression (if needed)", detail: "Perform transpedicular or posterolateral decompression if ligamentotaxis fails to relieve high-grade neurological deficits."),
                ApproachSequentialStep(stepNumber: 3, title: "Multi-Segment Posterior Instrumentation", detail: "Place pedicle screws two levels above and two below the fracture, or include index vertebra fracture screws to resist kyphotic collapse.")
            ]
        case .plate037:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Emergent Decompressive Laminotomy", detail: "Wide bilateral laminotomies or midline laminectomy with undercut medial facetectomies to visualize dural margins."),
                ApproachSequentialStep(stepNumber: 2, title: "Gentle Neural Mobilization", detail: "Carefully mobilize the tightly compressed, edematous thecal sac without excessive retraction to identify the sequestrum shoulder."),
                ApproachSequentialStep(stepNumber: 3, title: "Fragment Extraction & Disc Clearance", detail: "Extract massive extruded fragment using pituitaries and nerve hooks; thoroughly irrigate and inspect subligamentous space.")
            ]
        case .plate038:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Oncologic Separation Surgery", detail: "Perform circumferential epidural decompression removing 2-3 mm of tumor from thecal sac to create a safe margin for stereotactic radiosurgery (SRS)."),
                ApproachSequentialStep(stepNumber: 2, title: "Transpedicular / Posterolateral Decompression", detail: "Unroof spinal canal via laminectomy and transpedicular approach to access retrovertebral epidural disease."),
                ApproachSequentialStep(stepNumber: 3, title: "Rigid Multi-Segment Instrumented Fixation", detail: "Place cement-augmented or standard pedicle screws two levels above and below the osteolytic level to restore spinal stability (SINS).")
            ]
        case .plate039:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Exposure & Fistula Tracking", detail: "Re-open prior incision under loupe/microscope magnification; trace fluid tract through fascia down to the exact dural defect."),
                ApproachSequentialStep(stepNumber: 2, title: "Fistula Debridement & Primary Closure", detail: "Free adhesions from nerve rootlets; execute primary watertight running locked 4-0 or 5-0 monofilament suture repair."),
                ApproachSequentialStep(stepNumber: 3, title: "Multilayer Patching & Dead Space Closure", detail: "Apply collagen onlay patch, cover with PEG or fibrin hydrogel sealant, and perform watertight myofascial layered closure over subfascial drain.")
            ]
        case .plate040:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Emergent EVD & ICP Control", detail: "Place right Kocher's point external ventricular drain (EVD) to relieve acute hydrocephalus and monitor ICP before definitive securing."),
                ApproachSequentialStep(stepNumber: 2, title: "Aneurysm Morphology Assessment & Securing", detail: "Perform emergent CTA / catheter DSA; secure ruptured aneurysm via endovascular coiling/flow diversion or pterional microsurgical clipping."),
                ApproachSequentialStep(stepNumber: 3, title: "Triple-H Prophylaxis & Vasospasm Surveillance", detail: "Maintain euvolemia, normotension, and initiate nimodipine; monitor with daily transcranial Doppler (TCD) for delayed cerebral ischemia (DCI).")
            ]
        case .plate041:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Aggressive BP Lowering & Coagulopathy Reversal", detail: "Rapidly target SBP 130-140 mmHg with IV nicardipine/labetalol; immediately reverse anticoagulation (PCC for warfarin, andexanet/idarucizumab for DOACs)."),
                ApproachSequentialStep(stepNumber: 2, title: "External Ventricular Drainage & Clot Clearance", detail: "Place stereotactic EVD into lateral ventricle; consider intraventricular thrombolysis (alteplase/tPA) to accelerate blood clearance (CLEAR-IVH trial)."),
                ApproachSequentialStep(stepNumber: 3, title: "Minimally Invasive ICH Evacuation (MIS)", detail: "Perform tubular retractor or stereotactic endoscopic hematoma aspiration (ENRICH trial protocol) for select ganglionic/lobar hemorrhages.")
            ]
        case .plate042:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Corridor Selection (Anterior vs. Posterior)", detail: "Evaluate sagittal alignment; lordotic alignment allows posterior laminoplasty/laminectomy; kyphotic alignment requires anterior corpectomy/discectomy."),
                ApproachSequentialStep(stepNumber: 2, title: "Circumferential Decompression", detail: "Perform multilevel anterior decompression or posterior open-door laminoplasty (Hirabayashi) maintaining canal width >14 mm."),
                ApproachSequentialStep(stepNumber: 3, title: "Reconstruction & Sagittal Alignment", detail: "Re-establish cervical lordosis via lordotic cages and plate instrumentation, or posterior lateral mass screw-rod fixation.")
            ]
        case .plate043:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Acute Phase (< 1–2 Weeks)", detail: "Soft cervical collar, strict bed rest, analgesia, NSAIDs, and muscle relaxants (diazepam). >80% spontaneous resolution rate."),
                ApproachSequentialStep(stepNumber: 2, title: "Subacute Phase (2–4 Weeks)", detail: "Inpatient continuous cervical halter traction (5–7 lbs) with mild neck extension until reduction confirmed on lateral C-spine. Rigid collar / Minerva brace for 4–6 weeks."),
                ApproachSequentialStep(stepNumber: 3, title: "Chronic (> 1 Month) / Failed Traction", detail: "Halo-gravity traction under conscious sedation with fluoroscopic monitoring. If reduction achieved, immobilize in Halo vest for 8–12 weeks."),
                ApproachSequentialStep(stepNumber: 4, title: "Surgical Goel-Harms Fusion (Refractory/Type III–IV)", detail: "Posterior C1–C2 instrumental fusion (C1 lateral mass and C2 pedicle/pars screws) indicated for irreducible deformity, recurrence, neurologic deficit, or Fielding Type III/IV (AADI > 5 mm).")
            ]
        case .plate044:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Type I: Conservative Immobilization", detail: "Rigid cervical collar (Miami J or Aspen) for 8–12 weeks with serial upright lateral radiographs. High union rate (>95%)."),
                ApproachSequentialStep(stepNumber: 2, title: "Type II: Closed Reduction & Halo", detail: "Inpatient closed cervical traction reduction (5–10 lbs) under fluoroscopy until alignment restored, then immobilization in Halo vest for 12 weeks. ACDF if unstable."),
                ApproachSequentialStep(stepNumber: 3, title: "Type IIA: Extension Reduction (NO TRACTION)", detail: "Cervical traction is strictly CONTRAINDICATED. Perform gentle closed reduction in neck extension without traction under fluoroscopy, then Halo vest or anterior C2–C3 ACDF."),
                ApproachSequentialStep(stepNumber: 4, title: "Type III: Open Reduction & Instrumented Fusion", detail: "Urgent open posterior reduction of locked C2–C3 facets via midline corridor, followed by C2–C3 posterior instrumentation/fusion (C2 pedicle/pars screws to C3 lateral mass) ± anterior C2–C3 ACDF.")
            ]
        case .plate045:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Hyperosmolar Resuscitation", detail: "Immediate IV bolus of 3% Hypertonic Saline (250–500 mL over 15 min) or 20% Mannitol (1 g/kg IV) to re-establish osmotic pressure gradient and reduce brain volume."),
                ApproachSequentialStep(stepNumber: 2, title: "Temporizing Hyperventilation Bridge", detail: "Brief controlled mechanical hyperventilation targeting PaCO2 30–35 mmHg to induce cerebral vasoconstriction. Strictly a temporizing bridge to immediate surgical theater."),
                ApproachSequentialStep(stepNumber: 3, title: "Ventricular Drainage (EVD)", detail: "Immediate placement of external ventricular drain (EVD) at Kocher's point if acute obstructive hydrocephalus is present to release supratentorial CSF pressure."),
                ApproachSequentialStep(stepNumber: 4, title: "Emergent Decompressive Surgery", detail: "Immediate craniotomy/craniectomy to evacuate mass lesion (EDH/SDH/ICH) or wide Decompressive Hemicraniectomy with expansile duraplasty. Suboccipital craniectomy for tonsillar herniation.")
            ]
        case .plate046:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Neuromonitoring & Prone Positioning", detail: "Continuous intraoperative SSEP, MEP, and multichannel electromyography (anal sphincter, bilateral lower extremity motor roots). Avoid muscle relaxants after intubation."),
                ApproachSequentialStep(stepNumber: 2, title: "Normal-to-Abnormal Surgical Exposure", detail: "Expose normal rostral lamina one level above the defect. Perform laminotomy/laminectomy in pristine anatomy to identify normal dura and conus before tracing into the dysraphic zone."),
                ApproachSequentialStep(stepNumber: 3, title: "Microsurgical Untethering & Placode Preservation", detail: "For filar lipoma: bipolar and transect the filum below the conus. For lipomyelomeningocele: subtotal lipoma debulking, untethering placode from dura without invading cord parenchyma, and soft-tissue placode tubulation."),
                ApproachSequentialStep(stepNumber: 4, title: "Expansile Watertight Duraplasty & Flap Closure", detail: "Perform wide, tension-free expansile duraplasty (pericranial/collagen graft) to provide a spacious CSF reservoir that prevents retethering. Layered myofascial and fasciocutaneous closure.")
            ]
        case .plate047:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Awake Fiberoptic Intubation & Neutral Positioning", detail: "Perform awake fiberoptic intubation strictly maintaining neutral cervical alignment; avoid any neck extension which can precipitate fatal cervicomedullary compression. Secure Mayfield pin headrest and confirm baseline MEP/SSEP signals."),
                ApproachSequentialStep(stepNumber: 2, title: "C1-C2 Posterior Exposure & Venous Hemostasis", detail: "Midline suboccipital-to-C3 exposure. Cautiously skeletonize C1 posterior arch and lateral masses, controlling profuse bleeding from the peri-ganglionic C1-C2 venous plexus with bipolar cautery, thrombin-soaked gelfoam, and cottonoid compression."),
                ApproachSequentialStep(stepNumber: 3, title: "Goel-Harms Screw Instrumentation", detail: "Under fluoroscopic guidance, place bilateral C1 lateral mass screws (entry at center of posterior C1 lateral mass, directed 10-15° cephalad and slightly convergent). Place C2 pedicle screws (or pars screws if high-riding vertebral artery present). Connect with contoured titanium rods."),
                ApproachSequentialStep(stepNumber: 4, title: "Posterior Decortication & Arthrodesis", detail: "Thoroughly decorticate the posterior arch of C1, superior lamina of C2, and C1-C2 facet joints. Pack morselized autologous bone graft across the decorticated bed. Close in anatomical layers. Do NOT attempt anterior mass resection.")
            ]
        case .plate048:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Spinal DSA Localization & Hemilaminectomy", detail: "Preoperative catheter spinal DSA maps the exact intercostal/lumbar feeding pedicle. Prone positioning under general anesthesia without systemic hypotension. Perform a targeted unilateral hemilaminectomy / laminotomy at the fistula level."),
                ApproachSequentialStep(stepNumber: 2, title: "Dural Opening & Microvascular Exposure", detail: "Perform a paramedian linear dural incision over the lateral margin of the cord and nerve root sleeve. Place fine silk dural stay sutures. Identify the arterialized red serpentine coronal veins and the bridging vein entering the dural cuff."),
                ApproachSequentialStep(stepNumber: 3, title: "ICG Videoangiography Confirmation", detail: "Administer IV Indocyanine Green (ICG). High-magnification microscope videoangiography confirms early arterial transit through the dural feeder into the bridging vein, confirming the exact fistula point before cord parenchymal filling."),
                ApproachSequentialStep(stepNumber: 4, title: "Micro-Clip Application & Vessel Division", detail: "Apply a permanent titanium aneurysm micro-clip across the arterialized bridging vein flush against the inner dural layer. Bipolar coagulate and sharply transect the vein between the clip and dura. Confirm immediate collapse and darkening of coronal veins.")
            ]
        case .plate049:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Diagnostic Imaging & Rule of Spence Measurement", detail: "Obtain thin-cut cervical CT with coronal reconstructions and open-mouth radiograph. Measure combined bilateral overhang of C1 lateral masses over C2 (Rule of Spence). Perform MRI to evaluate mid-substance vs. avulsive TAL tear (Dickman classification)."),
                ApproachSequentialStep(stepNumber: 2, title: "Conservative Protocol for Stable Burst (< 6.9 mm)", detail: "For isolated C1 burst fractures with intact TAL (overhang < 6.9 mm), immobilize in a rigid cervical orthosis (Miami J) or Halo vest for 8–12 weeks with dynamic flexion-extension radiographs at completion to verify stability."),
                ApproachSequentialStep(stepNumber: 3, title: "Closed Halo-Gravity Traction Reduction", detail: "For unstable burst fractures with splayed lateral masses (overhang ≥ 7.0 mm), apply Gardner-Wells tongs or Halo traction under serial fluoroscopic guidance to pull the splayed lateral masses back inward and restore articular alignment."),
                ApproachSequentialStep(stepNumber: 4, title: "Posterior C1–C2 Instrumented Arthrodesis (Goel-Harms)", detail: "Perform posterior C1–C2 instrumentation using bilateral C1 lateral mass screws and C2 pedicle/pars screws connected with longitudinal titanium rods. Decorticate C1 posterior elements and C2 lamina, placing autologous morselized bone graft for permanent arthrodesis.")
            ]

        case .plate050:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Preoperative Multimodal Planning & K-Line Assessment", detail: "Evaluate sagittal bone CT and T2 MRI. Measure Canal Occupying Ratio (COR) and draw the K-line (mid-canal C2 to C7). If COR > 60% or K-line is negative, plan direct anterior corpectomy (ACCF) or 360° circumspinal reconstruction rather than posterior laminoplasty alone."),
                ApproachSequentialStep(stepNumber: 2, title: "Anterior Exposure & Multilevel Corpectomy (Smith-Robinson)", detail: "Transverse or longitudinal skin crease incision along medial border of SCM. Dissect through pretracheal fascia between carotid sheath laterally and trachea/esophagus medially. Perform discectomies above and below the ossified bodies (e.g. C3–C5). Use high-speed diamond burr under microscopic magnification to resect the anterior vertebral bodies."),
                ApproachSequentialStep(stepNumber: 3, title: "The OPLL 'Floating' Technique (Preserving Ossified Dura)", detail: "Thin the dense retrovertebral OPLL mass with a 2–3 mm diamond burr under copious irrigation until it becomes paper-thin and translucent. Using micro-curettes or diamond burr, isolate the lateral boundaries of the OPLL. Allow the floating ossified island to pulsate and drift anteriorly on the intact ventral dura without aggressively peeling it off."),
                ApproachSequentialStep(stepNumber: 4, title: "Titanium Mesh Cage & 360° Posterior Instrumentation", detail: "Measure and contour a vertical titanium mesh cage packed with autologous cancellous bone graft. Seat securely into the corpectomy trough and secure with an anterior cervical plate. For multi-level corpectomies (≥2 levels) or poor bone quality, perform posterior lateral mass screw-rod fixation (C3–C6) to prevent cage dislodgement and achieve 100% fusion.")
            ]

        case .plate051:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Transradial / Transfemoral Access & Diagnostic Run", detail: "Obtain vascular access, advance 6F guide catheter into external carotid artery, and obtain high-resolution diagnostic MMA angiography."),
                ApproachSequentialStep(stepNumber: 2, title: "Superselective Microcatheter Navigation", detail: "Navigate microcatheter over 0.014-inch microwire into anterior and posterior divisions of MMA distal to petrosal branch."),
                ApproachSequentialStep(stepNumber: 3, title: "Liquid Embolic Infusion & Membrane Penetration", detail: "Infuse liquid embolic or microparticles under continuous roadmap fluoroscopy until complete penetration of neovascular outer membrane.")
            ]

        case .plate090:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Diagnostic Ultrasound/MRI & Surface Mapping", detail: "Confirm carpal tunnel compression (median nerve CSA > 10 mm²). Map Kaplan's cardinal line from the first web space to the hook of the hamate and draw the longitudinal axis of the fourth ray (ring finger axis)."),
                ApproachSequentialStep(stepNumber: 2, title: "Palmar Incision & Subcutaneous Hemostasis", detail: "Make a 2.5–3.0 cm longitudinal incision along the ulnar axis of the fourth ray, starting distal to the distal wrist crease and ending 5 mm proximal to Kaplan's line. Cauterize superficial venous bleeders with fine bipolar forceps."),
                ApproachSequentialStep(stepNumber: 3, title: "Ulnar-Sided Division of Transverse Carpal Ligament", detail: "Divide the palmar fascia and identify the distal border of the transverse carpal ligament. Using a blunt probe or elevator, divide the ligament strictly along its ulnar border in line with the fourth ray, widely separating cut edges."),
                ApproachSequentialStep(stepNumber: 4, title: "Distal Fat Pad Exposure & Superficial Arch Protection", detail: "Extend the ligament release distally until the glistening yellow Distal Palmar Fat Pad is completely uncovered. Directly visualize and protect the superficial palmar arterial arch resting just distal to the fat pad."),
                ApproachSequentialStep(stepNumber: 5, title: "Proximal Antebrachial Fascia Release & Closure", detail: "Under direct vision with a lighted retractor or Senn retractor, divide the distal antebrachial fascia across the wrist flexion crease. Inspect the median nerve and radial recurrent motor branch; close skin with interrupted nylon eversion sutures.")
            ]


        case .plate091:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Smith-Robinson Approach & Discectomies", detail: "Develop anteromedial fascial corridor; perform complete discectomies at C5-C6 and C6-C7 back to PLL under microscopic visualization."),
                ApproachSequentialStep(stepNumber: 2, title: "C6 Corpectomy & Dural Decompression", detail: "Burr C6 vertebral body down between uncinate processes; thin posterior cortex to eggshell and resect PLL to completely free thecal sac."),
                ApproachSequentialStep(stepNumber: 3, title: "Expandable Cage & Anterior Plating", detail: "Seat and expand structural titanium corpectomy cage into endplates; secure bridging plate with locking screws maintaining >= 5 mm disc clearance.")
            ]
        case .plate092:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Medial Arm Corridor & Vessel Mobilization", detail: "Make 8-10 cm longitudinal incision along medial bicipital groove; mobilize basilic vein and brachial artery to expose median, ulnar, and musculocutaneous nerves."),
                ApproachSequentialStep(stepNumber: 2, title: "Motor Branch Neurolysis & Fascicular Mapping", detail: "Dissect biceps and brachialis motor branches back to musculocutaneous trunk; map ulnar and median fascicles with bipolar stimulator to identify FCU/FCR donors."),
                ApproachSequentialStep(stepNumber: 3, title: "Microsurgical Double Coaptation", detail: "Perform tension-free direct end-to-end epineurial coaptation of ulnar-to-biceps (Oberlin I) and median-to-brachialis (Oberlin II) with 9-0 nylon and fibrin glue.")
            ]
        case .plate093:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Arterial Access & BGC Placement", detail: "Obtain femoral or radial artery access; navigate 8F balloon guide catheter into cervical internal carotid artery under fluoroscopic guidance."),
                ApproachSequentialStep(stepNumber: 2, title: "Microcatheter Traversal & Stent Deployment", detail: "Track microcatheter across M1 occlusion; deploy self-expanding nitinol stent-retriever across thrombus and allow 3-5 minutes for clot integration."),
                ApproachSequentialStep(stepNumber: 3, title: "Flow Arrest, Aspiration & Retrieval", detail: "Inflate cervical ICA balloon, apply vigorous continuous syringe/pump aspiration, and withdraw stent-retriever and intermediate catheter en bloc.")
            ]
        case .plate094:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Fluoroscopic Localization & Hemilaminotomy", detail: "Midline incision T9-T10; unroof 10-12 mm inferior lamina border under AP fluoroscopy, strictly preserving midline ligaments."),
                ApproachSequentialStep(stepNumber: 2, title: "Epidural Paddle Lead Advancement", detail: "Gently advance directional 16-contact paddle cephalad in dorsal epidural space under continuous tactile and fluoroscopic feedback."),
                ApproachSequentialStep(stepNumber: 3, title: "Silicone Anchoring & Gluteal Tunneling", detail: "Anchor silicone sleeve securely to deep supraspinous fascia; tunnel lead subcutaneously to upper gluteal pocket and connect to IPG.")
            ]
        case .plate095:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Circumferential Junctional Dissection", detail: "Incise transitional zone between dysplastic epithelium and neural placode under microscope, freeing neural tissue completely."),
                ApproachSequentialStep(stepNumber: 2, title: "Pial Reconstruction & Cord Untethering", detail: "Approximate lateral pial margins with fine 7-0 monofilament sutures, tubularizing placode into a cylindrical neural tube."),
                ApproachSequentialStep(stepNumber: 3, title: "Watertight Dural & Myofascial Closure", detail: "Mobilize lateral dural leaflets for running 5-0 closure; advance bilateral lumbodorsal fascia flaps for tension-free coverage.")
            ]
        case .plate096:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Corridor Selection & Patient Positioning", detail: "Select optimal cranial, spinal, or peripheral vector based on 3D pathology localization, minimizing neural retraction."),
                ApproachSequentialStep(stepNumber: 2, title: "Osteological Exposure & Cisternal Decompression", detail: "Execute tailored osteotomies and drain CSF cisterns to maximize operative window and spontaneous brain relaxation."),
                ApproachSequentialStep(stepNumber: 3, title: "Target Microsurgery & Construct Realignment", detail: "Complete lesion resection, microvascular reconstruction, or multi-column spinal stabilization with neuromonitoring.")
            ]
        case .plate097:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Patient Positioning & Biplanar Fluoroscopy", detail: "Position supine with radiolucent bite block; obtain biplanar fluoroscopy confirming anatomical reduction of the displaced odontoid fracture."),
                ApproachSequentialStep(stepNumber: 2, title: "Low Anteromedial Retropharyngeal Exposure", detail: "Make transverse skin incision at C5-C6; develop Smith-Robinson plane, tunneling retropharyngeally to dock drill sleeve at anterior-inferior C2 lip."),
                ApproachSequentialStep(stepNumber: 3, title: "Guide Wire Insertion & Lag Screw Fixation", detail: "Drive threaded guide wire into odontoid apex; advance 4.0 mm partially threaded cannulated lag screw to achieve dense apical compression.")
            ]
        case .plate098:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Smith-Robinson Corridor & Distraction", detail: "Develop anteromedial corridor; anchor parallel distraction pins to restore disc height without inducing lordotic tipping."),
                ApproachSequentialStep(stepNumber: 2, title: "Complete Discectomy & Foraminal Release", detail: "Evacuate disc to posterior margins; resect PLL and uncovertebral spurs until thecal sac and nerve roots pulsate freely."),
                ApproachSequentialStep(stepNumber: 3, title: "Endplate Milling & Prosthesis Implantation", detail: "Mill midline keel slot under fluoroscopy; insert mobile-bearing artificial disc recessed 1-2 mm behind anterior rim.")
            ]
        case .plate099:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Exposure & Cervicothoracic Fixation", detail: "Position prone with skull tongs; expose C2 to T5 and place bilateral cervical lateral mass screws and upper thoracic pedicle screws."),
                ApproachSequentialStep(stepNumber: 2, title: "C7 Laminectomy & Transpedicular Wedge", detail: "Resect C7 posterior arch; mobilize bilateral C8 roots and resect symmetrical wedge through C7 pedicles and lateral vertebral body."),
                ApproachSequentialStep(stepNumber: 3, title: "Controlled Extension Closure & Multi-Rod Lock", detail: "Extend cervical spine under continuous neuromonitoring to close osteotomy; lock primary and accessory outrigger rods.")
            ]
        case .plate100:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Lateral Decubitus Positioning & Incision", detail: "Secure patient in 90° right lateral decubitus; make oblique 4 cm incision between ASIS and umbilicus, traversing retroperitoneum."),
                ApproachSequentialStep(stepNumber: 2, title: "Retroperitoneal ATP Retractor Docking", detail: "Mobilize peritoneal sac anteriorly; dock dual-blade retractor between anterior border of psoas and left common iliac vascular sheath."),
                ApproachSequentialStep(stepNumber: 3, title: "Discectomy & Lordotic Cage Implantation", detail: "Perform complete discectomy with contralateral annular release; orthogonalize and seat wide-footprint lordotic cage across ring apophyses.")
            ]
        case .plate101:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Positioning & Fluoroscopic Targeting", detail: "Position prone with extended hips; obtain true orthogonal AP and lateral views to mark lateral retroperitoneal corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Retroperitoneal Transpsoas Traversal", detail: "Make flank incision, gently traverse retroperitoneum, and split anterior-third psoas with neuro-monitoring guidance."),
                ApproachSequentialStep(stepNumber: 3, title: "Interbody Placement & Posterior Fixation", detail: "Expand orthogonal retractor, perform complete discectomy, insert wide-footprint cage, and place bilateral percutaneous screws.")
            ]
        case .plate102:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Exposure & Temporary Stabilizing Rod", detail: "Instrument 3-4 segments above and below apex; lock unilateral temporary rod before any osteotomy to prevent sudden shear translation."),
                ApproachSequentialStep(stepNumber: 2, title: "Laminectomy, Root Ligation & Corpectomy", detail: "Resect posterior arch; ligate thoracic nerve roots to work bilaterally, resecting apical vertebral body down to bleeding endplates."),
                ApproachSequentialStep(stepNumber: 3, title: "Expandable Cage & Quad-Rod Neutralization", detail: "Deploy expandable titanium cage anteriorly; apply controlled posterior compression to correct kyphosis and lock quad-rod construct.")
            ]
        case .plate103:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Exposure & Costotransversectomy", detail: "Midline incision T6-T10; resect 3-4 cm medial 8th rib head and T8 transverse process, entering the extrapleural plane with moist cottonoids."),
                ApproachSequentialStep(stepNumber: 2, title: "T8 Corpectomy & 360° Cord Decompression", detail: "Sweep pleura ventrally; perform complete corpectomy between T7 and T9 endplates to circumferentially decompress the thoracic thecal sac."),
                ApproachSequentialStep(stepNumber: 3, title: "Expandable Cage & Multi-Segment Fixation", detail: "Deploy expandable titanium cage anteriorly under fluoroscopy; lock bilateral pedicle screw construct spanning T6-T7 to T9-T10.")
            ]
        case .plate104:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Cranial Exposure & Hardware Inspection", detail: "Extend midline incision to T1-T2; expose proximal ends of existing rods, inspect for screw loosening, and prepare upper thoracic pedicles."),
                ApproachSequentialStep(stepNumber: 2, title: "Domino Coupling & Thoracic Fixation", detail: "Lock heavy-duty axial domino connectors to existing rods; insert bilateral thoracic pedicle screws extending cranially to T2."),
                ApproachSequentialStep(stepNumber: 3, title: "Multi-Rod Bridging & Alignment Restoration", detail: "Contour extension rods into balanced thoracic kyphosis; bridge accessory outriggers across domino junctions and verify sagittal balance under fluoroscopy.")
            ]
        case .plate105:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Laminectomy & Extradural Exposure", detail: "Expose one level above and below the bony septum; perform laminectomy, gently shielding bilateral dural sleeves under moist cottonoids."),
                ApproachSequentialStep(stepNumber: 2, title: "Diamond Burr Extradural Resection", detail: "Drill the central osseous spur extradurally down flush with the posterior vertebral body cortex under constant chilled saline irrigation."),
                ApproachSequentialStep(stepNumber: 3, title: "Inner Dural Excision & Single-Sac Closure", detail: "Sharply excise the inner medial dural cuffs lining the spur; perform running 5-0 monofilament duraplasty to unite both hemicords in a single sac.")
            ]
        case .plate106:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Tri-Planar Fluoroscopy Calibration", detail: "Position prone on radiolucent frame; calibrate true lateral sacrum, pelvic inlet (sacral canal), and pelvic outlet (sacral foramina)."),
                ApproachSequentialStep(stepNumber: 2, title: "Lateral Gluteal Docking & Pin Traversal", detail: "Make 3 cm incision over lateral gluteal region; dock guide pin through ilium across SI joint into dense sacral body."),
                ApproachSequentialStep(stepNumber: 3, title: "Transarticular Implant Arthrodesis", detail: "Deploy 3 triangular porous titanium implants spanning joint line, verifying rigid bony purchase on inlet and outlet views.")
            ]
        case .plate089:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Curved Retro-Epicondylar Exposure & MACN Preservation", detail: "Incise midway between medial epicondyle and olecranon; identify and protect crossing anterior/posterior MACN branches."),
                ApproachSequentialStep(stepNumber: 2, title: "Comprehensive Release of 5 Entrapment Sites", detail: "Divide Osborne's ligament, unroof retrocondylar groove, release Arcade of Struthers, and resect medial septum window."),
                ApproachSequentialStep(stepNumber: 3, title: "Submuscular Bed Creation & Transposition", detail: "Elevate flexor-pronator mass, place ulnar nerve in straight line on brachialis, and loosely repair flexor mass with 3-0 vicryl.")
            ]

        case .plate088:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Neutral Mayfield Concorde Positioning & Exposure", detail: "Lock head in neutral alignment (O-C2 angle 15°); expose midline subocciput down to C4 spinous process."),
                ApproachSequentialStep(stepNumber: 2, title: "Foramen Magnum Craniectomy & C1 Laminectomy", detail: "Resect 2.5 cm suboccipital bone and C1 posterior arch, dissecting medial to V3 groove to decompress brainstem."),
                ApproachSequentialStep(stepNumber: 3, title: "Triangulated Rigid Arthrodesis", detail: "Place midline occipital keel plate, C1 lateral mass screws, C2 pedicle/pars screws, contour rods, and decorticate for onlay autograft.")
            ]

        case .plate087:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retroperitoneal Access & Peritoneal Sweep", detail: "Left lower quadrant paramedian incision; divide anterior rectus sheath, mobilize rectus medially, and sweep peritoneal envelope."),
                ApproachSequentialStep(stepNumber: 2, title: "Vascular Mobilization & Bifurcation Triangle", detail: "Ligate middle sacral vessels; gently mobilize left common iliac vein laterally to expose L5–S1 disc space."),
                ApproachSequentialStep(stepNumber: 3, title: "Discectomy & Lordotic Reconstruction", detail: "Perform complete discectomy, endplate decortication, deploy hyperlordotic cage, and anchor divergent locking screws.")
            ]

        case .plate086:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Kocher's Point Entry & Ventricular Access", detail: "Place burr hole 1 cm anterior to coronal suture; cannulate lateral ventricle with peeling sheath along trajectory to Monro."),
                ApproachSequentialStep(stepNumber: 2, title: "Third Ventricle Navigation & Floor Inspection", detail: "Advance 0° neuroendoscope through foramen of Monro into third ventricle; identify mammillary bodies and tuber cinereum."),
                ApproachSequentialStep(stepNumber: 3, title: "Premamillary Stoma Creation & Basilar Apex Inspection", detail: "Perforate thin premamillary membrane with blunt probe, dilate with 3 Fr Fogarty balloon to 5 mm, and fenestrate Liliequist's membrane.")
            ]

        case .plate085:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Preoperative Staging & Multi-Disciplinary Planning", detail: "Obtain high-resolution sagittal/axial T2 MRI, pelvic CT angiogram, and CT-guided core biopsy (via a posterior midline tract that will be excised en bloc). Confirm chordoma histology and coordinate a two-team surgical plan with spine surgery, vascular surgery, and plastic surgery."),
                ApproachSequentialStep(stepNumber: 2, title: "Stage 1 — Anterior Retroperitoneal Release & Spacer Placement", detail: "Position the patient supine. Perform a lower midline laparotomy or retroperitoneal approach. Mobilize the common and internal iliac vessels and bilateral ureters laterally. Dissect the rectum off the presacral tumor pseudocapsule, ligate middle sacral vessels, and insert a radiopaque synthetic spacer (silastic/Gore-Tex) in the presacral cleavage plane."),
                ApproachSequentialStep(stepNumber: 3, title: "Stage 2 — Prone Posterior Midline Exposure & Ligamentous Release", detail: "Position patient prone on a radiolucent Jackson table with pelvic positioning rolls. Make a posterior midline incision incorporating the prior biopsy tract. Divide the sacrotuberous and sacrospinous ligaments to detach the pelvic floor muscles from the sacrum."),
                ApproachSequentialStep(stepNumber: 4, title: "En-Bloc Sacral & Iliac Osteotomies with Specimen Delivery", detail: "Perform laminectomies to expose the thecal sac. Ligate and divide lower sacral nerve roots according to planned margin level. Using high-speed burrs and osteotomes, cut bilaterally through the sacroiliac joints/iliac wings and perform a transverse sacral osteotomy across S1 or S2 into the anterior spacer. Deliver the intact tumor specimen en bloc."),
                ApproachSequentialStep(stepNumber: 5, title: "Triangular Spinopelvic Reconstruction & Gluteus Flap Closure", detail: "Place pedicle screws from L3 to L5 and quad iliac screws (two in each iliac wing). Connect screws with dual contoured rods, a transverse pelvic cross-link connector bar, and an expandable vertical mesh cage between L5 and the pelvis. Mobilize bilateral gluteus maximus advancement flaps for tension-free dead space closure.")
            ]

        case .plate084:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Pterional / Orbitozygomatic (OZO) Craniotomy", detail: "Position patient supine with head rotated 30° contralateral and extended 15°. Perform a frontotemporal or two-piece orbitozygomatic craniotomy, flattening the sphenoid ridge down to the meningo-orbital band."),
                ApproachSequentialStep(stepNumber: 2, title: "Extradural Unroofing & Optic Strut Drilling", detail: "Peel the frontotemporal dura extradurally from the superior orbital fissure. Using a 3 mm diamond burr with high-flow irrigation, drill the orbital roof, unroof the optic canal, and core out the optic strut connecting the ACP to the sphenoid body."),
                ApproachSequentialStep(stepNumber: 3, title: "Anterior Clinoid Process Removal & Falciform Incision", detail: "Gently mobilize and remove the anterior clinoid process en-bloc. Open the optic canal and sharply incise the falciform ligament along the optic nerve sheath to decompress CN II."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Opening & Circumferential Distal Dural Ring (DDR) Division", detail: "Open the dura in a curved fashion over the Sylvian fissure. Under the operating microscope, sharply divide the distal dural ring 180° around the anterior and lateral ICA circumference to mobilize the clinoid segment."),
                ApproachSequentialStep(stepNumber: 5, title: "Aneurysm Neck Dissection, Clip Occlusion & Micro-Doppler Verification", detail: "Dissect the aneurysm neck away from the optic nerve and ophthalmic artery origin. Apply an angled fenestrated or curved aneurysm clip across the neck. Verify complete aneurysm obliteration and patent ophthalmic/ICA flow via micro-Doppler and ICG angiography.")
            ]

        case .plate083:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Positioning & Fluoroscopic Trajectory Mapping", detail: "Position the patient prone on a radiolucent Wilson frame or Jackson table. Under biplane fluoroscopy, mark the midline and identify the L4–L5 disc space. Measure 8–10 cm laterally and plan an entry angle 35°–45° from the horizontal plane directed towards the medial pedicular line on AP and the posterior vertebral body line on lateral."),
                ApproachSequentialStep(stepNumber: 2, title: "18G Needle Insertion & Discography / Methylene Blue Staining", detail: "Advance an 18G spinal needle under fluoroscopic guidance into Kambin's triangle, docking at the Superior Articular Process (SAP) before sliding into the posterior disc space. Inject a mixture of radiopaque contrast and methylene blue (Chromodiscography) to selectively stain the degenerated, herniated nucleus pulposus blue."),
                ApproachSequentialStep(stepNumber: 3, title: "Guidewire Exchange & Crown Reamer Foraminoplasty", detail: "Pass a nitinol guidewire through the needle and perform a 7 mm skin incision. Advance progressive pencil-point dilators down to the ventral SAP. Introduce crown reamers over the dilator to undercut the ventral tip of the SAP, enlarging the bony foramen under fluoroscopic monitoring."),
                ApproachSequentialStep(stepNumber: 4, title: "Beveled Working Cannula Docking & Endoscope Introduction", detail: "Advance the beveled working sleeve over the dilator, anchoring its tip at the ventral facet border with the bevel rotated dorsolaterally to shield the exiting nerve root. Introduce the 30° wide-angle spinal endoscope and establish continuous low-pressure (<30 mmHg) saline irrigation."),
                ApproachSequentialStep(stepNumber: 5, title: "Endoscopic Fragmentectomy & Traversing Root Decompression", detail: "Under direct high-definition visualization, clear fibrous tissue with radiofrequency bipolar probes. Grasp and extract the blue-stained extruded disc fragment using micro-pituitary rongeurs. Inspect the traversing root and dural sac to confirm robust pulsation and unrestricted mobility.")
            ]

        case .plate082:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Concorde / Prone Positioning & Midline Suboccipital Craniotomy", detail: "Position the patient prone with the head flexed in a three-pin Mayfield fixation device (maintaining two finger-breadths between chin and sternum to ensure jugular venous drainage). Perform a midline suboccipital incision from external occipital protuberance (inion) to C2 spinous process. Perform a suboccipital craniotomy from transverse sinuses down to the foramen magnum with C1 posterior arch resection."),
                ApproachSequentialStep(stepNumber: 2, title: "Y-Shaped Dural Opening & Cisterna Magna Decompression", detail: "Open the dura in a Y-shaped or curvilinear fashion based on the transverse sinus, tenting the dural leaflets laterally with tacking sutures. Puncture the arachnoid of the cisterna magna to release CSF, decompress the posterior fossa, and allow the cerebellum to settle under gravity."),
                ApproachSequentialStep(stepNumber: 3, title: "Tonsillar Mobilization & Cerebellomedullary Fissure Exposure", detail: "Using dynamic microsurgical retractors, gently elevate and mobilize the bilateral cerebellar tonsils laterally and superiorly away from the dorsal medulla, widely exposing the bilateral cerebellomedullary fissures without parenchymal traction."),
                ApproachSequentialStep(stepNumber: 4, title: "Incision of Tela Choroidea & Inferior Medullary Velum (IMV)", detail: "Identify the taenia choroidea and the telovelotonsillar segment of the PICA. Using fine micro-scissors, sharply incise the transparent tela choroidea and the inferior medullary velum unilaterally or bilaterally along the taenia to enter the cavity of the fourth ventricle."),
                ApproachSequentialStep(stepNumber: 5, title: "Tumor Debulking & Rhomboid Fossa Preservation", detail: "Mobilize and debulk the fourth ventricular tumor superolaterally with ultrasonic aspirator or micro-curettes. Dissect the tumor capsule cleanly off the fastigium and lateral recesses while maintaining strict zero-touch visualization of the rhomboid fossa floor (facial colliculus, striae medullares, obex).")
            ]

        case .plate081:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Jackson Positioning & Multimodal Neuromonitoring", detail: "Position patient prone on a radiolucent Jackson table with chest and pelvic bolsters ensuring the abdomen hangs completely free to decompress the epidural venous plexus. Establish baseline bilateral lower extremity SSEPs, transcranial motor evoked potentials (tcMEP), and free-running/stimulated EMG across L2–S1 nerve roots."),
                ApproachSequentialStep(stepNumber: 2, title: "Multi-Level Exposure (T10 to Sacropelvis) & Pedicle Screw Placement", detail: "Perform a midline posterior incision from T10 to S2. Meticulously dissect paraspinal muscles subperiosteally out to the transverse processes, taking care to preserve the interspinous and supraspinous ligaments at T9–T10 for a soft proximal landing. Place polyaxial pedicle screws bilaterally from T10 to L5, and bicortical promontory screws at S1 under fluoroscopic or stereotactic navigation."),
                ApproachSequentialStep(stepNumber: 3, title: "Multi-Level Asymmetric Ponte Osteotomies (L1–L5)", detail: "At the apical and hypolordotic levels (L1–L5), resect the spinous processes and complete bilateral facetectomies (removing inferior articular process of cranial level and superior articular process of caudal level) down to the neural foramina. Meticulously excise the ligamentum flavum, exposing bleeding cancellous bone margins to create flexible Schwab Grade 2 osteotomies with wider resection on the coronal convexity."),
                ApproachSequentialStep(stepNumber: 4, title: "Bilateral S2AI Pelvic Screw Cannulation & Triangulation", detail: "Expose the S1 and S2 posterior sacral foramina. Establish entry 1 mm inferior and 1 mm lateral to the S1 dorsal sacral foramen. Using a gearshift probe under biplane fluoroscopy, cannulate across the sacroiliac joint directed 40° laterally toward the ASIS and 25°–30° caudally aiming for the dense supra-acetabular bone (iliac teardrop view). Tap and place 8.5 mm × 80–90 mm S2AI pelvic screws bilaterally, ensuring screw heads sit in-line with S1."),
                ApproachSequentialStep(stepNumber: 5, title: "Rod Derotation, Cantilever Lordotic Compression & Quad-Rod Reinforcement", detail: "Contour two 5.5 mm or 6.0 mm cobalt-chromium rods with physiologic lordosis and thoracic kyphosis. Place rods into reduction screw towers, translating coronal apex while applying cantilever compression across the Ponte osteotomy sites to close the posterior column. Bridge accessory satellite rods across L4–S1 using domino connectors to construct a rigid quad-rod foundation. Verify MAP > 85 mmHg and stable tcMEPs. Decorticate posterolateral elements and apply abundant autograft/allograft bone.")
            ]

        case .plate080:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Mayfield Positioning & C2/C7 Muscle-Sparing Exposure", detail: "Position the patient prone on chest rolls with the head secured in a Mayfield 3-pin clamp in a neutral or slightly flexed posture, strictly avoiding hyperflexion to protect the stenotic cord and prevent venous congestion. Perform a midline posterior cervical incision from C2 to C7. Subperiosteally elevate the paraspinal musculature strictly out to the medial facet margins, taking meticulous care to spare the semispinalis cervicis tendon insertion on the prominent C2 spinous process and preserving the posterior muscular sleeve of C7."),
                ApproachSequentialStep(stepNumber: 2, title: "Hinge Selection & Trough Preparation (Hirabayashi vs. Kurokawa)", detail: "For Open-Door (Hirabayashi): Designate the open side (typically the side with greater clinical radicular symptoms or worse foraminal stenosis) and the hinge side. For French-Door (Kurokawa): Prepare the spinous processes for midline sagittal division. Using a high-speed 2.5–3.0 mm diamond burr under continuous cold saline irrigation, mark the osteotomy boundaries along the lamina-facet junctions bilaterally from C3 through C7."),
                ApproachSequentialStep(stepNumber: 3, title: "Osteotomy Execution (Bicortical Open Trough vs. Midline Split)", detail: "In Open-Door: Thin the hinge gutter through the dorsal cortex, stopping when the inner cortex becomes pliable, thin, and bleeding (greenstick hinge). Drill the open gutter completely through the dorsal and ventral cortices to expose the blue-gray dura beneath. Excise cranial (C2–C3) and caudal (C7–T1) ligamentum flavum attachments using 1–2 mm Kerrison rongeurs. In French-Door: Drill a midline trough splitting the spinous processes and laminae sagitally down to dura, combined with bilateral lateral unicortical hinge troughs."),
                ApproachSequentialStep(stepNumber: 4, title: "Laminar Roof Elevation & Prophylactic C4–C5 Foraminotomy", detail: "Gently elevate the laminar door(s) by 4–5 mm using a micro-dissector, observing spontaneous posterior pulsation and expansion of the thecal sac. If excessive posterior cord drift (>4 mm) or severe pre-existing C5 foraminal narrowing is identified, perform a prophylactic microscopic keyhole foraminotomy unroofing the superior articular process at C4–C5 to decompress the C5 root and eliminate traction neuropraxia. Control epidural venous oozing along the open gutter with bipolar cautery and hemostatic matrix."),
                ApproachSequentialStep(stepNumber: 5, title: "Rigid Miniplate Fixation, Drain Placement & Multilayer Closure", detail: "In Open-Door: Contour and secure low-profile titanium laminoplasty miniplates across C3, C4, C5, C6, and C7, anchoring each plate with 4 self-tapping cortical screws (2 into the lateral mass and 2 into the laminar edge) to guarantee permanent canal patency. In French-Door: Secure trapezoidal hydroxyapatite ceramic blocks or titanium claw plates in the midline gap. Place a subfascial closed-suction drain to prevent compressive epidural hematoma. Meticulously re-approximate the deep paraspinal fascia in watertight layers.")
            ]

        case .plate079:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Stereotactic Frame Application & Multimodal CT-MRI Co-Registration", detail: "Under local scalp anesthesia, securely fix the Leksell G-frame or Vantage frame parallel to the orbitomeatal line (OML) ensuring zero pitch, yaw, or roll asymmetry. Perform a high-resolution stereotactic 3D bone CT scan with fiducial localization box and co-register rigidly to preoperative 3T FGATIR and T2-weighted MRI volumes. Define the mid-commissural point (MCP), AC-PC line, and calculate stereotactic coordinates for the bilateral dorsolateral motor STN (X = 11.5–12.5 mm lateral, Y = 2.0–3.0 mm posterior to MCP, Z = 4.0–5.0 mm inferior to AC-PC)."),
                ApproachSequentialStep(stepNumber: 2, title: "Precoronal Exposure & Burr Hole Trephination with Ventricular Sparing", detail: "Position the patient semi-sitting/supine with head elevated. Infiltrate local anesthetic and make bilateral 3 cm curvilinear incisions centered 2.5–3.0 cm lateral to the midline and 1–2 cm anterior to the coronal suture. Perform 14 mm burr hole trephinations. Cauterize and sharply incise the dura in a cruciate fashion. Immediately seal the burr hole with fibrin sealant / Gelfoam to prevent CSF egress, pneumocephalus, and intraoperative brain sag. Mount the stereotactic arc and set calculated ring and arc angles (~60° ring, ~12°–15° coronal arc) ensuring trajectory traverses strictly lateral to the frontal horn ependyma."),
                ApproachSequentialStep(stepNumber: 3, title: "Microelectrode Recording (MER) & Kinesthetic Motor Mapping", detail: "Insert the 5-channel Ben-Gun guide cannula stopped 10 mm above target. Advance tungsten microelectrodes using a motorized sub-millimeter microdrive. Monitor multi-unit neurophysiology continuously: identify quiescent zona incerta baseline, detect abrupt entry into the STN marked by dense irregular 35–50 Hz bursting, and perform passive contralateral wrist/elbow manipulation to confirm movement-locked kinesthetic units. Map the complete dorsolateral motor span (requiring ≥4.5 mm of typical bursting) before noting abrupt transition into high-frequency tonic SNr firing (>60–80 Hz) at the ventral border."),
                ApproachSequentialStep(stepNumber: 4, title: "Directional DBS Lead Implantation & Macrostimulation Boundary Testing", detail: "Withdraw the microelectrode and deliver a directional segmented 1-3-3-1 octapolar DBS lead through the chosen Ben-Gun track to the calculated motor target. Connect to the intraoperative screening screener and perform boundary macrostimulation: verify robust tremor suppression, rigidity relief, and improved finger tapping at 1.0–2.5 mA. Increment current to >3.5 mA to verify absence of capsular side effects (internal capsule contraction/dysarthria). Check for lemniscal paresthesias posteriorly and CN III oculomotor signs (diplopia/ptosis) ventromedially. Secure the lead at the skull defect using a Stimloc cranial cap, leaving a redundant strain-relief loop beneath the galea."),
                ApproachSequentialStep(stepNumber: 5, title: "General Anesthesia Transition, Tunneling & Infraclavicular IPG Placement", detail: "Remove the stereotactic frame and transition the patient to general endotracheal anesthesia. Prepare and drape the right infraclavicular chest and lateral neck. Create a 4 cm subclavicular incision and dissect a subcutaneous/subfascial pocket. Using a disposable Passer tool, tunnel the dual-channel extension cables subcutaneously behind the ear and along the sternocleidomastoid fascia into the chest pocket. Connect lead pins to the extension block, confirm low impedance across all contacts, and seat the dual-channel IPG securely. Close in anatomic layers and perform intraoperative 3D fluoroscopy / O-arm scan confirming sub-millimeter lead positioning.")
            ]

        case .plate078:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Jackson Positioning & Multimodal Neuromonitoring", detail: "Position the patient prone on a radiolucent Jackson spinal table with chest and pelvic bolsters ensuring the abdomen hangs completely free to decompress the epidural venous plexus and minimize intraoperative bleeding. Obtain baseline bilateral SSEP and transcranial electrical motor evoked potentials (tcMEP) across L1–S1 nerve roots."),
                ApproachSequentialStep(stepNumber: 2, title: "Posterior Exposure (T12–L2) via Midline or Wiltse Paraspinal Corridor", detail: "Perform a standard posterior midline exposure or muscle-sparing bilateral Wiltse paraspinal approach from T12 to L2. Meticulously dissect and expose the transverse processes and lateral facet borders of T12, the fractured L1, and L2. Carefully inspect the interspinous and supraspinous ligaments at T12–L1 and L1–L2 to confirm an intact posterior tension band (PLC)."),
                ApproachSequentialStep(stepNumber: 3, title: "Pedicle Cannulation & Intermediate Screw Placement at L1", detail: "Under biplane fluoroscopy or stereotactic navigation, cannulate the pedicles of T12, L1 (the fractured index level), and L2 using a gearshift probe. Place polyaxial pedicle screws at T12 and L2. Cannulate the intact pedicle isthmus of the fractured L1 vertebra and place bilateral intermediate pedicle screws directly into the fractured body to serve as active anterior-posterior cantilever fulcrums."),
                ApproachSequentialStep(stepNumber: 4, title: "Cantilever Lordotic Rod Reduction & Distraction Ligamentotaxis", detail: "Contour two 5.5 mm or 6.0 mm titanium or cobalt-chromium rods with physiologic thoracolumbar lordosis. Secure rods into the superior (T12) and inferior (L2) screw heads. Apply axial distraction across T12 and L2 to tension the intact posterior longitudinal ligament (ligamentotaxis), pulling the retropulsed bone fragments anteriorly away from the dural sac. Tighten the intermediate L1 screws to the contoured rod using cantilever reduction to reconstitute fractured vertebral height and correct local kyphosis."),
                ApproachSequentialStep(stepNumber: 5, title: "Final Tightening, Cross-Link Application & Posterolateral Arthrodesis", detail: "Confirm anatomical reduction and sagittal alignment (restoration of lordosis from 22° kyphosis to ~4° lordosis) on intraoperative biplane fluoroscopy. Torque set screws to final release limits. Apply a transverse cross-link connector for rotational rigidity. Decorticate the transverse processes and lateral facet joints of T12–L2 and lay down autologous local bone graft mixed with cancellous allograft for robust posterolateral arthrodesis.")
            ]

        case .plate077:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Concorde Positioning & 4-Modality Brainstem Neuromonitoring", detail: "Secure patient prone in a Mayfield 3-pin skull clamp in the Concorde position with head flexed and elevated in 15°–20° reverse Trendelenburg to optimize gravity-assisted cerebellar descent and lower intracranial venous pressure. Establish continuous SSEP, MEP, Brainstem Auditory Evoked Responses (BAER), and multi-channel extraocular muscle EMG (CN III, IV, VI)."),
                ApproachSequentialStep(stepNumber: 2, title: "Suboccipital Craniotomy & Transverse Sinus Skeletonization", detail: "Perform a midline suboccipital incision extending from the inion to C2. Elevate suboccipital musculature subperiosteally. Perform a bilateral suboccipital craniotomy extending superiorly flush with the transverse sinus and torcular Herophili to allow a zero-angle corridor along the tentorial roof. Open the dura in a Y-shaped or superiorly based flap and reflect it upward toward the transverse sinus with tension stay sutures."),
                ApproachSequentialStep(stepNumber: 3, title: "Supracerebellar Infratentorial (SCIT) Arachnoid Microdissection", detail: "Allow the cerebellar culmen and vermis to descend gently under gravity without mechanical brain retractors. Under 16× microscope magnification, sharply divide thickened arachnoid trabeculae over the cisterna magna and quadrigeminal cistern. Meticulously identify, bipolar, and divide the midline precentral cerebellar vein to unlock the supracerebellar corridor into the dorsal midbrain while strictly preserving the straight sinus, vein of Galen, and basal vein of Rosenthal."),
                ApproachSequentialStep(stepNumber: 4, title: "Identification & Absolute Preservation of the DVA", detail: "Expose the dorsal tectal plate and identify the associated Developmental Venous Anomaly (DVA) with its prominent collector vein coursing toward the galenic complex. Under no circumstances should the DVA be coagulated, clipped, or divided, as it provides critical physiological venous outflow to normal brainstem parenchyma. Apply a papaverine-soaked micro-cottonoid over the DVA to prevent vasospasm."),
                ApproachSequentialStep(stepNumber: 5, title: "Infracollicular Safe Entry & Intracapsular Piecemeal Evacuation", detail: "Identify the inferior colliculus, frenulum veli, and exiting trochlear nerve (CN IV). Map the infracollicular safe entry zone directly over the bluish pial presentation of the cavernoma. Make a 2–3 mm longitudinal micro-incision with a #11 micro-blade through the thinned pial cap. Use fine micro-pituitary forceps and cup forceps to debulk the mulberry vascular caverns and thrombosed locules inward, collapsing the capsule away from the surrounding brainstem. Leave the golden hemosiderin glial ring completely untouched (zero curettage) to prevent neurological deficit. Inspect for aqueduct patency and achieve meticulous hemostasis.")
            ]

        case .plate076:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Concorde Positioning & Neuro-Monitoring Setup", detail: "Secure patient prone in a Mayfield 3-pin skull clamp in the Concorde position with slight cervical flexion to open the interlaminar spaces. Apply 10°–15° reverse Trendelenburg to reduce epidural venous pressure. Establish continuous SSEP, MEP, and multi-channel free-running EMG monitoring of the deltoid/biceps (C5), wrist extensors (C6), and triceps (C7)."),
                ApproachSequentialStep(stepNumber: 2, title: "Minimally Invasive Tubular / Keyhole Exposure of V-Point", detail: "Under lateral fluoroscopic guidance, localize the target interlaminar space (e.g., C5–C6). Make a 1.5–2.0 cm paramedian longitudinal incision 1.5 cm off midline. Insert serial dilators and lock an 18 mm tubular retractor or micro-speculum directly over the facet junction. Clean soft tissue off the caudal C5 lamina, cranial C6 lamina, and the anatomical 'V-point' formed by their intersection at the medial facet joint."),
                ApproachSequentialStep(stepNumber: 3, title: "High-Speed Diamond Burr Laminoforaminotomy (≤50% Facet Rule)", detail: "Using a 3 mm high-speed diamond burr with continuous chilled saline irrigation, thin the outer cortex at the V-point. Resect the caudal margin of the C5 lamina and the cranial margin of the C6 lamina. Perform a medial facetectomy removing the medial half of the inferior articular process (IAP) of C5 and superior articular process (SAP) of C6, strictly preserving ≥50% of the lateral facet width to safeguard mechanical stability."),
                ApproachSequentialStep(stepNumber: 4, title: "Micro-Flavectomy & Unroofing of the Cervical Nerve Root", detail: "Using a fine micro-dissector and 1–2 mm 40° up-biting Kerrison rongeurs, excise the lateral ligamentum flavum, exposing the glistening blue-gray dural root sleeve. Trace the nerve root laterally out to the medial border of the pedicle until the root is completely unroofed for 6–8 mm. Control brisk epidural radicular venous bleeding with fine micro-bipolar cautery (10–12 W) and thrombin-soaked gelatin matrix pledgets."),
                ApproachSequentialStep(stepNumber: 5, title: "Nerve Root Mobilization, Subligamentous Fragmentectomy & Foraminal Check", detail: "Under 16× microscope magnification, gently mobilize the nerve root axilla and shoulder using a blunt micro-nerve hook with ZERO cord retraction. Incise the posterior longitudinal ligament if intact, and use micro-pituitary rongeurs to extract the extruded soft disc fragment. Pass a 1 mm ball-tipped micro-probe smoothly through the neuroforamen out into the extraforaminal zone to confirm circumferential decompression.")
            ]

        case .plate075:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Jackson Positioning & Baseline Multi-Modal Neuromonitoring", detail: "Position patient prone on a Jackson spine table with hips fully extended to optimize pelvic tilt and induce lordosis. Establish continuous baseline motor evoked potentials (MEP), somatosensory evoked potentials (SSEP), and multi-channel spontaneous/triggered electromyography (EMG) monitoring bilateral L5 (tibialis anterior, extensor hallucis longus) and S1 (gastrocnemius) nerve roots. Maintain MAP >85 mmHg."),
                ApproachSequentialStep(stepNumber: 2, title: "Wide Posterior Exposure & Complete L5 Gill Laminectomy", detail: "Perform a midline incision from L4 down to S2, extending laterally to expose bilateral posterior superior iliac spines (PSIS). Identify the detached, fibrocartilaginous 'floating' L5 posterior arch. Perform a complete Gill laminectomy by carefully freeing the pseudarthrosis fibrous tissue off the thecal sac and lateral recesses, completely mobilizing and unroofing the compressed cauda equina."),
                ApproachSequentialStep(stepNumber: 3, title: "Bilateral Circumferential L5 Foraminotomy & Sacral Dome Osteotomy", detail: "Under microscope illumination, perform generous bilateral L5 foraminotomies, exposing the 4–5 mm L5 nerve roots as they course over the sacral alae. Retract the dural sac medially with a protective cottonoid. Using a 4 mm curved diamond burr under chilled irrigation, resect the rounded, convex posterosuperior S1 sacral dome, flattening the bony fulcrum and eliminating the acute right-angle kink on the cauda equina."),
                ApproachSequentialStep(stepNumber: 4, title: "Triangular Spinopelvic Instrumentation & S2AI Screw Placement", detail: "Cannulate and insert bilateral polyaxial pedicle screws into L4, L5, and bicortical S1 promontory screws. Prepare bilateral S2-alar-iliac (S2AI) screw trajectories: starting 1 mm inferior and 1 mm lateral to the S1 dorsal foramen, angling 40° laterally and 20° caudally across the sacroiliac joint into the dense supracetabular bone corridor toward the AIIS. Countersink tulips deeply into the sacral groove."),
                ApproachSequentialStep(stepNumber: 5, title: "Cantilever Slip Angle Reduction & Modified Bohlman Trans-Sacral Arthrodesis", detail: "Attach reduction towers to L5 pedicle screws. Under continuous EMG surveillance, execute gradual cantilever reduction to correct the lumbosacral kyphotic slip angle from 91° to >100°, halting immediately if neuro-alerts fire. Prepare the trans-sacral corridor: drill a pilot hole starting from the posterior S1 body through the collapsed L5–S1 disc space and deep into the L5 vertebral body. Thread a structural cylindrical cage or fibular strut trans-sacrally across the shear plane, packed with autologous cancellous bone graft and rhBMP-2. Lock dual titanium rods.")
            ]

        case .plate074:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Pterional / Orbitozygomatic Exposure & Lumbar Drainage", detail: "Position patient supine with head rotated 30° contralateral and extended 15° to align the sphenoid ridge with the vertical axis. Place lumbar drain for brain relaxation if significant mass effect exists. Execute a curvilinear frontotemporal incision behind the hairline. Elevate a vascularized pericranial flap and perform interfascial temporal muscle dissection preserving the frontalis branch of CN VII. Perform a low pterional or two-piece orbitozygomatic craniotomy flush with the orbital roof and anterior cranial fossa floor."),
                ApproachSequentialStep(stepNumber: 2, title: "Extradural Sphenoid Ridge Drilling & MOB Peeling", detail: "Under microscope guidance, elevate the frontal and temporal dura extradurally. With a 4 mm coarse diamond burr and copious irrigation, drill the hyperostotic sphenoid ridge down to the lateral wall of the superior orbital fissure (SOF). Identify and sharply incise the meningo-orbital band (MOB)—the dural bridge between temporal dura and periorbita. Peel the temporal dura propria off the inner cavernous membrane to widely expose the anterior clinoid process (ACP)."),
                ApproachSequentialStep(stepNumber: 3, title: "Extradural Optic Canal Unroofing & Anterior Clinoidectomy", detail: "Using a 2 mm or 3 mm diamond burr under continuous chilled saline irrigation to prevent thermal injury to the optic nerve, drill the roof of the optic canal for 180°–270°. Hollow out the cancellous core of the anterior clinoid process and drill the optic strut separating the optic canal from the SOF. Gently fracture and remove the cortical shell of the ACP with micro-curettes, releasing the optic nerve and exposing the clinoidal ICA segment without opening the dura."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Opening, Early Devascularization & CUSA Internal Debulking", detail: "Open the dura in a curvilinear fashion along the sphenoid ridge base and orbit. Immediately coagulate and divide the primary dural feeding vessels from the sphenoid ridge and middle meningeal artery to devascularize the tumor. Incise the tumor capsule in a silent avascular zone and use ultrasonic aspirator (CUSA at low power) to hollow out the tumor core, creating internal slack before attempting capsular dissection."),
                ApproachSequentialStep(stepNumber: 5, title: "Micro-Dissection of ICA, AChA & Lenticulostriate Perforators", detail: "Under 16× high magnification, trace arachnoid cleavage planes along the proximal M1 segment, carotid bifurcation, supraclinoid ICA, and anterior choroidal artery (AChA). Meticulously preserve the recurrent artery of Heubner and the brush of lenticulostriate perforators extending into the anterior perforated substance. For Al-Mefty Group I tumors lacking an arachnoid plane, leave a microscopic tumor cuff on the arterial adventitia to avoid vessel laceration. Resect or reconstruct involved dural base (Simpson Grade II) with pericranial autograft.")
            ]

        case .plate073:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Positioning & Multi-Modal Neuromonitoring", detail: "Position the patient prone on a Wilson frame or Jackson spine table with the abdomen hanging completely free to decompress epidural Batson plexus veins. Establish continuous baseline motor evoked potentials (MEP) and somatosensory evoked potentials (SSEP). Maintain mean arterial pressure (MAP) strictly between 85–90 mmHg throughout the procedure to preserve spinal cord perfusion across the critical watershed zone."),
                ApproachSequentialStep(stepNumber: 2, title: "Targeted Unilateral Hemilaminectomy & Complete Pediculectomy", detail: "Under lateral fluoroscopic localization, perform a midline or paramedian incision centered over the disc space (e.g., T8–T9). Execute a targeted unilateral hemilaminectomy and partial medial facetectomy. Using a high-speed diamond burr and Kerrison rongeurs, perform a complete pediculectomy of the superior vertebra (T8), completely skeletonizing and exposing the lateral dural margin and the exiting T8 thoracic nerve root."),
                ApproachSequentialStep(stepNumber: 3, title: "Down-and-Away Vertebral Body Trenching", detail: "Without touching or manipulating the calcified disc mass or thecal sac, use a 3 mm high-speed diamond burr under continuous cold saline irrigation to drill a generous trench into the posterior third of the vertebral bodies above and below the disc space (T8 and T9). Hollow out a deep decompression cavity ventral and inferior to the disc herniation to create a receptive space."),
                ApproachSequentialStep(stepNumber: 4, title: "16× Reverse-Angle Cavitation & Down-and-Away Drop-In", detail: "Under 16× microscope magnification, strictly adhere to the rule of ZERO spinal cord retraction. Deploy a reverse-angle micro-curette or down-pushing micro-dissector above the calcified disc fragment, gently pushing the hard ossified mass downward and away into the pre-drilled vertebral trench. Use micro-pituitary rongeurs to extract the fractured fragments from within the cavity until the ventral thecal sac re-expands with brisk, synchronized cardiac pulsations."),
                ApproachSequentialStep(stepNumber: 5, title: "Ventral Dural Reconstruction & Short-Segment Stabilization", detail: "Inspect the ventral dura for intradural perforation. If a ventral dural defect is present, seal it with an onlay collagen matrix (DuraGen), autologous muscle/fat graft pledget, and fibrin sealant. Place bilateral or unilateral pedicle screws spanning the pediculectomy level (T7 and T9) connected by a pre-contoured titanium rod to prevent post-discectomy kyphotic deformity. Close the deep fascia watertight over a subfascial drain.")
            ]

                                                                        case .plate072:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Diagnostic Lateral Decubitus DSM / Dynamic CT Myelogram", detail: "Position the patient in lateral decubitus with the suspected leak side down (dependent position). Perform lumbar puncture with a 22G Quincke or Whitacre needle, inject 8–10 mL of non-ionic iodinated contrast (Isovue-300), and execute rapid continuous fluoroscopic DSM or high-resolution dynamic CT myelography over the mid-thoracic spine. Identify the exact thoracic level and lateralized nerve root sleeve where contrast jets directly into an intercostal/azygos draining vein."),
                ApproachSequentialStep(stepNumber: 2, title: "Targeted Minimally Invasive Hemilaminectomy Corridor", detail: "Position the patient prone on a Wilson frame or chest rolls under general anesthesia. Place an intraoperative marker on the spinous process and verify the target thoracic level with lateral fluoroscopy. Make a 2.5–3.0 cm paramedian incision. Under tubular retractor or micro-speculum exposure, execute a targeted unilateral hemilaminectomy and medial facetectomy directly over the identified nerve root sleeve."),
                ApproachSequentialStep(stepNumber: 3, title: "Microdissection of Dural Root Sleeve & Fistulous Vein", detail: "Under 16× high-magnification microscope illumination, gently retract the paraspinal epidural fat. Identify the lateral thecal sac transition into the thoracic dural root sleeve and exiting dorsal root ganglion (DRG). Meticulously dissect and skeletonize the engorged, arterialized fistulous vein exiting the lateral dural cuff, distinguishing it from adjacent Batson's epidural venous plexus."),
                ApproachSequentialStep(stepNumber: 4, title: "Microvascular Clip Application & Shunt Transection", detail: "Apply a small straight or slightly curved permanent titanium microvascular aneurysm clip (e.g., 3–5 mm blade) across the fistulous vein flush against the lateral dural root sleeve. Bipolar the vein distal to the clip with fine micro-forceps at low power (15 W) and sharply divide it with micro-scissors. Alternatively, for difficult ventral fistulae, perform circumferential double-clip ligation and division of the non-eloquent thoracic root sleeve proximal and distal to the DRG."),
                ApproachSequentialStep(stepNumber: 5, title: "Watertight Dural Inspection & Rebound Pressure Monitoring", detail: "Inspect the dural root sleeve under Valsalva maneuver (+30 cm H2O for 10 seconds) to verify complete absence of CSF egress. Apply a layer of autologous muscle graft or gelatin foam with fibrin sealant over the clipped stump. Close paraspinal fascia in watertight layers without a drain. Initiate aggressive post-operative monitoring for Rebound Intracranial Hypertension (RIH), starting acetazolamide 250–500 mg BID if recumbent headaches or papilledema manifest.")
            ]

                                                                        case .plate071:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Fiberoptic Intubation & Neutral Kyphotic Positioning", detail: "Perform awake fiberoptic endotracheal intubation in neutral cervical alignment without neck extension. Log-roll the patient onto a Jackson spine table with pre-built multi-level chest and pelvic bolsters customized to the patient's rigid pre-morbid thoracic kyphosis and 'chin-on-chest' deformity. Secure the head in a customized padded cradle or Mayfield pins; verify baseline somatosensory (SSEP) and motor evoked potentials (MEP) before and after positioning."),
                ApproachSequentialStep(stepNumber: 2, title: "Wide Subperiosteal Exposure (3 Above / 3 Below)", detail: "Perform a midline longitudinal incision spanning 3 levels above to 3 levels below the fracture apex (e.g., T9 down to L3 for a T12 fracture). Cauterize and elevate paraspinous musculature subperiosteally off the completely fused, porcelain-like laminar sheets. Identify the transverse 'chalk-stick' fracture line across the posterior elements and control cancellous fracture oozing with bone wax and hemostatic matrix."),
                ApproachSequentialStep(stepNumber: 3, title: "Multi-Level Bilateral Pedicle Screw Instrumentation", detail: "Under intraoperative navigation or biplane fluoroscopy, cannulate pedicles bilaterally at least 3 levels above and 3 levels below the fracture (total 12–14 screws). Use wide-diameter (5.5–6.5 mm) titanium polyaxial pedicle screws with deep bicortical purchase into osteopenic cancellous bodies to maximize pullout strength against long lever-arm torque. Avoid instrumenting the fractured vertebra directly."),
                ApproachSequentialStep(stepNumber: 4, title: "16× Microsurgical Laminectomy & Epidural Clot Evacuation", detail: "Execute a wide microscopic laminectomy at the fracture level using a high-speed diamond burr and 2 mm Kerrison rongeurs, avoiding plunging instruments into the stenotic canal. Gently evacuate the dark, compressive retrovertebral venous epidural hematoma with curved neural dissectors and micro-suction until the compressed thecal sac expands with vigorous, synchronized cardiac pulsations. Secure epidural hemostasis with bipolar cautery and thrombin-soaked gelatin sponge (Surgiflo)."),
                ApproachSequentialStep(stepNumber: 5, title: "Pre-Contoured Rod Cantilever & Transverse Cross-Link Locking", detail: "Pre-contour dual 5.5/6.0 mm titanium alloy rods to match the patient's native, fixed pre-injury kyphotic alignment perfectly without attempting acute deformity reduction. Sequentially lock rods into pedicle screw tulips with set screws. Apply gentle compression across the posterior column under fluoroscopy to close the anterior transdiscal gap. Lock a rigid transverse cross-link connector across the fracture site for multi-planar torsional stiffness. Apply autologous local bone graft mixed with allograft along decorticated lateral gutters.")
            ]

                                                                        case .plate070:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Regional Scalp Block & Asleep-Awake-Asleep Positioning", detail: "Perform a comprehensive 6-nerve regional scalp block (supraorbital, supratrochlear, zygomaticotemporal, auriculotemporal, greater and lesser occipital nerves) with 0.5% ropivacaine and epinephrine. Position the patient lateral or semirecumbent in Mayfield head fixation, ensuring direct line-of-sight and physical comfort for the intraoperative neuropsychologist and patient during DO-80 naming tasks. Maintain airway via LMA or dexmedetomidine-remifentanil conscious sedation during opening."),
                ApproachSequentialStep(stepNumber: 2, title: "Craniotomy & Cortical Surface Exposure", detail: "Execute a targeted left frontotemporoparietal craniotomy centered over the peri-Sylvian cortex and tumor epicenter. Reflect the dural flap superiorly and tether with traction sutures. Awaken the patient, transition off sedation, remove the LMA if used, and verify calm, cooperative patient engagement with baseline naming and counting fluency before initiating stimulation."),
                ApproachSequentialStep(stepNumber: 3, title: "Bipolar Cortical Direct Electrical Stimulation (DES)", detail: "Deploy a 5 mm bipolar Ojemann stimulation probe (60 Hz biphasic square waves, 1 ms pulse width, starting at 1.5 mA and titrated up to 3.5 mA under continuous electrocorticography to detect afterdischarges). Place sterile numbered tags on eloquent cortex: Broca area [1] (speech arrest), Wernicke area [2] (semantic paraphasia/anomia), supramarginal gyrus [3] (phonological paraphasia), precentral gyrus [4] (contralateral hand/thumb motor arrest), and identify safe non-eloquent cortical corridors [5, 6]."),
                ApproachSequentialStep(stepNumber: 4, title: "Subpial Corticotomy & 5-ALA Guided Cavitation", detail: "Switch microscope illumination to 405 nm blue-light excitation to visualize vivid ruby-magenta PpIX tumor fluorescence. Enter through a non-eloquent corticotomy tag ([5] or [6]) using subpial dissection. Core out the necrotic, highly vascular glioblastoma center with the ultrasonic aspirator (CUSA), debulking from the inside out to minimize lateral parenchymal traction."),
                ApproachSequentialStep(stepNumber: 5, title: "Subcortical Monopolar DES & White Matter Tract Sparing", detail: "Perform dynamic monopolar stimulation (train-of-five high-frequency technique) along deep resection margins while the patient names visual objects continuously. Detect subcortical tract boundaries: arcuate fasciculus (AF) on the deep lateral wall (repetition errors/phonemic paraphasia), inferior fronto-occipital fasciculus (IFOF) on the inferior/ventral margin (semantic paraphasia), and corticospinal tract (CST) on the posterior-medial floor (motor arrest/twitch). Stop resection at the 5 mA threshold (5 mm safe functional boundary) to achieve supratotal functional resection with zero permanent neurological deficit.")
            ]

                                                                        case .plate069:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & SSS-Crossing 4-Burr-Hole Craniotomy", detail: "Patient supine with head elevated 15° to lower intracranial venous pressure. Bicoronal or large horseshoe skin flap. Place 4 burr holes straddling the midline Superior Sagittal Sinus (2 ipsilateral, 2 contralateral). Strip the adherent midline dura under direct vision; perform a rectangular craniotomy crossing the midline SSS to achieve 360° sinus visualization."),
                ApproachSequentialStep(stepNumber: 2, title: "D-Shaped Dural Opening & Rolandic Bridging Vein Sparing", detail: "Invert a medial D-shaped dural flap with its base hinged along the SSS. Meticulously identify, skeletonize, and preserve all dominant cortical bridging veins, specifically the central rolandic vein and vein of Trolard entering the lateral lacunae. Devascularize middle meningeal artery branches along the convexity dura."),
                ApproachSequentialStep(stepNumber: 3, title: "CUSA Internal Cavitation & Falcine Resection", detail: "Under 16× microscope illumination, core out the firm, fibrous meningioma with an ultrasonic aspirator (CUSA). Collapse the tumor capsule inward away from the motor cortex arachnoid plane without traction on brain parenchyma. Resect the involved falx cerebri down to the free edge of the inferior sagittal sinus."),
                ApproachSequentialStep(stepNumber: 4, title: "SSS Lateral Recess Unroofing & Wall Resection", detail: "For Sindou Types II–IV invasion, apply temporary vascular micro-clips proximally and distally along the SSS. Unroof the lateral sinus recess and excise the invaded lateral wall, preserving deep intraluminal flow and the medial/superior dural walls."),
                ApproachSequentialStep(stepNumber: 5, title: "Autologous Pericranial Patch Reconstruction & Patency Verification", detail: "Reconstruct the triangular lateral sinus wall defect using an autologous pericranial patch or saphenous vein graft, sutured watertight with continuous 7-0 monofilament. Release temporary clips and perform real-time ICG videoangiography and micro-Doppler interrogation to verify patent, non-turbulent venous blood flow.")
            ]

                                                                        case .plate068:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Thecal Sac Durotomy & Intradural Phase", detail: "Perform a lateral linear durotomy centered over the intradural tumor pole. Dissect the arachnoid plane between the tumor and the compressed thoracic spinal cord under 16× magnification. Identify the dorsal root of origin and safely divide it with bipolar cautery, while strictly preserving adjacent ventral motor rootlets and passing radiculomedullary arterial feeders."),
                ApproachSequentialStep(stepNumber: 2, title: "Foraminal & Extraforaminal CUSA Debulking", detail: "Transition to the extradural/extrapleural compartment. Use an ultrasonic aspirator (CUSA) to internally cavitate and debulk the firm tumor tissue within the neural foramen and the large thoracic paravertebral mass, collapsing the capsule inward away from the sympathetic chain and parietal pleura."),
                ApproachSequentialStep(stepNumber: 3, title: "En-Bloc Capsule Delivery & Spinal Cord Mobilization", detail: "Circumferentially dissect the collapsed tumor capsule off the posterior mediastinal borders and delivery the entire dumbbell mass. Confirm gross total tumor resection, complete decompression, and spontaneous midline re-expansion of the thoracic spinal cord."),
                ApproachSequentialStep(stepNumber: 4, title: "Watertight Dural Repair & CSF-Pleural Fistula Prevention", detail: "Execute a watertight running monofilament suture closure of the lateral durotomy. Reinforce the repair with an onlay collagen dural matrix patch and fibrin sealant. Negative intrathoracic pleural pressure acts as a powerful siphon; an airtight and watertight dural barrier is essential to prevent CSF-pleural fistula."),
                ApproachSequentialStep(stepNumber: 5, title: "Posterior Column Reconstruction & Rigid Arthrodesis", detail: "Reconstruct the anterior column using an expandable or mesh titanium interbody cage packed with autologous bone graft. Complete bilateral pedicle screw and rod instrumentation spanning the decompressed thoracic segments to ensure 100% biomechanical stability and prevent post-costotransversectomy kyphosis.")
            ]

                                                                        case .plate067:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Retroauricular Hockey-Stick Incision", detail: "Patient placed in the park-bench or three-quarters prone position with the head secured in a 3-point Mayfield headholder, rotated 30° contralaterally and vertex flexed 15° to open the craniocervical gutter. A retroauricular inverted hockey-stick incision begins at the mastoid tip, curves superiorly above the superior nuchal line, and courses caudally along the midline down to C3."),
                ApproachSequentialStep(stepNumber: 2, title: "Layered Muscular Reflection & Suboccipital Triangle Isolation", detail: "Reflect the sternocleidomastoid, splenius capitis, and longissimus capitis muscles anterolaterally. Identify and meticulously dissect the deep suboccipital triangle bounded by rectus capitis posterior major, superior oblique, and inferior oblique muscles, exposing the fatty-venous envelope surrounding the vertebral artery."),
                ApproachSequentialStep(stepNumber: 3, title: "Extradural V3 Vertebral Artery Mobilization & Venous Hemostasis", detail: "Identify the horizontal V3 segment of the vertebral artery as it crosses the condylar groove on the superior aspect of the C1 posterior arch. Bipolar coagulate and pack the dense suboccipital venous plexus with hemostatic flowable gelatin matrix. Skeletonize the V3 periosteal sheath, preparing it for atraumatic mobilization."),
                ApproachSequentialStep(stepNumber: 4, title: "Far-Lateral Craniectomy, C1 Arch Resection & Partial Condylectomy", detail: "Perform a lateral suboccipital craniectomy unroofing the sigmoid-transverse junction down to the jugular bulb. Resect the lateral half of the posterior arch of C1 (hemilaminectomy). Using a 3 mm diamond burr under continuous cold saline irrigation, resect the posterior-medial one-third (1/3) of the occipital condyle, maintaining condylar stability while visualizing the superiorly located hypoglossal canal."),
                ApproachSequentialStep(stepNumber: 5, title: "C-Shaped Dural Opening & Trans-Condylar Cisternal Exposure", detail: "Perform a curved, C-shaped dural incision hinged laterally along the sigmoid sinus and dural ring of the vertebral artery. Sharply open the thick arachnoid membrane of the cisterna magna, releasing CSF to achieve complete posterior fossa relaxation. Visualize the V4 segment entering intradurally across the fibrous dural ring."),
                ApproachSequentialStep(stepNumber: 6, title: "Aneurysm Dissection, Titanium Clipping & Micro-Doppler Verification", detail: "Under 16× magnification, trace the V4 segment along the anterolateral medulla. Identify the preolivary CN XII rootlets and postolivary CN IX, X, XI rootlets. Meticulously dissect arachnoid bands to free the aneurysm neck at the VA-PICA junction. Apply an appropriately contoured curved mini-Yasargil titanium clip across the neck, strictly sparing the parent VA lumen and the distinct origin of the PICA. Perform micro-Doppler interrogation on the distal PICA to confirm robust pulsatile arterial flow (>20 cm/s).")
            ]

                                                                        case .plate066:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Low Bifrontal Craniotomy", detail: "Patient supine with head elevated 15° and neck slightly extended. Coronal or bicoronal incision behind hairline; meticulously harvest a large, vascularized anterior pericranial flap pedicled on supraorbital and supratrochlear arteries. Perform a low bifrontal craniotomy placed flush with the orbital roofs and nasion to eliminate brain retraction, exenterating the frontal sinus with mucosal stripping and cranialization."),
                ApproachSequentialStep(stepNumber: 2, title: "Extradural Subfrontal Mobilization & Dural Elevation", detail: "Under microscope illumination, peel the frontal dura extradurally off the orbital roofs and planum sphenoidale from anterior to posterior toward the crista galli, maintaining an intact dural envelope to contain CSF."),
                ApproachSequentialStep(stepNumber: 3, title: "Extradural Ethmoidal Devascularization", detail: "Identify the anterior and posterior ethmoidal arteries as they exit their respective foramina along the fronto-ethmoidal suture. Coagulate with bipolar cautery and divide these vessels extradurally, cutting off >80% of the primary dural feeding supply to the meningioma base prior to dural opening."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Opening & CUSA Internal Cavitation", detail: "Incise the frontal dura transversely parallel to the skull base. Ligate or clip the anterior sagittal sinus. Immediately enter the firm, fleshy meningioma capsule and perform aggressive internal debulking with an ultrasonic aspirator (CUSA) and micro-curettes, converting the tense spherical mass into a pliable, collapsible shell."),
                ApproachSequentialStep(stepNumber: 5, title: "Extracapsular Dissection & ACA / Optic Sparing", detail: "Under high magnification, mobilize the deflated tumor capsule. Identify and preserve the arachnoid dissection plane separating the posterior capsule from draped A2 anterior cerebral artery (ACA) trunks, frontopolar branches, optic nerves, and the displaced optic chiasm. Strip the capsule off adherent neurovascular structures without pulling."),
                ApproachSequentialStep(stepNumber: 6, title: "Simpson Grade I Resection & Pericranial Flap Skull Base Reconstruction", detail: "Complete tumor excision; drill the hyperostotic crista galli and involved cribriform plate with a diamond burr down to healthy bone (Simpson Grade I). Reconstruct the cribriform/ethmoid floor defect by rotating the vascularized pericranial flap over the anterior skull base, securing it watertight with sutures and fibrin sealant.")
            ]

                                                                        case .plate065:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Right Frontoparietal Parasagittal Craniotomy", detail: "Patient supine with head elevated 30° and neck flexed 15° in neutral rotation to orient the anterior interhemispheric fissure vertical. Right frontoparietal parasagittal craniotomy crossing the midline slightly to expose the superior sagittal sinus (SSS) margin, placed 2/3 anterior and 1/3 posterior to the coronal suture."),
                ApproachSequentialStep(stepNumber: 2, title: "Dural Opening & Interhemispheric Transcallosal Dissection", detail: "U-shaped dural flap reflected medially over the SSS. Gravity-assisted interhemispheric approach along the falx cerebri, strictly preserving bridging frontoparietal draining veins. Release CSF from the pericallosal cistern. Gently retract the right cingulate gyrus to expose the glistening white corpus callosum flanked by bilateral pericallosal arteries."),
                ApproachSequentialStep(stepNumber: 3, title: "Limited Anterior Callosotomy (<2.0 cm)", detail: "Separate the pericallosal arteries. Perform a 1.5–2.0 cm longitudinal anterior callosotomy through the raphe of the corpus callosum strictly anterior to the coronal suture using bipolar cautery and micro-suction. Penetrate the callosal body into the right lateral ventricle, avoiding deeper penetration into the septum."),
                ApproachSequentialStep(stepNumber: 4, title: "Intraventricular Orientation & Foramen of Monro Exposure", detail: "Confirm orientation by identifying the pearly-white septum pellucidum medially, arching fornix column, choroid plexus, and the thalamostriate vein converging at the venous angle. Visualize the bulging, yellowish-amber colloid cyst dome protruding through the dilated foramen of Monro."),
                ApproachSequentialStep(stepNumber: 5, title: "Cyst Fenestration, Content Aspiration & Capsule Dissection", detail: "Puncture the avascular dome with a micro-knife. Evacuate thick, viscous mucinous contents using a 3-French micro-suction tube and ring curette to deflate the mass. Gently mobilize the cyst capsule with micro-forceps, developing the fine arachnoid plane separating the capsule from the roof of the third ventricle and internal cerebral veins without forceful traction."),
                ApproachSequentialStep(stepNumber: 6, title: "Hemostasis, Foraminal Patency Verification & Closure", detail: "Confirm complete gross total capsule excision and verify bilateral widely patent foramina of Monro with clear CSF communication into the third ventricle. Inspect the intact forniceal pillars and confirm patency of the internal cerebral and thalamostriate veins with micro-Doppler. Fill ventricles with warm lactated Ringer's solution, close dura watertight, and secure bone flap.")
            ]

                                                                        case .plate064:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Neurophysiological Baseline Setup", detail: "Prone positioning with head secured in 3-point Mayfield clamp; neck in neutral or mild flexion without jugular venous compression. Establish baseline Somatosensory Evoked Potentials (SSEP), Transcranial Motor Evoked Potentials (TcMEP), and epidural D-wave recording electrodes placed caudal to the surgical level."),
                ApproachSequentialStep(stepNumber: 2, title: "Posterior Cervical Laminectomy (C3–C6)", detail: "Midline posterior cervical skin incision; meticulous subperiosteal dissection of paraspinal muscles exposing laminae of C3 to C6. Multi-level laminectomy performed with high-speed burr and Kerrison rongeurs, widely unroofing the swollen thecal sac past the superior and inferior tumoral margins."),
                ApproachSequentialStep(stepNumber: 3, title: "Midline Durotomy & Dorsal Column Topographical Mapping", detail: "Linear midline dural opening under the operating microscope, tethered laterally with 4-0 silk stay sutures. Retract arachnoid sharply. Symmetrically swollen cord with engorged coronal veins. Identify the posterior median sulcus by following posterior surface microvascular convergence and confirming bilateral symmetry between dorsal root entry zones (DREZ)."),
                ApproachSequentialStep(stepNumber: 4, title: "Posterior Median Sulcus Myelotomy & Pial Stay Tenting", detail: "Use a diamond micro-knife to incise the avascular midline posterior median raphe strictly between the fasciculus gracilis and cuneatus. Avoid unipolar cautery. Place fine 6-0 or 7-0 monofilament pial stay sutures on the myelotomy edges and anchor them to the lateral dura, gently splaying open the dorsal columns to expose the reddish-tan tumor capsule."),
                ApproachSequentialStep(stepNumber: 5, title: "Polar Mobilization & Ventral Feeder Coagulation", detail: "Identify the rostral and caudal tumor poles, which often communicate with cystic syrinx cavities. Develop the distinct gliotic cleavage plane using micro-dissectors. Gently elevate the tumor from rostral-to-caudal; identify, bipolar coagulate, and divide fine ventral sulcal feeding branches from the Anterior Spinal Artery (ASA) directly on the tumor capsule, preserving the main ASA trunk on the anterior median fissure floor."),
                ApproachSequentialStep(stepNumber: 6, title: "En-Bloc Tumor Delivery & Multimodal Neuromonitoring Closure", detail: "Deliver the encapsulated ependymoma en-bloc. Inspect the clean, glistening intramedullary resection cavity for complete hemostasis. Verify intact D-wave amplitude (>50%) and MEPs. Release pial stay sutures, allowing posterior columns to re-approximate spontaneously. Perform running watertight dural closure reinforced with collagen dural matrix.")
            ]

                                                                        case .plate063:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Right Orbitozygomatic / Low Pterional Craniotomy", detail: "Supine in 3-point Mayfield clamp; head rotated 30° contralaterally and vertex extended 15° to open the subtemporal-orbital trajectory. Frontotemporal curvilinear incision. Low pterional or two-piece orbitozygomatic craniotomy; extensive diamond burr drilling of the sphenoid ridge down to the meningo-orbital band, with unroofing of the superior orbital fissure to flatten the subfrontal approach vector."),
                ApproachSequentialStep(stepNumber: 2, title: "Wide Sylvian Split & Carotid-Oculomotor Corridor Opening", detail: "C-shaped dural opening. Meticulously split the Sylvian fissure from distal-to-proximal, liberating the frontal and temporal lobes. Open the optico-carotid and carotid-oculomotor triangles. Trace the posterior communicating artery (PComA) posteromedially toward its confluence with the P1 segment of the posterior cerebral artery."),
                ApproachSequentialStep(stepNumber: 3, title: "Sharp Division of Liliequist's Membrane", detail: "Under high magnification, sharply divide both the carotid and diencephalic leaves of Liliequist's membrane. Evacuate CSF from the prepontine and interpeduncular cisterns to achieve complete neurovascular relaxation. Identify the oculomotor nerve (CN III) entering the roof of the cavernous sinus."),
                ApproachSequentialStep(stepNumber: 4, title: "Basilar Trunk Isolation & Temporary Clip Security", detail: "Follow the basilar artery trunk inferiorly into the prepontine space. Identify the bilateral superior cerebellar arteries (SCA). Clear an adventitial landing zone on the mid-basilar trunk below the SCAs. Place a mini temporary titanium clip (clamp time strictly <5–10 min under mild hypothermia / burst-suppression neuroprotection) to soften the aneurysm dome."),
                ApproachSequentialStep(stepNumber: 5, title: "Interpeduncular Circumdissection & Thalamoperforator Sparing", detail: "Dissect the aneurysm neck 360° within the interpeduncular fossa. Separate bilateral P1 segments laterally. Use micro-mirrors and angled micro-dissectors to inspect the posterior wall of the basilar apex, meticulously teasing all posterior thalamoperforating micro-arteries (paramedian mesencephalic branches) off the back of the aneurysm neck."),
                ApproachSequentialStep(stepNumber: 6, title: "Permanent Clip Application & Multimodal Verification", detail: "Select a curved, angled, or fenestrated titanium Sugita/Yasargil clip. Apply clip blades flush across the neck parallel to the P1-P1 plane, verifying blade tips extend cleanly into clear space without kinking either P1 or pinching posterior thalamoperforators. Remove temporary basilar clip. Puncture dome to confirm decompression. Verify patency with ICG videoangiography and micro-Doppler (>25 cm/s in bilateral P1s).")
            ]

                                                                        case .plate062:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Right Pterional Craniotomy", detail: "Supine with head pinned in 3-point Mayfield clamp, rotated 30° contralaterally and extended 15° to place the Sylvian fissure horizontal in the operating field. Curvilinear frontotemporal incision. Standard pterional craniotomy; extradural high-speed diamond drilling of the sphenoid ridge down to the meningo-orbital band to maximize anterior subtemporal line of sight."),
                ApproachSequentialStep(stepNumber: 2, title: "Dural Opening & Distal-to-Proximal Sylvian Fissure Dissection", detail: "C-shaped dural opening based on sphenoid ridge. Open the Sylvian fissure using the distal-first technique: incise the arachnoid along the anterior Sylvian cleft between the frontal and temporal opercula. Dissect superficial Sylvian veins toward the temporal bank. Gently separate opercula with self-retaining retractor blades lined with moist cottonoids."),
                ApproachSequentialStep(stepNumber: 3, title: "Early M2 Identification & Retrorun to Bifurcation", detail: "Identify the distal opercular branches of the superior (frontal) and inferior (temporal) M2 trunks within the insular cleft. Trace these daughter trunks proximally down to the limen insulae to expose the MCA bifurcation and the base of the aneurysm dome without initial retraction on the fragile aneurysm sac."),
                ApproachSequentialStep(stepNumber: 4, title: "Proximal M1 Skeletonization & Temporary Hemodynamic Control", detail: "Trace M1 proximally into the sphenoidal compartment. Identify and meticulously dissect the fine lateral lenticulostriate perforating micro-arteries arising from the dorsal aspect of M1. Clear an adventitial landing zone on M1 proximal to the lenticulostriates and place a mini temporary clip for hemodynamic softening of the aneurysm dome."),
                ApproachSequentialStep(stepNumber: 5, title: "360° Neck Circumdissection & Daughter Branch Mobilization", detail: "Perform complete circumferential micro-dissection of the aneurysm neck. Separate the neck cleanly from the carina and both M2 origins using fine micro-hooks and curved dissectors. Confirm that no lenticulostriate or early temporal branch is adherent to the posterior wall of the sac."),
                ApproachSequentialStep(stepNumber: 6, title: "Tandem Multi-Clip Reconstruction & Multimodal Patency Verification", detail: "Apply a tandem construct of straight/curved or fenestrated titanium Yasargil clips across the broad neck to reconstruct the native bifurcation lumen. Sharply puncture or incise the aneurysm dome to prove complete flow exclusion and relief of mass effect. Remove the temporary M1 clip. Execute ICG videoangiography and micro-Doppler interrogation to verify patent, symmetric flow (>20 cm/s) in both superior and inferior M2 trunks.")
            ]

                                                                        case .plate061:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning, Pterional Craniotomy & Sphenoid Ridge Flattening", detail: "Supine with head rotated 30°–45° contralaterally, vertex extended 10°–15° to align the Sylvian fissure vertical. Curvilinear frontotemporal question-mark incision behind hairline. Standard pterional craniotomy; high-speed diamond drilling of the sphenoid ridge down to the meningo-orbital band to unroof the superior orbital fissure and provide an uninhibited, flat subfrontal trajectory."),
                ApproachSequentialStep(stepNumber: 2, title: "Dural Opening & Transsylvian Cisternal Dissection", detail: "C-shaped dural flap reflected anteriorly over the sphenoid ridge. Open the Sylvian fissure sharply from lateral to medial, preserving superficial Sylvian veins. Drain CSF from the opticocarotid and chiasmatic cisterns for complete brain relaxation without mechanical brain retractors."),
                ApproachSequentialStep(stepNumber: 3, title: "Early Proximal Hemodynamic Control (Dominant A1)", detail: "Trace the supraclinoid ICA to its terminal bifurcation into M1 and A1. Follow the dominant A1 segment medially across the optic nerve. Clear an adventitial landing zone on the proximal A1 and place a mini temporary titanium clip (clamp time strictly <10–15 min with burst-suppression neuroprotection) to soften the aneurysm dome."),
                ApproachSequentialStep(stepNumber: 4, title: "Gyrus Rectus Subpial Resection", detail: "Identify the olfactory tract on the frontal orbital surface. Perform a precise, minimal 5 mm subpial resection of the gyrus rectus strictly medial to the olfactory tract using bipolar cautery and micro-suction. Enter the interhemispheric fissure to directly visualize the contralateral A1, bilateral A2 origins, and the anterior face of the AComA complex without excessive frontal lobe retraction."),
                ApproachSequentialStep(stepNumber: 5, title: "Circumferential Neck Dissection & Perforator Preservation", detail: "Dissect the aneurysm neck 360° off parent vessels. Identify and mobilize the Recurrent Artery of Heubner (RAH) tracking laterally. Gently tease delicate chiasmatic and hypothalamic perforators off the posterior neck and aneurysm dome using micro-hooks and diamond micro-dissectors."),
                ApproachSequentialStep(stepNumber: 6, title: "Permanent Clip Application & Multimodal Verification", detail: "Select an appropriate straight, curved, or fenestrated titanium aneurysm clip. Apply clip blades flush across the neck parallel to the AComA parent axis, confirming blade tips extend 1–2 mm into clear space. Puncture or coagulate the dome to confirm complete depressurization. Remove the temporary A1 clip. Perform ICG videoangiography and micro-Doppler interrogation to verify patent bilateral A2 flow (>15 cm/s) and complete dome exclusion.")
            ]

                                                                        case .plate060:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Superficial Temporal Artery (STA) Mapping & Harvest", detail: "Preoperative Doppler mapping of frontal and parietal STA branches. Perform a curvilinear incision over the parietal branch; meticulous micro-dissection preserving a 1 cm galea-periosteal cuff for EDAS and isolating the distal donor branch with 2 mm adventitial cuff for direct bypass."),
                ApproachSequentialStep(stepNumber: 2, title: "Craniotomy & Cortical Recipient Selection", detail: "Perform an oval frontotemporal craniotomy centering over the angular gyrus / distal Sylvian fissure. Open the dura under the microscope; identify a pristine M4 recipient cortical MCA branch (>1.0 mm caliber) free of atherosclerotic plaque or bifurcations."),
                ApproachSequentialStep(stepNumber: 3, title: "Vessel Preparation & Temporary Occlusion", detail: "Place a green rubber dam beneath the recipient M4. Flush the donor STA lumen with heparinized saline (100 U/mL) and bevel the tip at 45° (fish-mouthing). Apply paired temporary microvascular clips to the M4; perform a 1.5–2.0 mm linear micro-arteriotomy with micro-knife and micro-scissors."),
                ApproachSequentialStep(stepNumber: 4, title: "Microsurgical End-to-Side Anastomosis", detail: "Place heel and toe 10-0 monofilament nylon anchoring sutures. Execute 5–6 interrupted 10-0 nylon sutures on the deep (posterior) wall, then anterior wall with full-thickness intimal purchase and knot exteriorization. Remove temporary clips (recipient first, then donor) and confirm brisk pulsation."),
                ApproachSequentialStep(stepNumber: 5, title: "EDAS Indirect Synangiosis & Dural Inversion", detail: "Create a 7–8 cm linear dural slit along the intact proximal STA trajectory. Fenestrate the arachnoid membrane across multiple gyri. Suture the galeal cuff of the pulsating STA to the dural edges with interrupted 8-0 nylon, laying the vessel flush against the ischemic pia-arachnoid. Invert dural leaflets beneath bone edges."),
                ApproachSequentialStep(stepNumber: 6, title: "Patency Verification & Hemodynamic Closure", detail: "Perform ICG videoangiography and quantitative microvascular flow probe measurement (>20 mL/min). Secure generous bony beveling at STA entry/exit craniotomy margins to prevent arterial compression during bone flap replacement. Close galea and skin loosely without compressive dressings.")
            ]
case .plate059:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Nasal Preparation & Vascularized Hadad Flap Harvest", detail: "Oxymetazoline topical decongestion. Right nasoseptal (Hadad-Bassagasteguy) flap harvested along the nasal septum pedicled on the posterior septal artery. Flap stored in the choana/maxillary sinus for late skull base reconstruction. Right middle turbinate outfractured or resected; posterior septostomy created for two-nostril four-handed binostril instrumentation."),
                ApproachSequentialStep(stepNumber: 2, title: "Sphenoidotomy, Mucosal Stripping & Anatomical Landmark Identification", detail: "Wide bilateral sphenoidotomies down to the sphenoid floor. Rostrum of the sphenoid drilled flat. Intersphenoid septations resected with diamond burrs. Drill sphenoid mucosa to expose the sellar floor, tuberculum sellae, clival indentation, optic protuberances, and parasellar carotid protuberances with the medial/lateral OCR."),
                ApproachSequentialStep(stepNumber: 3, title: "Sellar Floor Osteotomy, Dural Cruciate Opening & Pseudocapsule Dissection", detail: "Thinned sellar bone unroofed between bilateral cavernous sinuses. Bipolar coagulate intercavernous sinuses. Cruciate incision of the sellar dura. Identify the cleavage plane between the adenoma pseudocapsule and sellar dura. Core out the adenoma center with ring curettes, then gently mobilize the pseudocapsule off the compressed hypophysis."),
                ApproachSequentialStep(stepNumber: 4, title: "Diaphragma Sellae Inspection, Multilayer Closure & Flap Inlay", detail: "Verify complete tumor clearance with 30° and 45° angled endoscopes. Watch for the translucent diaphragma sellae to descend into the empty sella without CSF leakage. Perform multilayer reconstruction with collagen matrix inlay, bioresorbable rigid buttress, and lay the vascularized Hadad nasoseptal flap across the denuded sphenoid floor secured with fibrin sealant.")
            ]
        case .plate058:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Focused Epicenter Laminectomy", detail: "Perform targeted single- or two-level unroofing at maximum compression site, aspirating pus for immediate microbiology."),
                ApproachSequentialStep(stepNumber: 2, title: "Catheter Epidural Clearance", detail: "Pass soft pediatric feeding catheter cephalad and caudad under direct vision, gently irrigating multi-segment skip collections."),
                ApproachSequentialStep(stepNumber: 3, title: "Debridement & Hardware Sparing", detail: "Debride infected dorsal granulation tissue while preserving stabilizing facets; place subfascial closed suction drains.")
            ]
        case .plate057:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Positioning & Retrosigmoid Keyhole Exposure", detail: "Park-bench or lateral position in 3-pin Mayfield headholder. Vertical retroauricular incision 5 mm medial to asterion. Small 2.5 cm craniectomy unroofing the transverse-sigmoid sinus junction. Open dura in curvilinear fashion based on the sinuses."),
                ApproachSequentialStep(stepNumber: 2, title: "Cisternal CSF Drainage & Supracerebellar Corridor", detail: "Open the lateral cerebellomedullary cistern to drain CSF and achieve full cerebellar relaxation. Advance along the superior petrosal cerebellar surface without brain retractors. Gently release arachnoid trabeculae over the petrosal fissure."),
                ApproachSequentialStep(stepNumber: 3, title: "Neurovascular Exploration & Vein of Dandy Preservation", detail: "Identify the acoustic-facial bundle (CN VII/VIII) caudally, then look superiorly to expose CN V. Identify the superior petrosal vein (Vein of Dandy) and mobilize it atraumatically without coagulation. Dissect the offending arterial loop (SCA or AICA) free from the trigeminal root entry zone."),
                ApproachSequentialStep(stepNumber: 4, title: "Multi-Modal Decompression & Watertight Dural Closure", detail: "Mobilize the vessel off the nerve root. Perform decompression via shredded Teflon felt interposition, Teflon bridge transposition, or tentorial dural sling. Inspect to ensure vessel remains widely patent with zero contact on CN V. Perform watertight dural closure with running monofilament suture to prevent CSF leak.")
            ]
        case .plate056:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Preoperative Diagnostic DSA & Superselective Embolization", detail: "Perform biplane 3D rotational DSA to map all feeding pedicles (ACA, MCA, PCA), identify associated intranidal/feeder flow aneurysms, and characterize superficial vs. deep venous drainage paths (vein of Galen, basal vein of Rosenthal). Perform superselective Onyx/PHIL liquid embolic embolization to devascularize deep, inaccessible perforating feeders."),
                ApproachSequentialStep(stepNumber: 2, title: "Tailored Craniotomy & Circumferential Pial Incision", detail: "Fashion a generous bone flap centered over the nidus with wide margins around the planned corridor. Open dura with base toward sinus. Map cortical eloquence with somatosensory evoked potentials (SSEP) and direct cortical stimulation. Make a circumferential pial incision around the nidus in non-eloquent sulci along the yellow-brown hemosiderin ring."),
                ApproachSequentialStep(stepNumber: 3, title: "Feeder Skeletonization, En-Passage Sparing & Centripetal Dissection", detail: "Systematically work around the circumference (superficial to deep, non-eloquent before eloquent border). Skeletonize feeding arteries right at their nidus entrance, bipolar coagulate, and divide with micro-scissors. Meticulously distinguish true terminal feeders from en-passage vessels supplying distal normal brain. Dissect strictly in the gliotic plane, keeping instruments out of the nidus interior."),
                ApproachSequentialStep(stepNumber: 4, title: "Late Venous Ligation, En-Bloc Resection & Hemodynamic Breakthrough Monitoring", detail: "Once all arterial feeders are occluded, confirm that the primary draining vein turns dark blue and pulsatility ceases. Double-clip and divide the main draining vein. Deliver the devascularized nidus en-bloc. Inspect the resection cavity for residual nidus shunts under high magnification and indocyanine green (ICG) videoangiography. Maintain strict normotensive/hypotensive MAP targets postoperatively to prevent normal perfusion pressure breakthrough (NPPB).")
            ]
        case .plate055:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Subtemporal Craniotomy & Extradural Exposure", detail: "Park-bench or lateral decubitus position. Low temporal craniotomy flush with the middle cranial fossa floor. Gently elevate middle fossa dura from posterior to anterior under lumbar CSF drainage, identifying the arcuate eminence, GSPN, and foramen ovale (V3). Place Greenberg retractor."),
                ApproachSequentialStep(stepNumber: 2, title: "Kawase Triangle Delineation & Petrous Apex Drilling", detail: "Identify Kawase's rhomboid: GSPN anterolaterally, arcuate eminence posterolaterally, SPS medially, Meckel's cave anteromedially. Under continuous cold irrigation, drill petrous apex with diamond burrs, unroofing the posterior fossa dura from Meckel's cave to the internal acoustic meatus while preserving the cochlea and horizontal ICA."),
                ApproachSequentialStep(stepNumber: 3, title: "SPS Ligation & Tentorial Incision", detail: "Bipolar coagulate, clip, and sharply divide the superior petrosal sinus. Incise the tentorium from the petrous apex toward the tentorial incisura, carefully aiming posterior to the entrance of CN IV. Reflect tentorial flaps to unite middle and posterior cranial fossae into a single wide corridor."),
                ApproachSequentialStep(stepNumber: 4, title: "Trans-Tentorial Tumor Resection & Neurovascular Sparing", detail: "Incise the posterior fossa dura. Identify the petroclival meningioma capsule and devascularize clival feeding branches. Core out the central tumor mass with the ultrasonic aspirator (CUSA). Dissect tumor from the splayed trigeminal nerve (CN V), basilar artery, SCA, CN VI at Dorello's canal, and CN VII/VIII at the IAC.")
            ]
        case .plate054:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Thoracic Exposure & Level Localization", detail: "Prone position on Jackson table with Wilson frame. Midline incision centered over the thoracic OLF level under fluoroscopic guidance. Subperiosteal dissection of paraspinal muscles laterally to the facet joints, preserving facet capsules outside the decompression zone."),
                ApproachSequentialStep(stepNumber: 2, title: "Bilateral Lateral Trough Drilling", detail: "Using an ultrasonic bone scalpel or 3-mm diamond burr under continuous saline irrigation, drill bilateral longitudinal troughs at the medial junction of the pedicles and laminas down to the inner cortex, isolating the ossified laminar bridge."),
                ApproachSequentialStep(stepNumber: 3, title: "Floating Island Thin-Shell Technique", detail: "Thin the central ossified mass to a translucent paper-thin shell using a diamond burr. Strictly avoid inserting Kerrison footplates beneath the ossified shelf to prevent spinal cord impingement."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Decompression & Hemostasis", detail: "Allow the eggshell-thinned ossified ligament to float free on the expanding, pulsating dural sac. If dural ossification is present (tram-track sign), leave the adherent bone island floating. Apply Gelfoam and Surgicel.")
            ]
        case .plate053:
            return [ 
                ApproachSequentialStep(stepNumber: 1, title: "Supine Positioning & Sterile Prep", detail: "Supine position with head rotated 30–45° to the left, exposing the right frontal, retroauricular, and abdominal surgical fields in a single sterile prep."),
                ApproachSequentialStep(stepNumber: 2, title: "Kocher's Point Burr Hole & Ventricular Cannulation", detail: "Right frontal incision at Kocher's point (1 cm anterior to coronal suture, 3 cm lateral to midline). Drill burr hole, coagulate dura, and pass ventricular catheter with stylet aimed toward the ipsilateral medial canthus and EAM to a depth of 5.0–5.5 cm."),
                ApproachSequentialStep(stepNumber: 3, title: "Valve Seating & Subcutaneous Tunneling", detail: "Make a retroauricular pocket for the programmable valve with gravitational anti-siphon unit. Tunnel the distal catheter subcutaneously from head to abdomen using a malleable passer."),
                ApproachSequentialStep(stepNumber: 4, title: "Peritoneal Insertion & Verification", detail: "Perform mini-laparotomy (paramedian or periumbilical), incise the posterior rectus sheath and peritoneum, insert the distal catheter under direct vision, confirm active CSF dripping, and close in layers.")
            ]
        case .plate052:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retrosigmoid Craniectomy & Cisternal CSF Drainage", detail: "Perform keyhole retrosigmoid craniectomy; drain cisterna magna to achieve spontaneous gravity cerebellar relaxation."),
                ApproachSequentialStep(stepNumber: 2, title: "Posterior Capsular Incision & Debulking", detail: "Incise avascular center of tumor dome and debulk with CUSA; map anterior capsule with nerve stimulator (0.05-0.2 mA)."),
                ApproachSequentialStep(stepNumber: 3, title: "IAC Unroofing & Facial Nerve Preservation", detail: "Drill posterior IAC wall to expose fundus; identify CN VII at Bill's bar and dissect medially back to brainstem.")
            ]
        }
    }

    public var catastrophicHazards: [String] {
        switch self {
        case .plate001:
            return [
                "Vertebral Artery Laceration: Lateral dissection > 12 mm from midline on the posterior C1 arch risks catastrophic V3 artery laceration.",
                "Craniocervical Instability: Excessive resection of alar ligaments or transverse band creates fatal atlanto-axial dislocation."
            ]
        case .plate002:
            return [
                "Superior Sagittal Sinus Puncture: Puncturing fontanelle at the midline lacerates the sagittal sinus, causing fatal neonatal hemorrhage.",
                "Ventricular Traversal Beyond 4 cm: Excessive catheter insertion depth penetrates basal ganglia, thalamus, or contralateral ependyma."
            ]
        case .plate003:
            return [
                "PICA Perforator Infarction: Coagulation or avulsion of tortuous PICA tonsillomedullary loops causes fatal lateral medullary (Wallenberg) infarct.",
                "Foramen Magnum Crowding: Inadequate caudal craniectomy leaves an osseous ring compressing edematous cerebellar tonsils into the medulla."
            ]
        case .plate004:
            return [
                "Petrosal Vein (Dandy) Avulsion: Abrupt cerebellar retraction tears bridging petrosal vein at superior petrosal sinus, causing massive bleeding.",
                "Facial Nerve Traction Neuropraxia: Excessive medial retraction against acoustic complex causes permanent postoperative Bell's facial palsy."
            ]
        case .plate005:
            return [
                "Orbital Periorbita Violation: Piercing the periorbital sheath causes orbital fat herniation, obscuring the field and causing globe injury.",
                "TMJ Disruption & Malocclusion: Osteotomies placed too posteriorly violate articular eminence and temporomandibular joint, causing chronic trismus."
            ]
        case .plate006:
            return [
                "V3 Vertebral Artery Thrombosis: Aggressive manipulation of mobilized V3 segment causes intimal dissection, occlusion, or cerebellar stroke.",
                "Excessive Occipital Condylectomy: Resecting > 50% of the occipital condyle destabilizes the craniocervical junction, necessitating occipitocervical fusion."
            ]
        case .plate007:
            return [
                "Complete Facetectomy Instability: Resecting > 50% of the pars and superior articular process creates iatrogenic spondylolisthesis.",
                "Dural Laceration in Stenotic Gutter: Blindly biting under hypertrophic ligamentum flavum without plane separation causes large CSF durotomy."
            ]
        case .plate008:
            return [
                "Anterior Choroidal Artery Occlusion: Inadvertently incorporating the AChA into the aneurysm clip causes posterior limb internal capsule infarction and hemiplegia.",
                "Premature Aneurysm Rupture: Dissecting aneurysm sac prior to securing proximal ICA control causes catastrophic intraoperative hemorrhage."
            ]
        case .plate009:
            return [
                "Superficial Sylvian Vein Thrombosis: Coagulating or stretching superficial Sylvian veins leads to severe frontal/temporal venous infarction and aphasia.",
                "Middle Cerebral Artery Perforator Injury: Stray micro-knife cuts in the distal fissure sever M2 lenticulostriate or insular perforating branches."
            ]
        case .plate010:
            return [
                "Jugular Venous Kinking: Excessive chin-tuck (< 2 fingerbreadths) kinks internal jugular vein, causing sudden cerebellar venous engorgement.",
                "Transverse-Sigmoid Sinus Tear: Placing initial burr hole directly over the asterion punctures the transverse-sigmoid angle in 40% of cases."
            ]
case .plate011:
            return [
                "Iatrogenic Neurological Deficit: Aggressive blind intradiscal curettage risks puncturing anterior annulus and tearing aorta or iliac vessels.",
                "Failed Back Syndrome: Inadequate foraminal decompression of entrapped exiting nerve root leaves persistent intractable radiculopathy."
            ]
        case .plate012:
            return [
                "Superficial Sylvian Vein Thrombosis: Excessive retraction or coagulation of superficial Sylvian veins leads to severe venous infarction and speech arrest.",
                "Middle Cerebral Artery Perforator Injury: Dissecting distal Sylvian cleft without sharp micro-scissor release risks tearing critical insular M2/M3 branches."
            ]
        case .plate013:
            return [
                "PICA Perforator Stroke: Coagulating or stretching PICA tonsillar loops causes fatal lateral medullary (Wallenberg) infarction.",
                "Pseudomeningocele & CSF Fistula: Inadequate watertight dural closure produces persistent posterior fossa fluid collections and meningitis risk."
            ]
        case .plate014:
            return [
                "Vertebral Artery Laceration: Misguided C1 or C2 screw trajectory entering the transverse foramen tears vertebral artery, causing catastrophic bleeding or stroke.",
                "Spinal Cord Contusion: Medial drill breach into C1 or C2 neural canal causes direct mechanical cord transection or quadriplegia."
            ]
        case .plate015:
            return [
                "Carotid Sheath or Esophageal Perforation: Palpate carotid pulse and inspect medial retractor blade under headlight to ensure esophagus is not trapped.",
                "Vertebral Artery Injury: Stray lateral drilling beyond the uncinate process risks catastrophic bleeding from the V2 segment.",
                "Recurrent Laryngeal Nerve Palsy: Intermittently deflate endotracheal cuff after retractor placement to restore mucosal perfusion."
            ]
        case .plate016:
            return [
                "Facial Nerve (GSPN) Traction Palsy: Aggressive extradural elevation of temporal lobe tears GSPN, transmitting traction to geniculate ganglion and causing facial paralysis.",
                "Temporal Lobe Venous Infarction: Excessive fixed subtemporal brain retraction lacerates vein of Labbé, precipitating hemorrhagic temporal lobe infarction."
            ]
        case .plate017:
            return [
                "Superior Orbital Fissure Syndrome: Over-aggressive drilling of lateral sphenoid wing into SOF injures CN III, IV, V1, and VI, causing total ophthalmoplegia.",
                "Premature Aneurysm Rupture: Inadvertent traction on carotid or Sylvian cisterns prior to securing proximal vascular control causes catastrophic hemorrhage."
            ]
        case .plate018:
            return [
                "Delayed Frontal Sinus Mucocele: Failure to completely exenterate frontal sinus mucosa leads to late infected intracranial mucocele.",
                "Severe Abulia & Akinetic Mutism: Excessive bilateral frontal lobe retraction destroys bilateral anterior cingulate gyri, leaving irreversible mutism."
            ]
        case .plate019:
            return [
                "Vein of Trolard Occlusion: Sacrificing or kinking dominant parietal bridging veins produces venous hypertension, brain swelling, and dense sensory hemiplegia.",
                "Sagittal Sinus Air Embolism: Laceration of superior sagittal sinus without rapid irrigation or head-down positioning allows fatal venous air embolism."
            ]
        case .plate020:
            return [
                "Transverse-Sigmoid Sinus Tear: Placing burr hole directly over asterion tears the venous sinus confluence in 40% of patients.",
                "Postoperative CSF Rhinorrhea: Unsealed mastoid air cells allow posterior fossa CSF to drain through middle ear and eustachian tube into pharynx."
            ]
case .plate021:
            return [
                "Brain Herniation Over Bone Edges: Craniectomy < 12 cm allows edematous brain to strangulate over sharp bone rims, causing hemorrhagic venous infarction.",
                "Sagittal Sinus Laceration: Carrying superior osteotomy too close to midline (< 2 cm) tears superior sagittal sinus, causing uncontrollable venous bleeding."
            ]
        case .plate022:
            return [
                "Deep Venous Confluence Occlusion: Coagulating or stretching internal cerebral veins or Vein of Galen causes fatal bilateral thalamic and midbrain infarction.",
                "Air Embolism in Sitting Position: Operating in sitting posture risks fatal venous air embolism if transverse sinus or bridging petrosal veins tear."
            ]
        case .plate023:
            return [
                "Foraminal Nerve Root Impingement: Closing the posterior column osteotomy narrows neural foramen; failure to generously unroof exiting root causes severe radiculopathy.",
                "Dural Tear in Buckled Canal: Closing posterior wedge causes dura to fold and buckle; ensure dura does not get pinched between cut bony surfaces."
            ]
        case .plate024:
            return [
                "Anterior Column Hinge Disruption: Breaking through the anterior vertebral wall during wedge closing causes catastrophic sagittal shear translation and cord transection.",
                "Massive Epidural Hemorrhage: Exiting through pedicle walls tears lateral Batson venous plexus; pack bone wax and hemostatic matrix before closing."
            ]
        case .plate025:
            return [
                "Wernicke Aphasia: Resecting > 3.5 cm of dominant lateral temporal lobe destroys posterior superior temporal gyrus, causing permanent receptive language loss.",
                "Brainstem Infarction: Violating the arachnoid of the ambient cistern during mesial hippocampal dissection injures posterior cerebral artery perforators to midbrain."
            ]
        case .plate026:
            return [
                "Pleural Violation & Pneumothorax: Stray dissection during rib head mobilization lacerates parietal pleura; inspect for air leaks and repair immediately.",
                "Segmental Radicular Artery Tear: Dissecting near the intervertebral foramen risks tearing the artery of Adamkiewicz (T8-L1), causing anterior spinal artery ischemia."
            ]
        case .plate027:
            return [
                "Tract Transection Neurological Deficit: Advancing tubular port across rather than parallel to white matter tracts permanently severs corticospinal motor fibers.",
                "Secondary Hematoma Cavity Re-Bleeding: Vigorous scraping of the cavity periphery pulls on friable lenticulostriate arterioles, causing acute recurrent hemorrhage."
            ]
        case .plate028:
            return [
                "Femoral Nerve Lumbar Plexus Palsy: Retractor blade excursion into posterior 2/3 of psoas pinches the femoral nerve trunk, causing permanent quadriceps paralysis.",
                "Great Vessel Laceration: Straying anterior to the anterior longitudinal ligament tears the abdominal aorta or IVC, causing catastrophic exsanguination."
            ]
        case .plate029:
            return [
                "Exiting Nerve Root Traction Injury: Passing instruments into Kambin's triangle without unroofing superior foramen tears or stretches the exiting nerve root.",
                "Cage Retropulsion into Spinal Canal: Inadequate posterior rod compression allows interbody spacer to back out into the thecal sac postoperatively."
            ]
        case .plate030:
            return [
                "Internal Carotid Artery Rupture: Stray drilling beyond the medial optico-carotid recess or sellar boundary lacerates cavernous ICA, causing catastrophic fatal hemorrhage.",
                "Postoperative CSF Fistula & Meningitis: Failure to achieve watertight multilayer reconstruction of diaphragm sellae breach leads to CSF rhinorrhea and meningitis."
            ]
case .plate031:
            return [
                "C8 Nerve Root Traction: Avoid excessive lateral retraction on exiting root during disc fragment retrieval or osteophyte resection.",
                "Vertebral Artery & Canal Breach: Direct lateral mass screws 20-30° lateral and superior; confirm T1 pedicle trajectory with intraoperative fluoroscopy.",
            ]
        case .plate032:
            return [
                "Major Vascular Laceration (Iliac / Vena Cava): Carefully mobilize and retract vessels with blunt instruments; maintain vigilant awareness of iliolumbar vein at L4–L5.",
                "Lumbar Plexus / Femoral Nerve Neuropraxia: Enforce safe transpsoas corridor within anterior half of disc space; restrict retractor time to <20 minutes with neuromonitoring.",
            ]
        case .plate033:
            return [
                "Frontal Sinus Breach: Verify frontal sinus lateral extent on preoperative 3D CT; if breached, cranialise, mucosalize, and seal with vascularized pericranium.",
                "Supraorbital Nerve / Frontalis Branch Paresis: Keep eyebrow incision strictly within hair follicle margin and stay lateral to supraorbital notch; avoid excessive traction on orbicularis oculi.",
            ]
        case .plate034:
            return [
                "Catastrophic Cord Herniation on Traction: Never attempt closed reduction without MRI exclusion of traumatic disc extrusion; extruded disc can be dragged into cord during reduction.",
                "Vertebral Artery Occlusion / Dissection: Obtain CTA/MRA; monitor for posterior inferior cerebellar artery (PICA) or brainstem ischemia from facet subluxation trauma.",
            ]
        case .plate035:
            return [
                "Transverse Ligament Incompetence: Check MRI for transverse atlantal ligament disruption; anterior screw is contraindicated if ligament is torn (requires C1-C2 fusion).",
                "Screw Cut-Out / Esophageal Perforation: Ensure trajectory anchors in dense apical cortex; maintain gentle blunt retraction on esophagus and hypopharynx during anterior approach.",
            ]
        case .plate036:
            return [
                "Conus Medullaris / Root Impingement on Tamp: Never attempt blind anterior fragment impaction from posterior approach; direct bone tamp under direct endoscopic or ultrasound vision.",
                "Loss of Reduction & Implant Failure: Assess anterior column support; if Load Sharing Classification score >6, supplement with anterior/lateral corpectomy or cage reconstruction.",
            ]
        case .plate037:
            return [
                "Ischemic Root Injury from Over-Retraction: Do not vigorously retract a severely tense, ischemic thecal sac; widen bone resection (facet undercut) rather than forcing root retraction.",
                "Dural Tear in Stretched Thin Dura: Dissect plane between disc fragment and dural sac with micro-dissectors; repair any dural laceration with 4-0/5-0 sutures and fibrin onlay.",
            ]
        case .plate038:
            return [
                "Massive Tumor Hemorrhage: Obtain preoperative angiography/embolization for hypervascular metastases (e.g. renal cell, thyroid); prepare cell-saver and bipolar cautery.",
                "Spinal Instability Post-Decompression: Calculate SINS score; never decompress without instrumentation when middle/posterior columns or facet complexes are compromised.",
            ]
        case .plate039:
            return [
                "Cauda Equina Nerve Rootlet Entrapment: Inspect the fistula mouth; ensure herniated nerve rootlets are gently reduced into thecal sac before placing suture bites.",
                "Persistent CSF Leak & Wound Dehiscence: Perform Valsalva test to 30 cmH2O under irrigation; ensure tension-free, watertight fascial closure and consider temporary lumbar drain.",
            ]
        case .plate040:
            return [
                "Aneurysm Re-rupture During EVD Placement: Avoid precipitous CSF decompression; drain CSF slowly and maintain transmural pressure gradient across aneurysm wall.",
                "Delayed Cerebral Ischemia (Vasospasm): Administer oral nimodipine for 21 days; treat refractory symptomatic vasospasm promptly with endovascular intra-arterial vasodilators or angioplasty.",
            ]
        case .plate041:
            return [
                "Hematoma Expansion / Active Re-bleeding: Enforce strict blood pressure control (<140 mmHg) within first 6 hours; monitor for 'spot sign' on CTA indicating active contrast extravasation.",
                "Ventricular Catheter Obstruction by Clot: Maintain continuous EVD patency; flush sterilely or use intraventricular thrombolytics if catheter occludes with dense thrombus.",
            ]
        case .plate042:
            return [
                "C5 Nerve Root Palsy: Limit excessive posterior cord drift; perform prophylactic C4-C5 foraminotomies and avoid hyper-lordotic over-correction during posterior decompression.",
                "Vertebral Artery Injury During Uncinate Resection: Stay within medial 15 mm of uncinate process; keep high-speed diamond burr lateral to uncovertebral joint guided by preoperative CTA.",
            ]
        case .plate043:
            return [
                "Never attempt forceful manual manipulation or sudden rotational cracking under anesthesia without traction; high risk of dens displacement or fatal cervicomedullary injury.",
                "Distinguish AARS from Congenital Muscular Torticollis: in AARS, the tight/spastic SCM is CONTRALATERAL to head tilt; in congenital torticollis, tight SCM is IPSILATERAL.",
                "Fielding Type III (>5 mm anterior displacement) and Type IV carry high risk of cord compression and transverse ligament rupture; halo reduction and prompt surgical fusion are mandatory."
            ]
        case .plate044:
            return [
                "NEVER APPLY CERVICAL TRACTION TO TYPE IIA: Traction causes catastrophic gapping of the avulsed posterior disc space and severe spinal cord traction injury.",
                "Verify vertebral artery patency on CTA: bilateral C2 pars fractures pass directly adjacent to the C2 transverse foramina, with risk of traumatic dissection or thrombosis.",
                "Do not attempt aggressive closed reduction in Type III: jumped C2–C3 facets are locked by bone; closed manipulation risks neurological injury. Proceed directly to open reduction."
            ]
        case .plate045:
            return [
                "LUMBAR PUNCTURE IS STRICTLY CONTRAINDICATED: In patients with intracranial mass effect or midline shift, lumbar puncture creates a pressure gradient that precipitates fatal tonsillar coning.",
                "KERNOHAN'S NOTCH PHENOMENON: In uncal herniation, contralateral cerebral peduncle compression produces paradoxical IPSILATERAL hemiparesis; always decompress the side of the dilated pupil and CT lesion.",
                "DURET HEMORRHAGE IRREVERSIBILITY: Symmetrical rostrocaudal brainstem shift shears basilar paramedian perforating arteries; once Duret hemorrhages occur on CT/MRI, brainstem death is imminent."
            ]
        case .plate046:
            return [
                "NEVER CHASE LIPOMA INTO NEURAL PLACODE PARENCHYMA: Subtotal debulking is the standard of care; resecting fat within functional cord tissue causes irreversible lower extremity motor deficits and permanent neurogenic bowel/bladder.",
                "INTRAOPERATIVE NERVE STIMULATION IS MANDATORY: An anomalous low-lying functional nerve root can simulate or travel adherent to the filum or transitional lipoma; never divide any tissue without direct bipolar/monopolar stimulation.",
                "EMERGENT 24–48 HOUR REPAIR IN OPEN MYELOMENINGOCELE: Exposed neural placode lacks protective epidermal barriers; delayed surgical closure risks bacterial ventriculitis, meningitis, and rapidly progressive hydrocephalus."
            ]
        case .plate047:
            return [
                "AVOID NECK EXTENSION DURING INTUBATION: Extension narrows the retro-odontoid space and drives the pannus backward directly into the medulla, risking acute respiratory arrest or quadriplegia; awake fiberoptic intubation in neutral position is mandatory.",
                "HIGH-RIDING VERTEBRAL ARTERY DISRUPTION: Always review preoperative CTA/MRA for a high-riding C2 vertebral artery or persistent intersegmental artery; if the C2 pedicle internal height is < 4 mm, place C2 translaminar or pars screws instead of pedicle screws to prevent fatal arterial laceration.",
                "UNNECESSARY ANTERIOR SURGICAL MORBIDITY: Do not perform transoral, transnasal, or transcervical anterior odontoid resection; posterior stabilization alone induces spontaneous regression in >95% of cases without the high risk of pharyngeal contamination and CSF fistula."
            ]
        case .plate048:
            return [
                "NEVER COAGULATE OR RESECT SURFACE CORONAL VEINS: The serpentine dorsal veins are normal draining channels engorged by high pressure; coagulating or resecting them causes acute, catastrophic, irreversible spinal cord venous infarction and permanent flaccid paraplegia.",
                "RULE OUT ARTERY OF ADAMKIEWICZ ON DSA: Always perform superselective angiography of the feeding intercostal/lumbar artery to verify that the anterior spinal artery (radiculomedullary artery of Adamkiewicz) does NOT originate from the same pedicle before embolization or surgical clipping.",
                "AVOID SYSTEMIC HYPOTENSION: Congested, edematous spinal cord has critically compromised capillary perfusion; keep mean arterial pressure (MAP) > 85 mmHg throughout surgery and early postoperative recovery to prevent watershed ischemia."
            ]
        case .plate049:
            return [
                "MISSING OCCULT TAL RUPTURE: Up to 15% of open-mouth plain X-rays underestimate lateral mass overhang due to radiographic magnification errors; thin-cut coronal CT or MRI is mandatory to prevent unrecognized instability and late myelopathy.",
                "OVER-DISTRACTION DURING TRACTION: Never apply aggressive traction in patients with concurrent, unrecognized atlanto-occipital dissociation (AOD); always calculate the Powers ratio and CCI (condyle-C1 interval) before initiating cervical traction.",
                "VERTEBRAL ARTERY INJURY DURING C1 LATERAL MASS SCREW PLACEMENT: The vertebral artery grooves the superior surface of the C1 posterior arch immediately above the lateral mass; stay strictly on the inferior border of the C1 arch and visualize the medial wall of the lateral mass."
            ]

        case .plate050:
            return [
                "CATASTROPHIC DURAL TEAR FROM PEELING DURAL OSSIFICATION: In continuous OPLL, up to 30% of cases exhibit dural ossification (DO / double-layer sign on axial CT) where the OPLL has penetrated and replaced the dura mater. Never grab or peel the ossified mass with Kerrison rongeurs; always thin it with a diamond burr and float it on pulsating arachnoid to avoid giant dural defects, pseudomeningocele, and subarachnoid hemorrhage.",
                "VERTEBRAL ARTERY LACERATION DURING LATERAL CORPECTOMY: The uncinate processes mark the absolute lateral safety boundary (~15-18 mm total width). Exceeding the lateral margin of the uncinates into the transverse foramen risks catastrophic laceration of the V2 vertebral artery; maintain strictly midline orientation with fluoroscopic guidance.",
                "EARLY GRAFT DISLODGEMENT IN MULTI-LEVEL ACCF WITHOUT POSTERIOR REINFORCEMENT: A 2-level or 3-level anterior cervical corpectomy has a high pseudarthrosis and cage kick-out rate (up to 30%) with anterior plating alone. Always reinforce multi-level corpectomy constructs with posterior instrumented arthrodesis (360° stabilization)."
            ]

        case .plate051:
            return [
                "Ophthalmic Anastomosis Reflux: Inadvertent migration of liquid embolic through meningolacrimal anastomoses causes central retinal artery occlusion and blindness.",
                "Facial Nerve Palsy via Petrosal Branch: Embolizing proximal to the petrosal branch causes ischemia of the intra-petrous facial nerve (Bell's palsy)."
            ]

        case .plate090:
            return [
                "PERMANENT THENAR DENERVATION & APE-HAND DEFORMITY VIA MOTOR BRANCH TRANSECTION: Inadvertently dividing the ligament too far radially or encountering an unrecognized transligamentous motor branch (20% incidence) lacerates the thenar branch, causing irreversible atrophy of APB, OP, and FPB with loss of thumb opposition.",
                "PULSATILE PALMAR HEMATOMA & DIGITAL ISCHEMIA VIA SUPERFICIAL PALMAR ARCH LACERATION: Extending the retinacular incision distal to Kaplan's line or blindly plunging scissors through the distal fat pad lacerates the superficial palmar arterial arch, producing torrential arterial bleeding in the confined palmar space.",
                "PERSISTENT CARPAL TUNNEL SYMPTOMS VIA INCOMPLETE DISTAL RETINACULAR RELEASE: Failing to divide the thickened distal-most fibers of the transverse carpal ligament overlying the distal fat pad leaves a tight constricting band that prevents median nerve decompression and causes immediate surgical failure.",
                "DISABLING PALMAR HYPERPATHIA & NEUROMA VIA PALMAR CUTANEOUS NERVE INJURY: Plunging across the wrist crease radial to the palmaris longus or making transverse wrist incisions lacerates the palmar cutaneous branch of the median nerve (PCBMN), causing intractable burning scar pain and neuroma formation."
            ]


        case .plate091:
            return [
                "Vertebral Artery Laceration: Lateral corpectomy drilling beyond the uncinate processes tears the V2 vertebral artery; preserve uncinate lateral walls as shields.",
                "Endplate Subsidence: Over-aggressive endplate decortication into cancellous bone causes cage subsidence and progressive cervical kyphosis."
            ]
        case .plate092:
            return [
                "Donor Nerve Motor Deficit: Harvesting > 15% of ulnar or median nerve diameter causes permanent intrinsic hand weakness; rigorously map with nerve stimulator.",
                "Tension at Coaptation: Mobilize donor fascicles proximally to achieve completely tension-free micro-suture line; tension causes neuroma-in-continuity failure."
            ]
        case .plate093:
            return [
                "Distal Vessel Perforation: Advancing micro-guidewire or stent beyond occluded segment risks arterial rupture and catastrophic subarachnoid hemorrhage.",
                "Distal Clot Fragmentation: Withdrawing stent without proximal balloon flow arrest allows clot fragments to embolize into unaffected anterior cerebral territories."
            ]
        case .plate094:
            return [
                "Dural Puncture & Epidural Hematoma: Forcing paddle into scarred epidural space risks dural laceration or spinal cord compression; abort if resistance is felt.",
                "Lead Migration: Inadequate anchoring to deep supraspinous fascia allows caudal displacement, causing loss of therapeutic paresthesia coverage."
            ]
        case .plate095:
            return [
                "Neural Placode Desiccation: Prolonged exposure causes irreversible motor loss; keep placode constantly bathed in warm, sterile isotonic saline.",
                "CSF Fistula & Wound Breakdown: Incomplete dural hermetic seal allows persistent CSF leakage, precipitating neonatal bacterial meningitis."
            ]
        case .plate096:
            return [
                "Venous Sinus & Major Vessel Laceration: Bone drilling flush with dural sinuses (transverse/sigmoid) or iliac vessels mandates diamond burr and bone wax backup.",
                "Neuromonitoring Signal Loss: Abrupt drop in MEP/SSEP warrants immediate cessation of distraction/retraction, mean arterial pressure elevation, and vector reassessment."
            ]
        case .plate097:
            return [
                "Posterior Cortex Penetration: Steering guide wire or drill too far posteriorly penetrates the spinal canal, injuring the cervicomedullary junction.",
                "Apical Over-Penetration: Driving screw beyond the apex of the dens risks piercing the alar ligament and puncturing the atlanto-occipital dura."
            ]
        case .plate098:
            return [
                "Excessive Endplate Resection: Over-aggressive burring of endplate cortical bone leads to early prosthesis subsidence and loss of cervical lordosis.",
                "Off-Center Prosthesis Placement: Lateral or oblique placement creates asymmetrical kinematics, accelerated facet arthrosis, and heterotopic ossification."
            ]
        case .plate099:
            return [
                "C8 Nerve Root Impingement: Failure to perform generous foraminotomy before closing osteotomy traps C8 root, causing permanent hand intrinsic paralysis.",
                "Vertebral Artery Injury: Ensure preoperative CTA confirms C7 does not harbor an anomalous entering vertebral artery before pedicle resection."
            ]
        case .plate100:
            return [
                "Iliac Vessel Laceration: Stray traction or un-cushioned retractor blade pressure against the common iliac vein causes catastrophic retroperitoneal hemorrhage.",
                "Sympathetic Trunk Disruption: Cautery along the anterolateral vertebral body risks damaging the sympathetic chain, causing lower extremity temperature asymmetry."
            ]
        case .plate101:
            return [
                "Lumbar Plexus Neuropraxia: Posterior retractor blade excursion beyond anterior 1/3 of psoas pinches femoral nerve; limit retractor time to < 20 minutes.",
                "Great Vessel Laceration: Anterior retractor drift beyond anterior longitudinal ligament risks fatal laceration of the aorta or inferior vena cava."
            ]
        case .plate102:
            return [
                "Sudden Spinal Translation: Removing anterior and posterior columns without a locked unilateral stabilizing rod causes immediate transection of the spinal cord.",
                "Spinal Cord Hypoperfusion: Over-shortening or over-distraction during cage expansion jeopardizes anterior spinal artery perfusion; maintain MAP >= 85 mmHg."
            ]
        case .plate103:
            return [
                "Pleural Tear & Tension Pneumothorax: Sharp instruments in the extrapleural space risk pleural tear; repair immediately or place chest tube if breached.",
                "Epidural Venous Hemorrhage: Profuse bleeding from ventral venous plexus requires bipolar cautery and hemostatic matrix before tumor entry."
            ]
        case .plate104:
            return [
                "Domino Connector Slippage: Inadequate set screw torque on axial connectors leads to hardware disengagement and loss of correction.",
                "Thoracic Pedicle Breach: Small thoracic pedicle diameters risk medial spinal canal breach or lateral vascular injury; verify with intraoperative imaging."
            ]
        case .plate105:
            return [
                "Rotational Burr Laceration: Stray contact between rotating burr and thin dural sleeves causes immediate CSF blast and neural injury; always shield with cottonoids.",
                "Incomplete Ventral Spur Resection: Leaving a prominent ventral bony ridge prevents full spinal cord descent and leads to recurrent cord tethering."
            ]
        case .plate106:
            return [
                "Sacral Canal Breach: Trajectory steered too posteriorly risks violating the S1 neural canal and injuring traversing S1 sacral nerve roots.",
                "Superior Gluteal Bundle Injury: Starting trajectory placed too far caudal or exiting into greater sciatic notch lacerates superior gluteal artery and nerve."
            ]
        case .plate089:
            return [
                "Medial Septum Kinking / Bowstringing: Failure to excise medial intermuscular septum causes acute compressive ischemia of anteriorly transposed nerve.",
                "MACN Neuroma Formation: Inadvertently dividing cutaneous branches during superficial flap elevation causes incapacitating dysesthesias."
            ]

        case .plate088:
            return [
                "V3 Vertebral Artery Laceration: Stray drilling lateral to C1 sulcus arteriosus causes massive arterial bleeding and cerebellar/brainstem stroke.",
                "Hypopharyngeal Obstruction / Dysphagia: Fixing occipitocervical construct in excessive flexion kinks pharynx, requiring prolonged tracheostomy."
            ]

        case .plate087:
            return [
                "Left Common Iliac Vein Laceration: Aggressive vein retraction or unclipped iliolumbar branches cause catastrophic retroperitoneal venous hemorrhage.",
                "Retrograde Ejaculation via Hypogastric Plexus Injury: Using monopolar electrocautery or over-stretching prevertebral plexus paralyzes bladder neck sphincter."
            ]

        case .plate086:
            return [
                "Basilar Artery Apex / Perforator Rupture: Blind perforation through opaque ventricular floor risks puncture of an elevated, ectatic basilar apex.",
                "Hypothalamic / Forniceal Contusion: Shearing forniceal pillars or lateral hypothalamic walls during scope manipulation causes autonomic storm and memory loss."
            ]

        case .plate085:
            return [
                "FATAL INTERNAL ILIAC VESSEL LACERATION VIA POSTERIOR-ONLY BLIND RESECTION: Attempting sacral osteotomy or specimen mobilization posteriorly without prior anterior mobilization of the iliac vessels and presacral venous plexus tears the tethered internal iliac vessels, producing catastrophic, inaccessible retroperitoneal exsanguination. Stage 1 anterior release and protective spacer placement are absolute requirements.",
                "INTRATUMORAL CAPSULAR VIOLATION & LOCAL RECURRENCE: Breaching the chordoma pseudocapsule during osteotomies or blunt specimen traction spills gelatinous tumor cells across the pelvic and gluteal beds, increasing local recurrence from <10% (wide R0 margin) to >80% (intralesional). The osteotomy lines must maintain continuous normal bone and soft-tissue margins around the tumor.",
                "MASSIVE PELVIC HERNIATION & WOUND DEHISCENCE VIA INADEQUATE DEAD SPACE CLOSURE: High sacrectomy creates an enormous empty pelvic cavity. Failure to obliterate this dead space with robust vascularized muscle (bilateral gluteus maximus advancement flaps or rectus abdominis myocutaneous flaps) leads to small bowel herniation, perineal wound breakdown, and fatal deep pelvic infection.",
                "EARLY MECHANICAL FAILURE & NONUNION VIA INSUFFICIENT TRIANGULATION: High sacrectomy completely uncouples the spine from the pelvic ring. Relying on standard single iliac screws or omitting transverse cross-link bars results in rapid hardware fatigue, rod fracture, and screw pullout under cyclical axial and rotational shear forces; quad iliac screws with dual-rod triangulation and an anterior column structural cage are mandatory."
            ]

        case .plate084:
            return [
                "THERMAL OPTIC NEUROPATHY & MONOCULAR BLINDNESS VIA INADEQUATE DRILL COOLING: High-speed diamond burr drilling of the optic strut or orbital roof generates intense frictional heat. Omitting continuous, high-volume saline irrigation transfers thermal energy through the thin bony canal wall into the optic nerve sheath, causing instant, irreversible thermal coagulative necrosis and ipsilateral blindness.",
                "CATASTROPHIC PREMATURE ANEURYSM RUPTURE VIA INADEQUATE PROXIMAL CONTROL: Attempting to dissect or manipulate the aneurysm dome without first releasing the distal dural ring (DDR) or preparing for cervical carotid exposure leaves the surgeon without proximal vascular control. An intraoperative rupture under systemic arterial pressure produces torrential arterial bleeding in a cramped bone-restricted corridor, precipitating stroke or death.",
                "CENTRAL RETINAL ARTERY INFARCTION VIA OPHTHALMIC ARTERY CLIP OCCLUSION: Accidental incorporation or kinking of the ophthalmic artery origin within the clip blades or thermal thrombosis from bipolar cautery arrests blood flow to the central retinal artery, resulting in immediate permanent monocular blindness. Microvascular Doppler and ICG angiography confirmation is mandatory prior to final dural closure.",
                "CAVERNOUS SINUS VENOUS LACERATION & CRANIAL NERVE PALSY VIA INFERIOR PLUNGING: Violating the proximal dural ring (PDR) or plunging into the superior orbital fissure during ACP extraction lacerates the anterosuperior venous lakes of the cavernous sinus. Aggressive bipolar electrocautery in this region damages CN III (oculomotor) and CN VI (abducens); venous bleeding must be controlled with gentle hemostatic matrix packing (Floseal/Surgicel) rather than cautery."
            ]

        case .plate083:
            return [
                "EXITING NERVE ROOT LACERATION & DYSESTHESIA VIA VENTRAL PLUNGING: Docking the cannula too far anteriorly in the foramen or rotating the bevel ventrally pinches the exiting dorsal root ganglion (DRG) against the vertebral body. This causes excruciating, intractable post-discectomy radicular burning and motor foot drop. The bevel must always face the SAP to shield the exiting root.",
                "IATROGENIC SEGMENTAL INSTABILITY VIA EXCESSIVE FACET REAMING: Over-aggressive reaming that breaches the dorsal pars interarticularis or resects >50% of the superior articular process compromises the posterior tension band. This creates progressive post-discectomy spondylolisthesis requiring secondary spinal fusion.",
                "EPIDURAL INTRACRANIAL HYPERTENSION VIA PRESSURIZED FLUID IRRIGATION: Utilizing automated pressurized fluid pumps (>50–60 mmHg) in the presence of an occult dural tear forces irrigation fluid cranially up the spinal canal into the intracranial subarachnoid space, triggering severe retro-orbital pain, intraoperative seizures, and acute coma.",
                "RETROPERITONEAL GREAT VESSEL INJURY VIA DEEP ANTERIOR VIOLATION: Advancing rongeurs or cannulae deeper than 30 mm through the disc space breaches the anterior annulus and anterior longitudinal ligament (ALL). This lacerates the retroperitoneal common iliac vessels, resulting in torrential occult hemorrhage and rapid hemorrhagic shock."
            ]

        case .plate082:
            return [
                "POSTERIOR FOSSA SYNDROME & CEREBELLAR MUTISM VIA VERMIAN TRANSECTION: Splitting the inferior vermis or aggressive lateral retraction damaging the dentate nuclei precipitates delayed post-resection cerebellar mutism, severe emotional lability, and truncal ataxia in pediatric patients. The telovelar approach via the cerebellomedullary fissure eliminates vermian splitting.",
                "NUCLEAR BRAINSTEM INJURY & FACIAL DIPLEGIA VIA RHOMBOID FOSSA TRACTION: Applying bipolar cautery, traction, or aggressive suction directly to the floor of the fourth ventricle (facial colliculus) destroys the underlying abducens (CN VI) nucleus and internal genu of the facial (CN VII) nerve, causing permanent conjugate gaze palsy and peripheral facial paralysis.",
                "ACUTE AUTONOMIC HEMODYNAMIC COLLAPSE VIA OBEX & VAGAL TRIGONE VIOLATION: Excessive mechanical pressure or thermal injury on the obex, area postrema, or vagal trigone triggers immediate life-threatening intraoperative bradycardia, malignant hypertension, or respiratory arrest.",
                "LATERAL MEDULLARY (WALLENBERG) INFARCTION VIA PICA TRUNK OCCLUSION: Inadvertent clipping, electrocoagulation, or stretch-avulsion of the main trunk of the Posterior Inferior Cerebellar Artery (PICA) during tonsillar mobilization produces catastrophic lateral medullary infarction with Horner syndrome, ipsilateral ataxia, contralateral thermoanalgesia, and intractable dysphagia."
            ]

        case .plate081:
            return [
                "CATASTROPHIC PROXIMAL JUNCTIONAL KYPHOSIS / FAILURE (PJK/PJF) VIA SAGITTAL UNDER-CORRECTION: Under-correcting lumbar lordosis (failing to achieve PI - LL < 10°) leaves persistent positive sagittal malalignment. The patient is forced into compensatory trunk flexion, focusing massive dynamic torque at the Upper Instrumented Vertebra (T10). This precipitates acute vertebral body fracture, hardware pullout, subluxation, and catastrophic spinal cord compression requiring emergency revision.",
                "SCIATIC NOTCH & SUPERIOR GLUTEAL ARTERY/NERVE VIOLATION VIA S2AI MISPLACEMENT: Breaching the anterior cortex of the ilium or plunging through the greater sciatic notch during S2AI screw placement lacerates the superior gluteal artery (causing life-threatening deep intrapelvic arterial hemorrhage) or injures the sciatic nerve trunk (causing foot drop). Always confirm the screw stays within the dense supra-acetabular bone corridor on iliac teardrop fluoroscopy.",
                "NEUROLOGICAL COLLAPSE & ISCHEMIC CORD TRANSECTION VIA RAPID CANTILEVER OVER-CORRECTION: Applying aggressive, acute cantilever rod reduction across multiple osteotomy sites without continuous tcMEP monitoring kinks or stretches the anterior spinal artery and tethered spinal cord/conus, precipitating instant ischemic paralysis. If tcMEP signals drop >50%, immediately elevate MAP >85 mmHg, release rod cantilever distraction/compression, and perform an immediate hardware audit.",
                "LUMBOSACRAL PSEUDARTHROSIS & DUAL-ROD FATIGUE FRACTURE VIA SINGLE-ROD CONSTRUCTS: Attempting long-segment fusion to the sacrum with single 5.5 mm rods without accessory satellite rods or pelvic fixation results in fatigue failure. Cantilever flexion-extension bending stresses across L4–S1 exceed the endurance limit of titanium/cobalt-chromium, causing bilateral rod fracture and pseudarthrosis in >35% of patients. A multi-rod (quad-rod) construct and rigid S2AI triangulation are mandatory."
            ]

        case .plate080:
            return [
                "POST-LAMINOPLASTY KYPHOTIC DEFORMITY & LOSS OF CORD DRIFT VIA C2 MUSCLE DETACHMENT: Stripping the semispinalis cervicis tendon off the C2 spinous process or operating on a pre-existing kyphotic cervical spine (K-line negative) causes severe progressive post-laminoplasty swan-neck kyphosis and intractable axial neck pain. In a kyphotic spine, the decompressed cord remains tethered against ventral OPLL/disc ridges, leading to irreversible neurological deterioration.",
                "DELAYED C5 MOTOR PALSY VIA ROOT TRACTION NEUROPRAXIA: Excessive posterior spinal cord drift (>4–5 mm) creates acute mechanical traction on the short, horizontally oriented C5 nerve rootlets against the superior articular process. This manifests on postoperative days 2–4 as sudden, severe deltoid and biceps paralysis (5–10% incidence). Always perform prophylactic keyhole unroofing of the C4–C5 neural foramen in high-risk patients.",
                "HINGE FRACTURE, DISPLACEMENT & CANAL RE-CLOSURE VIA COMPLETE BICORTICAL CUTTING: Over-drilling the hinge trough through the inner ventral cortex results in complete bicortical laminar fracture. An unstable, floating hinge can buckle inward into the spinal canal directly contusing the cord, or cause spring-back collapse of the laminoplasty roof with catastrophic canal re-stenosis. Never violate the inner cortex and always secure rigid titanium miniplates.",
                "COMPRESSIVE EPIDURAL HEMATOMA & QUADRIPLEGIA VIA INADEQUATE HEMOSTASIS: The lateral open gutter cuts across extensive epidural venous plexuses surrounding the dural sac. Inadequate bipolar coagulative control or omitting a subfascial closed-suction drain permits rapid postoperative epidural hematoma accumulation under the elevated laminae, causing acute cord compression, quadriplegia, and emergency re-exploration."
            ]

        case .plate079:
            return [
                "INTRACEREBRAL HEMORRHAGE (ICH) & STROKE VIA SULCAL VESSEL OR STRIATOCAPSULAR PERFORATOR TRAVERSAL: Advancing rigid guide cannulae or microelectrodes through a cortical sulcus rather than the crown of a gyrus lacerates pial vessels or deep striatocapsular perforating arteries, precipitating massive intraventricular or basal ganglia hemorrhage with catastrophic hemiplegia and mortality. Always plan trajectories avoiding sulcal vessels on contrast MRI.",
                "ACUTE SEVERE HYPOMANIA, PSYCHOSIS & SUICIDAL IMPULSIVITY VIA VENTROMEDIAL LIMBIC STN STIMULATION: The ventral and medial poles of the STN project to the limbic and associative loops. Misplacing the DBS lead or current spreading ventromedially into the limbic territory induces acute manic disinhibition, hypersexuality, severe depression, or suicidal ideation. Stimulation must remain confined to the dorsolateral motor territory.",
                "THERMAL BRAINSTEM LESIONING & COAGULATION VIA MONOPOLAR ELECTROCUTERY: Activating monopolar electrocautery anywhere on a patient with an implanted DBS system induces high-voltage radiofrequency energy that conducts down the metal lead wires to the uninsulated lead contacts in the subthalamic nucleus and midbrain. This results in instant thermal tissue coagulation, extensive brainstem necrosis, and irreversible coma or death. Strictly enforce a bipolar-only electrocautery protocol.",
                "LOSS OF TARGET ACCURACY VIA VENTRICULAR VIOLATION, CSF LEAK & BRAIN SAG: Trajectories that traverse or breach the ependyma of the lateral ventricle cause acute CSF egress, tension pneumocephalus, and posterior/ventral brain shift (sag). A shift of even 2–3 mm displaces the STN outside the microelectrode mapping range, rendering stereotactic coordinates completely invalid and requiring procedure abortion."
            ]

        case .plate078:
            return [
                "CANAL VIOLATION & CONUS MEDULLARIS INJURY VIA MEDIAL PEDICLE BREACH: At the thoracolumbar junction (T12–L2), the spinal canal houses the conus medullaris and cauda equina roots. Breaching the medial pedicle wall during cannulation or placing an oversized screw directly drives the gearshift probe or screw threads into the dural sac, risking permanent paraplegia, neurogenic bowel/bladder dysfunction, or catastrophic CSF leak. Always palpate 5 bony walls with a ball-tipped probe and confirm biplane fluoroscopy before screw placement.",
                "CATASTROPHIC HARDWARE BREAKAGE & COLLAPSE VIA STANDALONE 2-LEVEL FIXATION: In burst fractures with McCormack load-sharing scores ≥7 (severe comminution), omitting intermediate screws results in cantilever fatigue failure. Standalone 1-above / 1-below short-segment constructs toggle in a parallelogram mode under physiological flexion loads, leading to pedicle screw loosening, rod fracture, and progressive kyphotic collapse in >50% of patients.",
                "OVER-DISTRACTION & NEUROLOGICAL DETERIORATION IN OCCULT TENSION BAND INJURY (PLC RUPTURE): Applying excessive axial distraction across a damaged Posterior Ligamentous Complex (Type B flexion-distraction injury mistaken for an isolated Type A burst) widens the posterior tension band, disrupts segmental stability, and creates severe traction injury to the conus medullaris and roots. Always verify an intact PLC on pre-op MRI before initiating ligamentotaxis.",
                "LATE PSEUDARTHROSIS & KYPHOTIC LOSS VIA FAILED ANTERIOR COLUMN LOAD SHARING: Relying solely on posterior instrumentation without meticulous posterolateral decortication and robust bone grafting leads to delayed non-union. Once metal fatigues, progressive kyphosis and late pain ensue; thorough arthrodesis across transverse processes and facet joints is mandatory."
            ]

        case .plate077:
            return [
                "FATAL BRAINSTEM VENOUS INFARCTION VIA DVA COAGULATION: The Developmental Venous Anomaly (DVA) is the sole functional drainage pathway for normal brainstem parenchyma surrounding the cavernoma. Coagulating, clipping, or sacrificing the DVA results in explosive brainstem venous hypertension, massive edema, hemorrhagic infarction, and catastrophic patient demise. The DVA must remain 100% patent and untouched.",
                "PERMANENT PARINAUD SYNDROME & QUADRIPLEGIA VIA HEMOSIDERIN CURETTAGE: The surrounding golden-yellow hemosiderin rim consists of eloquent, functioning brainstem tissue laden with hemosiderin macrophages. Attempting to curette or resect the hemosiderin capsule to achieve a 'clean margin' directly lacerates the vertical gaze centers, interstitial nucleus of Cajal, or descending corticospinal tracts, causing irreversible upward gaze paralysis, pupillary defects, and quadriplegia. Never scrape the hemosiderin bed.",
                "TROCHLEAR NERVE (CN IV) TRANSECTION AT THE FRENULUM VELI: The trochlear nerve emerges from the dorsal midbrain just caudal to the inferior colliculus and sweeps anterolaterally along the tentorial edge. During arachnoid dissection or pial incision, confusing the translucent CN IV fiber with an arachnoid band or over-retracting the tentorial margin results in nerve transection, causing severe permanent vertical diplopia (head-tilt deficit).",
                "DEEP VENOUS THROMBOSIS & HEMORRHAGIC INFARCTION VIA GALENIC RETRACTION: Excessive upward retraction on the straight sinus or tentorium, or mechanical compression of the vein of Galen or basal vein of Rosenthal, induces acute deep cerebral venous thrombosis. This leads to bilateral thalamic hemorrhagic infarction, coma, and death. Dissect strictly along the cerebellar surface under zero-tension gravity relaxation."
            ]

        case .plate076:
            return [
                "POST-FORAMINOTOMY SEGMENTAL KYPHOSIS VIA >50% FACETECTOMY: Resecting more than 50% of the cervical facet joint destroys the primary posterior column resistance to shear and flexion. In the subaxial cervical spine, this precipitates acute or progressive post-laminectomy kyphotic deformity, intractable mechanical neck pain, and recurrent neural compression requiring revision anterior-posterior 360° fusion. Never violate the 50% facet boundary.",
                "CERVICAL SPINAL CORD INFARCTION VIA MEDIAL INSTRUMENT RETRACTION: The cervical spinal cord is intolerant of any medial retraction. Pushing or leveraging micro-instruments, Kerrison punches, or cottonoids against the thecal sac to visualize foraminal pathology causes acute cord contusion, anterior spinal artery ischemia, and irreversible central cord syndrome or quadriplegia. All dissection vectors must remain strictly lateral along the nerve root axis.",
                "CATASTROPHIC VERTEBRAL ARTERY LACERATION VIA LATERAL PEDICLE VIOLATION: The V2 segment of the vertebral artery courses directly anterior to the lateral aspect of the superior articular process in the transverse foramen. Over-aggressive bone drilling or Kerrison plunging lateral to the lateral wall of the pedicle directly tears the vertebral artery, causing massive arterial hemorrhage, posterior circulation stroke, and pseudoaneurysm formation. Dissection must halt at the lateral pedicle border.",
                "C5/C6 MOTOR ROOTLET AVULSION VIA AGGRESSIVE DISC TRACTION: The motor rootlets lie on the anterior (ventral) aspect of the root sleeve and are thinner and more fragile than the posterior sensory root. Blindly pulling or grasping adherent disc fragments beneath the root can avulse the motor rootlets, resulting in permanent deltoid or biceps paralysis (flaccid arm). Always mobilize the nerve root gently under 16× magnification and extract fragments without traction."
            ]

        case .plate075:
            return [
                "L5 TRACTION NEUROPRAXIA & FOOT DROP VIA OVER-AGGRESSIVE REDUCTION: In spondyloptosis, the L5 nerve roots are chronically tethered over the transverse process, sacral ala, and iliolumbar ligament. Forcing a complete 100% translational reduction stretches the L5 roots against this tether point, causing acute ischemic traction neuropraxia and permanent complete foot drop (EHL/TA paralysis). Always prioritize restoring sagittal lordosis (slip angle) over anatomical translation, and release reduction immediately if intraoperative EMG fires.",
                "CATASTROPHIC SACRAL SCREW PLOW-THROUGH VIA SHORT-SEGMENT FIXATION: The high-grade spondylolisthesis slip plane generates massive shear and flexion-distraction moments. Terminating fixation at S1 without pelvic anchoring leads to rapid S1 pedicle screw plow-through, sacral bone purchase loss, and construct pull-apart within weeks. Triangular spinopelvic fixation incorporating bilateral S2AI or iliac screws is strictly mandatory.",
                "CAUDA EQUINA TRANSECTION OVER UNRESECTED SACRAL DOME: Attempting reduction maneuvers without performing an adequate sacral dome osteotomy forces the cauda equina against the razor-sharp posterosuperior corner of S1. This 'guillotine' effect lacerates the thecal sac and severs sacral nerve roots, causing permanent bowel, bladder, and lower extremity paraplegia. The sacral dome must be fully beveled and flattened before applying any reduction force.",
                "GREAT VESSEL LACERATION DURING TRANS-SACRAL BOHLMAN DRILLING: Drilling the trans-sacral cage corridor from S1 into L5 requires precise depth and trajectory control. Plunging past the anterior cortex of the L5 vertebral body risks catastrophic laceration of the aortic bifurcation, inferior vena cava, or common iliac vessels, resulting in fatal retroperitoneal exsanguination. Always verify guide-wire depth under continuous lateral fluoroscopic guidance."
            ]

        case .plate074:
            return [
                "INTERNAL CAPSULE INFARCTION VIA LENTICULOSTRIATE OR ACHA AVULSION: The medial sphenoid wing meningioma frequently drapes over or envelops the lateral lenticulostriate perforators and the anterior choroidal artery (AChA). Traction, thermal bipolar injury, or vasospasm of these end-arteries produces catastrophic, irreversible posterior limb internal capsule infarction with dense contralateral hemiplegia and hemianesthesia. Never pull or peel tumor blindly off perforating vessels; preserve arachnoid planes and leave tumor flecks.",
                "CATASTROPHIC ICA LACERATION IN AL-MEFTY GROUP I TUMORS: In Group I clinoidal meningiomas, tumor originates distal to the carotid cistern rings and infiltrates the arterial adventitia directly with complete absence of an arachnoid plane. Attempting sharp or blunt dissection to achieve complete tumor clearance causes instant high-flow carotid laceration or avulsion, leading to exsanguinating hemorrhage, stroke, or fatal intraoperative pseudoaneurysm formation. Always leave a thin protective tumor shell on the ICA.",
                "IRREVERSIBLE OPTIC NERVE ISCHEMIA & MONOCULAR BLINDNESS: The optic nerve is vulnerable to both mechanical compression and thermal injury from high-speed drilling during optic canal unroofing and anterior clinoidectomy. Furthermore, excessive devascularization of the superior hypophyseal arterial twigs or ophthalmic artery collateral branches during medial tumor resection triggers acute ischemic optic neuropathy and permanent blindness. Continuous cold irrigation during drilling and gentle micro-dissection of CN II are mandatory.",
                "CRANIAL NERVE PALSIES (CN III, IV, V1, VI) VIA SOF / CAVERNOUS SINUS INVASION: Tumor extension into the superior orbital fissure or lateral cavernous sinus wall directly encases the oculomotor (CN III), trochlear (CN IV), abducens (CN VI), and ophthalmic (V1) nerves. Aggressive curettage or bipolar coagulation within the SOF or cavernous sinus produces permanent complete ophthalmoplegia, ptosis, and corneal anesthesia. Extradural dissection must halt at the outer cavernous sinus layer."
            ]

        case .plate073:
            return [
                "ANTERIOR SPINAL CORD INFARCTION & PERMANENT PARAPLEGIA VIA RETRACTION: The thoracic spinal cord occupies nearly the entire canal and possesses a precarious watershed vascular network supplied by the Great Radiculomedullary Artery (Adamkiewicz, T9–L2). Even minimal, transient medial or posterior retraction of the dural sac against instruments triggers instant anterior spinal artery thrombosis, cord infarction, and irreversible flaccid paraplegia. The cord must remain 100% untouched; all discectomy vectors must be down-and-away into a drilled trench.",
                "CATASTROPHIC VENTRAL CORD AVULSION VIA AGGRESSIVE INTRADURAL PEELING: In giant calcified discs with intradural extension, the calcified osteophyte complex can become densely scarred to the anterior cord pia and anterior spinal artery. Forcing or pulling the calcified shell away from the cord causes cord tearing, pial stripping, or arterial avulsion. Always leave a paper-thin microscopic calcified shell on the pia if cleavage planes are absent.",
                "INTRACTABLE CSF-PLEURAL FISTULA & TENSION PNEUMOCEPHALUS: Over-aggressive anterolateral bone drilling or lateral dissection near the rib head can lacerate the closely adherent parietal pleura. When combined with a ventral dural defect, negative intrathoracic pleural pressure acts as a massive siphon, pulling continuous CSF into the hemithorax and precipitating acute intracranial hypotension, massive pleural effusion, and life-threatening tension pneumocephalus. Always perform an airtight, multilayer dural-pleural tissue barrier.",
                "POSTOPERATIVE KYPHOTIC COLLAPSE & PROGRESSIVE MYELOPATHY: Resecting the pedicle, facet joint, and a significant portion of the vertebral body and disc destabilizes the thoracic anterior and middle columns. Omitting instrumented stabilization leads to acute or progressive post-discectomy kyphosis, hardware pullout, and recurrent anterior cord impingement against the adjacent vertebral rim. Always bridge the pediculectomy with rigid pedicle screw-rod instrumentation."
            ]

                                                                        case .plate072:
            return [
                "ANTERIOR SPINAL ARTERY INFARCTION VIA RADICULAR VEIN REFLUX: During transvenous endovascular embolization, forceful injection of liquid embolic (Onyx/Squid) against high outflow resistance can cause retrograde reflux into the radiculomedullary vein or anterior spinal vein. This triggers acute, irreversible anterior spinal artery thrombosis and catastrophic thoracic spinal cord infarction resulting in permanent paraplegia and loss of bowel/bladder function. Always embolize gently under high-magnification roadmap fluoroscopy and halt injection immediately upon proximal branch filling.",
                "REBOUND INTRACRANIAL HYPERTENSION (RIH) & ACUTE VISUAL LOSS: Chronic high-volume CSF loss induces compensatory hyper-production of CSF by the choroid plexus and downregulation of arachnoid villus outflow capacity. Sudden surgical or endovascular closure of a long-standing CVF causes explosive intracranial hypertension (opening pressures often >40–50 cm H2O). If unrecognized and untreated, acute malignant intracranial hypertension precipitates severe papilledema, retinal hemorrhages, and permanent visual loss. Always have acetazolamide immediately available.",
                "IATROGENIC DURAL TEAR & CONVERSION TO EXTRADURAL CSF LEAK: Aggressive or blunt dissection of the fragile dural root sleeve in an attempt to isolate the fistulous vein can tear the thinned dura. Because CVFs have no preexisting extradural leak, tearing the sleeve converts an occult internal venous shunt into an overt, high-flow extradural pseudomeningocele or pleural CSF fistula. Always dissect strictly with micro-curettes and sharp micro-scissors, and keep muscle pledgets and micro-sutures ready.",
                "PNEUMOTHORAX VIA PARAPLEURAL DISSECTION: In the mid-to-lower thoracic spine, the neural foramen and intercostal nerve sleeve lie directly adjacent to the parietal pleura. Extending the bone removal or lateral soft-tissue dissection too far anteriorly into the rib head or costovertebral joint can lacerate the parietal pleura. Failure to detect a pleural tear can lead to tension pneumothorax or a high-flow CSF-pleural fistula. Always inspect the retro-foraminal plane and verify absence of pleural bubbling under Valsalva before closure."
            ]

                                                                        case .plate071:
            return [
                "IATROGENIC SPINAL CORD TRANSECTION DURING PRONE POSITIONING: Forcing an ankylosed spine with fixed thoracic hyperkyphosis flat onto an operating table or allowing the head/neck to hyperextend during transfer causes catastrophic distraction and posterior displacement across the 3-column chalk-stick fracture plane. This instantaneously severs or crushes the spinal cord, causing permanent quadriplegia or paraplegia. Always construct customized multi-tier chest and pelvic bolsters and maintain continuous MEP/SSEP monitoring throughout positioning.",
                "CATASTROPHIC HARDWARE PULLOUT VIA SHORT-SEGMENT FIXATION: Instrumenting only 1 or 2 levels above and below an AS fracture ignores the massive biomechanical lever arms created by the long rigid ankylosed column. Short-segment constructs suffer a >60% catastrophic failure rate with screw plow-through, hardware pullout, and construct pull-apart within weeks. Rigid fixation MUST extend a minimum of 3 levels above and 3 levels below the fracture apex.",
                "FATAL GREAT VESSEL RUPTURE VIA ACUTE FRACTURE REDUCTION: Attempting to 'straighten' or restore normal lordosis to an acutely fractured ankylosed spine exerts massive distraction and shear tension on the anterior soft tissues. The abdominal aorta, inferior vena cava, or esophageal wall—chronically tethered and scarred to flowing anterior syndesmophytes—can acutely tear, resulting in un-tamponaded exsanguinating retroperitoneal hemorrhage or mediastinitis. Fix the spine strictly in its native pre-morbid sagittal curvature.",
                "POSTOPERATIVE EPIDURAL HEMATOMA RE-ACCUMULATION & SUDDEN PARAPLEGIA: Fractured osteopenic cancellous bone and sheared epidural Batson plexus veins bleed continuously against rigid bone walls. Failing to achieve absolute hemostasis or omitting a deep subfascial closed-suction drain can trigger rapid, silent epidural hematoma re-accumulation with acute postoperative paraplegia. Always deploy thrombin-soaked hemostatic agents and place a high-flow closed subfascial drain."
            ]

                                                                        case .plate070:
            return [
                "INTRAOPERATIVE SEIZURE & STATUS EPILEPTICUS DURING ELECTRICAL STIMULATION: Direct electrical stimulation (DES) above the afterdischarge threshold can trigger focal motor or generalized seizures in awake patients. Uncontrolled seizures lead to airway loss, brain herniation, head movement in rigid pins, and acute emergency general anesthesia conversion. Protocol: Immediately flood the cortical surface with cold (4°C) Ringer's irrigation, halt stimulation immediately, and administer IV levetiracetam (1–2 g) or small propofol bolus (0.5–1 mg/kg) if afterdischarges fail to extinguish within 10 seconds.",
                "PERMANENT BROCA OR WERNICKE APHASIA VIA SUBCORTICAL WHITE MATTER TRANSECTION: Aggressive resection without continuous awake testing can transect the deep subcortical language tracts—the arcuate fasciculus (dorsal phonological stream) or inferior fronto-occipital fasciculus (ventral semantic stream). Inadvertent injury causes permanent, irreversible expressive or receptive aphasia. Resection MUST cease immediately upon eliciting reproducible language hesitation, semantic paraphasia, or phonemic paraphasia during subcortical mapping.",
                "COMPLETE CONTRALATERAL HEMIPLEGIA VIA CORTICOSPINAL TRACT (CST) VIOLATION: The posterior-medial deep margin of frontal and temporal opercular resections abuts the internal capsule and descending corona radiata. Infarction of lenticulostriate perforators or direct thermal/mechanical injury to the corticospinal tract causes devastating, flaccid contralateral hemiplegia. Always maintain dynamic monopolar stimulation with a 5 mm safety margin (1 mA = 1 mm distance) and preserve all white matter fascicles along the internal capsule floor.",
                "ACUTE AIRWAY LOSS & HYPOVENTILATION DURING AWAKE PHASE: Inadequate analgesia from an incomplete scalp block, patient panic, or drug-induced respiratory depression (excessive remifentanil/dexmedetomidine) can cause acute hypoventilation, hypercapnia, severe brain swelling, or airway compromise while the head is rigidly clamped. Always verify dense local block across all 6 cutaneous scalp nerves before incision and have a trained neuroanesthesiologist at the airway with video laryngoscopy and supraglottic airway equipment immediately accessible."
            ]

                                                                        case .plate069:
            return [
                "SACRIFICE OR THROMBOSIS OF CENTRAL ROLANDIC BRIDGING VEINS: The central rolandic vein and vein of Trolard drain critical motor and sensory cortex into the middle third of the SSS. Inadvertent coagulation, excessive traction, or temporary clip occlusions exceeding 15–20 minutes trigger devastating hemorrhagic venous infarction of the precentral gyrus, acute cerebral swelling, and permanent contralateral hemiplegia. Always dissect tumor away from veins and preserve all major venous tributaries.",
                "INTRAOPERATIVE VENOUS AIR EMBOLISM (VAE) VIA UNSEALED SSS OR LATERAL LACUNA: When operating near the apex with the head elevated, negative venous pressure inside the open superior sagittal sinus rapidly sucks atmospheric air into the venous circulation, precipitating acute right heart strain, catastrophic pulmonary embolism, and circulatory collapse. Always maintain intraoperative positive end-expiratory pressure (PEEP), keep sinus defects flooded with wet cottonoids or hemostatic gelatin, and repair the sinus lumen under positive venous pressure.",
                "COMPLETE SSS THROMBOSIS FROM OVER-NARROWED RECONSTRUCTION: Placing patch sutures too deeply across the sinus lumen or using an excessively small venous patch creates intraluminal stenosis and turbulent flow, precipitating acute sinus thrombosis. Acute complete occlusion of the middle/posterior SSS causes malignant bilateral hemispheric edema, intraventricular hemorrhage, and death. Always inspect intraluminal caliber and verify brisk flow with ICG videoangiography.",
                "INTRACTABLE CSF RHINORRHEA / SUBGALEAL HYGROMA: The midline bone cut and D-shaped durotomy over the SSS are subjected to continuous CSF pulsations. Inadequate, non-watertight dural closure over the sinus or failing to seal arachnoid defects leads to extensive subgaleal CSF collections, wound dehiscence, and ascending bacterial meningitis. Always execute watertight dural closure reinforced with an onlay collagen matrix and fibrin sealant."
            ]

                                                                        case .plate068:
            return [
                "ANTERIOR SPINAL ARTERY (ASA) INFARCTION VIA ARTERY OF ADAMKIEWICZ COAGULATION: Coagulating intercostal arteries near the neural foramen in the lower thoracic spine (T9–L2) can sacrifice the Great Anterior Radiculomedullary Artery (Adamkiewicz). This triggers catastrophic anterior spinal cord infarction with permanent, irreversible paraplegia, loss of bowel/bladder control, and dissociated sensory loss. Always review preoperative angiography/CTA and interrogate radicular branches with micro-Doppler before sacrifice.",
                "INTRACTABLE CSF-PLEURAL FISTULA & TENSION PNEUMOCEPHALUS: Failure to achieve a watertight dural closure in the presence of an occult or overt pleural tear allows negative intrathoracic pleural pressure during respiration to continuously siphon CSF into the pleural space. This causes massive pleural effusion, intracranial hypotension, and life-threatening tension pneumocephalus. Always perform a multilayer repair (running suture, onlay collagen matrix, fibrin sealant) and air-tight tissue barrier.",
                "PARIETAL PLEURA LACERATION & TENSION PNEUMOTHORAX / HEMOTHORAX: Careless instrument manipulation during costotransversectomy or extraforaminal tumor mobilization can lacerate the parietal pleura. Unrecognized pleural tears cause intraoperative tension pneumothorax or massive hemothorax. Always perform a saline immersion test under positive-pressure lung recruitment (Valsalva); place a chest tube under direct vision if air leak is detected.",
                "KYPHOTIC DEFORMITY & SPINAL INSTABILITY WITHOUT RIGID INSTRUMENTATION: Unilateral or bilateral costotransversectomy with pediculectomy destabilizes the posterior and middle spinal columns. Resecting the rib head and costovertebral joint destroys the thoracic cage's natural splinting effect, leading to progressive kyphosis, hardware pullout, and delayed cord compression if rigid multi-level instrumented arthrodesis is omitted."
            ]

                                                                        case .plate067:
            return [
                "VERTEBRAL ARTERY (V3/V4) LACERATION DURING CONDYLAR DRILLING OR DURAL RING MOBILIZATION: High-speed diamond burr drilling of the occipital condyle or aggressive mobilization of the fibrous dural ring can tear the vertebral artery wall, triggering torrential arterial bleeding in a confined skull base trough. Always skeletonize the periosteal sheath of V3 under direct vision and maintain temporary proximal clipping access at the C1 groove.",
                "LOWER CRANIAL NERVE (CN IX, X, XI) TRACTION & POSTOPERATIVE BULBAR PALSY: The rootlets of CN IX, X, and XI lie directly over the VA-PICA junction. Excessive mechanical retraction, stretching, or thermal injury causes devastating postoperative bulbar palsy (vocal cord paralysis, loss of gag reflex, intractable aspiration pneumonia, and dependence on tracheostomy/gastrostomy). Always monitor continuous vocal cord EMG and dissect arachnoid bands sharply without nerve traction.",
                "PICA OCCLUSION OR MEDULLARY PERFORATOR SACRIFICE (WALLENBERG SYNDROME): Applying an aneurysm clip that compromises the PICA origin or avulses lateral medullary perforators precipitates lateral medullary infarction (Wallenberg syndrome: ipsilateral ataxia, Horner syndrome, facial numbness, contralateral loss of pain/temperature, and severe dysphagia). Always confirm distal PICA patency with micro-Doppler (>20 cm/s) and ICG videoangiography.",
                "CRANIOCERVICAL INSTABILITY FROM EXCESSIVE CONDYLECTOMY (>50%): Resecting more than 50% of the occipital condyle disrupts the atlanto-occipital joint facet, leading to craniocervical junction instability, progressive neck pain, odontoid upward migration, and basilar invagination. Limit condylar resection strictly to the posterior-medial 1/3; if >50% resection is mandatory, perform upfront occipitocervical fusion (Occiput–C2)."
            ]

                                                                        case .plate066:
            return [
                "ANTERIOR CEREBRAL ARTERY (ACA) LACERATION / BIFRONTAL INFARCTION: The A2 segments of bilateral anterior cerebral arteries and frontopolar branches are frequently draped or encased over the posterior-superior tumor capsule. Blunt traction or careless cautery can tear or occlude the A2 trunks, causing catastrophic bifrontal infarction, profound akinetic mutism, abulia, and paraplegia. Always dissect strictly within the arachnoid plane under high magnification.",
                "POSTOPERATIVE CSF RHINORRHEA & ASCENDING MENINGITIS: Olfactory groove resection penetrates the cribriform plate and ethmoid air cells. Failure to reconstruct a watertight barrier leads to intractable CSF rhinorrhea, pneumocephalus, and life-threatening polymicrobial bacterial meningitis. Always harvest a generous vascularized pericranial flap, drill hyperostotic bone, and perform multilayer skull base closure with fibrin glue.",
                "OPTIC CHIASM DEFRAGMENTATION & TRACTION BLINDNESS: Giant olfactory groove meningiomas displace the optic nerves and chiasm inferoposteriorly into the tuberculum/chiasmatic sulcus. Excessive posterior tumor traction or injury to superior hypophyseal / ophthalmic perforators causes immediate, irreversible bilateral optic atrophy and total visual loss.",
                "AGGRESSIVE SUBFRONTAL RETRACTION & HYPOTHALAMIC CONTUSION: Applying heavy fixed blade retractors to the frontal lobes rather than performing low basal bone removal and internal debulking precipitates severe frontal contusion, brain edema, and hypothalamic dysfunction (hyperthermia, diabetes insipidus, altered mental status). Always rely on low bone removal and internal CUSA cavitation to collapse the tumor."
            ]

                                                                        case .plate065:
            return [
                "BILATERAL FORNIX INJURY & PERMANENT ANTEROGRADE AMNESIA: Excessive mechanical traction, blunt dissection, or bipolar thermal injury across the forniceal pillars causes irreversible bilateral fornix transection, resulting in profound permanent anterograde amnesia (inability to form new memories / severe Korsakoff-like syndrome). Limit retraction to unilateral gentle elevation (<1–2 mm) and never apply unipolar cautery near the forniceal columns.",
                "THALAMOSTRIATE VEIN COAGULATION & BASAL GANGLIA INFARCTION: Coagulating or avulsing the thalamostriate vein at the venous angle causes severe venous hypertension and hemorrhagic infarction of the caudate head and anterior thalamus, manifesting as hemiplegia, somnolence, abulia, and hyperthermia. Always preserve the thalamostriate and septal veins converging into the internal cerebral veins.",
                "INTERNAL CEREBRAL VEIN (ICV) LACERATION IN VELUM INTERPOSITUM: Aggressive upward pulling on the cyst capsule adherent to the roof of the third ventricle tears the paired internal cerebral veins, triggering torrential deep intraventricular hemorrhage with catastrophic tamponade and high mortality. Always sharply dissect the capsule from the third ventricle roof under continuous microscopic visualization.",
                "POSTERIOR CALLOSOTOMY EXTENSION & INTERHEMISPHERIC DISCONNECTION: Extending the anterior callosotomy >2.0–2.5 cm posteriorly into the splenium or midbody causes interhemispheric disconnection syndrome (left-hand apraxia, alexia without agraphia, tactile anomia). Always verify that the callosotomy is restricted strictly anterior to the coronal suture."
            ]

                                                                        case .plate064:
            return [
                "OFF-MIDLINE MYELOTOMY & SEVERE POSTERIOR COLUMN SENSORY ATAXIA: Incising lateral to the true posterior median sulcus into the fasciculus gracilis or cuneatus transects ascending proprioceptive and vibratory fibers, resulting in devastating permanent sensory ataxia, pseudoathetosis of the hands, and loss of joint position sense. Always identify the true avascular midline raphe and confirm symmetry between bilateral DREZ.",
                "INJURY TO THE ANTERIOR SPINAL ARTERY (ASA) & ANTERIOR SPINAL CORD INFARCTION: The main trunk of the ASA runs along the floor of the anterior median fissure directly ventral to the tumor capsule. Aggressive traction, deep bipolar coagulation, or blind scissor cuts along the anterior tumor bed can lacerate or thrombose the ASA, precipitating catastrophic anterior spinal cord infarction and permanent complete quadriplegia.",
                "OVER-TRACTION ON SPAYED DORSAL COLUMNS & QUADRIPLEGIA: Applying high-tension mechanical retractors or excessively tight pial stay sutures to splay the dorsal columns compresses the adjacent lateral corticospinal tracts. Always monitor continuous epidural D-waves; if D-wave amplitude drops >50%, immediately release pial stay sutures and pause surgical manipulation until electrophysiological recovery occurs.",
                "CONFUSING INFILTRATIVE ASTROCYTOMA FOR EPENDYMOMA: Attempting radical en-bloc resection in an infiltrative astrocytoma without a clear capsule destroys viable spinal cord tracts, causing irreversible neurological deficit. If a distinct gliotic cleavage plane cannot be identified under 16× magnification, abort en-bloc resection, perform gentle debulking/biopsy, and halt before violating normal white matter."
            ]

                                                                        case .plate063:
            return [
                "AVULSION OR OCCLUSION OF POSTERIOR THALAMOPERFORATING ARTERIES: The posterior thalamoperforators (paramedian mesencephalic arteries) originate from the posterior wall of the basilar apex and bilateral P1s, supplying the midbrain, reticular activating system, and paramedian thalami. Inadvertent clipping or traction on these micro-vessels causes catastrophic midbrain infarction, permanent coma, locked-in syndrome, or bilateral thalamic necrosis (Percheron-type deficit). Always inspect behind the neck before final clip closure.",
                "STENOSIS OR COMPRESSION OF BILATERAL P1 POSTERIOR CEREBRAL ARTERIES: Applying a clip that impinges on either P1 origin compromises the PCA territory, causing occipital infarction with permanent homonymous hemianopia and temporal lobe ischemia. Always interrogate both P1 branches with micro-Doppler (>25 cm/s) and ICG videoangiography.",
                "OCULOMOTOR NERVE (CN III) TRACTION PALSY: CN III passes directly between P1 and SCA and is vulnerable to retractor pressure or surgical manipulation. Excessive mechanical stretch causes complete third nerve palsy with severe ptosis, pupillary mydriasis, and external ophthalmoplegia (down-and-out eye). Minimize traction and dissect arachnoid bands sharply around the nerve.",
                "PREMATURE BASILAR APEX RUPTURE DURING LILIEQUIST DIVISION: Basilar tip aneurysm domes can adhere densely to the diencephalic membrane of Liliequist or invaginate the floor of the third ventricle. Blunt dissection or rapid CSF drainage can precipitate catastrophic intraoperative rupture before basilar trunk control is secured. Always expose the basilar trunk and establish proximal temporary control below the SCAs prior to manipulating the dome."
            ]

                                                                        case .plate062:
            return [
                "STENOSIS OR OCCLUSION OF THE SUPERIOR OR INFERIOR M2 DAUGHTER TRUNKS: Applying a clip that impinges on either M2 origin or compromises the bifurcation carina causes massive MCA branch infarction. Occlusion of the superior M2 causes contralateral faciobrachial hemiplegia and motor (Broca) aphasia; occlusion of the inferior M2 causes sensory (Wernicke) aphasia and homonymous superior quadrantanopia. Always verify symmetric high-velocity flow (>20 cm/s) with micro-Doppler.",
                "INADVERTENT INJURY OR CLIPPING OF LATERAL LENTICULOSTRIATE ARTERIES: Lateral lenticulostriates arise from the dorsal aspect of distal M1 and can adhere to the posterior neck of the aneurysm. Inadvertent clipping or bipolar coagulation of these end-arteries results in acute infarction of the posterior limb of the internal capsule and putamen, causing irreversible dense contralateral hemiplegia.",
                "PREMATURE INTRAOPERATIVE RUPTURE DURING DISTAL SYLVIAN SPLIT: In laterally pointing or broad-necked MCA aneurysms, the dome often embeds deeply into the superior temporal gyrus or frontal operculum. Forceful blunt separation of the opercula tears the adherent dome before proximal M1 control is established. Always dissect along the distal M2 branches down to the neck with micro-suction and sharp arachnoid release, maintaining proximal M1 temporary control ready.",
                "RESIDUAL ANEURYSM DOG-EAR FROM BROAD-NECK TENSION: Broad-necked MCA aneurysms are prone to clip blade slippage or residual neck dog-ears if a single straight clip is forced across the wide base. An untreated dog-ear leads to rapid aneurysm regrowth or delayed rupture. Always utilize tandem, curved, or fenestrated multi-clip constructs to completely reconstruct the carina."
            ]

                                                                        case .plate061:
            return [
                "INTRAOPERATIVE ANEURYSM RUPTURE DURING FRONTAL LOBE ELEVATION: In anterior-inferior projecting AComA aneurysms, the dome adheres to the optic chiasm and tuberculum sellae dura; premature frontal lobe traction tears the thin-walled dome before proximal control is established. Never elevate the frontal lobe aggressively; always split the Sylvian fissure and establish proximal A1 control before dissecting the chiasmatic cistern.",
                "OCCLUSION OR KINKING OF BILATERAL A2 ARTERIES: Applying a clip that bites across the AComA-A2 junction or causes secondary torque on the A2 origins results in catastrophic anterior cerebral artery (ACA) infarction, leading to profound bilateral lower-extremity paraparesis (bilateral leg paralysis), urinary incontinence, and severe abulia/akinetic mutism. Verify bilateral A2 patency with micro-Doppler (>15 cm/s) and ICG.",
                "AVULSION OF HYPOTHALAMIC & CHIASMATIC PERFORATORS: Posteriorly projecting AComA aneurysms adhere to fine, end-arterial hypothalamic branches supplying the optic chiasm, suprachiasmatic nucleus, and anterior hypothalamus. Clip encroachment or coagulation of these micro-vessels triggers severe short-term memory loss (Korsakoff-like amnesia), electrolyte crises (diabetes insipidus), and hyperthermic autonomic storms.",
                "ISCHEMIC INJURY TO THE RECURRENT ARTERY OF HEUBNER (RAH): Inadvertent clipping or thermal injury to the RAH (which arises near the A1-A2 junction and courses laterally to the anterior perforated substance) causes caudate head and anterior internal capsule infarction, manifesting as contralateral faciobrachial hemiparesis and dysarthria."
            ]

                                                                        case .plate060:
            return [
                "HYPERPERFUSION SYNDROME & INTRACEREBRAL HEMORRHAGE: Sudden high-volume hemodynamic restoration into chronically ischemic, auto-dysregulated cerebral capillary beds can cause capillary blowout, focal brain edema, seizures, and catastrophic hemorrhagic transformation. Maintain strict postoperative systolic blood pressure control (SBP 110–130 mmHg) and serial neurological exams.",
                "DONOR ARTERY KINKING, COMPRESSION, OR THROMBOSIS: Over-tightening scalp closure, inadequate craniotomy bone groove beveling, or compressive postoperative head dressings can compress or kink the donor STA, causing immediate graft thrombosis. Ensure wide bone gouges at entry/exit sites and avoid circular head bandages.",
                "TEMPORARY ISCHEMIC STROKE DURING RECIPIENT CLAMPING: Prolonged temporary occlusion of the cortical M4 recipient (>20–30 minutes) without collateral back-flow can cause permanent cortical infarction and focal neurological deficits (expressive aphasia or hand weakness). Limit clamp time (<20 min), maintain systemic normotension, and administer IV burst-suppression neuroprotection (propofol) during clamping.",
                "WATERSHED SHIFT & PROGRESSIVE ISCHEMIA: Competitive flow from a high-flow bypass can alter watershed hemodynamics, precipitating retrograde thrombosis of pre-existing fragile moyamoya collaterals before indirect neovascularization matures. Monitor with continuous arterial line and avoid aggressive hyperventilation or hypocapnia."
            ]
case .plate059:
            return [
                "INTERNAL CAROTID ARTERY (ICA) INJURY IN PARASELLAR CORRIDOR: Drifting lateral to the parasellar carotid protuberance or over-drilling in Knosp Grade 3–4 tumors can lacerate the cavernous ICA, causing torrential arterial hemorrhage (up to 1000 mL/min). Maintain continuous navigation and Doppler ultrasound; in the event of injury, pack with muscle/Floseal and prepare for emergent endovascular balloon/stent occlusion.",
                "POSTOPERATIVE CSF RHINORRHEA & BACTERIAL MENINGITIS: High-flow intraoperative CSF leaks occur when suprasellar dissection tears the fragile diaphragma sellae or arachnoid membrane. Failure to reconstruct the skull base with a vascularized nasoseptal flap and rigid buttress results in persistent CSF fistula, pneumocephalus, and life-threatening meningitis.",
                "OPTIC APPARATUS DEVASCULARIZATION & POSTOPERATIVE BLINDNESS: Vigorous pulling on the suprasellar tumor capsule or aggressive electrocautery near the tuberculum sellae can injure the superior hypophyseal arteries or optic chiasm, leading to catastrophic postoperative visual loss. Keep dissection sharp and directly on the tumor pseudocapsule under angled visualization.",
                "DIABETES INSIPIDUS & ANTERIOR PANHYPOPITUITARISM: Mistaking compressed normal pituitary gland or traction on the pituitary stalk (infundibulum) during suprasellar curettage causes permanent diabetes insipidus, adipsic hypernatremia, and lifelong panhypopituitarism. Carefully distinguish normal orange-tan pituitary gland tissue from friable whitish-pink adenoma."
            ]
        case .plate058:
            return [
                "Dural Laceration in Inflamed Field: Friable, septic dura tears easily; never forcefully traction adherent epidural phlegmon from thecal sac.",
                "Post-Infection Kyphotic Collapse: Destructive discitis with multi-level facetectomies precipitates progressive cord compression; preserve posterior columns."
            ]
        case .plate057:
            return [
                "SUPERIOR PETROSAL VEIN (VEIN OF DANDY) AVULSION & VENOUS INFARCTION: Coagulating or abruptly tearing the large superior petrosal vein trunk can trigger devastating cerebellar hemorrhagic infarction, brainstem edema, and posterior fossa herniation. The vein must be preserved whenever possible; if minor tributary sacrifice is mandatory, the main drainage trunk into the superior petrosal sinus must remain patent.",
                "AUDITORY NERVE (CN VIII) TRACTION & SENSORINEURAL DEAFNESS: Excessive or sudden retraction on the cerebellum directly stretches the vestibulocochlear nerve (CN VIII) as it enters the internal acoustic meatus. Continuous intraoperative Brainstem Auditory Evoked Potential (BAEP) monitoring is mandatory; latency shifts >0.5 ms or amplitude loss >50% require immediate retractor release and irrigation.",
                "SCA KINKING OR THROMBOSIS & BRAINSTEM STROKE: Over-mobilizing or sharply bending the superior cerebellar artery loop during transposition can cause arterial kinking, intimal dissection, or acute thrombosis. Infarction of the superior cerebellum and dorsal midbrain leads to severe ataxia, Horner syndrome, and pontine ischemia. Always confirm pulsatile, unkinked arterial flow following decompression.",
                "POSTOPERATIVE CSF LEAK & PSEUDOMENINGOCELE: The retrosigmoid keyhole approach requires meticulous watertight dural closure. Any unclosed dural defect allows CSF to track into the neck and retroauricular soft tissues, forming an intractable pseudomeningocele or CSF cutaneous fistula with high risk of meningitis. Augment closure with autologous fascia, pericranium, or dural substitute and fibrin sealant."
            ]
        case .plate056:
            return [
                "PREMATURE VENOUS OCCLUSION & EXPLOSIVE NIDUS RUPTURE: Occluding or tearing the primary draining vein before completing circumferential arterial devascularization abruptly eliminates outflow while high-pressure arterial inflow continues. The nidus balloons instantly and suffers explosive intraoperative blowout. Hemorrhage from an un-devascularized AVM bed is torrential and frequently fatal. The draining vein must remain untouched until the nidus is fully devascularized and the vein darkens.",
                "EN-PASSAGE ARTERIAL CLIPPING & REMOTE CEREBRAL INFARCTION: Arteries running along or adjacent to the AVM nidus may be feeding normal distal cortex ('en-passage' vessels) rather than terminating in the malformation. Inadvertently clipping or coagulating an en-passage artery causes profound remote ischemic stroke and permanent neurological deficit. Every vessel must be dissected under high magnification to confirm its terminal entrance into the nidus before division.",
                "NORMAL PERFUSION PRESSURE BREAKTHROUGH (NPPB): Chronic low-resistance shunting chronically deprives the surrounding cerebral capillary beds, causing maximal vasodilation and loss of normal autoregulatory tone. Following sudden AVM resection and restoration of normal perfusion pressure, the paralyzed capillary beds cannot vasoconstrict, resulting in massive brain swelling, petechial hemorrhages, and fatal hyperemic edema. Prevent with strict postoperative blood pressure control (SBP < 100–110 mmHg) and propofol sedation.",
                "RESIDUAL NIDUS FRAGMENT & POSTOPERATIVE INTRACEREBRAL HEMATOMA: Leaving even a minute microscopic fragment of patent nidus connected to high-pressure arterial inflow carries an exorbitant rebleeding rate—higher than an untreated AVM. The altered post-resection venous outflow dynamics cause residual shunts to rupture during the immediate recovery phase. Always verify complete total obliteration with intraoperative ICG videoangiography and urgent post-op catheter DSA."
            ]
        case .plate055:
            return [
                "COCHLEAR VIOLATION & PERMANENT SENSORINEURAL DEAFNESS: The cochlea lies in the bone directly lateral to the petrous apex, between the GSPN and the IAC fundus. Drifting lateral to the labyrinthine segment of the facial canal or deep to the geniculate ganglion breaches the cochlea, causing irreversible deafness. Always define and respect the safe medial drilling boundary.",
                "PETROUS INTERNAL CAROTID ARTERY (ICA) LACERATION: The horizontal petrous ICA lies immediately beneath the GSPN, with bony dehiscence in up to 30% of patients. Anterior-to-posterior dural traction or blind diamond burr drilling over the GSPN can tear the carotid wall, resulting in catastrophic skull base hemorrhage requiring emergency balloon occlusion or bypass.",
                "VEIN OF LABBÉ AVULSION & VENOUS HEMORRHAGIC INFARCTION: Excessive or prolonged subtemporal brain retraction exerts severe traction on the vein of Labbé as it enters the transverse sinus. Tearing or thrombosis of Labbé causes devastating temporal lobe hemorrhagic infarction, cerebral edema, aphasia, and intractable intracranial hypertension. Keep retractor pressure minimal and release intermittently.",
                "TROCHLEAR NERVE (CN IV) TRANSECTION DURING TENTORIAL DIVISION: Angling the tentorial incision too far anteriorly cuts the trochlear nerve as it enters its dural sleeve at the tentorial incisura. Always visualize the free tentorial edge and direct the incision strictly posterior to CN IV to avoid vertical diplopia."
            ]
        case .plate054:
            return [
                "UNDER-SHELF KERRISON PLUNGING & CORD CONTUSION: Inserting a Kerrison rongeur footplate beneath an ossified ligament shelf in a stenotic thoracic canal causes instantaneous, catastrophic spinal cord compression and paraplegia. All bone resection must be strictly extra-cavitary from superficial to deep using diamond burrs.",
                "DURAL TEAR & GIANT PSEUDOMENINGOCELE: Forcefully peeling ossified ligamentum flavum from fused dura (tram-track sign) causes massive dural lacerations that are difficult to repair in the thoracic canal. Utilize the floating-island technique instead.",
                "POSTOPERATIVE EPIDURAL HEMATOMA: Inadequate hemostasis in the epidural venous plexus beneath the decompressed lamina leads to rapid postoperative compression. Meticulously coagulate bleeding with bipolar and apply thrombin-soaked gelatin sponges before closure.",
                "SEGMENTAL INSTABILITY & KYPHOTIC DEFORMITY: Excessive lateral drilling beyond the medial half of the thoracic facet joints compromises posterior column integrity and precipitates progressive post-laminectomy kyphosis. Preserve the lateral facet architecture or perform instrumented fusion."
            ]
        case .plate053:
            return [
                "POSTURE-DEPENDENT OVER-DRAINAGE & SUBDURAL HEMATOMA: Siphoning effect in upright posture can cause excessive ventricular collapse and tearing of bridging veins, leading to acute-on-chronic subdural hematomas in elderly NPH patients. Always utilize an inline gravitational anti-siphon unit.",
                "VENTRICULAR CATHETER MISPLACEMENT & BASAL GANGLIA INFARCTION: Passing the ventricular catheter too deeply (>6 cm) or off-angle can penetrate the thalamus, internal capsule, or midbrain. Adhere strictly to the Kocher's point trajectory vectors.",
                "DISTAL CATHETER BOWEL PERFORATION: Blind trocar or needle insertion into the peritoneal cavity risks visceral puncture. Always perform minilaparotomy with direct visual verification of peritoneal entry.",
                "SHUNT INFECTION & COLONIZATION: Contamination with skin flora (Staphylococcus epidermidis) leads to ventriculitis and valve obstruction. Maintain strict aseptic technique, minimize glove-to-catheter contact, and utilize antibiotic-impregnated tubing."
            ]
        case .plate052:
            return [
                "Facial Nerve Traction Injury: Over-aggressive mechanical traction on the tumor capsule shears attenuated CN VII; decompress intracapsularly first.",
                "AICA Loop Avulsion: Coagulating adherent AICA vessels on the tumor surface causes brainstem stroke and cerebellar infarction."
            ]
        }
    }
}
