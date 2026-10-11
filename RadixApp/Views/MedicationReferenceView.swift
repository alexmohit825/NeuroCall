import SwiftUI

// MARK: - Medication & Anticoagulant Reversal Vault
public struct MedicationReferenceView: View {
    @State private var selectedCategory = "reversal"
    
    let categories = [
        ("reversal", "Reversal Agents", "shield.fill", Color.red),
        ("osmotic", "Hyperosmolar", "drop.fill", Color.blue),
        ("aeds", "Anti-Epileptics", "bolt.fill", Color.orange),
        ("steroids", "Steroids & Pressors", "cross.fill", Color.purple)
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("OVERNIGHT DRUG & REVERSAL VAULT")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.red)
                    Text("Medication Reference")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    Text("Emergency anticoagulant reversals, hyperosmolar bolusing, and seizure prophylaxis.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Category Picker Chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.0) { cat in
                            Button(action: {
                                HapticManager.impact(style: .light)
                                selectedCategory = cat.0
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: cat.2)
                                    Text(cat.1)
                                        .font(.system(size: 12, weight: .bold))
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(selectedCategory == cat.0 ? cat.3 : Color.white)
                                .foregroundColor(selectedCategory == cat.0 ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedCategory == cat.0 ? cat.3 : Color.black.opacity(0.06), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.03), radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Category Detail Cards
                Group {
                    if selectedCategory == "reversal" {
                        ReversalAgentsList()
                    } else if selectedCategory == "osmotic" {
                        OsmotherapyList()
                    } else if selectedCategory == "aeds" {
                        AEDReferenceList()
                    } else {
                        SteroidsPressorsList()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 28)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}

// MARK: - Reversal Agents List
struct ReversalAgentsList: View {
    var body: some View {
        VStack(spacing: 14) {
            
            // Warfarin / Coumadin
            MedDrugCard(
                drug: "Warfarin (Coumadin)",
                mechanism: "Vitamin K antagonist (Factors II, VII, IX, X)",
                primaryReversal: "4-Factor PCC (Kcentra) 25–50 units/kg IV STAT + Vitamin K 10 mg IV in 50 mL NS over 30 min",
                secondaryReversal: "Fresh Frozen Plasma (FFP) 10–15 mL/kg IV (Only if 4F-PCC unavailable due to volume overload and delayed thaw).",
                targetGoal: "Repeat STAT INR 15–30 min post-infusion; target INR < 1.4 before skin incision."
            )
            
            // Apixaban / Rivaroxaban
            MedDrugCard(
                drug: "Apixaban (Eliquis) & Rivaroxaban (Xarelto)",
                mechanism: "Direct Factor Xa Inhibitors",
                primaryReversal: "Andexanet Alfa (Andexxa): Low dose (400 mg IV bolus @ 30 mg/min then 4 mg/min for 120 min) or High dose (800 mg IV bolus then 8 mg/min for 120 min if last dose < 8 hrs or rivaroxaban > 10 mg).",
                secondaryReversal: "If Andexxa unavailable: 4-Factor PCC (Kcentra) 50 units/kg IV STAT (Max 5,000 units).",
                targetGoal: "Check Anti-Xa activity assay. Do not wait for lab turnaround if patient is herniating."
            )
            
            // Dabigatran
            MedDrugCard(
                drug: "Dabigatran (Pradaxa)",
                mechanism: "Direct Thrombin (Factor IIa) Inhibitor",
                primaryReversal: "Idarucizumab (Praxbind) 5 grams IV STAT (Given as two consecutive 2.5 g / 50 mL bolus infusions).",
                secondaryReversal: "If unavailable: 4-Factor PCC 50 units/kg IV. Hemodialysis removes ~60% of drug over 2–3 hours.",
                targetGoal: "Complete immediate reversal of thrombin time (TT) and aPTT within minutes."
            )
            
            // Heparin / LMWH
            MedDrugCard(
                drug: "Unfractionated Heparin & LMWH (Lovenox)",
                mechanism: "Antithrombin III activators",
                primaryReversal: "Protamine Sulfate: 1 mg per 100 units of Heparin received in past 2–3 hours (Max single dose 50 mg). For Lovenox: 1 mg Protamine per 1 mg Enoxaparin given in last 8 hours.",
                secondaryReversal: "Administer slowly over 10 min to prevent severe hypotension, pulmonary vasoconstriction, and anaphylactoid shock.",
                targetGoal: "STAT aPTT normalization."
            )
            
            // Antiplatelets
            MedDrugCard(
                drug: "Aspirin & Clopidogrel (Plavix) / Ticagrelor",
                mechanism: "Irreversible COX-1 and P2Y12 platelet ADP receptor blockade",
                primaryReversal: "Platelet Transfusion: 1 apheresis unit or 1 pooled pack (6 units) immediately prior to OR. DDAVP (Desmopressin) 0.3 mcg/kg IV over 30 min (releases endogenous vWF and Factor VIII).",
                secondaryReversal: "PATCH trial caution: Platelet transfusion in spontaneous non-operative ICH without planned surgery may increase mortality; use specifically for planned emergency neurosurgical intervention.",
                targetGoal: "Verify Platelet Function Assay (VerifyNow / PFA-100) or TEG platelet mapping."
            )
        }
    }
}

// MARK: - Hyperosmolar Therapy List
struct OsmotherapyList: View {
    var body: some View {
        VStack(spacing: 14) {
            MedDrugCard(
                drug: "3% Hypertonic Saline (HTS)",
                mechanism: "Draws intracellular/interstitial water into intravascular space across intact blood-brain barrier",
                primaryReversal: "Bolus: 250 mL IV over 15–20 minutes via central line (or wide-bore peripheral line in emergency). Continuous infusion: 0.5–1.5 mL/kg/hr.",
                secondaryReversal: "23.4% Saline Bullet: 30 mL IV push over 10 min via central line for acute impending transtentorial herniation with blown pupil.",
                targetGoal: "Target Serum Sodium: 145–155 mEq/L. Serum Osmolality < 320 mOsm/kg. Check BMP q4–6h."
            )
            
            MedDrugCard(
                drug: "Mannitol 20%",
                mechanism: "Osmotic diuretic + plasma expansion lowering blood viscosity and inducing cerebral vasoconstriction",
                primaryReversal: "Bolus: 0.5 to 1.0 g/kg IV over 20–30 minutes through an in-line filter (inspect bottle for crystals).",
                secondaryReversal: "Contraindicated in severe hypotension (SBP < 90 mmHg), acute tubular necrosis, or pulmonary edema. Requires Foley catheter.",
                targetGoal: "Target Osmolar Gap < 20 mOsm/kg. Calculate: Measured Osm - (2×Na + Glucose/18 + BUN/2.8). Discontinue if osmolar gap > 20 to prevent acute renal failure."
            )
        }
    }
}

// MARK: - AED Reference List
struct AEDReferenceList: View {
    var body: some View {
        VStack(spacing: 14) {
            MedDrugCard(
                drug: "Levetiracetam (Keppra)",
                mechanism: "SV2A synaptic vesicle protein binder",
                primaryReversal: "Loading dose: 20–60 mg/kg IV (typically 2,000 to 4,000 mg IV over 15 min for status epilepticus). Maintenance: 500–1,500 mg IV/PO q12h.",
                secondaryReversal: "Renal Adjustment: CrCl 50–80: 500–1000 mg q12h; CrCl 30–50: 250–750 mg q12h; CrCl < 30: 250–500 mg q12h.",
                targetGoal: "First-line post-traumatic seizure prophylaxis (7-day duration recommended in severe TBI)."
            )
            
            MedDrugCard(
                drug: "Lacosamide (Vimpat)",
                mechanism: "Enhances slow inactivation of voltage-gated sodium channels",
                primaryReversal: "Loading dose: 200–400 mg IV over 15–30 min. Maintenance: 100–200 mg IV/PO q12h.",
                secondaryReversal: "Caution: PR interval prolongation. Obtain baseline ECG; monitor in patients with conduction blocks or heart failure.",
                targetGoal: "Excellent second-line add-on agent when levetiracetam causes severe agitation or psychosis."
            )
            
            MedDrugCard(
                drug: "Fosphenytoin (Cerebyx) / Phenytoin",
                mechanism: "Fast sodium channel blocker",
                primaryReversal: "Loading dose: 15–20 mg PE (phenytoin equivalents)/kg IV @ max rate 150 mg PE/min.",
                secondaryReversal: "Black box warning: Severe hypotension and arrhythmias with rapid infusion. Continuous telemetry mandatory during loading.",
                targetGoal: "Target Free Phenytoin level: 1.0–2.0 mcg/mL (Total 10–20 mcg/mL, adjust for hypoalbuminemia via Sheiner-Tozer formula)."
            )
        }
    }
}

// MARK: - Steroids & Pressors List
struct SteroidsPressorsList: View {
    var body: some View {
        VStack(spacing: 14) {
            MedDrugCard(
                drug: "Dexamethasone (Decadron)",
                mechanism: "High glucocorticoid activity reducing vasogenic edema around neoplasms",
                primaryReversal: "Initial Loading: 10 mg IV STAT, then 4 mg IV/PO q6h. Taper as soon as feasible.",
                secondaryReversal: "CRASH Trial Alert: Strictly CONTRAINDICATED in Traumatic Brain Injury (TBI) — proven to increase mortality! Also avoid in acute ischemic stroke.",
                targetGoal: "Provide H2-blocker or PPI for gastroprotection. Monitor for hyperglycemia and acute psychosis."
            )
            
            MedDrugCard(
                drug: "Nimodipine (Nimotop)",
                mechanism: "Dihydropyridine calcium channel blocker reducing delayed cerebral ischemia (DCI) in aSAH",
                primaryReversal: "Dosing: 60 mg PO / NG q4h for 21 days from ictus. If SBP drops < 100 mmHg, adjust to 30 mg q2h.",
                secondaryReversal: "Black box warning: NEVER administer parenterally/IV — fatal cardiovascular collapse and cardiac arrest!",
                targetGoal: "Neuroprotective against delayed microvascular spasm and cortical spreading depression."
            )
        }
    }
}

// MARK: - Drug Card Component
struct MedDrugCard: View {
    let drug: String
    let mechanism: String
    let primaryReversal: String
    let secondaryReversal: String
    let targetGoal: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(drug)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                Text(mechanism)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 6) {
                Text("PRIMARY ACTION / EMERGENCY DOSING:")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(.red)
                Text(primaryReversal)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(red: 0.15, green: 0.2, blue: 0.3))
                    .lineSpacing(2)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("SECONDARY / CONTRAINDICATION ALERT:")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(.orange)
                Text(secondaryReversal)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(red: 0.25, green: 0.3, blue: 0.4))
                    .lineSpacing(2)
            }
            
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "target")
                    .foregroundColor(.blue)
                    .font(.system(size: 12))
                    .padding(.top, 2)
                Text("Goal: \(targetGoal)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.blue)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue.opacity(0.06)))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.04), radius: 6)
    }
}
