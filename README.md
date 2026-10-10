# [Radix] Neural & Dermatomal Conflict Solver
## Spine Root vs. Peripheral Nerve & Plexopathy Diagnostic Engine

**Author & Copyright:** 2026 A. Alex Mohit  
**Platform:** Progressive Web App (PWA) / Responsive Desktop, iPad Pro, and Mobile  
**Tech Stack:** React 19, TypeScript, Tailwind CSS v4, Lucide Icons, Vite  

---

### 1. Vision & Core Value
Radix is a high-acuity diagnostic engine designed for neurosurgeons, spine specialists, and neurologists to decouple overlapping cervical and lumbosacral root dermatomes/myotomes from peripheral nerve entrapments and plexopathies.

### 2. Key Modules & Capabilities
1. **Dynamic Conflict Resolver:**
   - Evaluates multi-level motor power (0–5 MRC Scale), dermatomal vs. peripheral autonomous cutaneous loss, and monosynaptic deep tendon reflex changes.
   - Calculates Bayesian likelihood distributions for **Root Radiculopathy**, **Peripheral Nerve Entrapment**, and **Tandem Double-Crush Syndrome**.
2. **Decisive Anatomical Arbitrators:**
   - **Pronator Teres & Palmar Cutaneous Branch:** Sparing in Carpal Tunnel vs. impairment in C6/C7 radiculopathy.
   - **Latissimus Dorsi & Triceps:** Sparing in radial groove/PIN palsies vs. impairment in C7 radiculopathy.
   - **Abductor Pollicis Brevis (APB) & FPL:** Sparing in ulnar neuropathy vs. impairment in C8/T1 root or Thoracic Outlet Syndrome.
   - **Tibialis Posterior (Foot Inversion):** The gold standard arbitrator for foot drop. 100% normal in isolated Common Peroneal Neuropathy at the fibular head; weak in L5 radiculopathy or sciatic trunk compromise.
   - **Adductor Longus (Obturator):** Sparing in isolated Femoral Neuropathy vs. weakness in L3/L4 root lesions.
3. **Provocative Maneuver Switchboard:**
   - Live integration of Spurling's test, Phalen's/Tinel's at wrist, Elbow Flexion test at cubital tunnel, Straight Leg Raise (SLR), Femoral Nerve Stretch, and Fibular Neck Tinel.
4. **Tandem Double-Crush Matrix (Upton & McComas Principle):**
   - Outlines the pathophysiology of serial axoplasmic transport failure across proximal and distal entrapment sites.
5. **EMG & NCS Decision Tree:**
   - Pre-ganglionic vs. post-ganglionic SNAP paradox and paraspinal needle EMG protocols.
6. **EHR-Ready Consult Note Generator:**
   - Instant export and formatted documentation for Epic, Cerner, or clinical records.

---

### 3. Verification & Build
- Clean TypeScript compilation with `tsc -b && vite build`.
- Live HTTP 200 response verified on local preview port `4173`.
