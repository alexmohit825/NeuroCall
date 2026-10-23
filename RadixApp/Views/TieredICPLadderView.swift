import SwiftUI

// MARK: - BTF Tiered Intracranial Pressure (ICP) Escalation Ladder
// Synthesized from Brain Trauma Foundation (BTF) Guidelines (4th Edition),
// Seattle International Severe Traumatic Brain Injury Consensus Conference (SIBICC),
// and Neurocritical Care Society (NCS) Refractory ICP Protocols.
// Provides real-time CPP hemodynamics, tier-by-tier intervention stepladders,
// live hyperosmolar dosing (3% HTS vs 20% Mannitol), and barbiturate coma kinetics.

public enum BTFICPTier: Int, CaseIterable, Identifiable {
    case tier0 = 0
    case tier1 = 1
    case tier2 = 2
    case tier3 = 3
    
    public var id: Int { self.rawValue }
    
    public var title: String {
        switch self {
        case .tier0: return "Tier 0: Universal Baseline"
        case .tier1: return "Tier 1: Early ICP > 22"
        case .tier2: return "Tier 2: Sustained ICP > 22"
        case .tier3: return "Tier 3: Refractory Crisis"
        }
    }
    
    public var subtitle: String {
        switch self {
        case .tier0: return "Foundational Neuro-ICU Measures for all severe TBI"
        case .tier1: return "Sedation deepening, osmotherapy, CSF drainage"
        case .tier2: return "Paralytics, hyperosmolar targets, mild hyperventilation"
        case .tier3: return "Decompressive hemicraniectomy vs Pentobarbital coma"
        }
    }
    
    public var color: Color {
        switch self {
        case .tier0: return ObsidianTheme.neonGreen
        case .tier1: return ObsidianTheme.neonCyan
        case .tier2: return ObsidianTheme.neonAmber
        case .tier3: return ObsidianTheme.neonRed
        }
    }
}

public struct TieredICPLadderView: View {
    @State private var selectedTier: BTFICPTier = .tier1
    
    // Hemodynamics State
    @State private var mapInput: Double = 85.0
    @State private var icpInput: Double = 24.0
    @State private var patientWeightKg: Double = 70.0
    
    // Hyperosmolar Calculator State
    @State private var selectedAgent: String = "3% Hypertonic Saline"
    
    public init() {}
    
    // Computed CPP
    private var calculatedCPP: Double {
        mapInput - icpInput
    }
    
