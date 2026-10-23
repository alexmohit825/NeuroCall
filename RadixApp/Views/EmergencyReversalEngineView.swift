import SwiftUI

// MARK: - Emergency Anticoagulant & Antiplatelet Rapid Reversal Cockpit
// Synthesized from Neurocritical Care Society (NCS) & Society of Critical Care Medicine (SCCM) Guidelines,
// Brain Trauma Foundation (BTF), and Chest Antithrombotic Guidelines.
// Provides live weight- and INR-based dosing, vial calculators, infusion kinetics, and backup options.

public enum ReversalDrugCategory: String, CaseIterable, Identifiable {
    case warfarin = "Warfarin (Coumadin)"
    case factorXa = "DOACs (Eliquis / Xarelto)"
    case dabigatran = "Dabigatran (Pradaxa)"
    case antiplatelet = "Antiplatelets (Plavix / ASA)"
    case heparin = "Heparin & LMWH"
    
    public var id: String { self.rawValue }
    
    public var icon: String {
        switch self {
        case .warfarin: return "drop.triangle.fill"
        case .factorXa: return "cross.vial.fill"
        case .dabigatran: return "shield.lefthalf.filled"
        case .antiplatelet: return "circle.hexagongrid.fill"
        case .heparin: return "syringe.fill"
        }
    }
}

public struct EmergencyReversalEngineView: View {
    @State private var selectedCategory: ReversalDrugCategory = .warfarin
    @State private var patientWeightKg: Double = 70.0
    
    // Warfarin State
    @State private var patientINR: Double = 3.5
    
    // Factor Xa State
    @State private var selectedXaDrug: String = "Apixaban (Eliquis)"
    @State private var xaDoseStrength: String = "Standard / High (>5mg)"
    @State private var hoursSinceLastXaDose: Double = 3.0
    
    // Heparin State
    @State private var heparinType: String = "Enoxaparin (LMWH)"
    @State private var heparinUnitsGiven: Double = 5000.0
    @State private var enoxaparinMgGiven: Double = 80.0
    @State private var hoursSinceHeparin: Double = 4.0
    
    // Antiplatelet State
    @State private var selectedAntiplatelet: String = "Clopidogrel (Plavix)"
    
    public init() {}
    
