import SwiftUI

// MARK: - On-Call Field Manual (Frontline Operational Principles)
// Reorganizes on-call cognitive, communication, and triage strategies into a clean, visual cockpit

public struct OnCallFieldManualView: View {
    @State private var selectedTopic = "tripartite"
    
    let topics = [
        ("tripartite", "Shift Triad", "arrow.triangle.branch", ObsidianTheme.neonRed),
        ("triage", "Frailty & Falls", "figure.fall", ObsidianTheme.neonAmber),
        ("communication", "Communication", "bubble.left.and.exclamationmark.bubble.right", ObsidianTheme.neonCyan),
        ("contingency", "Contingency Signout", "list.bullet.clipboard", ObsidianTheme.neonGreen),
        ("resilience", "Cognitive Offload", "brain", ObsidianTheme.neonPurple)
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Circle().fill(ObsidianTheme.neonAmber).frame(width: 8, height: 8)
                        Text("ON-CALL OPERATING MANUAL")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.8)
                            .foregroundColor(ObsidianTheme.neonAmber)
                    }
                    Text("Frontline On-Call Strategy")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(ObsidianTheme.textPrimary)
                    Text("Structured cognitive frameworks, referral de-escalation, and high-stakes signout discipline.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Strategy Selector Strip
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(topics, id: \.0) { t in
                            Button(action: {
                                HapticManager.impact(style: .light)
                                selectedTopic = t.0
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: t.2)
                                        .font(.system(size: 12, weight: .bold))
                                    Text(t.1)
                                        .font(.system(size: 11, weight: .bold))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .background(selectedTopic == t.0 ? t.3.opacity(0.25) : ObsidianTheme.glassSurface)
                                .foregroundColor(selectedTopic == t.0 ? t.3 : ObsidianTheme.textSecondary)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedTopic == t.0 ? t.3 : ObsidianTheme.glassBorder, lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Active Interactive Strategy Card
                Group {
                    switch selectedTopic {
                    case "tripartite":
                        TripartiteShiftRadarCard()
                    case "triage":
                        FrailtyTriageMatrixCard()
                    case "communication":
                        ReferralCommunicationCard()
                    case "contingency":
                        ContingencySignoutCard()
                    case "resilience":
                        CognitiveOffloadCard()
                    default:
                        TripartiteShiftRadarCard()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 32)
        }
        .obsidianCockpitBackground()
    }
}

// MARK: - 1. Tripartite Shift Radar Card
struct TripartiteShiftRadarCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("THE TRIPARTITE BURDEN OF CALL")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(ObsidianTheme.neonRed)
                Spacer()
                Text("PRIORITIZATION ENGINE")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textTertiary)
            }
            
            // Visual Triad Nodes
            HStack(spacing: 12) {
                TriadNodeView(
                    icon: "bed.double.fill",
                    title: "ICU Inpatient",
                    subtitle: "Blown pupil, ICP spike, CSF leak",
                    color: ObsidianTheme.neonRed,
                    priority: "P1: IMMEDIATE"
                )
                TriadNodeView(
                    icon: "phone.down.waves.left.and.right",
                    title: "Regional Consult",
                    subtitle: "Outside ED transfer requests",
                    color: ObsidianTheme.neonAmber,
                    priority: "P2: URGENT"
                )
                TriadNodeView(
                    icon: "scalpel",
                    title: "Emergency OR",
                    subtitle: "Running emergent craniotomies",
                    color: ObsidianTheme.neonPurple,
                    priority: "P1/P2 SYNCH"
                )
            }
            
            // Core Operational Rule
            VStack(alignment: .leading, spacing: 8) {
                Text("TACTICAL DEPLOYMENT RULE:")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(ObsidianTheme.neonRed)
                Text("Never enter the OR without establishing a clear proxy gatekeeper. Alert the surgical tech and circulating nurse to field critical outside calls. If an inpatient deteriorates while you are scrubbed, immediately initiate standardized bedside orders (hypertonic bolus, EVD leveling) before breaking scrub.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(ObsidianTheme.textSecondary)
                    .lineSpacing(2)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.04)))
        }
        .padding(16)
        .vitreousGlassCard()
    }
}

struct TriadNodeView: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let priority: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(color)
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text(priority)
                .font(.system(size: 9, weight: .black, design: .monospaced))
                .foregroundColor(color)
            Text(subtitle)
                .font(.system(size: 10))
                .foregroundColor(ObsidianTheme.textTertiary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.03)))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(color.opacity(0.2), lineWidth: 1))
    }
}