    private var isCPPCritical: Bool {
        calculatedCPP < 60.0
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Banner
                headerBanner
                
                // Real-time CPP & ICP Hemodynamic Cockpit
                hemodynamicCockpitCard
                
                // Tier Stepper Bar
                tierStepperSelectorBar
                
                // Active Tier Management Protocol Card
                activeTierDetailCard
                
                // Live Hyperosmolar Dosing Calculator (Embedded)
                liveOsmotherapyCalculatorCard
                
                // BTF Monitored Thresholds Reference
                btfMonitoringStandardsCard
                
                Spacer(minLength: 40)
            }
            .padding(.top, 10)
        }
        .background(ObsidianTheme.surfaceVoid)
    }
    
    // MARK: - Header Banner
    private var headerBanner: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Circle().fill(selectedTier.color).frame(width: 8, height: 8)
                Text("BRAIN TRAUMA FOUNDATION & SIBICC PROTOCOLS")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.8)
                    .foregroundColor(selectedTier.color)
            }
            Text("Refractory ICP Escalation Stepladder")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Evidence-based tiered management for intracranial hypertension (ICP > 22 mmHg).")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    // MARK: - Hemodynamic Cockpit (MAP, ICP, CPP)
    private var hemodynamicCockpitCard: some View {
        VStack(spacing: 12) {
            // Live Readout Row
            HStack(spacing: 12) {
                // MAP
                VStack(alignment: .leading, spacing: 2) {
                    Text("MEAN ARTERIAL PRESSURE")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(ObsidianTheme.textTertiary)
                    Text("\(Int(mapInput)) mmHg")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundColor(ObsidianTheme.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // ICP
                VStack(alignment: .leading, spacing: 2) {
                    Text("INTRACRANIAL PRESSURE")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(ObsidianTheme.textTertiary)
                    Text("\(Int(icpInput)) mmHg")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundColor(icpInput > 22 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // CPP (Result)
                VStack(alignment: .trailing, spacing: 2) {
                    Text("CEREBRAL PERFUSION")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(ObsidianTheme.textTertiary)
                    Text(String(format: "%.0f mmHg", calculatedCPP))
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .foregroundColor(isCPPCritical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            // CPP Status Banner
            HStack {
                Image(systemName: isCPPCritical ? "exclamationmark.triangle.fill" : "checkmark.seal.fill")
                    .foregroundColor(isCPPCritical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                Text(isCPPCritical ? "CRITICAL CEREBRAL ISCHEMIA: CPP < 60 mmHg! Elevate MAP or aggressively lower ICP." : (calculatedCPP > 70 ? "OPTIMAL PERFUSION: CPP > 70 mmHg (Monitor for ARDS / hyperemia)." : "TARGET THERAPEUTIC ZONE: CPP 60 – 70 mmHg."))
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(isCPPCritical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                Spacer()
            }
            .padding(8)
            .background((isCPPCritical ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen).opacity(0.12))
            .cornerRadius(8)
            
            // Sliders Row
            VStack(spacing: 8) {
                HStack {
                    Text("Adjust MAP:")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Slider(value: $mapInput, in: 50...140, step: 1)
                        .tint(ObsidianTheme.neonBlue)
                }
                HStack {
                    Text("Adjust ICP:")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Slider(value: $icpInput, in: 5...45, step: 1)
                        .tint(icpInput > 22 ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
            }
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - Tier Stepper Bar
    private var tierStepperSelectorBar: some View {
        HStack(spacing: 6) {
            ForEach(BTFICPTier.allCases) { tier in
                Button(action: {
                    HapticManager.impact(style: .light)
                    selectedTier = tier
                }) {
                    VStack(spacing: 3) {
                        Text("TIER \(tier.rawValue)")
                            .font(.system(size: 10, weight: .black))
                        Circle()
                            .fill(selectedTier == tier ? tier.color : Color.clear)
                            .frame(width: 5, height: 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(selectedTier == tier ? tier.color.opacity(0.2) : ObsidianTheme.surfaceElevated)
                    .foregroundColor(selectedTier == tier ? tier.color : ObsidianTheme.textTertiary)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(selectedTier == tier ? tier.color : ObsidianTheme.glassBorder, lineWidth: 1))
                }
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Active Tier Detail Card
    private var activeTierDetailCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(selectedTier.title.uppercased())
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(selectedTier.color)
                    Text(selectedTier.subtitle)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text(selectedTier == .tier3 ? "CRISIS RESCUE" : (selectedTier == .tier0 ? "BASELINE" : "ACTIVE ESCALATION"))
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(selectedTier.color)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(selectedTier.color.opacity(0.18))
                    .cornerRadius(4)
            }
            
            Divider().overlay(ObsidianTheme.glassBorder)
            
            // Step-by-Step Action Protocols
            VStack(alignment: .leading, spacing: 8) {
                ForEach(actionStepsForTier(selectedTier), id: \.self) { step in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 11))
                            .foregroundColor(selectedTier.color)
                            .padding(.top, 1)
                        Text(step)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                }
            }
            
            // Warnings & Pitfalls
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "exclamationmark.octagon.fill")
                    .foregroundColor(selectedTier.color)
                    .font(.system(size: 13))
                VStack(alignment: .leading, spacing: 2) {
                    Text("BTF CLINICAL SAFETY PEARL")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(selectedTier.color)
                    Text(pearlForTier(selectedTier))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
            }
            .padding(10)
            .background(selectedTier.color.opacity(0.08))
            .cornerRadius(10)
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(selectedTier.color.opacity(0.5), lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - Live Osmotherapy Calculator
    private var liveOsmotherapyCalculatorCard: some View {
        let weight = patientWeightKg
        let htsBolusMl = weight * 2.0 // 2 mL/kg
        let mannitolGrams = weight * 0.75 // 0.75 g/kg
        let mannitol20Ml = (mannitolGrams / 0.20) // 20% solution = 0.20 g/mL
        
        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("LIVE HYPEROSMOLAR DOSING CALCULATOR")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Text("Weight-adjusted osmotherapy bolus (3% HTS vs 20% Mannitol)")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text("\(Int(weight)) kg")
                    .font(.system(size: 12, weight: .heavy, design: .rounded))
                    .foregroundColor(ObsidianTheme.neonCyan)
            }
            
            Picker("Agent", selection: $selectedAgent) {
                Text("3% Hypertonic Saline (HTS)").tag("3% Hypertonic Saline")
                Text("20% Mannitol").tag("20% Mannitol")
            }
            .pickerStyle(.segmented)
            
            if selectedAgent == "3% Hypertonic Saline" {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("CALCULATED 3% HTS BOLUS")
                                .font(.system(size: 9, weight: .black))
                                .foregroundColor(ObsidianTheme.neonCyan)
                            Text(String(format: "%.0f mL IV Bolus", htsBolusMl))
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .foregroundColor(ObsidianTheme.neonCyan)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("RATE")
                                .font(.system(size: 9, weight: .black))
                                .foregroundColor(ObsidianTheme.textTertiary)
                            Text("Over 15-20 min")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(ObsidianTheme.textPrimary)
                        }
                    }
                    Text("• Standard bolus: 250 mL or 2.0 mL/kg IV over 20 min via central or dedicated peripheral line.")
                        .font(.system(size: 10))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Text("• Serum Target: Sodium 145 – 155 mEq/L (Max 160 mEq/L); Serum Osmolarity < 320 mOsm/kg.")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                .padding(10)
                .background(ObsidianTheme.neonCyan.opacity(0.08))
                .cornerRadius(10)
            } else {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("CALCULATED 20% MANNITOL")
                                .font(.system(size: 9, weight: .black))
                                .foregroundColor(ObsidianTheme.neonAmber)
                            Text(String(format: "%.0f g (%.0f mL)", mannitolGrams, mannitol20Ml))
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .foregroundColor(ObsidianTheme.neonAmber)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("INFUSION")
                                .font(.system(size: 9, weight: .black))
                                .foregroundColor(ObsidianTheme.textTertiary)
                            Text("Filter Needle x 20m")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(ObsidianTheme.textPrimary)
                        }
                    }
                    Text("• Standard bolus: 0.5 – 1.0 g/kg (20% solution = 0.20 g/mL) infused over 20 minutes.")
                        .font(.system(size: 10))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Text("• Absolute Contraindication: SBP < 90 mmHg (hypovolemic hypotension) or active renal failure.")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonRed)
                }
                .padding(10)
                .background(ObsidianTheme.neonAmber.opacity(0.08))
                .cornerRadius(10)
            }
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - Monitoring Standards Card
    private var btfMonitoringStandardsCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("BTF GUIDELINE SURGICAL & MONITORING THRESHOLDS")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(ObsidianTheme.neonGreen)
            
            VStack(alignment: .leading, spacing: 4) {
                bullet(label: "ICP Threshold:", val: "> 22 mmHg is associated with increased mortality (Level IIB recommendation).")
                bullet(label: "CPP Target:", val: "Maintain between 60 and 70 mmHg (Level IIB). Avoid CPP < 60 (ischemia) or > 70 (ARDS).")
                bullet(label: "EVD Drainage:", val: "Continuous vs intermittent drainage through ventriculostomy against 10-15 cmH2O column.")
                bullet(label: "Advanced PbtO2:", val: "Brain tissue oxygen tension target > 20 mmHg (monitor for microvascular hypoxia).")
            }
        }
        .padding(12)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    private func bullet(label: String, val: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text(label)
                .font(.system(size: 10, weight: .black))
                .foregroundColor(ObsidianTheme.neonGreen)
                .frame(width: 90, alignment: .leading)
            Text(val)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
    }
    
    // MARK: - Action Steps & Pearls
    private func actionStepsForTier(_ tier: BTFICPTier) -> [String] {
        switch tier {
        case .tier0:
            return [
                "Elevate Head of Bed (HOB) 30° with neutral neck alignment to maximize jugular venous return.",
                "Ensure endotracheal tube ties and cervical collars are not compressing internal jugular veins.",
                "Maintain strict normothermia (36.0°C – 37.0°C) with antipyretics and targeted temperature feedback.",
                "Maintain normocapnia: Target PaCO2 35 – 40 mmHg (avoid prophylactic hyperventilation).",
                "Sedation and analgesia titration (Propofol / Fentanyl) to abolish coughing and ventilator dyssynchrony.",
                "Maintain MAP ≥ 80 mmHg (arterial line zeroed at tragus) to support target CPP 60 – 70 mmHg.",
                "External Ventricular Drain (EVD) placement zeroed at Foramen of Monro for baseline CSF venting."
            ]
        case .tier1:
            return [
                "Deepen sedation: Titrate Propofol or Dexmedetomidine; short trial of neuromuscular blockade.",
                "Osmotherapy: Administer 3% Hypertonic Saline 250 mL bolus (or 2 mL/kg) over 20 minutes.",
                "Alternative Osmotherapy: 20% Mannitol 0.5 – 1.0 g/kg IV bolus over 20 minutes (if SBP > 90).",
                "EVD CSF Drainage: Open EVD to drain 5 – 10 mL CSF against 10 – 15 cmH2O pressure column.",
                "Repeat STAT non-contrast Head CT to rule out delayed epidural, subdural, or contusion expansion."
            ]
        case .tier2:
            return [
                "Neuromuscular Blockade: Continuous Cisatracurium infusion titrated to 1-2 twitches on Train-of-Four.",
                "Hyperosmolar Titration: Push serum sodium to 150 – 155 mEq/L using continuous 3% HTS infusion.",
                "23.4% Super-Saturated Saline Bullet: 30 mL IV push over 10 min via central line for refractory spike.",
                "Temporary Mild Hyperventilation: Target PaCO2 30 – 35 mmHg ONLY as a temporary acute bridge.",
                "Mild Therapeutic Hypothermia trial (35.0°C – 36.0°C) with automated surface cooling blanket."
            ]
        case .tier3:
            return [
                "Surgical Decompression: Emergent Unilateral Decompressive Hemicraniectomy (≥12 x 15 cm) with dural patch expansion OR Bifrontal Craniectomy.",
                "High-Dose Barbiturate Coma: Pentobarbital loading dose 10 mg/kg IV over 30 min, then 5 mg/kg/hr x 3h, then maintenance 1 – 2 mg/kg/hr.",
                "Continuous Bedside EEG: Titrate barbiturate infusion to burst suppression (1 – 5 bursts per minute / 85% suppression).",
                "Hemodynamic Vasopressor Support: Mandatory continuous Norepinephrine / Phenylephrine infusion to counteract barbiturate myocardial depression and keep CPP > 60 mmHg.",
                "Targeted Deep Hypothermia: 32°C – 34°C with slow rewarming rate (< 0.25°C/hr) to avoid rebound edema."
            ]
        }
    }
    
    private func pearlForTier(_ tier: BTFICPTier) -> String {
        switch tier {
        case .tier0:
            return "Every 1°C increase in core temperature increases cerebral metabolic demand (CMRO2) by ~10%, triggering reactive cerebral vasodilation and intracranial volume expansion."
        case .tier1:
            return "Do not administer Mannitol if SBP < 90 mmHg or patient is hypovolemic; osmotic diuresis will drop MAP and collapse CPP, precipitating secondary brainstem ischemia."
        case .tier2:
            return "Hyperventilation below PaCO2 30 mmHg causes severe cerebral vasoconstriction, cutting cerebral blood flow (CBF) and causing profound ischemic tissue hypoxia despite lower ICP numbers."
        case .tier3:
            return "Hemicraniectomy bone flaps MUST measure at least 12 x 15 cm. Small bone flaps cause mushroom herniation and venous strangulation against the rigid cut bone edges."
        }
    }
}