    // MARK: - Computed Properties
    private var patientWeightLbs: Double {
        patientWeightKg * 2.20462
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Banner
                headerBanner
                
                // Patient Weight Bar (Global Parameter)
                patientWeightCard
                
                // Category Pills Carousel
                categoryPillsCarousel
                
                // Active Protocol Calculator View
                Group {
                    switch selectedCategory {
                    case .warfarin:
                        warfarinReversalCard
                    case .factorXa:
                        factorXaReversalCard
                    case .dabigatran:
                        dabigatranReversalCard
                    case .antiplatelet:
                        antiplateletReversalCard
                    case .heparin:
                        heparinReversalCard
                    }
                }
                
                // General Reversal Safety Checklist
                reversalSafetyChecklistCard
                
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
                Circle().fill(ObsidianTheme.neonAmber).frame(width: 8, height: 8)
                Text("EMERGENCY HEMORRHAGIC CRITICAL CARE")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.8)
                    .foregroundColor(ObsidianTheme.neonAmber)
            }
            Text("Rapid Anticoagulation Reversal Cockpit")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Weight-adjusted 4F-PCC, Andexxa, Praxbind, Protamine, and DDAVP rapid bedside calculation.")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    // MARK: - Patient Weight Parameter Card
    private var patientWeightCard: some View {
        VStack(spacing: 8) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "scalemass.fill")
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Text("PATIENT WEIGHT")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                Spacer()
                Text(String(format: "%.0f kg (%.0f lbs)", patientWeightKg, patientWeightLbs))
                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                    .foregroundColor(ObsidianTheme.textPrimary)
            }
            
            Slider(value: $patientWeightKg, in: 40...150, step: 1)
                .tint(ObsidianTheme.neonCyan)
        }
        .padding(12)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - Category Carousel
    private var categoryPillsCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ReversalDrugCategory.allCases) { cat in
                    Button(action: {
                        HapticManager.impact(style: .light)
                        selectedCategory = cat
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: cat.icon)
                            Text(cat.rawValue)
                                .font(.system(size: 11, weight: .bold))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(selectedCategory == cat ? ObsidianTheme.neonAmber : ObsidianTheme.surfaceElevated)
                        .foregroundColor(selectedCategory == cat ? .black : ObsidianTheme.textSecondary)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedCategory == cat ? ObsidianTheme.neonAmber : ObsidianTheme.glassBorder, lineWidth: 1))
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - 1. Warfarin / VKA Reversal Card
    private var warfarinReversalCard: some View {
        let inr = patientINR
        let (unitsPerKg, maxUnits): (Double, Double) = {
            if inr < 2.0 {
                return (20.0, 2000.0)
            } else if inr <= 3.9 {
                return (25.0, 2500.0)
            } else if inr <= 6.0 {
                return (35.0, 3500.0)
            } else {
                return (50.0, 5000.0)
            }
        }()
        
        let rawDose = patientWeightKg * unitsPerKg
        let finalPCCDose = min(rawDose, maxUnits)
        let vials500 = Int(ceil(finalPCCDose / 500.0))
        let maxInfusionRate = min(patientWeightKg * 3.0, 210.0) // 3 units/kg/min, max 210 units/min
        let estimatedMinutes = finalPCCDose / maxInfusionRate
        
        return VStack(alignment: .leading, spacing: 14) {
            // Card Title
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("WARFARIN (COUMADIN) ACUTE REVERSAL")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(ObsidianTheme.neonAmber)
                    Text("4-Factor Prothrombin Complex Concentrate (Kcentra) + Vitamin K1")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text("FIRST-LINE NCS")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(ObsidianTheme.neonAmber)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(ObsidianTheme.neonAmber.opacity(0.18))
                    .cornerRadius(4)
            }
            
            // INR Slider
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Current Patient INR:")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(ObsidianTheme.textPrimary)
                    Spacer()
                    Text(String(format: "INR %.1f", patientINR))
                        .font(.system(size: 16, weight: .black, design: .rounded))
                        .foregroundColor(patientINR >= 4.0 ? ObsidianTheme.neonRed : ObsidianTheme.neonAmber)
                }
                Slider(value: $patientINR, in: 1.5...10.0, step: 0.1)
                    .tint(patientINR >= 4.0 ? ObsidianTheme.neonRed : ObsidianTheme.neonAmber)
            }
            
            Divider().overlay(ObsidianTheme.glassBorder)
            
            // Dosing Results Grid
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("CALCULATED KCENTRA DOSE")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(ObsidianTheme.neonCyan)
                        Text("\(Int(finalPCCDose)) Factor IX Units")
                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                            .foregroundColor(ObsidianTheme.neonCyan)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("REGIMEN RATE")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(ObsidianTheme.textTertiary)
                        Text("\(Int(unitsPerKg)) U/kg (Max \(Int(maxUnits)))")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                }
                
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Vials Required:")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(ObsidianTheme.textSecondary)
                        Text("~ \(vials500) x 500U vials")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(ObsidianTheme.surfaceElevated)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Infusion Rate:")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(ObsidianTheme.textSecondary)
                        Text(String(format: "%.0f U/min (~%.0f min)", maxInfusionRate, estimatedMinutes))
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(ObsidianTheme.surfaceElevated)
                    .cornerRadius(8)
                }
            }
            
            // Mandatory Vitamin K Co-Administration
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "exclamationmark.shield.fill")
                    .foregroundColor(ObsidianTheme.neonAmber)
                    .font(.system(size: 14))
                VStack(alignment: .leading, spacing: 2) {
                    Text("MANDATORY CO-ADMINISTRATION: Vitamin K1 (Phytonadione)")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonAmber)
                    Text("Dose: 10 mg IV piggyback in 50 mL NS over 30 minutes. NEVER give rapid IV push (anaphylaxis risk). 4F-PCC half-life is 6 hours; Vitamin K ensures endogenous sustained clotting factor synthesis.")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
            }
            .padding(10)
            .background(ObsidianTheme.neonAmber.opacity(0.08))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.neonAmber.opacity(0.3), lineWidth: 1))
            
            // Fallback: FFP
            VStack(alignment: .leading, spacing: 2) {
                Text("Fallback If Kcentra Unavailable: Fresh Frozen Plasma (FFP)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(ObsidianTheme.textSecondary)
                Text(String(format: "Dose: 15 mL/kg = %.0f mL FFP (~%.0f units). Caution: High risk of TRALI/TACO volume overload; requires 2-4 hours to thaw and infuse.", patientWeightKg * 15, (patientWeightKg * 15) / 250))
                    .font(.system(size: 10))
                    .foregroundColor(ObsidianTheme.textTertiary)
            }
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - 2. Direct Factor Xa Inhibitors Reversal Card
    private var factorXaReversalCard: some View {
        let isRecent = hoursSinceLastXaDose < 8.0
        let isHighDoseDrug = xaDoseStrength.contains("High") || (selectedXaDrug.contains("Apixaban") && xaDoseStrength.contains(">5mg")) || (selectedXaDrug.contains("Rivaroxaban") && xaDoseStrength.contains(">10mg"))
        let isAndexxaHighDose = isRecent && isHighDoseDrug
        
        return VStack(alignment: .leading, spacing: 14) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("DIRECT FACTOR XA INHIBITOR REVERSAL")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Text("Apixaban (Eliquis) & Rivaroxaban (Xarelto)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text("ANNEXA-4 SPEC")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(ObsidianTheme.neonCyan)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(ObsidianTheme.neonCyan.opacity(0.18))
                    .cornerRadius(4)
            }
            
            // Selector: Drug & Dose
            VStack(spacing: 10) {
                HStack {
                    Text("Target Ingestion:")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Spacer()
                    Picker("Xa Drug", selection: $selectedXaDrug) {
                        Text("Apixaban (Eliquis)").tag("Apixaban (Eliquis)")
                        Text("Rivaroxaban (Xarelto)").tag("Rivaroxaban (Xarelto)")
                        Text("Edoxaban (Savaysa)").tag("Edoxaban (Savaysa)")
                    }
                    .pickerStyle(.menu)
                    .tint(ObsidianTheme.neonCyan)
                }
                
                HStack {
                    Text("Dose Strength:")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Spacer()
                    Picker("Dose Strength", selection: $xaDoseStrength) {
                        Text(selectedXaDrug.contains("Apixaban") ? "Low (≤ 5 mg)" : "Low (≤ 10 mg)").tag("Low Dose")
                        Text(selectedXaDrug.contains("Apixaban") ? "High (> 5 mg or unknown)" : "High (> 10 mg or unknown)").tag("High Dose")
                    }
                    .pickerStyle(.menu)
                    .tint(ObsidianTheme.neonCyan)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Time Since Last Ingestion:")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(ObsidianTheme.textSecondary)
                        Spacer()
                        Text(String(format: "%.1f hours ago", hoursSinceLastXaDose))
                            .font(.system(size: 12, weight: .heavy))
                            .foregroundColor(isRecent ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                    }
                    Slider(value: $hoursSinceLastXaDose, in: 0.5...24.0, step: 0.5)
                        .tint(isRecent ? ObsidianTheme.neonRed : ObsidianTheme.neonGreen)
                }
            }
            .padding(10)
            .background(ObsidianTheme.surfaceElevated)
            .cornerRadius(10)
            
            Divider().overlay(ObsidianTheme.glassBorder)
            
            // Andexxa Protocol Result Box
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("PRIMARY REVERSAL: Andexanet alfa (Andexxa)")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Spacer()
                    Text(isAndexxaHighDose ? "HIGH DOSE PROTOCOL" : "LOW DOSE PROTOCOL")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(isAndexxaHighDose ? ObsidianTheme.neonRed : ObsidianTheme.neonCyan)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background((isAndexxaHighDose ? ObsidianTheme.neonRed : ObsidianTheme.neonCyan).opacity(0.18))
                        .cornerRadius(4)
                }
                
                if isAndexxaHighDose {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• IV Bolus: 800 mg target at 30 mg/min (~27 min)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                        Text("• Continuous IV Infusion: 8 mg/min for 120 minutes (960 mg)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                        Text("• Total Dose: 1,760 mg (Nine 200 mg vials)")
                            .font(.system(size: 11, weight: .heavy))
                            .foregroundColor(ObsidianTheme.neonAmber)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• IV Bolus: 400 mg target at 30 mg/min (~14 min)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                        Text("• Continuous IV Infusion: 4 mg/min for 120 minutes (480 mg)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                        Text("• Total Dose: 880 mg (Four to five 200 mg vials)")
                            .font(.system(size: 11, weight: .heavy))
                            .foregroundColor(ObsidianTheme.neonCyan)
                    }
                }
            }
            .padding(10)
            .background(ObsidianTheme.neonCyan.opacity(0.08))
            .cornerRadius(10)
            
            // Alternative Protocol Box: 4F-PCC
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("ALTERNATIVE (If Andexxa Unavailable): 4F-PCC (Kcentra)")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(ObsidianTheme.neonAmber)
                    Spacer()
                    Text("OFF-LABEL BTF")
                        .font(.system(size: 8, weight: .heavy))
                        .foregroundColor(ObsidianTheme.neonAmber)
                }
                let altPCCDose = min(patientWeightKg * 50.0, 5000.0)
                Text(String(format: "Dose: 50 units/kg IV bolus (Calculated: %.0f units, max 5,000 units) OR fixed dose 2,000 units IV. Administer over 15-20 min.", altPCCDose))
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding(10)
            .background(ObsidianTheme.surfaceElevated)
            .cornerRadius(10)
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - 3. Dabigatran (Pradaxa) Reversal Card
    private var dabigatranReversalCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("DABIGATRAN (PRADAXA) ACUTE REVERSAL")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(ObsidianTheme.neonPurple)
                    Text("Direct Thrombin (Factor IIa) Inhibitor")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text("RE-VERSE AD")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(ObsidianTheme.neonPurple)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(ObsidianTheme.neonPurple.opacity(0.18))
                    .cornerRadius(4)
            }
            
            // Primary Agent: Praxbind
            VStack(alignment: .leading, spacing: 8) {
                Text("SPECIFIC MONOCLONAL REVERSAL: Idarucizumab (Praxbind)")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(ObsidianTheme.neonPurple)
                
                HStack(spacing: 8) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("TOTAL DOSE")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(ObsidianTheme.textTertiary)
                        Text("5.0 Grams IV")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(ObsidianTheme.neonPurple)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("VIAL PACKAGING")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(ObsidianTheme.textTertiary)
                        Text("Two 2.5 g / 50 mL vials")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                    }
                }
                
                Text("Administration: Administer both 2.5 g / 50 mL vials consecutively as rapid IV bolus or 5-10 minute infusion each. Complete normal hemostasis is restored within 5-10 minutes.")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding(10)
            .background(ObsidianTheme.neonPurple.opacity(0.08))
            .cornerRadius(10)
            
            // Hemodialysis Kinetics & Alternatives
            VStack(alignment: .leading, spacing: 6) {
                Text("KINETIC PEARLS & BACKUP OPTIONS")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(ObsidianTheme.textTertiary)
                
                Text("• Hemodialysis Clearance: Dabigatran has low plasma protein binding (35%). Emergent hemodialysis removes ~60% of circulating drug within 2-3 hours.")
                    .font(.system(size: 10))
                    .foregroundColor(ObsidianTheme.textSecondary)
                
                Text("• Secondary Backup: 4F-PCC (Kcentra) 50 U/kg IV or Activated PCC (FEIBA) 50 U/kg if Praxbind is unavailable.")
                    .font(.system(size: 10))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding(10)
            .background(ObsidianTheme.surfaceElevated)
            .cornerRadius(10)
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - 4. Antiplatelet Agents Reversal Card
    private var antiplateletReversalCard: some View {
        let ddavpDose = patientWeightKg * 0.4
        
        return VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("ANTIPLATELET CRITICAL REVERSAL")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(ObsidianTheme.neonRose)
                    Text("Aspirin, Clopidogrel (Plavix), Ticagrelor (Brilinta), Prasugrel")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text("PATCH TRIAL")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(ObsidianTheme.neonRose)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(ObsidianTheme.neonRose.opacity(0.18))
                    .cornerRadius(4)
            }
            
            // Selector: Drug
            HStack {
                Text("Active Antiplatelet:")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ObsidianTheme.textSecondary)
                Spacer()
                Picker("Drug", selection: $selectedAntiplatelet) {
                    Text("Aspirin (COX-1)").tag("Aspirin (COX-1)")
                    Text("Clopidogrel (Plavix)").tag("Clopidogrel (Plavix)")
                    Text("Ticagrelor (Brilinta)").tag("Ticagrelor (Brilinta)")
                    Text("Dual Antiplatelet (DAPT)").tag("Dual Antiplatelet (DAPT)")
                }
                .pickerStyle(.menu)
                .tint(ObsidianTheme.neonRose)
            }
            .padding(8)
            .background(ObsidianTheme.surfaceElevated)
            .cornerRadius(8)
            
            // Step 1: DDAVP
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("STEP 1: Desmopressin (DDAVP)")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Spacer()
                    Text(String(format: "%.1f mcg IV", ddavpDose))
                        .font(.system(size: 16, weight: .heavy, design: .rounded))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
                Text("Dose: 0.4 mcg/kg IV diluted in 50 mL NS over 30 minutes. Stimulates Weibel-Palade bodies to release endogenous Factor VIII and von Willebrand factor, markedly improving platelet adhesion.")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
            }
            .padding(10)
            .background(ObsidianTheme.neonCyan.opacity(0.08))
            .cornerRadius(10)
            
            // Step 2: Platelet Transfusion
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("STEP 2: Platelet Transfusion (Operative Mandate)")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(ObsidianTheme.neonRose)
                    Spacer()
                    Text("1-2 Apheresis Units")
                        .font(.system(size: 12, weight: .heavy))
                        .foregroundColor(ObsidianTheme.neonRose)
                }
                Text("• Indication: Immediate surgical intervention for acute intracranial hemorrhage (EDH/SDH/ICH).")
                    .font(.system(size: 10))
                    .foregroundColor(ObsidianTheme.textSecondary)
                Text("• Timing Warning: If Clopidogrel was taken < 2-4 hours ago, active circulating hepatic metabolites will bind and inactivate transfused platelets. Repeat transfusion in 4 hours if bleeding persists.")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(ObsidianTheme.neonAmber)
            }
            .padding(10)
            .background(ObsidianTheme.neonRose.opacity(0.08))
            .cornerRadius(10)
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - 5. Heparin & LMWH Reversal Card
    private var heparinReversalCard: some View {
        return VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("HEPARIN & LMWH RAPID REVERSAL")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(ObsidianTheme.neonBlue)
                    Text("Unfractionated Heparin (UFH) & Enoxaparin (Lovenox)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text("PROTAMINE")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(ObsidianTheme.neonBlue)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(ObsidianTheme.neonBlue.opacity(0.18))
                    .cornerRadius(4)
            }
            
            // Picker: Heparin Type
            Picker("Heparin Type", selection: $heparinType) {
                Text("Enoxaparin (LMWH)").tag("Enoxaparin (LMWH)")
                Text("Unfractionated Heparin (UFH)").tag("Unfractionated Heparin (UFH)")
            }
            .pickerStyle(.segmented)
            
            if heparinType == "Unfractionated Heparin (UFH)" {
                // UFH Protamine Dosing
                let protamineDose = min((heparinUnitsGiven / 100.0), 50.0)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("PROTAMINE SULFATE DOSE")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(ObsidianTheme.neonCyan)
                        Spacer()
                        Text(String(format: "%.0f mg IV Slow Push", protamineDose))
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundColor(ObsidianTheme.neonCyan)
                    }
                    Text("Formula: 1 mg Protamine per 100 units of UFH given in the last 2 hours. Maximum single bolus dose is 50 mg.")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Text("Black Box Safety: Administer over at least 10 minutes (max 5 mg/min). Rapid injection causes catastrophic anaphylactoid reaction, severe pulmonary hypertension, and peripheral vasodilation.")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonRed)
                }
                .padding(10)
                .background(ObsidianTheme.neonCyan.opacity(0.08))
                .cornerRadius(10)
            } else {
                // LMWH Protamine Dosing
                let isRecentEnox = hoursSinceHeparin < 8.0
                let protamineMg = isRecentEnox ? (enoxaparinMgGiven * 1.0) : (enoxaparinMgGiven * 0.5)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("PROTAMINE FOR ENOXAPARIN")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(ObsidianTheme.neonBlue)
                        Spacer()
                        Text(String(format: "%.0f mg IV Push", protamineMg))
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundColor(ObsidianTheme.neonBlue)
                    }
                    Text(isRecentEnox ? "• Ingestion < 8 hours: 1 mg protamine per 1 mg enoxaparin." : "• Ingestion 8-12 hours: 0.5 mg protamine per 1 mg enoxaparin.")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                    Text("Note: Protamine neutralizes ~60-75% of anti-Factor Xa activity of LMWH. If bleeding persists, a second dose of 0.5 mg/mg enoxaparin may be administered.")
                        .font(.system(size: 10))
                        .foregroundColor(ObsidianTheme.textTertiary)
                }
                .padding(10)
                .background(ObsidianTheme.neonBlue.opacity(0.08))
                .cornerRadius(10)
            }
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - Reversal Safety Checklist Card
    private var reversalSafetyChecklistCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("PERIOPERATIVE VERIFICATION TIMELINE")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(ObsidianTheme.neonGreen)
            
            VStack(alignment: .leading, spacing: 4) {
                checklistBullet(time: "T + 0 min", text: "Send baseline STAT TEG / Rotem, Anti-Xa, PT/INR, PTT, Fibrinogen, and Type & Screen.")
                checklistBullet(time: "T + 15 min", text: "Infuse calculated reversal agent; do NOT delay emergent surgical incision for lab results.")
                checklistBullet(time: "T + 30 min", text: "Repeat STAT post-reversal INR / TEG / Anti-Xa level.")
                checklistBullet(time: "T + 24 hrs", text: "Assess risk of thromboembolic events (DVT/PE); consider restarting chemical prophylaxis when repeat CT demonstrates stability.")
            }
        }
        .padding(12)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    private func checklistBullet(time: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text(time)
                .font(.system(size: 9, weight: .heavy, design: .monospaced))
                .foregroundColor(ObsidianTheme.neonGreen)
                .frame(width: 58, alignment: .leading)
            Text(text)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
    }
}
