import SwiftUI

// MARK: - OR Setup & Implant Spec-Sheet Bridge for Circulators & Reps
// Bridges the critical 3 AM communication gap between neurosurgery resident,
// OR circulating nurse, scrub technician, and device hardware representatives.
// Provides precise tray picks, screw diameters, Mayfield pin torques, shunt settings, and 1-tap sharing.

public enum ORProcedureSpecType: String, CaseIterable, Identifiable {
    case traumaCraniectomy = "Trauma Craniectomy / Craniotomy"
    case harmsC1C2 = "Goel-Harms C1–C2 Fusion"
    case tlifLumbar = "L4–L5 TLIF Interbody Fusion"
    case evdBedside = "Emergency EVD Kit"
    case shuntValves = "Programmable Shunt Reprogramming"
    
    public var id: String { self.rawValue }
    
    public var icon: String {
        switch self {
        case .traumaCraniectomy: return "cross.case.fill"
        case .harmsC1C2: return "lock.shield.fill"
        case .tlifLumbar: return "link"
        case .evdBedside: return "syringe.fill"
        case .shuntValves: return "dial.low.fill"
        }
    }
}

public struct ORSetupBridgeView: View {
    @State private var selectedProcedure: ORProcedureSpecType = .traumaCraniectomy
    @State private var copiedConfirmation = false
    
    public init() {}
    
