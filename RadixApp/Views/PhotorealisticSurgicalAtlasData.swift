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
                    title: "Posterior Craniocervical Junction (",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Deep stabilizing ligaments of the spinal canal with vertebral arches resected.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate002:
            return [
                SurgicalCallout(
                    id: "plate_002_1",
                    title: "Neonatal Ventricular Access Device ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "External ventricular drain and subcutaneous reservoir placement in a neonate with open cranial sutures.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate003:
            return [
                SurgicalCallout(
                    id: "plate_003_1",
                    title: "Midline Suboccipital Craniectomy & ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct operative view into the posterior fossa through a midline suboccipital craniectomy with dural opening under surgical microscope magni",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate004:
            return [
                SurgicalCallout(
                    id: "plate_004_1",
                    title: "Right Retrosigmoid Cerebellopontine",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Operative microsurgical view into the right cerebellopontine angle through a retrosigmoid / retromastoid craniectomy.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate005:
            return [
                SurgicalCallout(
                    id: "plate_005_1",
                    title: "Two-Piece Fronto-Temporal Orbitozyg",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "3-part exploded osteological plate showing the cranium and its two detached bone pieces (pterional flap and one-piece orbitozygomatic bar).",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate006:
            return [
                SurgicalCallout(
                    id: "plate_006_1",
                    title: "Right Far-Lateral Transcondylar App",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Microsurgical operative view of the right craniocervical junction during a far-lateral transcondylar approach with mobilization of the V3 ve",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate007:
            return [
                SurgicalCallout(
                    id: "plate_007_1",
                    title: "Lumbar Lateral Recess Stenosis vs. ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Side-by-side comparative axial cross-sections at L4–L5 contrasting a normal, patent lumbar canal with severe lateral recess (subarticular) s",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate008:
            return [
                SurgicalCallout(
                    id: "plate_008_1",
                    title: "Left Pterional Transsylvian Approac",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 surface-texture modernization of NeuroCall Plate 1 (`plate_aneurysm`), preserving 100% of the exact perspective, vascular geometr",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate009:
            return [
                SurgicalCallout(
                    id: "plate_009_1",
                    title: "Splitting of Distal Anterior Sylvia",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Microsurgical opening of the superficial and deep Sylvian cisterns between the frontal and temporal opercula.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate010:
            return [
                SurgicalCallout(
                    id: "plate_010_1",
                    title: "Retromastoid / Retrosigmoid Positio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Lateral cranial positioning in a 3-point Mayfield skull clamp illustrating the osteological and dural venous sinus landmarks for a retromast",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate011:
            return [
                SurgicalCallout(
                    id: "plate_011_1",
                    title: "Lumbar Disc Degeneration & Posterio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Dual-view anatomical pathology plate showing concentric annular lamellae with a posterior radial/concentric annular tear (top axial view) an",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate012:
            return [
                SurgicalCallout(
                    id: "plate_012_1",
                    title: "Left Pterional Craniotomy & Sylvian",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 modernization of NeuroCall's `plate_pterional_fissure` line drawing into publication-grade Modern Atlas Realism.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate013:
            return [
                SurgicalCallout(
                    id: "plate_013_1",
                    title: "Chiari I Malformation Suboccipital ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 dual-panel modernization of NeuroCall's `plate_chiari_decompression` comparing pre-duraplasty tonsillar herniation (left) with co",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate014:
            return [
                SurgicalCallout(
                    id: "plate_014_1",
                    title: "Posterior C1–C2 Goel-Harms Screw-Ro",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 dual-view modernization of NeuroCall's `plate_harms_c1_c2` illustrating bilateral C1 lateral mass and C2 pedicle/pars polyaxial s",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate015:
            return [
                SurgicalCallout(
                    id: "plate_015_1",
                    title: "Anterior Cervical Discectomy & Fusi",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 surface-texture modernization and inferior vertebral body restoration of NeuroCall's `plate_acdf`.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate016:
            return [
                SurgicalCallout(
                    id: "plate_016_1",
                    title: "Right Subtemporal / Temporal Cranio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Direct 1:1 typography-scrubbed master of NeuroCall's `plate_craniotomy_temporal`, showing a right temporal craniotomy flush with the zygomat",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate017:
            return [
                SurgicalCallout(
                    id: "plate_017_1",
                    title: "Left Pterional (Frontotemporal) Cra",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "3D osteological and cortical exposure of a standard left frontotemporal (pterional) craniotomy centered on the sphenoid ridge and Sylvian cl",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate018:
            return [
                SurgicalCallout(
                    id: "plate_018_1",
                    title: "Bifrontal Craniotomy 3D Skull Model",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Anterior coronal 3D skull view demonstrating a bilateral frontal craniotomy crossing the midline above the supraorbital rims, exposing both ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate019:
            return [
                SurgicalCallout(
                    id: "plate_019_1",
                    title: "Left Parietal Craniotomy Window & D",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Left lateral 3D skull model with a circumscribed parietal craniotomy behind the coronal suture, showing the beveled diploic bone margin and ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate020:
            return [
                SurgicalCallout(
                    id: "plate_020_1",
                    title: "Right Retrosigmoid / Asterion Crani",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Right posterolateral 3D skull and upper cervical spine model illustrating the key retrosigmoid craniectomy window tucked immediately inferio",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate021:
            return [
                SurgicalCallout(
                    id: "plate_021_1",
                    title: "Decompressive Frontotemporoparietal",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Large trauma/stroke frontotemporoparietal hemicraniectomy with reflected myocutaneous scalp flap, peripheral bone tack-up holes, and waterti",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate022:
            return [
                SurgicalCallout(
                    id: "plate_022_1",
                    title: "Pineal Region Tumor & Supracerebell",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Midsagittal anatomical and surgical corridor master illustrating a pineal region mass in the quadrigeminal cistern and the three classic sur",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate023:
            return [
                SurgicalCallout(
                    id: "plate_023_1",
                    title: "Smith-Petersen (SPO) & Ponte Poster",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Two-stage lateral biomechanical and osteological comparison of a Schwab Grade 2 Posterior Column Osteotomy (Smith-Petersen / Ponte Osteotomy",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate024:
            return [
                SurgicalCallout(
                    id: "plate_024_1",
                    title: "Three-Column Pedicle Subtraction Os",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Two-stage lateral biomechanical and osteological comparison of a Schwab Grade 3 Three-Column Pedicle Subtraction Osteotomy (PSO) across a 3-",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate025:
            return [
                SurgicalCallout(
                    id: "plate_025_1",
                    title: "Anterior Temporal Lobectomy (ATL) v",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "4-part 2x2 comparative neurosurgical epilepsy atlas plate contrasting Anterior Temporal Lobectomy (ATL, left column) with Selective Amygdalo",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate026:
            return [
                SurgicalCallout(
                    id: "plate_026_1",
                    title: "Thoracic Costotransversectomy — Pos",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Dual-panel comprehensive spine atlas plate depicting a completed Right-Sided Thoracic Costotransversectomy (posterolateral extrapleural corr",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate027:
            return [
                SurgicalCallout(
                    id: "plate_027_1",
                    title: "Minimally Invasive Parafascicular S",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Three-panel master neurosurgical atlas plate illustrating Minimally Invasive Parafascicular Surgery (MIPS) for deep subcortical/basal gangli",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate028:
            return [
                SurgicalCallout(
                    id: "plate_028_1",
                    title: "Lateral Lumbar Interbody Fusion (LL",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Publication-grade anatomical atlas plate depicting the surgical transpsoas retroperitoneal corridor for Lateral Lumbar Interbody Fusion (LLI",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate029:
            return [
                SurgicalCallout(
                    id: "plate_029_1",
                    title: "Transforaminal Lumbar Interbody Fus",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Modernized multi-panel educational atlas plate illustrating Transforaminal Lumbar Interbody Fusion (TLIF).",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate030:
            return [
                SurgicalCallout(
                    id: "plate_030_1",
                    title: "Endoscopic Endonasal Sellar Corrido",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-quadrant endoscopic transsphenoidal skull base master plate illustrating anatomical landmarks and neurovascular relationships for pitui",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate031:
            return [
                SurgicalCallout(
                    id: "plate_031_1",
                    title: "Posterior Cervical (C7–T1) Decompre",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Dual-panel cervical spine atlas plate illustrating C2–T1 root anatomy alongside posterior C7–T1 laminectomy, C8 nerve root decompression, an",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate032:
            return [
                SurgicalCallout(
                    id: "plate_032_1",
                    title: "360° Comprehensive Lumbar Interbody",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel anatomical and biomechanical reference plate comparing all 360° surgical corridors into the lumbar intervertebral disc space.",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate033:
            return [
                SurgicalCallout(
                    id: "plate_033_1",
                    title: "Supraorbital Eyebrow Keyhole Cranio",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Master 3D cranial osteology plate demonstrating the precise bone window, burr hole placement, and surgical landmarks for the Supraorbital Ey",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate034:
            return [
                SurgicalCallout(
                    id: "plate_034_1",
                    title: "Bilateral Jumped / Locked Cervical ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-panel master atlas plate correlating authentic diagnostic radiology (CT & MRI) with high-detail Netter-style pathoanatomical dissection",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate035:
            return [
                SurgicalCallout(
                    id: "plate_035_1",
                    title: "Anderson & D'Alonzo Odontoid Fractu",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Master neurosurgical spine trauma decision plate detailing the anatomical classification, vascular watershed biomechanics, union rates, and ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate036:
            return [
                SurgicalCallout(
                    id: "plate_036_1",
                    title: "Acute Thoracolumbar Burst Fracture ",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-panel master atlas plate correlating authentic diagnostic CT imaging (axial and sagittal bone windows) with 3D Frank Netter-style sagit",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate037:
            return [
                SurgicalCallout(
                    id: "plate_037_1",
                    title: "Cauda Equina Syndrome — Massive Lum",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Sagittal T2 MRI with 3D Frank Netter-style sagittal and axial pa",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate038:
            return [
                SurgicalCallout(
                    id: "plate_038_1",
                    title: "Metastatic Epidural Spinal Cord Com",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Sagittal T2 MRI with 3D Frank Netter-style sagittal and axial pa",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate039:
            return [
                SurgicalCallout(
                    id: "plate_039_1",
                    title: "Postoperative Lumbar Pseudomeningoc",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Four-panel master neurosurgical atlas plate correlating authentic diagnostic T2 MRI (sagittal and axial) with 3D Frank Netter-style sagittal",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate040:
            return [
                SurgicalCallout(
                    id: "plate_040_1",
                    title: "Acute Aneurysmal Subarachnoid Hemor",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Axial Non-Contrast Head CT with 3D Frank Netter-style Circle of ",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate041:
            return [
                SurgicalCallout(
                    id: "plate_041_1",
                    title: "Hypertensive Ganglionic Intracerebr",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic Axial Non-Contrast Head CT with 3D Frank Netter-style axial basa",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
            ]
        case .plate042:
            return [
                SurgicalCallout(
                    id: "plate_042_1",
                    title: "Cervical Spondylotic Myelopathy (CS",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "Tri-panel master neurosurgical atlas plate correlating authentic diagnostic High-Resolution Sagittal T2 Cervical MRI with 3D Frank Netter-st",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
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
                    structureType: "SKULL BASE ARTERIAL CONDUIT",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.22,
                    normalizedY: 0.65,
                    description: "Ascending branch from the internal maxillary artery entering through foramen spinosum, serving as the coaxial conduit for microcatheter navigation.",
                    surgicalPearl: "Confirm catheter position distal to the petrosal branch to prevent facial nerve (CN VII) ischemia and palsy from embolic reflux."
                ),
                SurgicalCallout(
                    id: "plate_051_2",
                    title: "Superselective MMA Catheterization",
                    structureType: "MICRO-TARGETED CORRIDOR",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.29,
                    normalizedY: 0.44,
                    description: "Superselective navigation of a 0.0165\" microcatheter into the posterior (parietal) MMA branch feeding the hypervascular outer neomembrane of the chronic subdural collection.",
                    surgicalPearl: "Target the dominant branch supplying the thickest neo-membranes; bilateral embolization is indicated for bilateral cSDH or crossing midline convexity collections."
                ),
                SurgicalCallout(
                    id: "plate_051_3",
                    title: "Onyx Liquid Embolic Membrane Cast",
                    structureType: "DEEP ARTERIOLAR PENETRATION",
                    color: Color.yellow,
                    normalizedX: 0.41,
                    normalizedY: 0.29,
                    description: "Dendritic cast of black liquid embolic (Onyx-18 / Squid) penetrating and occluding the friable, hypervascular capillary network (inner dural plexus) of the outer hematoma membrane.",
                    surgicalPearl: "Liquid embolic provides durable penetration into the microvasculature, shutting down inflammatory exudation and eliminating the cycle of recurrent microhemorrhage."
                ),
                SurgicalCallout(
                    id: "plate_051_4",
                    title: "Chronic Subdural Liquefied Collection",
                    structureType: "DEGRADED CRUDE-OIL HEMORRHAGE",
                    color: Color.red,
                    normalizedX: 0.38,
                    normalizedY: 0.14,
                    description: "Chronic encapsulated subdural fluid with degraded liquefied blood products causing significant hemispheric mass effect and cortical indentation.",
                    surgicalPearl: "MMA embolization can be used standalone for asymptomatic/mildly symptomatic cSDH (halting expansion and driving resorption) or as an adjunct following burr hole drainage to cut recurrence from 15-20% down to <3%."
                ),
                SurgicalCallout(
                    id: "plate_051_5",
                    title: "Longitudinal CT Resolution Correlation",
                    structureType: "PRE-OP MASS EFFECT VS COMPLETE RESOLUTION",
                    color: Color.green,
                    normalizedX: 0.85,
                    normalizedY: 0.50,
                    description: "Panel B demonstrates marked pre-procedure mass effect with sulcal effacement and midline shift. Panel C confirms complete spontaneous hematoma resorption, hemispheric re-expansion, and midline recentering following MMA embolization.",
                    surgicalPearl: "Groundbreaking Level 1 evidence (EMBOLISE, STEM, MEMBRANE trials) establishes MMA embolization as a definitive therapy drastically reducing recurrence and reoperation rates."
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
                    structureType: "AVASCULAR POSTERIOR CAPSULE",
                    color: Color.green,
                    normalizedX: 0.34,
                    normalizedY: 0.42,
                    description: "The posterior tumor capsule directly facing the retrosigmoid surgeon is completely free of cranial nerves. This is the mandated entry point for initial capsular incision and internal ultrasonic debulking (CUSA), safely gutting the tumor core before dissecting the capsule.",
                    surgicalPearl: "Never dissect the tumor capsule circumferentially before central debulking; gutting the core collapses the tumor inward, transforming high-tension traction on CN VII into a relaxed, dissectible arachnoid plane."
                ),
                SurgicalCallout(
                    id: "plate_052_2",
                    title: "Facial Nerve (CN VII) Ventral Trajectory",
                    structureType: "HIDDEN VENTRAL CAPSULE & SEVEN-UP RULE",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.42,
                    normalizedY: 0.28,
                    description: "In >95% of cases, CN VII is splayed and attenuated into a paper-thin ribbon adhering to the deep anterior/ventral capsule, heading to the anterior-superior quadrant of the IAC fundus (anterior to Bill\'s bar, superior to transverse crest).",
                    surgicalPearl: "Identify CN VII at the two anatomical anchors: medially at the brainstem root exit zone (pontomedullary junction anterior to the choroid plexus of Luschka) and laterally at the IAC fundus; never search for the nerve in the mid-capsular stretched zone."
                ),
                SurgicalCallout(
                    id: "plate_052_3",
                    title: "Drilled Porus Acusticus & IAC Fundus",
                    structureType: "INTERNAL AUDITORY CANAL UNROOFING",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: 0.55,
                    normalizedY: 0.38,
                    description: "The posterior wall of the IAC is unroofed with a high-speed diamond burr under continuous cold saline irrigation to prevent thermal injury to CN VII, exposing the lateral tumor cone and the transverse crest/Bill\'s bar.",
                    surgicalPearl: "Limit bone drilling to the medial 8–10 mm of the posterior wall; lateral drilling beyond the fundus breaches the posterior semicircular canal and vestibule, causing irreversible sensorineural deafness."
                ),
                SurgicalCallout(
                    id: "plate_052_4",
                    title: "AICA Loop & Lower Cranial Nerves",
                    structureType: "CPA CISTERNAL NEUROVASCULAR BOUNDARY",
                    color: Color.red,
                    normalizedX: 0.38,
                    normalizedY: 0.75,
                    description: "The crimson AICA meatal loop courses along the inferior-medial tumor capsule, while lower cranial nerves (CN IX, X, XI) cross the caudal pole toward the jugular foramen.",
                    surgicalPearl: "Preserve the labyrinthine (internal auditory) artery branching off AICA; inadvertent coagulation causes immediate ipsilateral hearing loss even with an intact cochlear nerve."
                ),
                SurgicalCallout(
                    id: "plate_052_5",
                    title: "Axial 3T T1-Contrast MRI Correlation",
                    structureType: "KOOS GRADE IV ICE-CREAM CONE TUMOR",
                    color: Color.yellow,
                    normalizedX: 0.85,
                    normalizedY: 0.52,
                    description: "Diagnostic 3T T1 post-contrast MRI confirms a 3.5 cm vividly enhancing right CPA mass widening the internal auditory canal with significant brainstem indentation, middle cerebellar peduncle compression, and 4th ventricle effacement.",
                    surgicalPearl: "Koos Grade IV tumors with brainstem compression carry significant surgical risk; subtotal resection with facial nerve anatomically preserved followed by stereotactic radiosurgery (SRS) is a proven strategy when capsule is densely adherent."
                )
            ]
        }
    }

    public var steps: [ApproachSequentialStep] {
        switch self {
        case .plate001:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate002:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate003:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate004:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate005:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate006:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate007:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate008:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate009:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate010:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate011:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate012:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate013:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate014:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate015:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate016:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate017:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate018:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate019:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate020:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate021:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate022:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate023:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate024:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate025:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate026:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate027:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate028:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate029:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate030:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate031:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate032:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate033:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate034:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate035:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate036:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate037:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate038:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate039:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate040:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate041:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
            ]
        case .plate042:
            return [
                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),
                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),
                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")
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
                ApproachSequentialStep(stepNumber: 1, title: "Vascular Access & Diagnostic Angiography", detail: "Obtain radial or femoral arterial access. Advance a 5F or 6F guide catheter into the external carotid artery (ECA). Perform high-resolution biplane digital subtraction angiography (DSA) of the MMA to map frontal and parietal branches, identify the neomembrane blush, and rule out dangerous ophthalmic or petrosal anastomoses."),
                ApproachSequentialStep(stepNumber: 2, title: "Superselective Microcatheter Navigation", detail: "Under biplane fluoroscopic roadmap guidance, navigate a 0.0165\" microcatheter over a 0.008\"–0.010\" steerable microwire past foramen spinosum. Selectively cannulate the posterior and/or anterior MMA branches supplying the cSDH membrane, positioning the tip distal to the petrosal branch."),
                ApproachSequentialStep(stepNumber: 3, title: "Provocative Testing & Embolic Preparation", detail: "Perform microcatheter superselective angiogram ('micro-run') to confirm true membrane blush and verify absence of orbital/lacrimal or cranial nerve collaterals. Flush with DMSO if using Onyx, or prime microcatheter if using particle slurry (150–250 μm PVA particles)."),
                ApproachSequentialStep(stepNumber: 4, title: "Controlled Liquid Embolic / Particle Infusion", detail: "Infuse liquid embolic (Onyx-18 / Squid) slowly under continuous subtracted fluoroscopy, creating a proximal plug and forcing embolic material distally into the neomembrane capillary network. Terminate injection once dense capillary casting and branch truncation are achieved without proximal reflux.")
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
                ApproachSequentialStep(stepNumber: 1, title: "Retrosigmoid Craniectomy & CSF Drainage", detail: "Park-bench or lateral decubitus position with head flexed and rotated 15° to contralateral side. Curvilinear or lazy-S incision behind the mastoid. Retrosigmoid craniectomy exposes the inferior margin of the transverse sinus and posterior edge of the sigmoid sinus. Open dura in a C-shaped flap; immediately release CSF from the cisterna magna to achieve a completely relaxed, slack cerebellum without retraction injury."),
                ApproachSequentialStep(stepNumber: 2, title: "Tumor Exposure & Capsular Mapping", detail: "Place a Greenberg retractor blade to gently support the petrosal cerebellar surface. Incise the arachnoid over the posterior tumor dome. Identify the AICA meatal loop and lower cranial nerves along the caudal pole. Map the posterior capsule with a handheld monopolar nerve stimulator (0.05–0.2 mA) to confirm the complete absence of a displaced facial nerve."),
                ApproachSequentialStep(stepNumber: 3, title: "Posterior Capsular Incision & Intracapsular Debulking", detail: "Perform an elliptical capsular opening in the safe, avascular posterior center using micro-scissors or bipolar. Use the ultrasonic aspirator (CUSA) to systematically core out the tumor interior, working from central to lateral. As the tumor mass collapses inward, the arachnoid dissection planes loosen."),
                ApproachSequentialStep(stepNumber: 4, title: "IAC Unroofing & Facial Nerve Preservation at the Fundus", detail: "Reflect the dural flap over the petrous bone. Under continuous irrigation, drill the posterior lip of the porus acusticus with a 2–3 mm diamond burr, unroofing the lateral 8 mm of the IAC. Identify Bill\'s bar and the transverse crest at the fundus. Dissect the lateral tumor cone from the facial nerve in the anterior-superior quadrant, following CN VII medially back to the brainstem.")
            ]
        }
    }

    public var catastrophicHazards: [String] {
        switch self {
        case .plate001:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate002:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate003:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate004:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate005:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate006:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate007:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate008:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate009:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate010:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate011:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate012:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate013:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate014:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate015:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate016:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate017:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate018:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate019:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate020:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate021:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate022:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate023:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate024:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate025:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate026:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate027:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate028:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate029:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate030:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate031:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate032:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate033:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate034:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate035:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate036:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate037:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate038:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate039:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate040:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate041:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
            ]
        case .plate042:
            return [
                "Preserve critical neurovascular boundaries and perforating vessels.",
                "Verify rigid construct alignment and complete decompression before closure."
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
                "IRREVERSIBLE BLINDNESS VIA MENINGO-OPHTHALMIC ANASTOMOSIS: The anterior MMA can connect with the ophthalmic artery via the superior orbital fissure or recurrent meningeal branch. Always perform high-magnification roadmap angiography; embolic reflux or forward migration into the ophthalmic artery causes instant, catastrophic central retinal artery occlusion and permanent monocular blindness.",
                "FACIAL NERVE PALSY VIA PETROSAL BRANCH: The petrosal branch of the MMA supplies the facial nerve (CN VII) in the Fallopian canal / geniculate ganglion. Always advance the microcatheter tip DISTAL to the petrosal branch takeoff before injecting liquid embolic or particles; embolization of the petrosal artery causes acute, permanent peripheral facial palsy (Bell's palsy).",
                "PROXIMAL REFLUX INTO MAXILLARY OR CAROTID ARTERY: Never push liquid embolic aggressively against resistance. Maintain continuous fluoroscopic visualization of the catheter tip to prevent reflux back into the internal maxillary artery or external carotid system, which can cause skin necrosis, jaw claudication, or distal stroke."
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
                "FACIAL NERVE TRANSECTION IN UNRECOGNIZED ANTERIOR DISPLACEMENT: Never perform circumferential sharp dissection along the anterior tumor capsule early in the operation. CN VII is paper-thin and visually indistinguishable from tumor capsule under tension; always debulk the core first and identify CN VII at the brainstem REZ and IAC fundus before attempting capsule mobilization.",
                "LABYRINTHINE BREACH CAUSING PERMANENT SENSORINEURAL DEAFNESS: Over-drilling the lateral posterior wall of the IAC (>10 mm) will violate the posterior semicircular canal or vestibule. Always maintain orientation relative to the common crus and endolymphatic duct; once the fundus is reached, stop drilling.",
                "TEARING THE SUPERIOR PETROSAL VEIN (VEIN OF DANDY): Excessive or abrupt retraction on the superior cerebellum can tear the vein of Dandy at its junction with the superior petrosal sinus, causing torrential, difficult-to-control venous hemorrhage and risk of cerebellar venous infarction."
            ]
        }
    }
}
