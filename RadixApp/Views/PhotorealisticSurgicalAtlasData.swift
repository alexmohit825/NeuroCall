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
                    title: "CN IX, X, XI",
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
                    normalizedX: 0.780,
                    normalizedY: 0.312,
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
                    normalizedY: 0.560,
                    description: "MILITARY CHIN-TUCK SETUP: Single anterior pin and dual posterior rocker pins, with neck flexed maintaining 2-finger jugular clearance.",
                    surgicalPearl: "Maintain >= 2 fingerbreadths between chin and sternum; excessive flexion compresses internal jugular veins, causing venous infarction."
                ),
                SurgicalCallout(
                    id: "plate_010_2",
                    title: "Asterion & Cranial Sutures",
                    structureType: "SURFACE OSTEOLOGICAL LANDMARK",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.520,
                    normalizedY: 0.588,
                    description: "SURFACE SUTURE CONFLUENCE: Junction of lambdoid, parietomastoid, and occipitomastoid sutures overlying the transverse-sigmoid angle.",
                    surgicalPearl: "Asterion overlies transverse-sigmoid junction in only 60% of cases; in 40% it sits directly over transverse sinus. Always drill inferior-medial."
                ),
                SurgicalCallout(
                    id: "plate_010_3",
                    title: "Transverse-Sigmoid Sinus Junction",
                    structureType: "VITAL VENOUS SINUS CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.650,
                    normalizedY: 0.490,
                    description: "VENOUS ANGLE BOUNDARY: Blue dural sinuses showing horizontal transverse sinus turning into descending sigmoid sinus behind mastoid.",
                    surgicalPearl: "Expose the inferior edge of transverse and posterior edge of sigmoid sinus to maximize viewing angle without sinus laceration."
                ),
                SurgicalCallout(
                    id: "plate_010_4",
                    title: "Strategic Burr Hole & Craniectomy Window",
                    structureType: "PLANNED CRANIECTOMY WINDOW",
                    color: ObsidianTheme.neonEmerald,
                    normalizedX: 0.600,
                    normalizedY: 0.769,
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
                    normalizedY: 0.414,
                    description: "SUTURE INTERSECTION: Confluence of lambdoid, parietomastoid, and occipitomastoid sutures marking lateral posterior fossa entrance.",
                    surgicalPearl: "Asterion overlies transverse-sigmoid junction in 60% of skulls; in 40% it sits on transverse sinus. Place burr hole 5 mm inferior-medial."
                ),
                SurgicalCallout(
                    id: "plate_020_2",
                    title: "Keyhole Retrosigmoid Craniectomy",
                    structureType: "CRANIAL KEYHOLE DEFECT",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.496,
                    normalizedY: 0.558,
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
            return []
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
                    normalizedX: 0.475,
                    normalizedY: 0.550,
                    description: "EXTRAPLEURAL BONE ENTRY: 3-4 cm resection of rib head, neck, and transverse process, unroofing extrapleural space.",
                    surgicalPearl: "Subperiosteal dissection of the rib head off the costovertebral joint avoids tearing parietal pleura and entering thoracic cavity."
                ),
                SurgicalCallout(
                    id: "plate_026_2",
                    title: "Swept Parietal Pleura",
                    structureType: "PULMONARY TISSUE SPARING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.410,
                    normalizedY: 0.434,
                    description: "EXTRAPLEURAL RETROPERITONEAL PLANE: Intact parietal pleura swept ventrally with moist cottonoids, exposing lateral vertebral body.",
                    surgicalPearl: "Working strictly in the extrapleural plane maintains pulmonary biomechanics and completely avoids need for postoperative chest tube."
                ),
                SurgicalCallout(
                    id: "plate_026_3",
                    title: "Posterolateral Corpectomy Cavity",
                    structureType: "VENTRAL DECOMPRESSION CAVITY",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.316,
                    normalizedY: 0.355,
                    description: "CIRCUMFERENTIAL RESECTION DEFECT: Complete resection of pathological vertebral body and discs between adjacent healthy endplates.",
                    surgicalPearl: "Drill vertebral body down to contralateral pedicle; full 360-degree dural untethering restores spinal cord microcirculation."
                )
            ]
        case .plate027:
            return [
                SurgicalCallout(
                    id: "plate_027_1",
                    title: "Deep Ganglionic / Thalamic Hematoma Target",
                    structureType: "INTRACEREBRAL HEMORRHAGE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.438,
                    normalizedY: 0.559,
                    description: "DEEP HYPERTENSIVE ICH: Large hypertensive hematoma in basal ganglia/thalamus exerting mass effect and midline shift.",
                    surgicalPearl: "Early MIPS evacuation (< 24 hours) relieves toxic thrombin mass effect and prevents secondary perihematomal edema."
                ),
                SurgicalCallout(
                    id: "plate_027_2",
                    title: "Transparent Tubular Transsulcal Port",
                    structureType: "PARAFASCICULAR RETRACTION PORT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.627,
                    normalizedY: 0.189,
                    description: "PARAFASCICULAR CANNULA: Transparent tubular port (BrainPath) introduced along white matter fiber tracts with zero cutting.",
                    surgicalPearl: "Introduce port along major tract trajectories (parallel to corticospinal tract) to displace rather than transect axonal fibers."
                ),
                SurgicalCallout(
                    id: "plate_027_3",
                    title: "Microsurgical Suction Clot Evacuation",
                    structureType: "INTERNAL DECOMPRESSION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.910,
                    normalizedY: 0.603,
                    description: "LUMINAL CLOT ASPIRATION: Dedicated micro-suction cannula and bipolar under high illumination gently evacuating burgundy thrombus.",
                    surgicalPearl: "Evacuate mobile clot inside the cavity; never vigorously scrape adherent clot on cavity walls to prevent active re-bleeding."
                )
            ]
        case .plate028:
            return [
                SurgicalCallout(
                    id: "plate_028_1",
                    title: "Anterior Retroperitoneal Sweep (Aorta/IVC)",
                    structureType: "GREAT VESSEL SAFETY ZONE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.438,
                    normalizedY: 0.188,
                    description: "VASCULAR CLEARANCE: Peritoneal envelope, aorta, and IVC resting on anterior disc margin, swept safely away from retractor channel.",
                    surgicalPearl: "Keep retractor docked strictly posterior to the anterior longitudinal ligament; anterior drift endangers aorta and vena cava."
                ),
                SurgicalCallout(
                    id: "plate_028_2",
                    title: "Psoas Split & Lumbar Plexus Safety",
                    structureType: "TRANSPSOAS NEUROLOGICAL WINDOW",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.589,
                    normalizedY: 0.412,
                    description: "ANTERIOR-THIRD CORRIDOR: Psoas split in anterior 1/3; traversing femoral nerve and lumbar plexus protected in posterior 2/3.",
                    surgicalPearl: "Utilize continuous directional EMG; nerve proximity alerts prevent direct mechanical compression of the femoral nerve trunk."
                )
            ]
        case .plate029:
            return []
        case .plate030:
            return []