    // Markdown export script for Circulator / Scrub Tech / Rep
    private var shareableSpecScript: String {
        switch selectedProcedure {
        case .traumaCraniectomy:
            return """
            🚨 OR SETUP SPEC-SHEET: EMERGENT TRAUMA CRANIECTOMY / CRANIOTOMY 🚨
            • Positioning: Supine on gel horseshoe or 3-pin Mayfield (Torque: 60 lbs; pin avoidance: temporal muscle & thin squama).
            • Drill & Footplate: High-speed electric/pneumatic drill, 14 mm perforator with auto-clutch, footplate craniotome bit.
            • Hemostasis: Bipolar forceps (irrigation line attached, setting 25-35), Surgicel Fibrillar (x3), Floseal/Surgiflo (2 kits), Gelita-Spon, Bone Wax.
            • Dural Patch: 3x3 inch bovine pericardium (DuraGuard) or DuraGen onlay + 4-0 Nurolon braided retention sutures.
            • Closure/Hardware: 0.6 mm dynamic titanium cranial mesh + 4 mm self-drilling cross-pin screws; 10 Fr Blake/JP subgaleal drain to gravity.
            """
        case .harmsC1C2:
            return """
            🚨 OR SETUP SPEC-SHEET: GOEL-HARMS C1-C2 POSTERIOR FUSION 🚨
            • Patient Position: Prone on Jackson table with chest rolls; 3-pin Mayfield with rocker arm inverted (military chin tuck, cross-table fluoro clearance).
            • Screws: 3.5 mm polyaxial screws (C1 Lateral Mass: 28 mm & 30 mm; C2 Pedicle/Pars: 26 mm & 28 mm).
            • Rods: 3.5 mm pre-contoured titanium rods (35-45 mm length).
            • Drivers: Torx T15 / T20 star-shaped set-screw drivers with 5.0 Nm torque-limiting handle.
            • Biologics: Demineralized bone matrix (DBM) putty + local bone graft chips; bone wax for C2 epidural venous plexus bleeding.
            """
        case .tlifLumbar:
            return """
            🚨 OR SETUP SPEC-SHEET: L4-L5 TLIF INTERBODY FUSION 🚨
            • Positioning: Prone on radiolucent Jackson spinal table (Wilson frame or flat radiolucent top).
            • Pedicle Screws: Four 6.5 mm x 45 mm (or 7.5 mm) pedicle screws + two 5.5 mm titanium rods.
            • Interbody Spacer: Porous 3D-printed titanium or PEEK curved banana cage (Heights: 9 mm, 10 mm, 11 mm; 4-8° lordosis).
            • Retractors & Instruments: McCulloch retractor frame, Scoville nerve root retractor, bayoneted disc rongeurs, bone graft funnel.
            • Biologics: Recombinant BMP-2 (Infuse small kit) or DBM putty + autologous local facet bone.
            """
        case .evdBedside:
            return """
            🚨 OR/BEDSIDE SETUP: EMERGENCY VENTRICULOSTOMY (EVD) KIT 🚨
            • Entry Landmark: Kocher's point (11 cm posterior from nasion, 3 cm lateral from midline).
            • Trephination: Hand twist drill with 5.5 mm bit and safety depth stop collar set to 1.0 cm.
            • Catheter: 8.5 Fr or 9 Fr barium-impregnated silver/antibiotic ventriculostomy catheter with metallic stylet.
            • Target Angles: Medial canthus in coronal plane; tragus in sagittal plane (Never advance > 7.0 cm; stop at 5.5-6.5 cm).
            • Transducer: External drainage system with laser zero level referenced to Tragus (Foramen of Monro).
            """
        case .shuntValves:
            return """
            🚨 SHUNT VALVE SIZING & REPROGRAMMING GUIDE 🚨
            • Medtronic Strata II: Settings 0.5 (very low), 1.0, 1.5 (standard), 2.0, 2.5 (high). Requires Strata hand programmer magnet; affected by 1.5T/3T MRI (Must verify setting post-MRI).
            • Codman Certas Plus: Settings 1 (lowest, 36 mmH2O) to 8 (highest, 238 mmH2O). MRI conditional to 3.0 Tesla; setting does NOT alter in magnetic field.
            • Sophysa Polaris: Micro-magnets with magnetic locking. MRI stable up to 3 Tesla.
            • Miethke proGAV 2.0: Gravitational ball-in-cone valve. Range 0 to 20 cmH2O. MRI conditional up to 3T without unintentional resetting.
            """
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Banner
                headerBanner
                
                // Procedure Selector Carousel
                procedureSelectorCarousel
                
                // Active Setup Specifications Card
                activeSpecDetailCard
                
                // 1-Tap Action: Share with Scrub Nurse / Rep
                shareActionCard
                
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
                Circle().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 8)
                Text("SURGICAL OPERATIONS & LOGISTICS BRIDGE")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1.8)
                    .foregroundColor(ObsidianTheme.neonCyan)
            }
            Text("OR Setup & Implant Spec-Sheets")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ObsidianTheme.textPrimary)
            Text("Exact tray sizes, pin torques, screw diameters, and 1-tap handoffs for circulators and reps.")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(ObsidianTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    // MARK: - Procedure Carousel
    private var procedureSelectorCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ORProcedureSpecType.allCases) { proc in
                    Button(action: {
                        HapticManager.impact(style: .light)
                        selectedProcedure = proc
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: proc.icon)
                            Text(proc.rawValue)
                                .font(.system(size: 11, weight: .bold))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(selectedProcedure == proc ? ObsidianTheme.neonCyan : ObsidianTheme.surfaceElevated)
                        .foregroundColor(selectedProcedure == proc ? .black : ObsidianTheme.textSecondary)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedProcedure == proc ? ObsidianTheme.neonCyan : ObsidianTheme.glassBorder, lineWidth: 1))
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Active Spec Detail Card
    private var activeSpecDetailCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(selectedProcedure.rawValue.uppercased())
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(ObsidianTheme.neonCyan)
                    Text("Standard Operating Room Instrumentation Spec")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(ObsidianTheme.textSecondary)
                }
                Spacer()
                Text("VERIFIED PROTOCOL")
                    .font(.system(size: 8, weight: .black))
                    .foregroundColor(ObsidianTheme.neonGreen)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(ObsidianTheme.neonGreen.opacity(0.18))
                    .cornerRadius(4)
            }
            
            Divider().overlay(ObsidianTheme.glassBorder)
            
            // Structured Breakdown Sections
            VStack(alignment: .leading, spacing: 10) {
                ForEach(specRowsForProcedure(selectedProcedure), id: \.title) { row in
                    VStack(alignment: .leading, spacing: 3) {
                        HStack {
                            Image(systemName: row.icon)
                                .font(.system(size: 11))
                                .foregroundColor(row.color)
                            Text(row.title)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(row.color)
                        }
                        Text(row.content)
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(ObsidianTheme.textPrimary)
                            .lineSpacing(2)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ObsidianTheme.surfaceElevated)
                    .cornerRadius(10)
                }
            }
        }
        .padding(14)
        .background(ObsidianTheme.glassSurface)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(ObsidianTheme.glassBorder, lineWidth: 1))
        .padding(.horizontal)
    }
    
    // MARK: - 1-Tap Share Card
    private var shareActionCard: some View {
        VStack(spacing: 10) {
            Button(action: {
                HapticManager.impact(style: .medium)
                UIPasteboard.general.string = shareableSpecScript
                copiedConfirmation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    copiedConfirmation = false
                }
            }) {
                HStack {
                    Image(systemName: copiedConfirmation ? "checkmark.circle.fill" : "paperplane.fill")
                    Text(copiedConfirmation ? "Copied Spec-Sheet to Clipboard!" : "Copy Spec-Sheet to Text Scrub Nurse / Rep")
                        .font(.system(size: 12, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(ObsidianTheme.neonCyan)
                .foregroundColor(.black)
                .cornerRadius(12)
                .shadow(color: ObsidianTheme.neonCyan.opacity(0.3), radius: 6, y: 2)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Row Specs Generator
    private struct SpecRow {
        let title: String
        let icon: String
        let content: String
        let color: Color
    }
    
    private func specRowsForProcedure(_ proc: ORProcedureSpecType) -> [SpecRow] {
        switch proc {
        case .traumaCraniectomy:
            return [
                SpecRow(title: "Patient Positioning & Head Holder", icon: "person.fill", content: "Supine with ipsilateral shoulder roll; gel horseshoe or 3-pin Mayfield torqued to 60 lbs. Avoid temporal squama (thin bone penetration risk) and previous shunt hardware.", color: ObsidianTheme.neonCyan),
                SpecRow(title: "High-Speed Drill & Perforators", icon: "bolt.fill", content: "Electric/pneumatic high-speed drill, 14 mm cranial perforator bit with auto-clutch release, and angled footplate craniotome bit for rapid bone flap elevation.", color: ObsidianTheme.neonAmber),
                SpecRow(title: "Hemostatic Agents & Bipolar", icon: "flame.fill", content: "Bipolar forceps with continuous irrigation (power 25-35), Surgicel Fibrillar (3 packs), Floseal gelatin-thrombin matrix (2 kits), Gelita-Spon, and sterile bone wax.", color: ObsidianTheme.neonRose),
                SpecRow(title: "Dural Expansion & Closure", icon: "shield.fill", content: "3x3 inch bovine pericardial graft (DuraGuard) or DuraGen onlay matrix; 4-0 Nurolon braided dural hitch sutures; 0.6 mm dynamic titanium cranial mesh with 4 mm self-drilling screws.", color: ObsidianTheme.neonGreen)
            ]
        case .harmsC1C2:
            return [
                SpecRow(title: "Patient Positioning & Fluoroscopy", icon: "person.fill", content: "Prone on Jackson radiolucent spinal table with chest bolsters; 3-pin Mayfield with rocker arm inverted; slight chin flexion ('military tuck') allowing unobstructed lateral C-arm fluoroscopy.", color: ObsidianTheme.neonCyan),
                SpecRow(title: "Posterior Cervical Screws", icon: "shippingbox.fill", content: "3.5 mm polyaxial screws: C1 Lateral Mass = 28 mm & 30 mm; C2 Pedicle/Pars = 26 mm & 28 mm. Pre-contoured 3.5 mm titanium rods (35-45 mm length).", color: ObsidianTheme.neonAmber),
                SpecRow(title: "Drivers & Torque Limiters", icon: "wrench.and.screwdriver.fill", content: "Torx T15 / T20 star-shaped set screw driver; 5.0 Nm calibrated torque-limiting release handle; high-speed 2 mm diamond burr for C1 inferior arch notching.", color: ObsidianTheme.neonPurple),
                SpecRow(title: "Biologics & Venous Control", icon: "leaf.fill", content: "Demineralized bone matrix (DBM) putty + local autologous bone chips packed into C1-C2 decorticated joint space; FloSeal + Cottonoids for C2 venous plexus control.", color: ObsidianTheme.neonGreen)
            ]
        case .tlifLumbar:
            return [
                SpecRow(title: "Operating Table & Imaging", icon: "bed.double.fill", content: "Radiolucent Jackson spinal frame with flat carbon-fiber top. C-arm positioned from contralateral side for true orthogonal AP and lateral lumbar verification.", color: ObsidianTheme.neonCyan),
                SpecRow(title: "Pedicle Fixation System", icon: "shippingbox.fill", content: "Four 6.5 mm x 45 mm (or 7.5 mm) polyaxial pedicle screws + two 5.5 mm titanium rods + reduction set screws.", color: ObsidianTheme.neonAmber),
                SpecRow(title: "Interbody Cage & Trials", icon: "cube.fill", content: "Curved banana or bullet PEEK / porous 3D-printed titanium TLIF cage (Heights: 9 mm, 10 mm, 11 mm; 4-8° lordosis); trial sizers; bone graft injection funnel.", color: ObsidianTheme.neonPurple),
                SpecRow(title: "Retractors & Discectomy", icon: "scissors", content: "McCulloch retractor blades, Scoville nerve root retractor with insulated shaft to protect traversing root, bayoneted pituitary rongeurs, and straight/curved ring curettes.", color: ObsidianTheme.neonGreen)
            ]
        case .evdBedside:
            return [
                SpecRow(title: "Kocher's Point Anatomical Coordinates", icon: "mappin.and.ellipse", content: "11 cm posterior from nasion along midline, 3 cm lateral from midline (mid-pupillary line), strictly anterior to coronal suture.", color: ObsidianTheme.neonCyan),
                SpecRow(title: "Twist Drill Assembly", icon: "circle.grid.cross.fill", content: "Hand twist drill or electric cranial perforator with 5.5 mm bit and adjustable mechanical depth stop collar locked at 1.0 cm.", color: ObsidianTheme.neonAmber),
                SpecRow(title: "Catheter & Stylet Trajectory", icon: "syringe.fill", content: "8.5 Fr or 9 Fr antibiotic-impregnated ventricular catheter. Aim toward medial canthus in coronal plane and external auditory meatus in sagittal plane. Normal depth: 5.5 to 6.5 cm.", color: ObsidianTheme.neonPurple),
                SpecRow(title: "Transducer & Drainage Column", icon: "waveform.path.ecg", content: "Sterile closed-system ventricular drainage bag with laser level calibrated and zeroed to the Tragus (Foramen of Monro). Pop-off pressure set to +10 to +15 cmH2O.", color: ObsidianTheme.neonGreen)
            ]
        case .shuntValves:
            return [
                SpecRow(title: "Medtronic Strata II Programming", icon: "dial.low.fill", content: "Settings: 0.5 (Very Low), 1.0 (Low), 1.5 (Standard Medium), 2.0 (High), 2.5 (Very High). Non-magnetic mechanical lock absent; MUST re-check and re-program after every 1.5T or 3.0T MRI.", color: ObsidianTheme.neonCyan),
                SpecRow(title: "Codman Certas Plus Programming", icon: "dial.medium.fill", content: "Settings: 1 (Lowest, 36 mmH2O) to 8 (Highest, 238 mmH2O). MRI Conditional to 3.0 Tesla; magnetic brake prevents setting change inside MRI scanner. Does not require routine post-MRI reprogramming.", color: ObsidianTheme.neonAmber),
                SpecRow(title: "Sophysa Polaris Programming", icon: "dial.high.fill", content: "Uses magnetic orientation of micro-magnets. Locked by patented mechanical spring; completely insensitive to inadvertent deprogramming from everyday magnets or 3T MRI.", color: ObsidianTheme.neonPurple),
                SpecRow(title: "Miethke proGAV 2.0 Programming", icon: "slider.horizontal.3", content: "Gravitational ball-and-spring valve combined with adjustable unit (0 to 20 cmH2O). Feedback ring confirmation; immune to magnetic fields up to 3 Tesla.", color: ObsidianTheme.neonGreen)
            ]
        }
    }
}
