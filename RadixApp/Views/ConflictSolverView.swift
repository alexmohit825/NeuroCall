import SwiftUI

public struct ConflictSolverView: View {
    @State private var selectedConflict = "foot_drop"
    @State private var tibialisPosteriorPower = 5
    @State private var tibialisAnteriorPower = 2
    @State private var pronatorTeresPower = 5
    @State private var apbPower = 3
    @State private var thenarPalmarSensoryNormal = true
    @State private var spurlingPositive = false
    @State private var phalenPositive = true
    @State private var fibularTinelPositive = false
    
    public init() {}
    
    var rootLikelihood: Int {
        if selectedConflict == "foot_drop" {
            // Foot Inversion weak = L5 root / sciatic! Spared = isolated peroneal
            return tibialisPosteriorPower < 5 ? 92 : 12
        } else {
            // Pronator weak or palmar numb = C6 root! Spared = Carpal tunnel
            return (!thenarPalmarSensoryNormal || pronatorTeresPower < 5 || spurlingPositive) ? 88 : 15
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("NEURO-ANATOMICAL CONFLICT ARBITRATOR")
                        .font(.system(size: 11, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(.indigo)
                    Text("Spinal Root vs. Peripheral Nerve")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Conflict Dilemma Switcher
                HStack(spacing: 8) {
                    Button(action: { selectedConflict = "foot_drop" }) {
                        Text("Foot Drop: L5 vs. Common Peroneal")
                            .font(.system(size: 12, weight: .bold))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(selectedConflict == "foot_drop" ? Color.indigo : Color.white)
                            .foregroundColor(selectedConflict == "foot_drop" ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.04), radius: 3)
                    }
                    
                    Button(action: { selectedConflict = "hand_cts" }) {
                        Text("Hand Numbness: C6 vs. Carpal Tunnel")
                            .font(.system(size: 12, weight: .bold))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(selectedConflict == "hand_cts" ? Color.indigo : Color.white)
                            .foregroundColor(selectedConflict == "hand_cts" ? .white : Color(red: 0.3, green: 0.35, blue: 0.45))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.04), radius: 3)
                    }
                }
                .padding(.horizontal)
                
                // Anatomic Spinal Root Cross-Section Drawing
                VStack(spacing: 8) {
                    Text("Radicular Nerve vs. Peripheral Trunk Topology")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.55))
                    
                    SpinalCordCrossSectionView(selectedSegment: .constant("L5"))
                        .padding(.vertical, 4)
                    
                    Text("Dorsal Root Ganglion (DRG) is pre-ganglionic in root lesions (sparing SNAP) vs. post-ganglionic terminal nerve loss.")
                        .font(.system(size: 11, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.55))
                        .padding(.horizontal, 24)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.04), radius: 8)
                .padding(.horizontal)
                
                // Real-Time Diagnostic Gauge
                VStack(spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(rootLikelihood > 50 ? "SPINAL ROOT RADICULOPATHY FAVORED" : "ISOLATED PERIPHERAL NERVE FAVORED")
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(rootLikelihood > 50 ? .indigo : .teal)
                            Text(selectedConflict == "foot_drop"
                                 ? (rootLikelihood > 50 ? "L5 Nerve Root Compromise" : "Common Peroneal Entrapment at Fibular Neck")
                                 : (rootLikelihood > 50 ? "C6 Radiculopathy / Foraminal Stenosis" : "Carpal Tunnel Syndrome (CTS)"))
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                        }
                        Spacer()
                        Text("\(rootLikelihood > 50 ? rootLikelihood : (100 - rootLikelihood))%")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(rootLikelihood > 50 ? .indigo : .teal)
                    }
                    
                    // Gauge bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(red: 0.9, green: 0.92, blue: 0.95))
                                .frame(height: 10)
                            RoundedRectangle(cornerRadius: 6)
                                .fill(LinearGradient(colors: [.teal, .indigo], startPoint: .leading, endPoint: .trailing))
                                .frame(width: geo.size.width * CGFloat(rootLikelihood) / 100.0, height: 10)
                        }
                    }
                    .frame(height: 10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.04), radius: 6)
                .padding(.horizontal)
                
                // Decisive Arbitrator Test Controls
                VStack(alignment: .leading, spacing: 16) {
                    Text("Decisive Clinical Arbitrators")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.18))
                    
                    if selectedConflict == "foot_drop" {
                        // Tibialis Posterior Stepper (The supreme foot drop test)
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Tibialis Posterior (Foot Inversion)")
                                    .font(.system(size: 13, weight: .bold))
                                Text("L5 via Tibial nerve. Spared in peroneal palsy; weak in L5 root.")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Stepper("\(tibialisPosteriorPower)/5", value: $tibialisPosteriorPower, in: 0...5)
                                .font(.system(size: 13, weight: .black))
                        }
                    } else {
                        // Pronator Teres Stepper
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Pronator Teres Power")
                                    .font(.system(size: 13, weight: .bold))
                                Text("C6/C7 proximal to carpal tunnel. Spared in CTS; weak in C6 root.")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Stepper("\(pronatorTeresPower)/5", value: $pronatorTeresPower, in: 0...5)
                                .font(.system(size: 13, weight: .black))
                        }
                        
                        Toggle(isOn: $thenarPalmarSensoryNormal) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Palmar Cutaneous Thenar Sensation Spared")
                                    .font(.system(size: 13, weight: .bold))
                                Text("Travels superficial to retinaculum. Normal in CTS; reduced in C6 root.")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .tint(.indigo)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.04), radius: 6)
                .padding(.horizontal)
            }
            .padding(.bottom, 24)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }
}