case .plate031:
            return []
        case .plate032:
            return []
        case .plate033:
            return []
        case .plate034:
            return [
                SurgicalCallout(
                    id: "plate_034_1",
                    title: "Locked C6–C7 Facet Dislocation",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.956,
                    normalizedY: 0.331,
                    description: "Parasagittal CT and dissection view showing C6 inferior articular facet perched and locked anterior to C7 superior articular process.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_034_2",
                    title: "Intramedullary Cord Contusion / Edema",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.717,
                    normalizedY: 0.394,
                    description: "High-intensity sagittal T2 cord signal pinched between posterosuperior C7 vertebral body and displaced C6 posterior arch.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_034_3",
                    title: "Disrupted Posterior Ligament Complex",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.822,
                    normalizedY: 0.596,
                    description: "Gross widening of C6–C7 interspinous distance indicating complete rupture of supraspinous, interspinous, and ligamentum flavum fibers.",
                    surgicalPearl: ""
                )
            ]
        case .plate035:
            return []
        case .plate036:
            return []
        case .plate037:
            return [
                SurgicalCallout(
                    id: "plate_037_1",
                    title: "Massive Extruded Disc Sequestrum",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.260,
                    normalizedY: 0.300,
                    description: "Diagnostic sagittal T2 MRI demonstrating huge extruded disc fragment filling >80% of spinal canal with complete CSF block at L4–L5.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_037_2",
                    title: "Compressed Cauda Equina Roots",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.740,
                    normalizedY: 0.320,
                    description: "Axial cross-section showing cauda equina nerve rootlets flattened into an ischemic crescentic band against posterior lamina.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_037_3",
                    title: "Annular Defect & Ruptured PLL",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.280,
                    normalizedY: 0.720,
                    description: "3D midsagittal cutaway illustrating intervertebral disc origin through disrupted posterior annulus and elevated/torn posterior longitudinal ligament.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_037_4",
                    title: "Intact Endplates & Vertebral Bodies",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.720,
                    normalizedY: 0.700,
                    description: "Well-preserved L4 and L5 cancellous bone and cortical endplates differentiating primary disc extrusion from infectious/neoplastic collapse.",
                    surgicalPearl: ""
                )
            ]
        case .plate038:
            return [
                SurgicalCallout(
                    id: "plate_038_1",
                    title: "T8 Pathologic Fracture & Height Loss",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.260,
                    normalizedY: 0.300,
                    description: "Osteolytic metastatic tumor destroying cancellous bone with anterior column collapse and focal pathologic kyphosis on sagittal MRI.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_038_2",
                    title: "Circumferential Cord Compression (Bilsky 3)",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.740,
                    normalizedY: 0.320,
                    description: "Complete obliteration of subarachnoid space with circumferential cord indentation and intrinsic T2-hyperintense intramedullary cord edema.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_038_3",
                    title: "Pedicle & Epidural Tumor Infiltration",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.280,
                    normalizedY: 0.720,
                    description: "Transverse cutaway showing tumor expansion through left pedicle and into epidural space creating a 180° dorsal and ventral cord pincer.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_038_4",
                    title: "Spared Contiguous Vertebrae (T7/T9)",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.720,
                    normalizedY: 0.700,
                    description: "Healthy adjacent vertebrae providing solid pedicle purchase for multi-level rigid posterior stabilization and separation surgery.",
                    surgicalPearl: ""
                )
            ]
        case .plate039:
            return [
                SurgicalCallout(
                    id: "plate_039_1",
                    title: "Dural Tear Fistula Defect",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.260,
                    normalizedY: 0.300,
                    description: "Linear or stellate laceration in posterior lumbar thecal sac allowing pressurized CSF egress into surrounding dead space.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_039_2",
                    title: "Subcutaneous Fluid Collection (MRI)",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.740,
                    normalizedY: 0.320,
                    description: "High-contrast sagittal T2 MRI showing large, non-enhancing hyperintense CSF collection dissecting through lumbodorsal fascia.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_039_3",
                    title: "Encapsulated Pseudocyst Wall",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.280,
                    normalizedY: 0.720,
                    description: "Fibrous pseudo-epithelial capsule forming the wall of pseudomeningocele lacking true arachnoid/ependymal lining.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_039_4",
                    title: "Multilayer Watertight Reconstruction",
                    structureType: "SURGICAL TECHNIQUE",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.720,
                    normalizedY: 0.700,
                    description: "Primary continuous 4-0/5-0 monofilament dural suture reinforced with collagen matrix onlay patch and hydrogel/fibrin polymer sealant.",
                    surgicalPearl: ""
                )
            ]
        case .plate040:
            return [
                SurgicalCallout(
                    id: "plate_040_1",
                    title: "ACom Aneurysm Rupture Site",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.559,
                    normalizedY: 0.231,
                    description: "3D skull base dissection showing irregular saccular anterior communicating artery aneurysm at A1-A2 junction with crimson clot on fundus.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_040_2",
                    title: "Biventricular Hydrocephalus",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.292,
                    normalizedY: 0.589,
                    description: "Ballooned temporal horns and rounded frontal horn angles caused by dense cisternal clot obstructing arachnoid villi and CSF outflow.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_040_3",
                    title: "Circle of Willis Cisternal Anatomy",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.546,
                    normalizedY: 0.511,
                    description: "Preserved bilateral ICA bifurcations, M1/M2 Sylvian trunks, and basilar apex defining corridors for microsurgical clipping or coiling.",
                    surgicalPearl: ""
                )
            ]
        case .plate041:
            return [
                SurgicalCallout(
                    id: "plate_041_1",
                    title: "Putaminal ICH & Perilesional Edema",
                    structureType: "PATHOLOGY / LESION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.210,
                    normalizedY: 0.496,
                    description: "Hyperdense parenchymal hematoma in putamen/external capsule from ruptured Charcot-Bouchard microaneurysms on lenticulostriate perforators.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_041_2",
                    title: "Intraventricular Hemorrhage Cast (IVH)",
                    structureType: "CRITICAL HAZARD",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.161,
                    normalizedY: 0.329,
                    description: "Trans-ependymal rupture causing dense cast of frontal horn, third ventricle, and dependent clot sedimentation in occipital horns.",
                    surgicalPearl: ""
                ),
                SurgicalCallout(
                    id: "plate_041_3",
                    title: "Foramina of Monro Outflow Obstruction",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.477,
                    normalizedY: 0.427,
                    description: "Obstructive hydrocephalus at Monro-third ventricle interface with ballooning of lateral ventricles requiring urgent ventricular drainage.",
                    surgicalPearl: ""
                )
            ]
        case .plate042:
            return []
        case .plate043:
            return []
        case .plate044:
            return []
        case .plate045:
            return [
                SurgicalCallout(
                    id: "plate_045_1",
                    title: "Subfalcine (Cingulate) Herniation",
                    structureType: "DURAL NOTCH DISPLACEMENT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.250,
                    normalizedY: 0.250,
                    description: "Cingulate gyrus wedged beneath the inferior free margin of the rigid falx cerebri. Compresses pericallosal and callosomarginal ACA branches, causing contralateral lower-extremity paresis.",
                    surgicalPearl: "Often early and clinically silent until severe ACA ischemia ensues. High risk of converting to secondary uncal herniation."
                ),
                SurgicalCallout(
                    id: "plate_045_2",
                    title: "Uncal (Lateral Transtentorial) Herniation",
                    structureType: "INCISURAL HERNIATION",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.750,
                    normalizedY: 0.250,
                    description: "Medial temporal uncus herniates over the sharp tentorial edge. Compresses ipsilateral CN III (blown pupil), PCA (hemianopia), and contralateral cerebral peduncle (Kernohan's notch false localizing sign).",
                    surgicalPearl: "Immediate neurosurgical emergency: demands osmotherapy bolus and emergent surgical decompression within minutes."
                ),
                SurgicalCallout(
                    id: "plate_045_3",
                    title: "Central Transtentorial (Duret Hemorrhages)",
                    structureType: "ROSTROCAUDAL DISPLACEMENT",
                    color: ObsidianTheme.neonPurple,
                    normalizedX: 0.250,
                    normalizedY: 0.750,
                    description: "Bilateral downward displacement of diencephalon and midbrain. Mechanical traction shears basilar paramedian perforators, producing fatal Duret brainstem hemorrhages.",
                    surgicalPearl: "Progressive rostrocaudal deterioration: small reactive pupils become midposition fixed; decorticate rigidity progresses to decerebrate posturing."
                ),
                SurgicalCallout(
                    id: "plate_045_4",
                    title: "Tonsillar Herniation ('Coning')",
                    structureType: "FORAMEN MAGNUM CONING",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.750,
                    normalizedY: 0.750,
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
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.125,
                    normalizedY: 0.400,
                    description: "Conus medullaris tapers normally and terminates at L1–L2. Slender filum terminale (<2 mm) with vertically draping cauda equina rootlets. Posterior bony elements, fascia, and overlying skin are intact.",
                    surgicalPearl: "Normal conus level must be confirmed by counting down from T12/ribs or up from S1 to avoid misidentifying low-lying cord on sagittal MRI."
                ),
                SurgicalCallout(
                    id: "plate_046_2",
                    title: "Filar Lipoma (Tethered Cord)",
                    structureType: "OCCULT SPINAL DYSRAPHISM",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.375,
                    normalizedY: 0.650,
                    description: "Conus medullaris pathologically low-lying (descending to L4–L5). Thickened, bright golden-yellow fibroadipose filum (>2 mm) tethering the conus under mechanical traction with taut horizontal nerve roots.",
                    surgicalPearl: "Microsurgical sectioning of the fatty filum immediately relaxes traction. Intraoperative nerve stimulation must confirm absent motor response before bipolaring and transecting the filum."
                ),
                SurgicalCallout(
                    id: "plate_046_3",
                    title: "Lipomyelomeningocele",
                    structureType: "CLOSED SPINAL DYSRAPHISM",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.625,
                    normalizedY: 0.500,
                    description: "Spina bifida with dorsal laminar defect (L4–S2) beneath intact skin (subcutaneous fatty dome). Subcutaneous lipoma enters the spinal canal through the fascial defect and fuses directly into the dorsal aspect of the tethered placode.",
                    surgicalPearl: "NEVER attempt complete resection of the lipoma into cord tissue; debulk only the extraneous mass and untether the placode. Aggressive parenchymal resection causes permanent paraplegia or neurogenic bladder."
                ),
                SurgicalCallout(
                    id: "plate_046_4",
                    title: "Open Myelomeningocele",
                    structureType: "SPINA BIFIDA APERTA",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.875,
                    normalizedY: 0.480,
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
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.125,
                    normalizedY: 0.350,
                    description: "Freestanding oval C1 anterior arch, intact conical dens, and C1 posterior arch ring. Wide perimedullary and prepontine subarachnoid space (CSF) cushioning an uncompressed brainstem and spinal cord. AADI is strictly < 3 mm.",
                    surgicalPearl: "Anterior atlantodental interval (AADI) > 3 mm in adults is pathognomonic of transverse atlantal ligament incompetency and atlantoaxial instability."
                ),
                SurgicalCallout(
                    id: "plate_047_2",
                    title: "Retro-Odontoid Pannus & Crowned Dens",
                    structureType: "PATHOLOGICAL PSEUDOTUMOR",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.375,
                    normalizedY: 0.350,
                    description: "Crowned dens with multi-lobulated calcific deposits at the dens tip. A bulky, fleshy retro-odontoid pseudotumor mass expands into the spinal canal. The cord is caught in a pincer between the anterior pannus and forward-shifted C1 posterior arch, with focal intramedullary myelomalacia.",
                    surgicalPearl: "Pannus develops as an inflammatory fibrocartilaginous pseudotumor secondary to repetitive atlantoaxial micromotion (seen in CPPD, rheumatoid arthritis, or chronic non-union)."
                ),
                SurgicalCallout(
                    id: "plate_047_3",
                    title: "Rigid Goel-Harms Fixation In Situ",
                    structureType: "POSTERIOR C1-C2 ARTHRODESIS",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.625,
                    normalizedY: 0.400,
                    description: "Posterior titanium C1 lateral mass screw (angled 10-15° cephalad) connected via a longitudinal rod to a C2 pedicle screw (angled 25-30° cephalad). Vascularized morselized autograft packed between C1 and C2. The retro-odontoid mass is deliberately left in situ without anterior resection.",
                    surgicalPearl: "Direct transoral or transnasal resection carries up to a 10% risk of CSF leak and fatal meningitis. Posterior stabilization alone reliably cures the condition."
                ),
                SurgicalCallout(
                    id: "plate_047_4",
                    title: "Spontaneous Involution & Solid Bony Fusion",
                    structureType: "12-MONTH POST-OP ARTHRODESIS",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.875,
                    normalizedY: 0.350,
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
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.125,
                    normalizedY: 0.350,
                    description: "Slender, straight, non-dilated posterior median spinal vein (cobalt blue) with a delicate coronal venous plexus. Normal radicular vein draining smoothly through the lateral dural sleeve into the epidural venous plexus. Normal cord caliber.",
                    surgicalPearl: "Normal spinal venous drainage is low-pressure and valveless; cord perfusion depends entirely on the arteriovenous pressure gradient."
                ),
                SurgicalCallout(
                    id: "plate_048_2",
                    title: "Arterialized Serpentine Veins & Foix-Alajouanine",
                    structureType: "CONGESTIVE MYELOPATHY",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.375,
                    normalizedY: 0.350,
                    description: "Fistulous nidus inside the dural root sleeve shunts high-pressure arterial blood retrogradely into the coronal venous plexus. Grossly dilated, hyper-convoluted, serpentine arterialized veins and severe congestive cord swelling (Foix-Alajouanine myelopathy).",
                    surgicalPearl: "Presents insidiously with ascending lower extremity paraparesis, sensory level, and sphincter dysfunction, frequently misdiagnosed as lumbar spinal stenosis or transverse myelitis."
                ),
                SurgicalCallout(
                    id: "plate_048_3",
                    title: "Intraoperative ICG Videoangiography",
                    structureType: "MICROSURGICAL LOCALIZATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.625,
                    normalizedY: 0.400,
                    description: "Under high microscope magnification, intense arterial-phase fluorescence reveals the radiculomeningeal arterial feeder entering the dural sleeve and shunting directly into the single arterialized medullary bridging vein before cord capillaries fill.",
                    surgicalPearl: "ICG videoangiography definitively differentiates the pathological arterialized draining vein from adjacent normal radicular veins."
                ),
                SurgicalCallout(
                    id: "plate_048_4",
                    title: "Micro-Clip Interruption & Decompression",
                    structureType: "DEFINITIVE SURGICAL CURE",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.875,
                    normalizedY: 0.350,
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
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.125,
                    normalizedY: 0.200,
                    description: "Intact, continuous C1 ring with stout Transverse Atlantal Ligament (TAL) holding the C2 dens tightly against the anterior arch. Superior axial view shows generous canal space; anterior coronal view demonstrates flush lateral masses (0 mm overhang).",
                    surgicalPearl: "Normal lateral atlantodental intervals (LADI) are strictly symmetric; combined lateral mass overhang is 0 mm."
                ),
                SurgicalCallout(
                    id: "plate_049_2",
                    title: "Stable Burst (TAL Intact, Overhang < 6.9 mm)",
                    structureType: "STABLE JEFFERSON (DICKMAN I)",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.375,
                    normalizedY: 0.200,
                    description: "4-part burst fracture through the anterior and posterior arches. The Transverse Atlantal Ligament remains 100% intact, preventing lateral mass splaying. Combined lateral mass overhang on coronal view is strictly < 6.9 mm. Spinal cord is uncompromised.",
                    surgicalPearl: "Stable fractures with intact TAL can be treated conservatively in a rigid cervical collar (Miami J / Aspen) or Halo-vest for 8–12 weeks."
                ),
                SurgicalCallout(
                    id: "plate_049_3",
                    title: "Unstable Burst (TAL Ruptured, Overhang ≥ 7 mm)",
                    structureType: "UNSTABLE JEFFERSON (DICKMAN II)",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.625,
                    normalizedY: 0.200,
                    description: "Severe comminuted burst with mid-substance rupture and shredding of the Transverse Atlantal Ligament. Both lateral masses splay widely outward (> 7 mm combined overhang, positive Rule of Spence). The dens retropulses into the canal, indenting the spinal cord.",
                    surgicalPearl: "Combined lateral mass overhang ≥ 7.0 mm on open-mouth view or coronal CT proves TAL disruption, indicating gross mechanical instability requiring surgical stabilization."
                ),
                SurgicalCallout(
                    id: "plate_049_4",
                    title: "Anatomical Reduction & Arthrodesis",
                    structureType: "SURGICAL REDUCTION & RESTORATION",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.875,
                    normalizedY: 0.200,
                    description: "Closed traction reduction or posterior instrumented reduction brings the splayed lateral masses back inward. Coronal overhang is eliminated (0 mm overhang), the C1 ring circumference is restored, and the cervical spinal cord is fully decompressed.",
                    surgicalPearl: "Posterior C1–C2 Goel-Harms instrumented fusion (C1 lateral mass to C2 pedicle/pars screws) provides immediate rigid biomechanical stability and high fusion rates."
                )
            ]

        case .plate050:
            return []

        case .plate051:
            return [
                SurgicalCallout(
                    id: "plate_051_1",
                    title: "MMA Trunk & Foramen Spinosum",
                    structureType: "ANGIOGRAPHIC TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.278,
                    normalizedY: 0.588,
                    description: "Middle meningeal artery entering middle cranial fossa through foramen spinosum before bifurcating into frontal and parietal branches.",
                    surgicalPearl: "Carefully inspect MMA origin for dangerous anastomoses with ophthalmic artery (meningolacrimal branch) prior to embolization."
                ),
                SurgicalCallout(
                    id: "plate_051_2",
                    title: "Superselective MMA Catheterization",
                    structureType: "ENDOVASCULAR CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.365,
                    normalizedY: 0.478,
                    description: "Microcatheter navigation into anterior and posterior convex convexity branches distal to petrosal / facial nerve arcade.",
                    surgicalPearl: "Ensure microcatheter tip is well past petrosal branch of MMA to prevent inadvertent facial nerve palsy from embolic reflux."
                ),
                SurgicalCallout(
                    id: "plate_051_3",
                    title: "Onyx Liquid Embolic Membrane Cast",
                    structureType: "EMBOLIZATION CAST",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.403,
                    normalizedY: 0.337,
                    description: "Controlled liquid embolic penetration (Onyx / PHIL / particles) penetrating fragile neovascular dural capillary membranes of CSDH.",
                    surgicalPearl: "Penetration into the distal capillary network of the outer subdural membrane is essential to arrest recurring micro-hemorrhages."
                )
            ]

        case .plate090:
            return []


        case .plate091:
            return []
        case .plate092:
            return []
        case .plate093:
            return []
        case .plate094:
            return []
        case .plate095:
            return []
        case .plate096:
            return []
        case .plate097:
            return []
        case .plate098:
            return []
        case .plate099:
            return []
        case .plate100:
            return []
        case .plate101:
            return []
        case .plate102:
            return []
        case .plate103:
            return []
        case .plate104:
            return []
        case .plate105:
            return []
        case .plate106:
            return []
        case .plate089:
            return []

        case .plate088:
            return []

        case .plate087:
            return []

        case .plate086:
            return []

        case .plate085:
            return []

        case .plate084:
            return []

        case .plate083:
            return []

        case .plate082:
            return []

        case .plate081:
            return []

        case .plate080:
            return []

        case .plate079:
            return []

        case .plate078:
            return []

        case .plate077:
            return []

        case .plate076:
            return []

        case .plate075:
            return []

        case .plate074:
            return [
                SurgicalCallout(
                    id: "plate_074_1",
                    title: "Neuroimaging ",
                    structureType: "SYNTHETIC CT/MRI, ANGIOGRAPHY & AL-MEFTY MATRIX",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.500,
                    description: "Panel A synthesizes multimodal neuroimaging and the definitive Al-Mefty classification for medial sphenoid wing/clinoidal meningiomas. A1 (coronal T1+C) and A3 (axial T1+C) demonstrate a right clinoidal meningioma encasing the internal carotid artery (ICA) bifurcation and compressing the optic nerve. A2 (bone CT) reveals profound hyperostosis of the right sphenoid wing, orbital roof, and optic strut. A4 (catheter angiogram) shows ICA and MCA (M1) encasement with rich tumor blush. Lower insets delineate Al-Mefty Groups: Group I (origin distal to carotid cistern ring, no arachnoid plane between tumor and ICA adventitia), Group II (origin from superior/lateral clinoid, arachnoid plane present between tumor and ICA), and Group III (origin at optic canal unroofing/strut).",
                    surgicalPearl: "In Al-Mefty Group I meningiomas, tumor invades the adventitia of the ICA directly without an intervening arachnoid plane. Aggressive pursuit of a Simpson Grade 1 resection in Group I invariably results in catastrophic carotid laceration or middle cerebral artery stroke; subtotal resection with adjuvant stereotactic radiosurgery is the standard of care."
                ),
                SurgicalCallout(
                    id: "plate_074_2",
                    title: "Extradural Sphenoid Drilling & MOB Peeling",
                    structureType: "EXTRADURAL SKULL BASE & MENINGO-ORBITAL BAND",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.480,
                    normalizedY: 0.380,
                    description: "Panel B depicts the critical extradural phase of the pterional/orbitozygomatic approach. A high-speed diamond burr with continuous cold saline irrigation systematically flattens the hyperostotic sphenoid ridge down to the superior orbital fissure (SOF). Peeling and sharply dividing the meningo-orbital band (MOB) detaches the frontotemporal dura from the periorbita, unlocking the anterior clinoid space. Lower insets detail 270° optic canal unroofing, resection of the optic strut, and anterior clinoidectomy, decompressing CN II and exposing the clinoidal segment of the ICA before opening the dura.",
                    surgicalPearl: "Extradural optic canal unroofing and anterior clinoidectomy decompress the optic nerve prior to any intradural tumor manipulation and devascularize the primary tumor blood supply from the middle meningeal and ophthalmic collateral branches."
                ),
                SurgicalCallout(
                    id: "plate_074_3",
                    title: "16× Microsurgical Resection & Perforator Preservation",
                    structureType: "MICROSURGICAL RESECTION & PERFORATING BRUSH",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.820,
                    normalizedY: 0.380,
                    description: "Panel C enforces the cardinal mandate: 'PRESERVE PERFORATORS & ADVENTITIAL CLEAVAGE PLANES'. Under 16× magnification, ultrasonic cavitation (CUSA) debulks the firm pink tumor mass. High-power views display complete exposure of CN II, supraclinoid ICA, anterior choroidal artery (AChA) takeoff, M1/M2 bifurcation, and the delicate brush of lateral lenticulostriate perforators. Insets illustrate dural attachment coagulation, the exact MOB peeling plane, and meticulous micro-dissection sparing every perforator.",
                    surgicalPearl: "The Achilles' heel of medial sphenoid wing meningioma resection is the lenticulostriate brush and AChA. Stripping adherent tumor off these vessels causes capsular infarction and permanent dense hemiplegia. Preserve the adventitial plane and leave tumor flecks on perforating vessels."
                ),
                SurgicalCallout(
                    id: "plate_074_4",
                    title: "Three Operative Principles & Postoperative Surveillance",
                    structureType: "OPERATIVE PRINCIPLES & CRANIAL NERVE PROTOCOL",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.623,
                    normalizedY: 0.944,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.500,
                    description: "Panel A exhibits synthetic bone-window CT (sagittal and axial, W4000/L700) and T2 MRI at T8–T9 displaying a compact, calcified disc-osteophyte complex occupying ~45–50% of the spinal canal cross-section with severe ventral thecal sac encroachment. The thoracic cord is compressed into an anatomical crescent with bright intramedullary T2 hyperintensity (compressive myelomalacia). Lower insets contrast central versus right-paracentral herniation and detail the risk of intradural calcification eroding the ventral dura.",
                    surgicalPearl: "Giant thoracic disc herniations (>50% canal compromise) are almost invariably calcified and densely adherent to the ventral dura. Posterior laminectomy alone is strictly contraindicated because it cannot access the ventral pathology without requiring cord retraction."
                ),
                SurgicalCallout(
                    id: "plate_073_2",
                    title: "Posterolateral Transpedicular Corridor & Trenching",
                    structureType: "OPERATIVE APPROACH & DOWN-AND-AWAY DRILLING",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.500,
                    normalizedY: 0.380,
                    description: "Panel B depicts prone positioning with active multi-modal SSEP/MEP monitoring (maintaining MAP >85–90 mmHg). The operative field shows a right-sided posterolateral transpedicular approach: T8 hemilaminectomy, medial facetectomy, and complete T8 pediculectomy exposing the lateral thecal sac and exiting T8 nerve root. The lower view demonstrates vertebral body trenching: a 3 mm diamond burr drills a deep cavity in the posterior third of T8/T9 vertebral bodies ventral and inferior to the disc before touching the calcified fragment.",
                    surgicalPearl: "Vertebral body trenching is the non-negotiable prerequisite of thoracic discectomy. Always hollow out a deep bony decompression cavity beneath the disc first; the calcified fragment must be pushed down into this empty space rather than pulled backward against the cord."
                ),
                SurgicalCallout(
                    id: "plate_073_3",
                    title: "16× Micro-Cavitation & Zero Cord Retraction",
                    structureType: "MICROSURGICAL CAVITATION & ZERO RETRACTION",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.820,
                    normalizedY: 0.380,
                    description: "Panel C enforces the cardinal mandate: '⚠️ ZERO SPINAL CORD RETRACTION'. Under 16× magnification, a reverse-angle micro-curette gently pushes the hard calcified fragment down and away into the pre-drilled trench, collapsing it away from the pristine, untouched thecal sac. Following decompression, the thecal sac re-expands with restored dural vascularity. Insets detail multi-layer ventral dural repair (collagen matrix, fat/muscle graft, fibrin glue) and short-segment pedicle screw instrumentation bridging the pediculectomy.",
                    surgicalPearl: "Never insert an instrument between the ventral dura and a calcified thoracic disc. The cord in the thoracic spine has a precarious watershed vascular supply (Artery of Adamkiewicz); even 1 mm of medial cord retraction triggers irreversible paraplegia."
                ),
                SurgicalCallout(
                    id: "plate_073_4",
                    title: "The Three Cardinal Rules & Intradural Adhesions",
                    structureType: "SURGICAL AXIOMS & INTRADURAL ALGORITHM",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.500,
                    normalizedY: 0.880,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.268,
                    normalizedY: 0.158,
                    description: "Panel A contrasts the classic cranial 'SEEPS' signs of spontaneous intracranial hypotension (diffuse pachymeningeal enhancement, tonsillar descent/pseudo-Chiari, flattened pons, effaced prepontine cistern, and engorged venous sinuses) with the definitive spinal diagnostic modality: lateral decubitus Digital Subtraction Myelography (DSM). The DSM captures an immediate contrast jet from the nerve root sleeve opacifying an undulating paraspinal/intercostal vein draining into the azygos system, with ZERO extradural CSF leak.",
                    surgicalPearl: "CSF-venous fistulas (Schievink Type 3) NEVER produce an epidural fluid collection on spine MRI. Routine supine spine MRIs are completely normal; definitive diagnosis requires rapid, high-frame-rate lateral decubitus CT myelography or DSM with the leak-side dependent."
                ),

                SurgicalCallout(
                    id: "plate_072_2",
                    title: "Aberrant Arachnoid Granulation & Transvenous Coiling",
                    structureType: "MICRO-ANATOMY & ENDOVASCULAR EMBOLIZATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.758,
                    normalizedY: 0.158,
                    description: "Panel B reveals the microscopic patho-anatomy: an aberrant, hypertrophied spinal arachnoid granulation herniating directly through the dural root sleeve into an adjacent radicular/paraspinal vein at the neural foramen, shunting CSF into Batson's and azygos venous plexuses. The lower panel illustrates transvenous endovascular embolization via femoral/jugular access navigating the azygos vein and posterior intercostal vein, deploying platinum micro-coils and a liquid embolic cast (Onyx/Squid) to occlude the fistulous dural junction.",
                    surgicalPearl: "Transvenous embolization is a safe, minimally invasive first-line curative option. The key is occluding the exact dural junction of the draining vein with micro-coils and liquid embolic without allowing material to reflux into anterior or posterior spinal cord medullary veins."
                ),

                SurgicalCallout(
                    id: "plate_072_3",
                    title: "16× Microsurgical Clip Ligation & Resection",
                    structureType: "MICROSURGICAL LIGATION & POST-OP RESOLUTION",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.478,
                    normalizedY: 0.651,
                    description: "Panel C depicts the 16× microsurgical field via a targeted unilateral hemilaminectomy. The dorsal root ganglion (DRG) and dural root sleeve are exposed, and the engorged fistulous vein is selectively clipped at its dural takeoff using a titanium microvascular clip and sharply divided distal to the clip, permanently obliterating the shunt while preserving the nerve root. Inset verifies complete post-op MRI resolution of brainstem sagging, tonsillar herniation, and pachymeningeal enhancement.",
                    surgicalPearl: "Microsurgical clip ligation provides a 100% immediate cure for CVF. Meticulously dissect the draining vein off the nerve root sleeve, apply the microvascular clip flush against the dural cuff, and divide the vein distally to eliminate any possibility of recanalization."
                )
            ]

                                                                        case .plate071:
            return []

                                                                        case .plate070:
            return [
                SurgicalCallout(
                    id: "plate_070_1",
                    title: "3D Synthetic DTI Tractography & Language Networks",
                    structureType: "SYNTHETIC NEUROIMAGING & TRACTOGRAPHY",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.283,
                    normalizedY: 0.222,
                    description: "Panel A exhibits synthetic axial and coronal T1-contrast scans of a left frontal-opercular glioblastoma (WHO Grade 4) with ring enhancement and central necrosis. The 3D DTI tractography reconstruction maps the surrounding critical white matter tracts: Corticospinal Tract (CST) descending vertically in royal blue, Arcuate Fasciculus (AF) / SLF II–III looping in magenta/crimson, Inferior Fronto-Occipital Fasciculus (IFOF) in dark violet, and Uncinate Fasciculus (UF) in green. Inset details DES stimulation endpoints (AF = repetition errors; IFOF = semantic paraphasias; CST = motor arrest).",
                    surgicalPearl: "Subcortical language organization is dual-stream: the dorsal stream (AF/SLF) subserves phonological processing and repetition, while the ventral stream (IFOF) subserves semantic comprehension. Preserving both streams is required to prevent permanent postoperative aphasia."
                ),

                SurgicalCallout(
                    id: "plate_070_2",
                    title: "Awake Craniotomy & Cortical DES Mapping Standard",
                    structureType: "OPERATIVE MAPPING & PERISYLVIAN ANATOMY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.500,
                    normalizedY: 0.716,
                    description: "Panel B depicts the awake asleep-awake-asleep field with regional scalp block and the patient alert performing DO-80 naming tasks. An Ojemann bipolar probe (60 Hz, 1.5–3.5 mA) stimulates perisylvian gyri under ECoG monitoring. Numbered sterile tags mark critical landmarks: [1] Speech arrest (Broca area / IFG), [2] Semantic paraphasia / anomia (Wernicke / STG), [3] Phonological paraphasia (supramarginal gyrus), [4] Contralateral hand motor arrest (precentral motor strip), and [5]/[6] Negative silent cortex marking the safe subpial corticotomy corridor.",
                    surgicalPearl: "Direct electrical stimulation (DES) remains the gold standard for defining eloquent brain. A 1 cm functional margin around positive language sites prevents permanent postoperative language deficits."
                ),

                SurgicalCallout(
                    id: "plate_070_3",
                    title: "16× Subcortical DES, 5-ALA Fluorescence & Tract Sparing",
                    structureType: "SUBCORTICAL DISSECTION & WHITE MATTER PRESERVATION",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.764,
                    normalizedY: 0.170,
                    description: "Panel C illustrates the cavity under 405 nm violet-blue illumination. The glioblastoma core exhibits intense ruby-magenta Protoporphyrin IX (PpIX) fluorescence debulked by CUSA. A subcortical monopolar ball-tip probe actively stimulates deep cavity walls, identifying the glistening striated white fiber bundles of the Arcuate Fasciculus on the deep lateral wall and the Corticospinal Tract (CST) on the posterior-medial floor, defining the functional boundary of supratotal resection.",
                    surgicalPearl: "5-ALA fluorescence visualizes tumor tissue beyond MRI gadolinium margins, but fluorescence must always be subordinated to subcortical stimulation: when a positive motor or language response occurs, tumor resection must halt regardless of residual pink fluorescence."
                )
            ]

                                                                        case .plate069:
            return [
                SurgicalCallout(
                    id: "plate_069_1",
                    title: "3D Contrast MRI & Sindou Classification Matrix",
                    structureType: "NEUROIMAGING & SSS INVASION MATRIX",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.191,
                    normalizedY: 0.160,
                    description: "Panel A exhibits pre- and post-operative 3T contrast MRI of a spherical middle-third parasagittal/falcine meningioma compressing the rolandic cortex and invading the superior sagittal sinus (SSS). Complete Simpson resection with patent SSS on post-op imaging. The bottom matrix details the Sindou Classification (Types I through VI) defining the surgical strategy: from outer dural coagulation (Type I) and lateral wall repair with patch duraplasty (Types II–IV) to saphenous bypass (Type V) or en-bloc sinus resection (Type VI).",
                    surgicalPearl: "The Sindou Classification dictates the limits of safe oncological resection. Invasion of the lateral wall (Types II–IV) permits complete Simpson Grade I resection when paired with meticulous autologous patch reconstruction, avoiding sinus sacrifice."
                ),

                SurgicalCallout(
                    id: "plate_069_2",
                    title: "SSS-Crossing Craniotomy & Rolandic Bridging Vein Sparing",
                    structureType: "SURGICAL EXPOSURE & VENOUS TOPOGRAPHY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.546,
                    normalizedY: 0.652,
                    description: "Panel B demonstrates surgical planning and exposure: (1) Vertex topography illustrating 4 burr holes straddling the midline SSS for safe dural peeling without sinus tear; (2) D-shaped dural flap hinged medially along the SSS. The large operative field reveals the central rolandic vein and vein of Trolard meticulously skeletonized and preserved as they enter the lateral lacunae, alongside devascularization of middle meningeal artery branches along the convexity.",
                    surgicalPearl: "Never sacrifice dominant rolandic bridging veins in the middle or posterior third of the SSS. Occluding or tearing the central rolandic vein triggers devastating hemorrhagic infarction of the motor cortex with permanent contralateral hemiplegia."
                )
            ]

                                                                        case .plate068:
            return [
                SurgicalCallout(
                    id: "plate_068_1",
                    title: "3D Multi-Modal MRI, Eden Classification & Corridor Biomechanics",
                    structureType: "NEUROIMAGING & AXIAL RESECTION VECTOR",
                    color: Color.red,
                    normalizedX: 0.753,
                    normalizedY: 0.130,
                    description: "Panel A illustrates multi-planar 3T MRI of an Eden Type II/III thoracic dumbbell schwannoma showing intradural cord compression with CSF capping, foraminal waist widening, and paravertebral soft-tissue extension. The axial cross-section demonstrates the costotransversectomy corridor: resection of the transverse process, rib head, proximal 3–5 cm rib, pedicle, and lateral vertebral body, creating a 180° posterolateral trajectory directly to the lateral thecal sac and posterior mediastinum with zero spinal cord retraction. Inset details Eden Types I through IV.",
                    surgicalPearl: "The costotransversectomy corridor eliminates the need for thoracic spinal cord retraction. Resecting the proximal rib head and pedicle converts a deep, high-risk traction corridor into a flat, tangential working trajectory."
                ),


                SurgicalCallout(
                    id: "plate_068_2",
                    title: "Posterolateral Exposure, Extrapleural Corridor & Dumbbell Lobes",
                    structureType: "OPERATIVE FIELD & TRIPLE-COMPARTMENT TOPOGRAPHY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.558,
                    normalizedY: 0.634,
                    description: "Panel B reveals the deep operative exposure from rostral T1 to caudal T3. Bilateral pedicle screws with rods provide rigid biomechanical stabilization. The lobulated yellow-tan dumbbell tumor is cleanly differentiated into three continuous compartments: intradural (spinal canal), foraminal, and extraforaminal thoracic (paravertebral). Parietal pleura is mobilized extrapleurally and protected with moist gauze. The intercostal neurovascular bundle (vein, artery, nerve) tracks along the rib margin into the neural foramen next to the costal stump (3–5 cm rib resection).",
                    surgicalPearl: "Always dissect in the extrapleural plane. Gentle blunt mobilization of the parietal pleura with a moist sponge avoids pleural laceration and prevents postoperative pneumothorax or hemothorax."
                )
            ]

                                                                        case .plate067:
            return [
                SurgicalCallout(
                    id: "plate_067_1",
                    title: "3D CT Angiography & Condylar Resection Biomechanics",
                    structureType: "ANGIOPATHOLOGY & SKULL BASE BIOMECHANICS",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.500,
                    description: "Panel A shows 3D CT angiography of the left vertebral artery (VA) ascending from horizontal V3 into intradural V4, giving off the anterior spinal artery (ASA) and basilar artery. A saccular aneurysm arises at the VA-PICA junction, projecting posterolaterally toward the lower cranial nerves. PICA segments (anterior medullary, lateral medullary, tonsillomedullary) loop gracefully. Bottom inset contrasts the narrow ~60° retrocondylar viewing angle against the flat ~90° corridor achieved by resecting the posterior 1/3 of the occipital condyle, opening a 30° wider surgical window without brainstem retraction.",
                    surgicalPearl: "Partial condylectomy (posterior 1/3) provides a flat, shallow corridor directly along the anterior surface of the medulla. It converts a deep, high-risk traction corridor into a direct, line-of-sight exposure of the aneurysm neck."
                ),
                SurgicalCallout(
                    id: "plate_067_2",
                    title: "Far-Lateral Suboccipital Triangle & Condylar Drilling",
                    structureType: "EXTRADURAL V3 & SKULL BASE EXPOSURE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.500,
                    normalizedY: 0.380,
                    description: "Panel B illustrates the far-lateral transcondylar approach via a retroauricular hockey-stick incision. Layered muscular reflection exposes the suboccipital triangle (rectus capitis posterior major, superior oblique, and inferior oblique). The V3 horizontal segment of the vertebral artery loops across the C1 posterior arch groove, enveloped by a dense suboccipital venous plexus. Bony resection encompasses lateral suboccipital craniectomy unroofing the sigmoid sinus down to the jugular bulb, C1 lateral hemilaminectomy, and high-speed diamond burr drilling of the posterior 1/3 of the occipital condyle, preserving the hypoglossal canal.",
                    surgicalPearl: "The V3 segment must be identified and mobilized early. Bipolar coagulation and hemostatic packing (Surgiflo) of the suboccipital venous plexus prevents air embolism and maintains a bloodless field during condylar drilling."
                ),
                SurgicalCallout(
                    id: "plate_067_3",
                    title: "16× Microsurgical Corridor, Lower CNs & PICA Clipping",
                    structureType: "INTRADURAL MICROSURGERY & PERFUSION RECONSTRUCTION",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.820,
                    normalizedY: 0.380,
                    description: "Panel C operating microscope view under 16× magnification. The medulla, olive, and preolivary/postolivary sulci are pristine. CN XII rootlets emerge from the preolivary sulcus, while CN IX, X, and XI cascade through the postolivary sulcus toward the jugular foramen. A curved mini-Yasargil titanium clip reconstructs the aneurysm neck at the VA-PICA junction, preserving the parent V4 lumen and PICA origin. A micro-Doppler probe confirms robust downstream pulsatile flow in the PICA (>20 cm/s).",
                    surgicalPearl: "PICA aneurysms are intimately intertwined with the rootlets of CN IX, X, and XI. Dissect the arachnoid bands sharply around these rootlets rather than retracting them; blunt traction causes severe postoperative vocal cord paralysis and dysphagia."
                ),
                SurgicalCallout(
                    id: "plate_067_4",
                    title: "Intraoperative Neuromonitoring & Condylar Safety Rule",
                    structureType: "NEUROMONITORING & CRANIOCERVICAL BIOMECHANICS",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.440,
                    normalizedY: 0.954,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.500,
                    description: "Sagittal 3T contrast MRI demonstrates a giant (~6 cm) homogeneously enhancing subfrontal olfactory groove meningioma with hyperostotic downward remodeling into the ethmoid sinus. Displaces the frontal lobe superiorly/posteriorly and drapes bilateral A2 ACA trunks over the posterior dome. Bottom inset contrasts olfactory groove meningiomas (push optic chiasm down/back) against tuberculum sellae meningiomas (push optic chiasm up/lateral).",
                    surgicalPearl: "The displacement of the optic chiasm is the defining anatomical difference: olfactory groove tumors arise anterior to the chiasm and push it posteroinferiorly, whereas tuberculum sellae tumors arise directly beneath the chiasm and elevate it. Draped ACAs require patient extracapsular microdissection."
                ),
                SurgicalCallout(
                    id: "plate_066_2",
                    title: "Bifrontal Exposure & Extradural Devascularization",
                    structureType: "EXTRADURAL DEVASCULARIZATION CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.500,
                    normalizedY: 0.380,
                    description: "Low bifrontal craniotomy drilled flush with orbital roofs and nasion. A large vascularized pericranial flap is preserved and reflected anteriorly. Extradural elevation of frontal dura exposes the crista galli, cribriform plate, and planum sphenoidale. Bipolar cautery divides the anterior ethmoidal artery at the fronto-ethmoidal suture and posterior ethmoidal artery near the optic canal, cutting off >80% of tumor vascularity before durotomy.",
                    surgicalPearl: "Extradural coagulation of the anterior and posterior ethmoidal arteries is the hallmark of the transbasal approach. Devascularizing the tumor from its skull base attachments converts a high-tension, vascular tumor into a soft, ischemic, easily aspirable mass."
                ),
                SurgicalCallout(
                    id: "plate_066_3",
                    title: "16× CUSA Debulking, ACA Sparing & Simpson Grade I Repair",
                    structureType: "INTRADURAL MICROSURGERY & SKULL BASE REPAIR",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.820,
                    normalizedY: 0.380,
                    description: "16× operating microscope view. Ultrasonic aspiration (CUSA) hollows out the firm fibrous core of the meningioma, collapsing the capsule inward away from frontal cortex. Extracapsular arachnoid dissection mobilizes and preserves the draped bilateral A2 ACAs and frontopolar branches, decompressing the optic apparatus. Simpson Grade I reconstruction removes hyperostotic crista galli and cribriform floor, sealed with the vascularized pericranial flap and fibrin glue.",
                    surgicalPearl: "Always dissect in the arachnoid cleavage plane. The ACAs and their frontopolar branches are separated from the tumor by an intact arachnoid layer; pulling or coagulating on the tumor capsule blindly risks anterior cerebral artery thrombosis and profound bilateral frontal lobe infarction."
                ),
                SurgicalCallout(
                    id: "plate_066_4",
                    title: "Meningothelial Neuropathology & CSF Leak Protocol",
                    structureType: "NEUROPATHOLOGY & MULTILAYER CLOSURE",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.186,
                    normalizedY: 0.866,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.214,
                    normalizedY: 0.191,
                    description: "Preoperative non-contrast CT demonstrates a well-circumscribed hyperdense round mass centered at the foramen of Monro causing acute biventricular obstructive hydrocephalus. Preoperative T1 MRI shows a hyperintense/isointense mucinous cyst; postoperative CT confirms complete excision and ventriculomegaly resolution. Coronal schematic illustrates the 3 third ventricular corridors: (1) Transforaminal, (2) Interforniceal, and (3) Transchoroidal (subchoroidal).",
                    surgicalPearl: "CT hyperdensity reflects high protein and mucin viscosity within the cyst, which often resists needle aspiration and requires sharp fenestration and micro-curettage. Preoperative imaging must assess fornix splaying to select between transforaminal and interforniceal entry."
                ),
                SurgicalCallout(
                    id: "plate_065_2",
                    title: "Right Transcallosal Exposure & Foramen of Monro Anatomy",
                    structureType: "INTRAVENTRICULAR MICROSURGICAL ANATOMY",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.520,
                    normalizedY: 0.175,
                    description: "Right frontoparietal parasagittal craniotomy with interhemispheric corridor along the falx. Limited 1.5–2.0 cm anterior callosotomy between pericallosal arteries entering the right lateral ventricle. Definitive intraventricular landmarks: pearly-white septum pellucidum with the vertical septal vein medially, arching ivory fornix column, thalamostriate vein coursing to the venous angle, glomerular choroid plexus along the choroidal fissure, and the yellowish-amber colloid cyst bulging through the foramen.",
                    surgicalPearl: "Limiting anterior callosotomy to <2.0 cm strictly anterior to the coronal suture prevents disconnection syndromes (interhemispheric transfer deficits). Sparing bridging veins entering the superior sagittal sinus avoids hemorrhagic venous infarction of the motor strip."
                ),
                SurgicalCallout(
                    id: "plate_065_3",
                    title: "16× Cyst Evacuation, Capsule Dissection & Restored Foramen",
                    structureType: "4-STEP CYST RESECTION & FORAMEN RESTORATION",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.820,
                    normalizedY: 0.380,
                    description: "Progressive 4-step microsurgical sequence: (1) Cyst fenestration and micro-aspiration of viscous mucinous contents; (2) Capsule mobilization peeling the fibrous wall off the third ventricle roof; (3) Preservation of bilateral forniceal columns and deep internal cerebral veins in the velum interpositum; (4) Widely patent, communicating bilateral foramina of Monro restoring normal cerebrospinal fluid dynamics.",
                    surgicalPearl: "Never pull vigorously on the cyst capsule where it adheres to the third ventricular roof; the internal cerebral veins run immediately adjacent within the velum interpositum. Cauterizing the capsule gently shrinks it away from the deep venous system without risking torrential deep intraventricular hemorrhage."
                ),
                SurgicalCallout(
                    id: "plate_065_4",
                    title: "H&E Neuropathology & Forniceal / Venous Angle Safety",
                    structureType: "NEUROPATHOLOGY & SAFETY PROTOCOL",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.500,
                    normalizedY: 0.880,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.500,
                    description: "Sagittal T1 contrast MRI demonstrates a well-circumscribed, homogeneously enhancing central intramedullary cervical mass (C4–C6) flanked by rostral and caudal polar syrinx cysts. Sagittal T2WI reveals the pathognomonic 'hemosiderin cap sign' (jet-black hypointense rims capping superior and inferior poles from chronic microhemorrhages). Axial cutaway contrasts central encapsulated ependymoma against infiltrative astrocytoma.",
                    surgicalPearl: "The presence of polar syrinx cysts and T2 hemosiderin caps is highly predictive of ependymoma over astrocytoma, indicating a surgically cleavable capsule that permits gross total resection with curative potential."
                ),
                SurgicalCallout(
                    id: "plate_064_2",
                    title: "Posterior Cervical Exposure & Posterior Median Sulcus Myelotomy",
                    structureType: "POSTERIOR MYELOTOMY CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.500,
                    normalizedY: 0.380,
                    description: "Multi-level posterior cervical exposure (C3–C6 laminectomy) with dura opened mid-dorsally. Symmetrically swollen cord with engorged coronal venous plexus. A diamond micro-knife incises the avascular posterior median sulcus strictly between the dorsal columns (fasciculus gracilis and cuneatus). Fine 6-0/7-0 monofilament pial stay sutures gently tent the posterior columns open to expose the reddish-tan encapsulated tumor.",
                    surgicalPearl: "Always identify the dorsal median sulcus by inspecting the convergence of posterior surface micro-vessels or using a dorsal column mapping probe. Incising off-midline into the fasciculus cuneatus causes severe ipsilateral posterior column sensory ataxia and loss of proprioception."
                ),
                SurgicalCallout(
                    id: "plate_064_3",
                    title: "Gliotic Cleavage Dissection & En-Bloc Resection Bed",
                    structureType: "EN-BLOC RESECTION & ASA SPARING",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.820,
                    normalizedY: 0.380,
                    description: "High-magnification (16×) view demonstrating the distinct gliotic cleavage plane separating the encapsulated reddish-tan ependymoma from normal white matter tracts. Polar mobilization allows the tumor to be rolled en-bloc from rostral to caudal while tiny ventral feeding sulcal branches from the Anterior Spinal Artery (ASA) are coagulated and divided, leaving an empty, glistening resection bed.",
                    surgicalPearl: "Never apply forceful traction or use gross internal debulking if the tumor can be delivered en-bloc. Ventral feeders must be coagulated precisely on the tumor capsule to avoid thermal or traction injury to the main ASA trunk running on the anterior median fissure floor."
                ),
                SurgicalCallout(
                    id: "plate_064_4",
                    title: "Real-Time IONM (D-Wave/MEP/SSEP) & Histopathology",
                    structureType: "NEUROMONITORING & WHO GRADE II HISTOLOGY",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.500,
                    normalizedY: 0.880,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.550,
                    description: "Catheter DSA (Towne's/RAO view) demonstrating the vertebral confluence, basilar trunk, AICA, SCA, and saccular basilar apex aneurysm between bilateral P1 PCAs. Correlative sagittal classification defines 3 tiers relative to the dorsum sellae: Normal Apex (within 5 mm above dorsum sellae), High-Riding Apex (>5–10 mm above clinoid, invaginating third ventricle), and Low-Riding Apex (below posterior clinoid, hidden behind clivus).",
                    surgicalPearl: "Bifurcation height dictates surgical strategy: a normal apex is accessible via standard transsylvian/pterional corridors; a high-riding apex requires an orbitocranial or subtemporal approach with posterior clinoidectomy; a low-riding apex requires a transcavernous or anterior petrosectomy (Kawase) approach."
                ),
                SurgicalCallout(
                    id: "plate_063_2",
                    title: "Right Pterional Transsylvian & Trans-Liliequist Corridor",
                    structureType: "MICROSURGICAL OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.500,
                    normalizedY: 0.380,
                    description: "Right pterional transsylvian exposure with flattened sphenoid ridge and reflected dural apron. Carotid-oculomotor and opticocarotid triangles are opened following division of both carotid and diencephalic leaves of Liliequist's membrane. A temporary clip is applied on the mid-basilar trunk below the SCA origins for proximal hemodynamic control. The oculomotor nerve (CN III) is cleanly mobilized between P1 and SCA.",
                    surgicalPearl: "CN III is the sentinel landmark of the upper basilar complex, passing precisely between P1 above and SCA below. Gentle mobilization without traction prevents post-operative third nerve palsy (ptosis, mydriasis, and down-and-out diplopia)."
                ),
                SurgicalCallout(
                    id: "plate_063_3",
                    title: "16× Interpeduncular Dissection & Permanent Clip Application",
                    structureType: "CLIP RECONSTRUCTION & PERFORATOR SPARING",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.810,
                    normalizedY: 0.380,
                    description: "High-magnification (16×) view of the interpeduncular fossa. A curved titanium Yasargil/Sugita clip is placed flush across the basilar neck parallel to the P1-P1 plane, completely excluding the aneurysm with visible collapse and purplish darkening of the sac. Complete preservation of bilateral P1s, SCAs, CN III, and the critical posterior thalamoperforators.",
                    surgicalPearl: "Meticulous microscopic inspection behind the basilar apex is required before and after clip closure. The posterior thalamoperforating micro-arteries (paramedian mesencephalic branches) supply the midbrain and thalami; inadvertent clipping causes devastating coma, akinetic mutism, or bilateral paramedian thalamic infarction."
                ),
                SurgicalCallout(
                    id: "plate_063_4",
                    title: "Intraoperative ICG Videoangiography & Micro-Doppler Verification",
                    structureType: "FLOW PATENCY & EXCLUSION CONFIRMATION",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.500,
                    normalizedY: 0.880,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.294,
                    normalizedY: 0.210,
                    description: "Right internal carotid catheter DSA (lateral/oblique view) displaying the horizontal sphenoidal M1 trunk, fine candle-flame lateral lenticulostriate perforating arteries (LsA) arising from the dorsal aspect of M1, and a saccular aneurysm at the MCA bifurcation (limen insulae) dividing into superior (frontal) and inferior (temporal) M2 trunks.",
                    surgicalPearl: "Preoperative 4-vessel angiography or high-resolution 3D rotational DSA is mandatory to identify early branching (e.g. early anterior temporal artery mimicking bifurcation) and to map the relationship of the lateral lenticulostriate arteries, which supply the posterior limb of the internal capsule."
                ),

                SurgicalCallout(
                    id: "plate_062_2",
                    title: "Right Pterional Transsylvian Exposure & Distal-to-Proximal Corridor",
                    structureType: "MICROSURGICAL OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.791,
                    normalizedY: 0.152,
                    description: "Right frontotemporal pterional craniotomy with sphenoid ridge drilled flat to the meningo-orbital band. Frontal and temporal opercula are gently separated with self-retaining retractor blades across the Sylvian fissure. Superficial Sylvian veins are preserved on the temporal bank. A temporary clip is placed on the horizontal M1 trunk for proximal hemodynamic control during bifurcation dissection.",
                    surgicalPearl: "The distal-to-proximal transsylvian approach traces M2 opercular branches retrograde down to the bifurcation, which minimizes frontal lobe retraction. Always apply temporary clips on M1 only after identifying and sparing all dorsal lenticulostriate perforators."
                ),

                SurgicalCallout(
                    id: "plate_062_3",
                    title: "16× Multi-Clip Tandem Reconstruction & Sac Incision",
                    structureType: "TANDEM CLIP RECONSTRUCTION & EXCLUSION",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.483,
                    normalizedY: 0.620,
                    description: "High-magnification (16×) view of the MCA bifurcation. A complex, broad-based aneurysm neck is reconstructed using multiple interlocking titanium Yasargil/Sugita clips applied in tandem. The excluded aneurysm sac is sharply incised and decompressed, proving complete flow obliteration. Both superior M2 (frontal motor) and inferior M2 (temporal language) trunks remain widely patent.",
                    surgicalPearl: "In broad-necked MCA aneurysms, a single straight clip risks dog-ear residual or stenosis of the daughter trunks. Applying a tandem or fenestrated clip construct reconstructs the native arterial carina. Puncturing or incising the dome confirms complete exclusion before releasing temporary clips."
                )
            ]

                                                                        case .plate061:
            return [
                SurgicalCallout(
                    id: "plate_061_1",
                    title: "AComA Aneurysm 4-Projection Classification & CTA MIP",
                    structureType: "ANGIOGRAPHIC MORPHOLOGY & CTA",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.550,
                    description: "Axial CTA MIP and four canonical projection profiles: (a) Anteroinferior (projects toward prechiasmatic cistern/optic chiasm; prone to rupture during initial frontal lobe retraction), (b) Superior/Interhemispheric (projects upward between bilateral A2s), (c) Posterosuperior (projects toward lamina terminalis/hypothalamus; high perforator risk), and (d) Complex/Inferior-Dorsal (adherent to dorsal chiasm).",
                    surgicalPearl: "Preoperative 3D CTA and rotational DSA define the dominant feeding A1 (present in >80% of AComA aneurysms due to asymmetric circle of Willis flow dynamics). Pterional craniotomy is chosen on the side of the dominant A1 to secure early proximal control."
                ),
                SurgicalCallout(
                    id: "plate_061_2",
                    title: "Right Pterional Transsylvian Approach & Gyrus Rectus Corridor",
                    structureType: "MICROSURGICAL OPERATIVE CORRIDOR",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.500,
                    normalizedY: 0.380,
                    description: "Right frontotemporal pterional craniotomy with sphenoid ridge drilled flat to the meningo-orbital band. The Sylvian fissure is widely split, releasing CSF from the carotid-optic cistern. A temporary clip is placed on the dominant Right A1 for proximal hemodynamic protection. A minimal 5 mm subpial resection of the gyrus rectus medial to the olfactory tract exposes the AComA complex and contralateral A1/A2 without brain retraction injury.",
                    surgicalPearl: "Subpial gyrus rectus resection must remain strictly medial to the olfactory tract and anterior to the anterior communicating artery to avoid damaging the olfactory striae, optic chiasm, or hypothalamic nuclei. Preserving the pial cuff prevents venous infarction."
                ),
                SurgicalCallout(
                    id: "plate_061_3",
                    title: "16× Microdissection & Permanent Yasargil Clip Application",
                    structureType: "CLIP RECONSTRUCTION & PERFORATOR SPARING",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.810,
                    normalizedY: 0.380,
                    description: "High-magnification (16×) view showing 360° circumferential skeletonization of the aneurysm neck. A titanium Sugita/Yasargil spring clip completely occludes the neck flush with the parent AComA vessel, causing visible collapse and darkening of the excluded sac. Complete preservation of bilateral A2 trunks, the Recurrent Artery of Heubner (RAH), and posterior hypothalamic/chiasmatic perforating micro-arterioles.",
                    surgicalPearl: "The clip blades must span 1–2 mm beyond the far neck margin to ensure complete closure without leaving a residual neck dog-ear. Meticulously inspect the tips behind the neck to confirm that the contralateral A2, Heubner's artery, and hypothalamic perforators are completely free before releasing proximal temporary clips."
                ),
                SurgicalCallout(
                    id: "plate_061_4",
                    title: "Intraoperative ICG Videoangiography & Micro-Doppler Verification",
                    structureType: "FLOW PATENCY & EXCLUSION CONFIRMATION",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.500,
                    normalizedY: 0.880,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.170,
                    normalizedY: 0.400,
                    description: "Chronic progressive stenosis/occlusion of the terminal supraclinoid ICA (carotid fork) triggering extensive lenticulostriate and thalamoperforating collateral telangiectasias at the skull base ('moyamoya' or puff of smoke). Progresses from early bifurcation narrowing (Stage I) through florid basal collaterals (Stage III) to complete ICA occlusion and dependence on ECA vault collaterals (Stage VI).",
                    surgicalPearl: "Fragile moyamoya collateral microvessels are prone to microaneurysm formation and rupture, causing catastrophic adult intracerebral/intraventricular hemorrhage. Revascularization reduces hemodynamic stress on these fragile basal networks."
                ),
                SurgicalCallout(
                    id: "plate_060_2",
                    title: "STA-MCA End-to-Side Micro-Anastomosis (16× Magnification)",
                    structureType: "MICROSURGICAL BYPASS FIELD",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.520,
                    normalizedY: 0.350,
                    description: "Direct end-to-side anastomosis between the donor superficial temporal artery (STA, ~1.5–2.0 mm caliber) and recipient cortical middle cerebral artery (M4 / angular branch, ~1.0 mm caliber). A green rubber contrast sheet elevates the vessel. Paired temporary micro-clips isolate a 5–7 mm recipient segment with a 1.5–2.0 mm linear arteriotomy.",
                    surgicalPearl: "Fish-mouth the donor STA tip at 45° to match the oval arteriotomy and prevent anastomotic stenosis. Place foundational heel and toe 10-0 nylon anchor sutures first, followed by 5–6 interrupted 10-0 monofilament sutures per side with intimal eversion."
                ),
                SurgicalCallout(
                    id: "plate_060_3",
                    title: "EDAS (Encephalo-Duro-Arterio-Synangiosis) Indirect Revascularization",
                    structureType: "INDIRECT SYNANGIOSIS CORRIDOR",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.840,
                    normalizedY: 0.420,
                    description: "The intact, pulsating parietal branch of the STA is mobilized with a wide (~1 cm) galea-periosteal cuff along 7–8 cm. Through a linear dural slit with micro-fenestrated arachnoid, the adventitia of the artery and galeal cuff are anchored flush against the bare ischemic cerebral cortex using interrupted 8-0 nylon dural sutures.",
                    surgicalPearl: "Maintain continuous anterograde flow through the intact STA; do not cauterize or strip the perivascular adventitia, which carries critical VEGF and bFGF angiogenic factors essential for spontaneous transdural neovascular sprouting over 3–6 months."
                ),
                SurgicalCallout(
                    id: "plate_060_4",
                    title: "Intraoperative ICG Videoangiography & Flow Verification",
                    structureType: "FLOW HEMODYNAMICS & PATENCY",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.250,
                    normalizedY: 0.880,
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
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.160,
                    normalizedY: 0.350,
                    description: "Absence of the intervening high-resistance capillary bed creates a low-resistance, high-flow arteriovenous fistula. Massive arterial runoff into thin-walled, arterialized draining veins drives progressive venous ectasia, turbulent shear stress, and recruitment of hypertrophied feeding arteries.",
                    surgicalPearl: "High-flow shunting induces chronic hypoperfusion in adjacent normal brain (cerebral steal), making surrounding parenchyma exquisitely susceptible to ischemia or hyperemic breakthrough."
                ),
                SurgicalCallout(
                    id: "plate_056_2",
                    title: "Spetzler-Martin Grading System & Eloquence Mapping",
                    structureType: "SURGICAL RISK CLASSIFICATION",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.468,
                    normalizedY: 0.642,
                    description: "Three-tier anatomical risk scoring: Nidus Size (<3 cm = 1, 3–6 cm = 2, >6 cm = 3); Eloquence of adjacent brain (Non-eloquent = 0, Eloquent = 1: motor, sensory, language, visual, thalamus, internal capsule, brainstem); Venous Drainage (Superficial only = 0, Deep components = 1). Total Grade I–V correlates directly with surgical morbidity and mortality.",
                    surgicalPearl: "Grades I and II are ideal microsurgical candidates (<3% deficit); Grade III represents a mixed management dilemma often requiring staged embolization; Grades IV and V carry prohibitive surgical morbidity and are usually managed conservatively."
                ),
                SurgicalCallout(
                    id: "plate_056_3",
                    title: "Circumferential Feeder Dissection (The 'Vein Last' Rule)",
                    structureType: "MICROSURGICAL CARDINAL AXIOM",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.840,
                    normalizedY: 0.350,
                    description: "Microsurgical circumdissection advances 360° along the gliotic hemosiderin border plane. Pial and sulcal feeders are individually skeletonized, bipolared, and divided at the nidus margin while strictly preserving the main arterialized draining vein.",
                    surgicalPearl: "The cardinal rule of AVM surgery: NEVER occlude the primary draining vein prematurely. Premature venous occlusion transforms the high-flow shunt into a closed pressure cooker, triggering immediate catastrophic intraoperative explosive rupture."
                ),
                SurgicalCallout(
                    id: "plate_056_4",
                    title: "Dry Resection Bed & En-Passage Vessel Preservation",
                    structureType: "POST-RESECTION GLIOTIC MARGIN",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.860,
                    normalizedY: 0.820,
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
                    normalizedX: 0.520,
                    normalizedY: 0.450,
                    description: "Bounded anterolaterally by GSPN/V3, posterolaterally by the arcuate eminence (superior semicircular canal), medially by the superior petrosal sinus (SPS), and anteromedially by Meckel's cave. Drilling this triangle opens a direct 10–12 mm extradural corridor to the posterior fossa dura medial to the IAC.",
                    surgicalPearl: "Drilling must remain strictly medial to the GSPN and anterior to the arcuate eminence to protect the cochlea and vestibular labyrinth."
                ),
                SurgicalCallout(
                    id: "plate_055_2",
                    title: "Horizontal Petrous ICA & GSPN",
                    structureType: "VASCULAR DANGER ZONE",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.480,
                    normalizedY: 0.320,
                    description: "The horizontal segment of the petrous internal carotid artery lies directly deep to the GSPN. In up to 30% of patients, the carotid canal roof is dehiscent.",
                    surgicalPearl: "Elevate the middle fossa dura strictly from posterior to anterior; anterior-to-posterior dissection can snag a dehiscent ICA or avulse the GSPN from the geniculate ganglion, causing facial palsy."
                ),
                SurgicalCallout(
                    id: "plate_055_3",
                    title: "Subsurface Cochlea & Labyrinth Protection",
                    structureType: "AUDITORY SPARING ZONE",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.540,
                    normalizedY: 0.720,
                    description: "The cochlea is hidden in the bone within the apex between the GSPN, geniculate ganglion, and internal auditory canal fundus. The superior semicircular canal lies directly under the arcuate eminence.",
                    surgicalPearl: "Never drill lateral to the line connecting the facial hiatus to the IAC fundus; violation of the otic capsule causes immediate permanent sensorineural hearing loss."
                ),
                SurgicalCallout(
                    id: "plate_055_4",
                    title: "Tentorial Division & Trochlear Nerve (CN IV) Sparing",
                    structureType: "TRANS-TENTORIAL CORRIDOR",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.880,
                    normalizedY: 0.180,
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
                    normalizedX: 0.180,
                    normalizedY: 0.420,
                    description: "Progression from Type I (Lateral capsular), Type II (Extended interlaminar), Type III (Diffuse laminar), to Type IV/V (Fused nodular beak). In Type V, massive bilateral cauliflower ossification meets in the midline, pinching the cord into a thin transverse crescent with >60% canal compromise.",
                    surgicalPearl: "Type IV and V have high incidence of dural ossification (tram-track sign); attempting circumferential dissection without thinning will tear the dura."
                ),
                SurgicalCallout(
                    id: "plate_054_2",
                    title: "The Floating Island / Thin-Shell Technique",
                    structureType: "MICROSURGICAL PROTOCOL",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.880,
                    normalizedY: 0.450,
                    description: "Bilateral pedicle troughs are cut down to the inner cortex with an ultrasonic bone scalpel. The central ossified mass is thinned to a translucent paper-thin shell with a diamond burr and left floating on pulsating dura, avoiding violent peeling from adherent dura.",
                    surgicalPearl: "The floating shell expands outward with restored CSF pulsation; dissecting fused bone off ossified dura is unnecessary and causes giant pseudomeningoceles."
                ),
                SurgicalCallout(
                    id: "plate_054_3",
                    title: "Zero-Plunging Under-Shelf Mandate",
                    structureType: "CRITICAL SAFETY ZONE",
                    color: ObsidianTheme.neonRed,
                    normalizedX: 0.880,
                    normalizedY: 0.220,
                    description: "Strict prohibition against inserting Kerrison rongeur footplates underneath the ossified ligament shelf. The thoracic canal has zero reserve volume; sliding any footplate under the shelf exerts immediate focal compression onto the ischemic thoracic cord.",
                    surgicalPearl: "All bone resection must be strictly extra-cavitary (from superficial to deep) using diamond burrs or ultrasonic aspirators until the bone is eggshell thin."
                ),
                SurgicalCallout(
                    id: "plate_054_4",
                    title: "Sagittal Patterns & Compressive Myelomalacia",
                    structureType: "LONGITUDINAL MORPHOLOGY",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.520,
                    normalizedY: 0.320,
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
                    normalizedX: 0.420,
                    normalizedY: 0.240,
                    description: "Disproportionately Enlarged Subarachnoid Space Hydrocephalus (DESH) is characterized by cavernous Sylvian fissures, severe parasagittal high-convexity sulcal crowding ('vertex crowding'), and an acute callosal angle < 90° (measuring 68° vs. > 110° in ex-vacuo atrophy).",
                    surgicalPearl: "DESH has >80% positive predictive value for shunt responsiveness; diffuse cortical sulcal enlargement across the vertex signifies Alzheimer atrophy, where shunting confers zero benefit and high subdural risk."
                ),
                SurgicalCallout(
                    id: "plate_053_2",
                    title: "The Evans Index (> 0.30)",
                    structureType: "AXIAL VENTRICULOMEGALY CALIPER",
                    color: ObsidianTheme.neonBlue,
                    normalizedX: 0.160,
                    normalizedY: 0.280,
                    description: "Ratio of the maximum frontal horn transverse diameter (48 mm) to the maximum inner biparietal skull diameter at the same axial level (137 mm), yielding an Evans Index of 0.35 (> 0.30 threshold). Faint periventricular halos represent transependymal CSF resorption.",
                    surgicalPearl: "The Evans Index is a mandatory screening metric for ventriculomegaly, but must always be paired with coronal DESH to prevent shunting patients with neurodegenerative cortical atrophy."
                ),
                SurgicalCallout(
                    id: "plate_053_3",
                    title: "Kocher's Point Frontal Trajectory",
                    structureType: "BURR HOLE ENTRY SITE",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.740,
                    normalizedY: 0.160,
                    description: "Right frontal burr hole located 1 cm anterior to the coronal suture and 2.5–3.0 cm lateral to midline in the mid-pupillary line. Trajectory perpendicular to cranial curvature aimed towards the medial canthus of the ipsilateral eye and external auditory meatus.",
                    surgicalPearl: "Never plunge beyond 5.5–6.0 cm from the outer cortex; the ventricular catheter tip must remain cleanly inside the frontal horn anterior to the foramen of Monro."
                ),
                SurgicalCallout(
                    id: "plate_053_4",
                    title: "Programmable Valve & Gravitational Anti-Siphon Unit",
                    structureType: "RETROAURICULAR HARDWARE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.990,
                    normalizedY: 0.394,
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
                    normalizedX: 0.342,
                    normalizedY: 0.411,
                    description: "Avascular posterior tumor dome incised and systematically debulked using ultrasonic aspiration (CUSA) to loosen capsular adhesions.",
                    surgicalPearl: "Stay strictly intracapsular during initial debulking to avoid premature traction on the stretched, attenuated facial nerve."
                ),
                SurgicalCallout(
                    id: "plate_052_2",
                    title: "Facial Nerve (CN VII) Ventral Trajectory",
                    structureType: "CRITICAL CRANIAL NERVE",
                    color: ObsidianTheme.neonRose,
                    normalizedX: 0.500,
                    normalizedY: 0.450,
                    description: "Stretched, splayed facial nerve displaced onto anterior-inferior tumor capsule; mapped continuously with handheld monopolar stimulator.",
                    surgicalPearl: "Preserve the thin arachnoid dissection plane between tumor capsule and facial nerve; leave a thin tumor remnant if adherent."
                ),
                SurgicalCallout(
                    id: "plate_052_3",
                    title: "Drilled Porus Acusticus & IAC Fundus",
                    structureType: "OSTEOLOGICAL DECOMPRESSION",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.611,
                    normalizedY: 0.334,
                    description: "High-speed diamond drilling of posterior IAC lip under continuous cold irrigation, unroofing fundus and exposing transverse crest and Bill's bar.",
                    surgicalPearl: "Bill's bar (vertical crest) separates CN VII anterosuperiorly from superior vestibular nerve posterosuperiorly at the IAC fundus."
                ),
                SurgicalCallout(
                    id: "plate_052_4",
                    title: "AICA Loop & Lower Cranial Nerves",
                    structureType: "NEUROVASCULAR BOUNDARY",
                    color: ObsidianTheme.neonGreen,
                    normalizedX: 0.459,
                    normalizedY: 0.741,
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
            return []
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
                ApproachSequentialStep(stepNumber: 3, title: "Surgical Corridor Planning", detail: "")
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
                ApproachSequentialStep(stepNumber: 2, title: "C1 Lateral Mass & C2 Pedicle Screw Placement", detail: ""),
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
                ApproachSequentialStep(stepNumber: 3, title: "", detail: "")
            ]
        case .plate026:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterolateral Incision & Rib Resection", detail: "Midline incision; resect medial 3-4 cm of rib head and transverse process, unroofing the extrapleural corridor."),
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
                ApproachSequentialStep(stepNumber: 1, title: "Vector Alignment & Retroperitoneal Access", detail: ""),
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
                ApproachSequentialStep(stepNumber: 3, title: "360° Realignment & Instrumented Fusion", detail: "")
            ]
        case .plate035:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Classification & Risk Stratification", detail: ""),
                ApproachSequentialStep(stepNumber: 2, title: "", detail: ""),
                ApproachSequentialStep(stepNumber: 3, title: "Surgical Fixation & Alignment", detail: "Execute bicortical lag screw fixation under dual biplanar fluoroscopy or Harms posterior instrumented polyaxial screw-rod construction.")
            ]
        case .plate036:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Canal Decompression & Indirect Reduction", detail: "Ligamentotaxis via intraoperative distraction and lordosis restoring vertebral height and pulling retropulsed fragments from canal."),
                ApproachSequentialStep(stepNumber: 2, title: "", detail: ""),
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
                ApproachSequentialStep(stepNumber: 1, title: "Oncologic Separation Surgery", detail: ""),
                ApproachSequentialStep(stepNumber: 2, title: "Transpedicular / Posterolateral Decompression", detail: "Unroof spinal canal via laminectomy and transpedicular approach to access retrovertebral epidural disease."),
                ApproachSequentialStep(stepNumber: 3, title: "Rigid Multi-Segment Instrumented Fixation", detail: "")
            ]
        case .plate039:
            return []
        case .plate040:
            return []
        case .plate041:
            return []
        case .plate042:
            return []
        case .plate043:
            return []
        case .plate044:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Type I: Conservative Immobilization", detail: ""),
                ApproachSequentialStep(stepNumber: 2, title: "Type II: Closed Reduction & Halo", detail: ""),
                ApproachSequentialStep(stepNumber: 3, title: "Type IIA: ORIF", detail: ""),
                ApproachSequentialStep(stepNumber: 4, title: "Type III: ORIF", detail: "")
            ]
        case .plate045:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Hyperosmolar Resuscitation", detail: ""),
                ApproachSequentialStep(stepNumber: 2, title: "Temporizing Hyperventilation Bridge", detail: "Brief controlled mechanical hyperventilation targeting PaCO2 30–35 mmHg to induce cerebral vasoconstriction. Strictly a temporizing bridge to immediate surgical theater."),
                ApproachSequentialStep(stepNumber: 3, title: "", detail: ""),
                ApproachSequentialStep(stepNumber: 4, title: "Emergent Decompressive Surgery", detail: "")
            ]
        case .plate046:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Neuromonitoring & Prone Positioning", detail: ""),
                ApproachSequentialStep(stepNumber: 2, title: "Normal-to-Abnormal Surgical Exposure", detail: "Expose normal rostral lamina one level above the defect. Perform laminotomy/laminectomy in pristine anatomy to identify normal dura and conus before tracing into the dysraphic zone."),
                ApproachSequentialStep(stepNumber: 3, title: "Microsurgical Untethering & Placode Preservation", detail: "For filar lipoma: bipolar and transect the filum below the conus. For lipomyelomeningocele: subtotal lipoma debulking, untethering placode from dura without invading cord parenchyma, and soft-tissue placode tubulation."),
                ApproachSequentialStep(stepNumber: 4, title: "Expansile Watertight Duraplasty & Flap Closure", detail: "")
            ]
        case .plate047:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Awake Fiberoptic Intubation & Neutral Positioning", detail: "Perform awake fiberoptic intubation strictly maintaining neutral cervical alignment; avoid any neck extension which can precipitate fatal cervicomedullary compression. Secure Mayfield pin headrest and confirm baseline MEP/SSEP signals."),
                ApproachSequentialStep(stepNumber: 2, title: "C1-C2 Posterior Exposure & Venous Hemostasis", detail: "Midline suboccipital-to-C3 exposure. Cautiously skeletonize C1 posterior arch and lateral masses, controlling profuse bleeding from the peri-ganglionic C1-C2 venous plexus with bipolar cautery, thrombin-soaked gelfoam, and cottonoid compression."),
                ApproachSequentialStep(stepNumber: 3, title: "Goel-Harms Screw Instrumentation", detail: ""),
                ApproachSequentialStep(stepNumber: 4, title: "Posterior Decortication & Arthrodesis", detail: "Thoroughly decorticate the posterior arch of C1, superior lamina of C2, and C1-C2 facet joints. Pack morselized autologous bone graft across the decorticated bed. Close in anatomical layers. Do NOT attempt anterior mass resection.")
            ]
        case .plate048:
            return []
        case .plate049:
            return []

        case .plate050:
            return []

        case .plate051:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Transradial / Transfemoral Access & Diagnostic Run", detail: "Obtain vascular access, advance 6F guide catheter into external carotid artery, and obtain high-resolution diagnostic MMA angiography."),
                ApproachSequentialStep(stepNumber: 2, title: "Superselective Microcatheter Navigation", detail: "Navigate microcatheter over 0.014-inch microwire into anterior and posterior divisions of MMA distal to petrosal branch."),
                ApproachSequentialStep(stepNumber: 3, title: "Liquid Embolic Infusion & Membrane Penetration", detail: "Infuse liquid embolic or microparticles under continuous roadmap fluoroscopy until complete penetration of neovascular outer membrane.")
            ]

        case .plate090:
            return []


        case .plate091:
            return []
        case .plate092:
            return []
        case .plate093:
            return []
        case .plate094:
            return []
        case .plate095:
            return []
        case .plate096:
            return []
        case .plate097:
            return []
        case .plate098:
            return []
        case .plate099:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Prone Exposure & Cervicothoracic Fixation", detail: "Position prone with skull tongs; expose C2 to T5 and place bilateral cervical lateral mass screws and upper thoracic pedicle screws."),
                ApproachSequentialStep(stepNumber: 2, title: "C7 Laminectomy & Transpedicular Wedge", detail: "Resect C7 posterior arch; mobilize bilateral C8 roots and resect symmetrical wedge through C7 pedicles and lateral vertebral body."),
                ApproachSequentialStep(stepNumber: 3, title: "Controlled Extension Closure & Multi-Rod Lock", detail: "Extend cervical spine under continuous neuromonitoring to close osteotomy; lock primary and accessory outrigger rods.")
            ]
        case .plate100:
            return []
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
            return []
        case .plate104:
            return []
        case .plate105:
            return []
        case .plate106:
            return []
        case .plate089:
            return []

        case .plate088:
            return []

        case .plate087:
            return []

        case .plate086:
            return []

        case .plate085:
            return []

        case .plate084:
            return []

        case .plate083:
            return []

        case .plate082:
            return []

        case .plate081:
            return []

        case .plate080:
            return []

        case .plate079:
            return []

        case .plate078:
            return []

        case .plate077:
            return []

        case .plate076:
            return []

        case .plate075:
            return []

        case .plate074:
            return []

        case .plate073:
            return []

                                                                        case .plate072:
            return []

                                                                        case .plate071:
            return []

                                                                        case .plate070:
            return []

                                                                        case .plate069:
            return []

                                                                        case .plate068:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Thecal Sac Durotomy & Intradural Phase", detail: "Perform a lateral linear durotomy centered over the intradural tumor pole. Dissect the arachnoid plane between the tumor and the compressed thoracic spinal cord under 16× magnification. Identify the dorsal root of origin and safely divide it with bipolar cautery, while strictly preserving adjacent ventral motor rootlets and passing radiculomedullary arterial feeders."),
                ApproachSequentialStep(stepNumber: 2, title: "Foraminal & Extraforaminal CUSA Debulking", detail: "Transition to the extradural/extrapleural compartment. Use an ultrasonic aspirator (CUSA) to internally cavitate and debulk the firm tumor tissue within the neural foramen and the large thoracic paravertebral mass, collapsing the capsule inward away from the sympathetic chain and parietal pleura."),
                ApproachSequentialStep(stepNumber: 3, title: "En-Bloc Capsule Delivery & Spinal Cord Mobilization", detail: "Circumferentially dissect the collapsed tumor capsule off the posterior mediastinal borders and delivery the entire dumbbell mass. Confirm gross total tumor resection, complete decompression, and spontaneous midline re-expansion of the thoracic spinal cord."),
                ApproachSequentialStep(stepNumber: 4, title: "Watertight Dural Repair & CSF-Pleural Fistula Prevention", detail: "Execute a watertight running monofilament suture closure of the lateral durotomy. Reinforce the repair with an onlay collagen dural matrix patch and fibrin sealant. Negative intrathoracic pleural pressure acts as a powerful siphon; an airtight and watertight dural barrier is essential to prevent CSF-pleural fistula."),
                ApproachSequentialStep(stepNumber: 5, title: "Posterior Column Reconstruction & Rigid Arthrodesis", detail: "Reconstruct the anterior column using an expandable or mesh titanium interbody cage packed with autologous bone graft. Complete bilateral pedicle screw and rod instrumentation spanning the decompressed thoracic segments to ensure 100% biomechanical stability and prevent post-costotransversectomy kyphosis.")
            ]

                                                                        case .plate067:
            return []

                                                                        case .plate066:
            return []

                                                                        case .plate065:
            return []

                                                                        case .plate064:
            return []

                                                                        case .plate063:
            return []

                                                                        case .plate062:
            return []

                                                                        case .plate061:
            return []

                                                                        case .plate060:
            return []
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
            return []
        case .plate055:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Subtemporal Craniotomy & Extradural Exposure", detail: ""),
                ApproachSequentialStep(stepNumber: 2, title: "Kawase Triangle Delineation & Petrous Apex Drilling", detail: "Identify Kawase's rhomboid: GSPN anterolaterally, arcuate eminence posterolaterally, SPS medially, Meckel's cave anteromedially. Under continuous cold irrigation, drill petrous apex with diamond burrs, unroofing the posterior fossa dura from Meckel's cave to the internal acoustic meatus while preserving the cochlea and horizontal ICA."),
                ApproachSequentialStep(stepNumber: 3, title: "SPS Ligation & Tentorial Incision", detail: "Bipolar coagulate, clip, and sharply divide the superior petrosal sinus. Incise the tentorium from the petrous apex toward the tentorial incisura, carefully aiming posterior to the entrance of CN IV. Reflect tentorial flaps to unite middle and posterior cranial fossae into a single wide corridor."),
                ApproachSequentialStep(stepNumber: 4, title: "Trans-Tentorial Tumor Resection & Neurovascular Sparing", detail: "Intra-arachnoidal dissection if possible")
            ]
        case .plate054:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Posterior Thoracic Exposure & Level Localization", detail: "Prone position on Jackson table with Wilson frame. Midline incision centered over the thoracic OLF level under fluoroscopic guidance. Subperiosteal dissection of paraspinal muscles laterally to the facet joints, preserving facet capsules outside the decompression zone."),
                ApproachSequentialStep(stepNumber: 2, title: "Bilateral Lateral Trough Drilling", detail: "Using an ultrasonic bone scalpel or 3-mm diamond burr under continuous saline irrigation, drill bilateral longitudinal troughs at the medial junction of the pedicles and laminas down to the inner cortex, isolating the ossified laminar bridge."),
                ApproachSequentialStep(stepNumber: 3, title: "Floating Island Thin-Shell Technique", detail: "Thin the central ossified mass to a translucent paper-thin shell using a diamond burr. Strictly avoid inserting Kerrison footplates beneath the ossified shelf to prevent spinal cord impingement."),
                ApproachSequentialStep(stepNumber: 4, title: "Dural Decompression & Hemostasis", detail: "Do not force Kerrison under the bony shelf")
            ]
        case .plate053:
            return []
        case .plate052:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Retrosigmoid Craniectomy & Cisternal CSF Drainage", detail: "Perform keyhole retrosigmoid craniectomy; drain cisterna magna to achieve spontaneous gravity cerebellar relaxation."),
                ApproachSequentialStep(stepNumber: 2, title: "Posterior Capsular Incision & Debulking", detail: "Intra-Arachnoidal Dissection"),
                ApproachSequentialStep(stepNumber: 3, title: "IAC Unroofing & Facial Nerve Preservation", detail: "Drill posterior IAC wall to expose fundus; identify CN VII at Bill's bar and dissect medially back to brainstem.")
            ]
        }
    }

    public var catastrophicHazards: [String] {
        switch self {
        case .plate001:
            return []
        case .plate002:
            return []
        case .plate003:
            return []
        case .plate004:
            return []
        case .plate005:
            return []
        case .plate006:
            return []
        case .plate007:
            return []
        case .plate008:
            return []
        case .plate009:
            return []
        case .plate010:
            return []
case .plate011:
            return []
        case .plate012:
            return []
        case .plate013:
            return []
        case .plate014:
            return []
        case .plate015:
            return [
                "Carotid Sheath or Esophageal Perforation: Palpate carotid pulse and inspect medial retractor blade under headlight to ensure esophagus is not trapped.",
                "Vertebral Artery Injury: Stray lateral drilling beyond the uncinate process risks catastrophic bleeding from the V2 segment.",
                "Recurrent Laryngeal Nerve Palsy: Intermittently deflate endotracheal cuff after retractor placement to restore mucosal perfusion."
            ]
        case .plate016:
            return []
        case .plate017:
            return []
        case .plate018:
            return []
        case .plate019:
            return []
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
            return []
        case .plate024:
            return []
        case .plate025:
            return []
        case .plate026:
            return []
        case .plate027:
            return [
                "Tract Transection Neurological Deficit: Advancing tubular port across rather than parallel to white matter tracts permanently severs corticospinal motor fibers.",
                "Secondary Hematoma Cavity Re-Bleeding: Vigorous scraping of the cavity periphery pulls on friable lenticulostriate arterioles, causing acute recurrent hemorrhage."
            ]
        case .plate028:
            return []
        case .plate029:
            return []
        case .plate030:
            return []
case .plate031:
            return [
                "C8 Nerve Root Traction: Avoid excessive lateral retraction on exiting root during disc fragment retrieval or osteophyte resection.",
                "Vertebral Artery & Canal Breach: Direct lateral mass screws 20-30° lateral and superior; confirm T1 pedicle trajectory with intraoperative fluoroscopy.",
            ]
        case .plate032:
            return []
        case .plate033:
            return []
        case .plate034:
            return []
        case .plate035:
            return []
        case .plate036:
            return []
        case .plate037:
            return []
        case .plate038:
            return []
        case .plate039:
            return []
        case .plate040:
            return []
        case .plate041:
            return []
        case .plate042:
            return []
        case .plate043:
            return []
        case .plate044:
            return []
        case .plate045:
            return []
        case .plate046:
            return []
        case .plate047:
            return []
        case .plate048:
            return []
        case .plate049:
            return []

        case .plate050:
            return []

        case .plate051:
            return []

        case .plate090:
            return []


        case .plate091:
            return []
        case .plate092:
            return []
        case .plate093:
            return []
        case .plate094:
            return []
        case .plate095:
            return []
        case .plate096:
            return []
        case .plate097:
            return []
        case .plate098:
            return []
        case .plate099:
            return []
        case .plate100:
            return []
        case .plate101:
            return []
        case .plate102:
            return []
        case .plate103:
            return []
        case .plate104:
            return []
        case .plate105:
            return []
        case .plate106:
            return []
        case .plate089:
            return []

        case .plate088:
            return []

        case .plate087:
            return []

        case .plate086:
            return []

        case .plate085:
            return []

        case .plate084:
            return []

        case .plate083:
            return []

        case .plate082:
            return []

        case .plate081:
            return []

        case .plate080:
            return []

        case .plate079:
            return []

        case .plate078:
            return []

        case .plate077:
            return []

        case .plate076:
            return []

        case .plate075:
            return []

        case .plate074:
            return []

        case .plate073:
            return []

                                                                        case .plate072:
            return []

                                                                        case .plate071:
            return []

                                                                        case .plate070:
            return []

                                                                        case .plate069:
            return []

                                                                        case .plate068:
            return [
                "ANTERIOR SPINAL ARTERY (ASA) INFARCTION VIA ARTERY OF ADAMKIEWICZ COAGULATION: Coagulating intercostal arteries near the neural foramen in the lower thoracic spine (T9–L2) can sacrifice the Great Anterior Radiculomedullary Artery (Adamkiewicz). This triggers catastrophic anterior spinal cord infarction with permanent, irreversible paraplegia, loss of bowel/bladder control, and dissociated sensory loss. Always review preoperative angiography/CTA and interrogate radicular branches with micro-Doppler before sacrifice.",
                "INTRACTABLE CSF-PLEURAL FISTULA & TENSION PNEUMOCEPHALUS: Failure to achieve a watertight dural closure in the presence of an occult or overt pleural tear allows negative intrathoracic pleural pressure during respiration to continuously siphon CSF into the pleural space. This causes massive pleural effusion, intracranial hypotension, and life-threatening tension pneumocephalus. Always perform a multilayer repair (running suture, onlay collagen matrix, fibrin sealant) and air-tight tissue barrier.",
                "PARIETAL PLEURA LACERATION & TENSION PNEUMOTHORAX / HEMOTHORAX: Careless instrument manipulation during costotransversectomy or extraforaminal tumor mobilization can lacerate the parietal pleura. Unrecognized pleural tears cause intraoperative tension pneumothorax or massive hemothorax. Always perform a saline immersion test under positive-pressure lung recruitment (Valsalva); place a chest tube under direct vision if air leak is detected.",
                "KYPHOTIC DEFORMITY & SPINAL INSTABILITY WITHOUT RIGID INSTRUMENTATION: Unilateral or bilateral costotransversectomy with pediculectomy destabilizes the posterior and middle spinal columns. Resecting the rib head and costovertebral joint destroys the thoracic cage's natural splinting effect, leading to progressive kyphosis, hardware pullout, and delayed cord compression if rigid multi-level instrumented arthrodesis is omitted."
            ]

                                                                        case .plate067:
            return []

                                                                        case .plate066:
            return []

                                                                        case .plate065:
            return []

                                                                        case .plate064:
            return []

                                                                        case .plate063:
            return []

                                                                        case .plate062:
            return []

                                                                        case .plate061:
            return []

                                                                        case .plate060:
            return []
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
            return []
        case .plate055:
            return []
        case .plate054:
            return []
        case .plate053:
            return []
        case .plate052:
            return []
        }
    }
}