// MARK: - 2. Frailty & Anticoagulated Fall Triage Card
struct FrailtyTriageMatrixCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("ANTICOAGULATED HEAD TRAUMA IN FRAIL PATIENTS")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(ObsidianTheme.neonAmber)
                Spacer()
                Text("TRIAGE MATRIX")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textTertiary)
            }
            
            VStack(spacing: 10) {
                TriageOptionRow(
                    tag: "TRANSFER STAT",
                    color: ObsidianTheme.neonRed,
                    criteria: "SDH/EDH > 10 mm, shift > 5 mm, progressive GCS drop ≥ 2, viable baseline functional status.",
                    action: "Rush 4-Factor PCC / Idarucizumab, alert neuro-anesthesia, mobilize OR team."
                )
                TriageOptionRow(
                    tag: "LOCAL MONITORING",
                    color: ObsidianTheme.neonAmber,
                    criteria: "Contusion < 15 mm, minimal SAH, GCS 15, non-focal exam, high premorbid dementia/frailty.",
                    action: "Hold anticoagulation, check repeat CT Head in 6 hours, maintain SBP < 140 mmHg."
                )
                TriageOptionRow(
                    tag: "PALLIATIVE CONFERENCING",
                    color: ObsidianTheme.neonPurple,
                    criteria: "Catastrophic bi-hemispheric injury, GCS 3 with fixed dilated pupils, pre-existing end-stage illness.",
                    action: "Avoid non-beneficial surgical craniectomy; engage ICU goals-of-care discussion early."
                )
            }
        }
        .padding(16)
        .vitreousGlassCard()
    }
}

struct TriageOptionRow: View {
    let tag: String
    let color: Color
    let criteria: String
    let action: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(tag)
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(color.opacity(0.18)))
                Spacer()
            }
            Text(criteria)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text(action)
                .font(.system(size: 11))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.04)))
    }
}

// MARK: - 3. Referral Communication & De-escalation Card
struct ReferralCommunicationCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("REFERRAL TRIAGE & CALM ANCHOR TECHNIQUE")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(ObsidianTheme.neonCyan)
                Spacer()
                Text("SBAR DISCIPLINE")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textTertiary)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "mic.fill")
                        .foregroundColor(ObsidianTheme.neonCyan)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("THE 'CALM ANCHOR' PRINCIPLE")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(ObsidianTheme.neonCyan)
                        Text("In acute resuscitations, your voice tempo dictates the emotional temperature of the referring team. Deliberately lower vocal pitch and decelerate phrasing. Unhurried clarity conveys surgical command.")
                            .font(.system(size: 12))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.04)))
                
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "shield.lefthalf.filled")
                        .foregroundColor(ObsidianTheme.neonAmber)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("DEFENSIVE REFERRAL MANAGEMENT")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(ObsidianTheme.neonAmber)
                        Text("When a non-neurosurgical case is referred purely for medicolegal liability transfer, never respond with frustration. Provide explicit, written management guidance: 'Neurologically stable. No surgical indication. Recommend outpatient MRI in 4 weeks. Repeat CT immediately if GCS drops.'")
                            .font(.system(size: 12))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.04)))
            }
        }
        .padding(16)
        .vitreousGlassCard()
    }
}

// MARK: - 4. Contingency Signout Card
struct ContingencySignoutCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("HIGH-STAKES HANDOVER & CONTINGENCY 'IF/THEN'")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(ObsidianTheme.neonGreen)
                Spacer()
                Text("ZERO-ERROR TRANSITIONS")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textTertiary)
            }
            
            VStack(spacing: 8) {
                ContingencyRow(trigger: "IF ICP > 20 mmHg for > 5 min", action: "Verify zero level, check pupillary symmetry, push 30 mL 23.4% Saline bolus.")
                ContingencyRow(trigger: "IF EVD drainage abruptly ceases", action: "Inspect for airlocks/clots, lower transducer briefly to test siphon; NEVER flush proximal limb blindly.")
                ContingencyRow(trigger: "IF focal pronator drift emerges", action: "Order STAT CTA/CTP for vasospasm; raise MAP target > 95 mmHg immediately.")
                ContingencyRow(trigger: "IF post-op spine patient has urinary retention", action: "Perform bladder ultrasound; straight cath if PVR > 300 mL; test motor EHL power.")
            }
        }
        .padding(16)
        .vitreousGlassCard()
    }
}

struct ContingencyRow: View {
    let trigger: String
    let action: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(trigger)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(ObsidianTheme.neonGreen)
            Text(action)
                .font(.system(size: 11))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.04)))
    }
}

// MARK: - 5. Cognitive Offload & Resilience Card
struct CognitiveOffloadCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("COGNITIVE OFFLOADING & CIRCADIAN VIGILANCE")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(ObsidianTheme.neonPurple)
                Spacer()
                Text("WELLNESS RESILIENCE")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(ObsidianTheme.textTertiary)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "brain.head.profile")
                        .foregroundColor(ObsidianTheme.neonPurple)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("NEVER RELY ON MEMORY AT 3:00 AM")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                        Text("Decision fatigue compounds exponentially overnight. Offload every pending callback, potassium level, and serial exam onto your digital checklist.")
                            .font(.system(size: 11))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "bed.double.circle.fill")
                        .foregroundColor(ObsidianTheme.neonCyan)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("TACTICAL MICRO-RECOVERY")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                        Text("When clinical tempo permits a lull between 03:00 and 05:00, execute a 20-minute tactical sleep cycle with feet elevated. This resets prefrontal cortex processing speed for morning operating cases.")
                            .font(.system(size: 11))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.04)))
        }
        .padding(16)
        .vitreousGlassCard()
    }
}
