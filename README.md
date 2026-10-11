# NeuroCall — Neurosurgery On-Call Navigator & Procedures
## High-Acuity Decision Engine, Cannot-Miss Emergencies, Procedural Atlas & 60-Second Neuroimaging

**Author & Copyright:** 2026 A. Alex Mohit  
**Platform:** Native iOS & iPadOS (100% Pure SwiftUI) + Universal PWA  
**Target Bundle ID:** `com.AlexMohit.NeuroCall`  

---

### 1. Vision & Core Value
NeuroCall is the tactical on-call co-pilot for neurosurgery and neurology residents, spine fellows, and neuro-intensivists. It synthesizes acute surgical decision algorithms, procedural technical guidance, systematic CT/MRI reading checklists, and neuro-anatomical conflict solving into a light, high-contrast, visual clinical interface.

### 2. The 5 Core Clinical Pillars
1. **2 AM Crisis Triage (`EmergencyProtocolsView.swift`):**
   * Real-time triage calculators for Epidural (EDH), Subdural (SDH), and Uncal Herniation.
   * Dynamic surgical indication thresholds: Clot thickness $>10\text{ mm}$, Midline shift $>5\text{ mm}$, GCS drop.
   * Emergency hyperosmolar therapy dosing (Mannitol 20%, 3% Saline, 23.4% Super-Saturated Saline push).
   * **The 3 AM Attending Call Briefing (SBAR Generator):** Instant spoken script synthesis to brief the on-call attending over the phone in 30 seconds.
2. **Neurosurgical Emergencies — "Cannot Miss" (`NeurosurgicalEmergenciesView.swift`):**
   * Cauda Equina Syndrome (PVR $>200\text{ mL}$ threshold).
   * Spinal Epidural Abscess (Severe back pain + fever + progressive weakness).
   * Aneurysmal Subarachnoid Hemorrhage (Thunderclap headache, Nimodipine, BP targets).
   * Pituitary Apoplexy (STAT stress-dose hydrocortisone before MRI).
   * Acute Cerebellar Stroke / Posterior Fossa Mass (4th ventricle effacement risk).
3. **Procedural Atlas & Hardware (`NeurosurgicalProceduresView.swift`):**
   * **External Ventricular Drain (EVD) at Kocher's Point:** The 3 Golden Trajectory Rules (Medial canthus, Tragus/EAM, depth $\le 5.5\text{--}6.0\text{ cm}$), zeroing, and troubleshooting.
   * **Lumbar Subarachnoid Drain:** L3-L4/L4-L5, Tuohy cephalad bevel technique, 8–10 cm catheter advancement, strict 5–10 mL/hr drainage limits.
   * **Camino / Intraparenchymal Bolt:** Hand drill stop at 1.0 cm, sharp dural piercing, 1.5–2.0 cm parenchymal depth.
   * **ICP Waveforms:** Compliance analysis ($P1 > P2 > P3$ vs. decompensated $P2 > P1$) and Lundberg A plateau waves.
4. **Systematic 60-Second Scan Navigator (`ScanNavigatorView.swift`):**
   * Head CT: *"Blood Can Be Very Bad"* (Blood, Cisterns, Brain, Ventricles, Bone).
   * Spine MRI: Alignment, Bone & Disc, Cord T2 signal, Dura & Canal calipers ($<10\text{ mm}$ central stenosis, $<3\text{ mm}$ lateral recess).
   * Standard Hounsfield Unit (HU) window presets (Brain, Subdural, Bone, Stroke).
5. **Neuro-Anatomical Conflict Solver (`ConflictSolverView.swift`):**
   * Decouples overlapping root radiculopathies from peripheral entrapments (Foot Drop: L5 vs Common Peroneal via Tibialis Posterior; Hand: C6 vs CTS via Pronator Teres & Palmar Cutaneous Branch).

---

### 3. Native App Store & TestFlight Pipeline
* Fully configured XcodeGen project: `project.yml` targeting `iphoneos` SDK.
* Automated CI/CD delivery: `.github/workflows/testflight.yml` running on macOS 15.
