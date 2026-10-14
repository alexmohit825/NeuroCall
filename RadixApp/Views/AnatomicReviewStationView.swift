import SwiftUI

// MARK: - Anatomic Reality Check & Quality Review Studio
// Dedicated resident/attending audit cockpit for inspecting all 26 medical plates in Trephine.
// Allows Dr. Mohit to systematically review each plate, mark KEEP vs REPLACE (Path A Rhoton / Path B Radiographic),
// add defect tags/notes, and export an audit report with 1 tap.

public struct ReviewPlateItem: Identifiable, Codable {
    public let id: String
    public let imageName: String
    public let title: String
    public let category: String // "Surgical Atlas", "2 AM Crisis CT", "Frontline ER Consults"
    public let clinicalContext: String
    public let anatomicalChecklist: [String]
    public var status: PlateReviewStatus // keep, replace, undecided
    public var defectTags: [String]
    public var notes: String
}

public enum PlateReviewStatus: String, Codable, CaseIterable {
    case undecided = "Undecided"
    case keep = "Keep (Approved)"
    case replace = "Recreate / Replace"
}

public class PlateAuditManager: ObservableObject {
    public static let shared = PlateAuditManager()
    
    @Published public var plates: [ReviewPlateItem] = []
    
    private let storageKey = "Trephine_AnatomicPlateAudit_v1"
    
    private init() {
        loadPlates()
    }
    
    public func loadPlates() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([ReviewPlateItem].self, from: data) {
            self.plates = saved
        } else {
            self.plates = PlateAuditManager.defaultPlates
        }
    }
    
    public func savePlates() {
        if let data = try? JSONEncoder().encode(plates) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    public func updateStatus(id: String, status: PlateReviewStatus) {
        if let idx = plates.firstIndex(where: { $0.id == id }) {
            plates[idx].status = status
            savePlates()
        }
    }
    
    public func toggleTag(id: String, tag: String) {
        if let idx = plates.firstIndex(where: { $0.id == id }) {
            if plates[idx].defectTags.contains(tag) {
                plates[idx].defectTags.removeAll { $0 == tag }
            } else {
                plates[idx].defectTags.append(tag)
            }
            savePlates()
        }
    }
    
    public func updateNotes(id: String, notes: String) {
        if let idx = plates.firstIndex(where: { $0.id == id }) {
            plates[idx].notes = notes
            savePlates()
        }
    }
    
    public func resetAudit() {
        self.plates = PlateAuditManager.defaultPlates
        savePlates()
    }
    
    public var keepCount: Int {
        plates.filter { $0.status == .keep }.count
    }
    
    public var replaceCount: Int {
        plates.filter { $0.status == .replace }.count
    }
    
    public var undecidedCount: Int {
        plates.filter { $0.status == .undecided }.count
    }
    
    public func generateAuditReportMarkdown() -> String {
        var report = "# Trephine Anatomic Plate Reality Check Audit\n\n"
        report += "**Summary:** \(keepCount) Approved to KEEP • \(replaceCount) Flagged for REPLACEMENT • \(undecidedCount) Pending Review\n\n"
        
        let categories = ["Surgical Atlas", "2 AM Crisis CT", "Frontline ER Consults"]
        for cat in categories {
            report += "## \(cat)\n"
            let catPlates = plates.filter { $0.category == cat }
            for plate in catPlates {
                let statusEmoji = plate.status == .keep ? "🟢 KEEP" : (plate.status == .replace ? "🔴 REPLACE" : "🟡 PENDING")
                report += "- **\(plate.title)** (`\(plate.imageName)`): **\(statusEmoji)**\n"
                if !plate.defectTags.isEmpty {
                    report += "  - *Defect Tags:* " + plate.defectTags.joined(separator: ", ") + "\n"
                }
                if !plate.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    report += "  - *Notes:* \(plate.notes)\n"
                }
            }
            report += "\n"
        }
        return report
    }
    
    public static let defaultPlates: [ReviewPlateItem] = [
        // MARK: - 1. Surgical Atlas Corridors (4 approved plates)
        ReviewPlateItem(
            id: "sa_aneurysm",
            imageName: "plate_aneurysm",
            title: "Anterior Circulation Aneurysm Clipping",
            category: "Surgical Atlas",
            clinicalContext: "Acom, Pcom, and MCA bifurcation clipping windows via pterional corridor.",
            anatomicalChecklist: ["Parent vessel control (ICA/A1/M1)", "Perforator visualization", "Clip blade trajectory"],
            status: .keep, defectTags: [], notes: "Authentic intraoperative neurovascular corridor plate."
        ),
        ReviewPlateItem(
            id: "sa_pterional",
            imageName: "plate_pterional",
            title: "Pterional Frontotemporosphenoidal Corridor",
            category: "Surgical Atlas",
            clinicalContext: "Standard pterional craniotomy, sphenoid ridge flattening to meningo-orbital band.",
            anatomicalChecklist: ["Frontal boss bone removal", "Sphenoid ridge flushness", "Sylvian fissure exposure"],
            status: .keep, defectTags: [], notes: "Core cranial operative corridor."
        ),
        ReviewPlateItem(
            id: "sa_retrosigmoid",
            imageName: "plate_retrosigmoid",
            title: "Retrosigmoid CPA Dissection",
            category: "Surgical Atlas",
            clinicalContext: "Retromastoid craniectomy exposing transverse-sigmoid junction and CN VII/VIII.",
            anatomicalChecklist: ["Sinus edge margins", "Petrosal vein (Dandy)", "Acousticofacial bundle"],
            status: .keep, defectTags: [], notes: "CPA operative corridor."
        ),
        ReviewPlateItem(
            id: "sa_endonasal_sellar",
            imageName: "plate_endonasal_sellar",
            title: "Endoscopic Endonasal Sellar Corridor",
            category: "Surgical Atlas",
            clinicalContext: "Transsphenoidal binostril approach, carotid protuberances, medial OCR, sellar floor.",
            anatomicalChecklist: ["Carotid siphon prominences", "Optico-carotid recess (OCR)", "Sellar dural exposure"],
            status: .keep, defectTags: [], notes: "Skull base transsphenoidal corridor."
        ),
        ReviewPlateItem(
            id: "sa_far_lateral",
            imageName: "plate_far_lateral",
            title: "Far-Lateral Suboccipital Transcondylar Approach",
            category: "Surgical Atlas",
            clinicalContext: "Suboccipital craniectomy, C1 lateral mass unroofed foramen transversarium, mobilized V3 vertebral artery loop, trimmed C2 superior edge.",
            anatomicalChecklist: ["Unroofed C1 foramen transversarium", "Mobilized V3 vertebral artery loop", "C2 nerve root relationship", "Trimmed C2 superior edge", "Dural exposure without incision line"],
            status: .keep, defectTags: [], notes: "Approved Plate A.248 schematic with mobilized vertebral artery."
        ),
        ReviewPlateItem(
            id: "sa_hemicraniectomy",
            imageName: "plate_hemicraniectomy",
            title: "Decompressive Hemicraniectomy & Expansile Duroplasty",
            category: "Surgical Atlas",
            clinicalContext: "Massive >=12x15 cm frontotemporoparietal bone removal flush to middle fossa floor with expansile patch duroplasty and perimeter hitch sutures.",
            anatomicalChecklist: ["Expansile tension-free patch duroplasty", "Herniating edematous hemisphere", "Flush middle fossa floor decompression", "Perimeter dural hitch sutures"],
            status: .keep, defectTags: [], notes: "Approved decompressive hemicraniectomy operative plate."
        ),
        ReviewPlateItem(
            id: "sa_kochers_evd",
            imageName: "plate_kochers_evd",
            title: "Frontal Burr Hole / Kocher's Point EVD Ventriculostomy",
            category: "Surgical Atlas",
            clinicalContext: "Right frontal Kocher's point burr hole, lateral C-shaped ventricle, catheter seating at Foramen of Monro (5.5 cm depth) aligned with tragus.",
            anatomicalChecklist: ["Kocher's point pre-coronal coordinates", "Catheter perpendicular entry", "Foramen of Monro seating anterior to choroid plexus", "Tragus trajectory line"],
            status: .keep, defectTags: [], notes: "Approved Kocher's point EVD ventriculostomy lateral projection plate."
        ),
        
        // MARK: - 2. 2 AM Crisis Head CTs (4 plates)
        ReviewPlateItem(
            id: "cr_edh",
            imageName: "plate_ct_edh",
            title: "Acute Epidural Hematoma (EDH)",
            category: "2 AM Crisis CT",
            clinicalContext: "High-contrast axial CT, biconvex lenticular arterial hematoma, suture restriction.",
            anatomicalChecklist: ["Biconvex hyperdense shape", "Does not cross sutures", "Anterior/Posterior orientation"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "cr_sdh",
            imageName: "plate_ct_sdh",
            title: "Acute Subdural Hematoma (SDH)",
            category: "2 AM Crisis CT",
            clinicalContext: "High-contrast axial CT, crescentic bridging vein bleed crossing cranial suture lines.",
            anatomicalChecklist: ["Crescentic shape", "Crosses suture lines", "Sulcal effacement"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "cr_uncal",
            imageName: "plate_ct_uncal",
            title: "Acute Uncal Herniation",
            category: "2 AM Crisis CT",
            clinicalContext: "Medial temporal uncal herniation over tentorial incisura compressing midbrain.",
            anatomicalChecklist: ["Uncus is ANTERIOR (not posterior)", "Ipsilateral ambient cistern effacement", "Cerebral peduncle distortion"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "cr_post_fossa",
            imageName: "plate_ct_post_fossa",
            title: "Posterior Fossa Cerebellar ICH",
            category: "2 AM Crisis CT",
            clinicalContext: "Large cerebellar hematoma compressing 4th ventricle with acute obstructive hydrocephalus.",
            anatomicalChecklist: ["Clear cerebellar hematoma visible", "4th ventricle compression", "Dorsal brainstem distortion"],
            status: .undecided, defectTags: [], notes: ""
        ),
        
        // MARK: - 3. Frontline ER Consults Suite (9 plates)
        ReviewPlateItem(
            id: "er_sah",
            imageName: "plate_cranial_sah_aneurysm",
            title: "Aneurysmal Subarachnoid Hemorrhage (SAH)",
            category: "Frontline ER Consults",
            clinicalContext: "High-contrast CTA showing ruptured anterior communicating / MCA bifurcation aneurysm.",
            anatomicalChecklist: ["Hyperdense blood in basal cisterns", "Aneurysm dome and parent vessel", "Ventricular horn blood"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_ich_lobar",
            imageName: "plate_cranial_ich_lobar",
            title: "Hypertensive Lobar / Basal Ganglia ICH",
            category: "Frontline ER Consults",
            clinicalContext: "Axial CT demonstrating putaminal/thalamic hemorrhage with internal capsule effacement.",
            anatomicalChecklist: ["Deep nuclear/lobar parenchymal bleed", "Perilesional edema halo", "Ventricular extension (IVH)"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_vp_shunt",
            imageName: "plate_cranial_vp_shunt",
            title: "VP Shunt Valve & Ventricular Catheter",
            category: "Frontline ER Consults",
            clinicalContext: "Radiographic shunt series showing programmable valve setting and catheter trajectory.",
            anatomicalChecklist: ["Ventricular catheter tip at Monro", "Flushing valve reservoir", "Distal peritoneal tubing intact"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_shunt_prox_distal",
            imageName: "plate_cranial_shunt_prox_distal",
            title: "Shunt Malfunction: Proximal vs Distal",
            category: "Frontline ER Consults",
            clinicalContext: "Ventricular catheter choroid occlusion vs distal pseudocyst with ventriculomegaly.",
            anatomicalChecklist: ["Ventriculomegaly (Evans index >0.3)", "Proximal slit ventricles vs hydrocephalus", "Distal pseudocyst radiograph"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_jumped_facets",
            imageName: "plate_spine_jumped_facets",
            title: "Bilateral Jumped Cervical Facets",
            category: "Frontline ER Consults",
            clinicalContext: "Sagittal CT/MRI showing inferior articular process locked anterior to superior facet.",
            anatomicalChecklist: ["Facet dislocation / locking", "Anterior listhesis >50%", "Thecal sac pinch / disc herniation"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_tumor_compression",
            imageName: "plate_spine_tumor_compression",
            title: "Metastatic Epidural Spinal Cord Compression",
            category: "Frontline ER Consults",
            clinicalContext: "Sagittal T2 MRI showing vertebral body collapse, epidural mass, Bilsky grade 3.",
            anatomicalChecklist: ["Ventral epidural tumor component", "Effacement of T2 CSF sleeve", "Cord myelomalacia signal"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_burst_fracture",
            imageName: "plate_spine_burst_fracture",
            title: "Thoracolumbar Burst Fracture with Retropulsion",
            category: "Frontline ER Consults",
            clinicalContext: "Axial/Sagittal CT of L1 burst fracture with retropulsed fragment occupying >50% canal.",
            anatomicalChecklist: ["Posterior superior cortex fragment", "Canal compromise percentage", "Interpedicular widening"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_cauda_equina",
            imageName: "plate_spine_cauda_equina",
            title: "Cauda Equina Compression Central Herniation",
            category: "Frontline ER Consults",
            clinicalContext: "Axial T2 MRI showing massive extruded central lumbar disc obliterating thecal sac.",
            anatomicalChecklist: ["Massive central disc sequestration", "Complete thecal sac obliteration", "Compressed cauda equina rootlets"],
            status: .undecided, defectTags: [], notes: ""
        ),
        ReviewPlateItem(
            id: "er_csf_leak",
            imageName: "plate_spine_csf_leak",
            title: "Postoperative Spine Pseudomeningocele / CSF Leak",
            category: "Frontline ER Consults",
            clinicalContext: "Sagittal/Axial T2 MRI revealing subfascial fluid collection continuous with dural tear.",
            anatomicalChecklist: ["Subfascial hyperintense fluid pocket", "Continuous with dural defect", "Rootlet entrapment in tear"],
            status: .undecided, defectTags: [], notes: ""
        )
    ]
}

// MARK: - Studio View
public struct AnatomicReviewStationView: View {
    @ObservedObject var auditManager = PlateAuditManager.shared
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCategory = "All"
    @State private var selectedPlateId: String = "sa_aneurysm"
    @State private var copiedReport = false
    @State private var showingReportSheet = false
    @State private var showingFullScreenZoom = false
    @State private var zoomScale: CGFloat = 1.0
    
    let categories = ["All", "Surgical Atlas", "2 AM Crisis CT", "Frontline ER Consults"]
    
    let availableTags = [
        "Vascular course incorrect",
        "Bone margins incorrect",
        "Orientation inverted",
        "Artifact / unwanted pins",
        "Needs Path A: Real Rhoton Photo",
        "Needs Path B: Authentic 3T MRI",
        "Needs Path B: Thin-Slice Bone CT"
    ]
    
    var filteredPlates: [ReviewPlateItem] {
        if selectedCategory == "All" {
            return auditManager.plates
        }
        return auditManager.plates.filter { $0.category == selectedCategory }
    }
    
    var currentPlate: ReviewPlateItem? {
        auditManager.plates.first(where: { $0.id == selectedPlateId }) ?? filteredPlates.first
    }
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress & KPI Header
                auditProgressHeader
                
                // Category Filter Pills
                categorySelectorBar
                
                // Main Plate Review Canvas
                if let plate = currentPlate {
                    ScrollView {
                        VStack(spacing: 16) {
                            // Plate Image Viewport with Deep Zoom
                            plateViewport(plate: plate)
                            
                            // Decision Decision Buttons (KEEP vs RECREATE)
                            decisionControlsBar(plate: plate)
                            
                            // Anatomical Reality Checklist Card
                            checklistCard(plate: plate)
                            
                            // Defect Tags Selector
                            defectTagsSelector(plate: plate)
                            
                            // Surgeon Notes Field
                            notesEditor(plate: plate)
                            
                            // Quick Navigation Carousel
                            bottomThumbnailsBar
                            
                            Spacer(minLength: 30)
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
            .background(Color(red: 0.08, green: 0.09, blue: 0.12))
            .navigationTitle("Anatomic Review Studio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 8) {
                        Button(action: {
                            showingReportSheet = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "list.bullet.clipboard.fill")
                                Text("View & Sync")
                            }
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ObsidianTheme.neonCyan)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(ObsidianTheme.neonCyan.opacity(0.15))
                            .cornerRadius(6)
                        }
                        
                        Button(action: {
                            let report = auditManager.generateAuditReportMarkdown()
                            UIPasteboard.general.string = report
                            copiedReport = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                copiedReport = false
                            }
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: copiedReport ? "checkmark.circle.fill" : "doc.on.doc.fill")
                                Text(copiedReport ? "Copied!" : "Copy")
                            }
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(copiedReport ? .green : .white.opacity(0.8))
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundColor(ObsidianTheme.neonAmber)
                }
            }
            .sheet(isPresented: $showingReportSheet) {
                AuditReportModalView(auditManager: auditManager)
            }
            .fullScreenCover(isPresented: $showingFullScreenZoom) {
                if let plate = currentPlate {
                    FullScreenPlateZoomModal(plate: plate)
                }
            }
        }
    }
    
    // MARK: - Progress & KPI Header
    private var auditProgressHeader: some View {
        Button(action: { showingReportSheet = true }) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text("ANATOMIC REALITY CHECK AUDIT")
                            .font(.system(size: 9, weight: .black))
                            .tracking(1.4)
                            .foregroundColor(ObsidianTheme.neonAmber)
                        Image(systemName: "list.bullet.clipboard.fill")
                            .font(.system(size: 10))
                            .foregroundColor(ObsidianTheme.neonCyan)
                    }
                    Text("\(auditManager.keepCount + auditManager.replaceCount) / \(auditManager.plates.count) Reviewed  •  Tap to View Report")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // KPI Badges
                HStack(spacing: 6) {
                    HStack(spacing: 3) {
                        Circle().fill(Color.green).frame(width: 7, height: 7)
                        Text("\(auditManager.keepCount) KEEP")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.12))
                    .cornerRadius(6)
                    
                    HStack(spacing: 3) {
                        Circle().fill(Color.red).frame(width: 7, height: 7)
                        Text("\(auditManager.replaceCount) RECREATE")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(Color.red.opacity(0.12))
                    .cornerRadius(6)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(ObsidianTheme.neonCyan)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(red: 0.12, green: 0.14, blue: 0.18))
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Category Selector
    private var categorySelectorBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories, id: \.self) { cat in
                    Button(action: {
                        selectedCategory = cat
                        if let first = filteredPlates.first {
                            selectedPlateId = first.id
                        }
                    }) {
                        Text(cat)
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedCategory == cat ? ObsidianTheme.neonCyan.opacity(0.25) : Color.white.opacity(0.06))
                            .foregroundColor(selectedCategory == cat ? ObsidianTheme.neonCyan : .gray)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(selectedCategory == cat ? ObsidianTheme.neonCyan : Color.clear, lineWidth: 1))
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
        }
        .background(Color(red: 0.10, green: 0.11, blue: 0.15))
    }
    
    // MARK: - Plate Viewport
    private func plateViewport(plate: ReviewPlateItem) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(plate.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text(plate.category.uppercased())
                    .font(.system(size: 9, weight: .black))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.1))
                    .foregroundColor(ObsidianTheme.neonAmber)
                    .cornerRadius(4)
            }
            .padding(.horizontal, 16)
            
            ZStack {
                ZoomablePlateImageView(
                    imageName: plate.imageName,
                    contentHeight: 290,
                    onExpand: {
                        showingFullScreenZoom = true
                    }
                )
                
                // Status Ribbon
                VStack {
                    HStack {
                        Spacer()
                        Text(plate.status.rawValue.uppercased())
                            .font(.system(size: 10, weight: .black))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(plate.status == .keep ? Color.green : (plate.status == .replace ? Color.red : Color.yellow))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                            .padding(10)
                    }
                    Spacer()
                }
                .allowsHitTesting(false)
            }
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.15), lineWidth: 1))
            .padding(.horizontal, 14)
        }
    }
    
    // MARK: - Decision Controls
    private func decisionControlsBar(plate: ReviewPlateItem) -> some View {
        HStack(spacing: 10) {
            Button(action: {
                HapticManager.impact(style: .medium)
                auditManager.updateStatus(id: plate.id, status: .keep)
                advanceToNextPlate()
            }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("KEEP (APPROVED)")
                }
                .font(.system(size: 12, weight: .black))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(plate.status == .keep ? Color.green : Color.green.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1.5))
            }
            
            Button(action: {
                HapticManager.impact(style: .heavy)
                auditManager.updateStatus(id: plate.id, status: .replace)
                advanceToNextPlate()
            }) {
                HStack {
                    Image(systemName: "xmark.octagon.fill")
                    Text("RECREATE (PATH A/B)")
                }
                .font(.system(size: 12, weight: .black))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(plate.status == .replace ? Color.red : Color.red.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1.5))
            }
        }
        .padding(.horizontal, 14)
    }
    
    // MARK: - Anatomical Reality Checklist
    private func checklistCard(plate: ReviewPlateItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(ObsidianTheme.neonCyan)
                Text("ANATOMIC REALITY CHECKLIST:")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(ObsidianTheme.neonCyan)
            }
            
            Text(plate.clinicalContext)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(Color.gray)
                .padding(.bottom, 2)
            
            ForEach(plate.anatomicalChecklist, id: \.self) { item in
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "circle.circle")
                        .font(.system(size: 10))
                        .foregroundColor(ObsidianTheme.neonAmber)
                        .padding(.top, 2)
                    Text(item)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.13, green: 0.15, blue: 0.20))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.08), lineWidth: 1))
        .padding(.horizontal, 14)
    }
    
    // MARK: - Defect Tags Selector
    private func defectTagsSelector(plate: ReviewPlateItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("QUICK DEFECT TAGS (IF RECREATING):")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(ObsidianTheme.neonRose)
            
            FlowLayout(spacing: 6) {
                ForEach(availableTags, id: \.self) { tag in
                    let isSelected = plate.defectTags.contains(tag)
                    Button(action: {
                        auditManager.toggleTag(id: plate.id, tag: tag)
                    }) {
                        Text(tag)
                            .font(.system(size: 10, weight: .semibold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(isSelected ? ObsidianTheme.neonRose : Color.white.opacity(0.08))
                            .foregroundColor(isSelected ? .white : .gray)
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(isSelected ? Color.white : Color.clear, lineWidth: 1))
                    }
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.13, green: 0.15, blue: 0.20))
        .cornerRadius(10)
        .padding(.horizontal, 14)
    }
    
    // MARK: - Notes Editor
    private func notesEditor(plate: ReviewPlateItem) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("ATTENDING / RESIDENT NOTES:")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(.gray)
            
            TextField("e.g. Needs cadaveric dissection showing V3 looping over C1 arch...", text: Binding(
                get: { plate.notes },
                set: { auditManager.updateNotes(id: plate.id, notes: $0) }
            ))
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(10)
            .background(Color.black.opacity(0.6))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.12), lineWidth: 1))
        }
        .padding(12)
        .background(Color(red: 0.13, green: 0.15, blue: 0.20))
        .cornerRadius(10)
        .padding(.horizontal, 14)
    }
    
    // MARK: - Bottom Thumbnails Bar
    private var bottomThumbnailsBar: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("QUICK JUMP CAROUSEL:")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(.gray)
                .padding(.horizontal, 14)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(filteredPlates) { item in
                        Button(action: {
                            selectedPlateId = item.id
                        }) {
                            VStack(spacing: 4) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 45)
                                    .clipped()
                                    .cornerRadius(6)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(selectedPlateId == item.id ? ObsidianTheme.neonCyan : Color.clear, lineWidth: 2))
                                
                                Circle()
                                    .fill(item.status == .keep ? Color.green : (item.status == .replace ? Color.red : Color.yellow))
                                    .frame(width: 6, height: 6)
                            }
                        }
                    }
                }
                .padding(.horizontal, 14)
            }
        }
    }
    
    private func advanceToNextPlate() {
        if let currentIdx = filteredPlates.firstIndex(where: { $0.id == selectedPlateId }),
           currentIdx + 1 < filteredPlates.count {
            selectedPlateId = filteredPlates[currentIdx + 1].id
        }
    }
}

// Simple FlowLayout for Tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 6
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 300
        var height: CGFloat = 0
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentX + size.width > width {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
        height = currentY + lineHeight
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentX = bounds.minX
        var currentY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentX + size.width > bounds.maxX {
                currentX = bounds.minX
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            subview.place(at: CGPoint(x: currentX, y: currentY), proposal: .unspecified)
            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }
}

// MARK: - Audit Report Modal View
public struct AuditReportModalView: View {
    @ObservedObject var auditManager: PlateAuditManager
    @Environment(\.dismiss) var dismiss
    
    @State private var syncStatus: String? = nil
    @State private var isSyncing: Bool = false
    @State private var copied: Bool = false
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header Summary Banner
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ANATOMIC AUDIT REPORT")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.5)
                            .foregroundColor(ObsidianTheme.neonAmber)
                        
                        Text("Trephine Plate Quality & Anatomic Review")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 8) {
                            HStack(spacing: 4) {
                                Circle().fill(Color.green).frame(width: 8, height: 8)
                                Text("\(auditManager.keepCount) Approved")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.green)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.green.opacity(0.12))
                            .cornerRadius(8)
                            
                            HStack(spacing: 4) {
                                Circle().fill(Color.red).frame(width: 8, height: 8)
                                Text("\(auditManager.replaceCount) Recreate")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.red)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.red.opacity(0.12))
                            .cornerRadius(8)
                            
                            HStack(spacing: 4) {
                                Circle().fill(Color.yellow).frame(width: 8, height: 8)
                                Text("\(auditManager.undecidedCount) Pending")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.yellow)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.yellow.opacity(0.12))
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.12, green: 0.14, blue: 0.18))
                    .cornerRadius(14)
                    
                    // 1-Tap Autonomous Sync to PC Action
                    VStack(spacing: 12) {
                        Button(action: syncAuditToPC) {
                            HStack(spacing: 8) {
                                if isSyncing {
                                    ProgressView()
                                        .tint(.black)
                                } else {
                                    Image(systemName: "antenna.radiowaves.left.and.right")
                                        .font(.system(size: 16, weight: .bold))
                                }
                                Text(isSyncing ? "Transmitting to PC..." : "⚡ Sync Audit Directly to Antigravity PC")
                                    .font(.system(size: 14, weight: .black))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(ObsidianTheme.neonCyan)
                            .cornerRadius(12)
                            .shadow(color: ObsidianTheme.neonCyan.opacity(0.3), radius: 8, y: 3)
                        }
                        .disabled(isSyncing)
                        
                        if let status = syncStatus {
                            Text(status)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(status.contains("✅") ? .green : .red)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                UIPasteboard.general.string = auditManager.generateAuditReportMarkdown()
                                copied = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { copied = false }
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: copied ? "checkmark.circle.fill" : "doc.on.doc.fill")
                                    Text(copied ? "Copied!" : "Copy Markdown")
                                }
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.white.opacity(0.08))
                                .cornerRadius(8)
                            }
                            
                            ShareLink(item: auditManager.generateAuditReportMarkdown()) {
                                HStack(spacing: 6) {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share Report")
                                }
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.white.opacity(0.08))
                                .cornerRadius(8)
                            }
                        }
                    }
                    
                    // Detailed List of All Plates by Category
                    VStack(alignment: .leading, spacing: 16) {
                        Text("DETAILED PLATE BREAKDOWN")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.4)
                            .foregroundColor(ObsidianTheme.neonAmber)
                        
                        let categories = ["Surgical Atlas", "2 AM Crisis CT", "Frontline ER Consults"]
                        ForEach(categories, id: \.self) { cat in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(cat.uppercased())
                                    .font(.system(size: 12, weight: .heavy))
                                    .foregroundColor(ObsidianTheme.neonCyan)
                                    .padding(.top, 4)
                                
                                let catPlates = auditManager.plates.filter { $0.category == cat }
                                ForEach(catPlates) { plate in
                                    HStack(alignment: .top, spacing: 10) {
                                        Circle()
                                            .fill(plate.status == .keep ? Color.green : (plate.status == .replace ? Color.red : Color.yellow))
                                            .frame(width: 8, height: 8)
                                            .padding(.top, 5)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            HStack {
                                                Text(plate.title)
                                                    .font(.system(size: 13, weight: .bold))
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text(plate.status.rawValue)
                                                    .font(.system(size: 10, weight: .bold))
                                                    .foregroundColor(plate.status == .keep ? .green : (plate.status == .replace ? .red : .yellow))
                                            }
                                            
                                            if !plate.defectTags.isEmpty {
                                                Text("Defects: " + plate.defectTags.joined(separator: ", "))
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.red.opacity(0.85))
                                            }
                                            
                                            if !plate.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                                Text("Attending Note: \(plate.notes)")
                                                    .font(.system(size: 11, weight: .medium))
                                                    .foregroundColor(ObsidianTheme.neonAmber)
                                            }
                                        }
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(Color(red: 0.10, green: 0.12, blue: 0.16))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(red: 0.08, green: 0.09, blue: 0.12))
            .navigationTitle("Audit Summary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundColor(ObsidianTheme.neonAmber)
                }
            }
        }
    }
    
    private func syncAuditToPC() {
        isSyncing = true
        syncStatus = nil
        
        let report = auditManager.generateAuditReportMarkdown()
        guard let data = report.data(using: .utf8) else {
            isSyncing = false
            syncStatus = "❌ Encoding Error"
            return
        }
        
        // Try candidate endpoints: current Wi-Fi IP, secondary IP, then Cloudflare Edge Relay
        let endpoints = [
            "http://192.168.4.42:7788/upload",
            "http://192.168.6.120:7788/upload",
            "https://screendrop-relay.mohalex.workers.dev/upload?token=alex-screendrop-2026"
        ]
        
        func trySend(index: Int) {
            guard index < endpoints.count else {
                DispatchQueue.main.async {
                    self.isSyncing = false
                    self.syncStatus = "⚠️ Offline: Copied to Clipboard instead!"
                    UIPasteboard.general.string = report
                }
                return
            }
            
            guard let url = URL(string: endpoints[index]) else {
                trySend(index: index + 1)
                return
            }
            
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.setValue("text/plain", forHTTPHeaderField: "Content-Type")
            if url.host?.contains("workers.dev") == true {
                req.setValue("alex-screendrop-2026", forHTTPHeaderField: "X-Auth-Token")
            }
            req.httpBody = data
            req.timeoutInterval = 3
            
            URLSession.shared.dataTask(with: req) { _, response, _ in
                if let http = response as? HTTPURLResponse, http.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.isSyncing = false
                        let label = url.host?.contains("workers.dev") == true ? "Cloudflare Edge Relay" : "Wi-Fi (Port 7788)"
                        self.syncStatus = "✅ Transmitted to Antigravity PC via \(label)!"
                    }
                } else {
                    trySend(index: index + 1)
                }
            }.resume()
        }
        
        trySend(index: 0)
    }
}

// MARK: - Interactive Two-Finger Pinch-to-Zoom & Pan Component
public struct ZoomablePlateImageView: View {
    public let imageName: String
    public var contentHeight: CGFloat = 290
    public var onExpand: (() -> Void)? = nil
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    public init(imageName: String, contentHeight: CGFloat = 290, onExpand: (() -> Void)? = nil) {
        self.imageName = imageName
        self.contentHeight = contentHeight
        self.onExpand = onExpand
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let delta = value / lastScale
                                    lastScale = value
                                    let newScale = scale * delta
                                    scale = min(max(newScale, 1.0), 5.0)
                                }
                                .onEnded { _ in
                                    lastScale = 1.0
                                    if scale < 1.05 {
                                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                            scale = 1.0
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    }
                                },
                            DragGesture()
                                .onChanged { val in
                                    if scale > 1.05 {
                                        offset = CGSize(
                                            width: lastOffset.width + val.translation.width,
                                            height: lastOffset.height + val.translation.height
                                        )
                                    }
                                }
                                .onEnded { _ in
                                    lastOffset = offset
                                    if scale <= 1.05 {
                                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    }
                                }
                        )
                    )
                    .onTapGesture(count: 2) {
                        HapticManager.impact(style: .medium)
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            if scale > 1.1 {
                                scale = 1.0
                                offset = .zero
                                lastOffset = .zero
                            } else {
                                scale = 2.5
                            }
                        }
                    }
                
                // Overlay controls
                VStack {
                    HStack {
                        if scale > 1.05 {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                    .font(.system(size: 9))
                                Text(String(format: "%.1fx ZOOM", scale))
                                    .font(.system(size: 9, weight: .heavy, design: .monospaced))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.black.opacity(0.85))
                            .foregroundColor(ObsidianTheme.neonAmber)
                            .cornerRadius(4)
                        } else {
                            HStack(spacing: 4) {
                                Image(systemName: "hand.pinch")
                                    .font(.system(size: 9))
                                Text("PINCH TO ZOOM")
                                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(Color.white.opacity(0.7))
                            .cornerRadius(4)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 6) {
                            if scale > 1.05 {
                                Button(action: {
                                    HapticManager.impact(style: .light)
                                    withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                        scale = 1.0
                                        lastScale = 1.0
                                        offset = .zero
                                        lastOffset = .zero
                                    }
                                }) {
                                    Image(systemName: "arrow.counterclockwise")
                                        .font(.system(size: 11, weight: .bold))
                                        .padding(6)
                                        .background(Color.black.opacity(0.85))
                                        .foregroundColor(ObsidianTheme.neonCyan)
                                        .clipShape(Circle())
                                }
                            }
                            
                            if let onExpand = onExpand {
                                Button(action: {
                                    HapticManager.impact(style: .medium)
                                    onExpand()
                                }) {
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                                        .font(.system(size: 11, weight: .bold))
                                        .padding(6)
                                        .background(Color.black.opacity(0.85))
                                        .foregroundColor(ObsidianTheme.neonCyan)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    .padding(8)
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(height: contentHeight)
    }
}

// MARK: - Full Screen Plate Zoom Modal
public struct FullScreenPlateZoomModal: View {
    public let plate: ReviewPlateItem
    @Environment(\.dismiss) var dismiss
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    public init(plate: ReviewPlateItem) {
        self.plate = plate
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            GeometryReader { geo in
                Image(plate.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
                            MagnificationGesture()
                                .onChanged { val in
                                    let delta = val / lastScale
                                    lastScale = val
                                    let newScale = scale * delta
                                    scale = min(max(newScale, 1.0), 6.0)
                                }
                                .onEnded { _ in
                                    lastScale = 1.0
                                    if scale < 1.05 {
                                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                            scale = 1.0
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    }
                                },
                            DragGesture()
                                .onChanged { val in
                                    if scale > 1.05 {
                                        offset = CGSize(
                                            width: lastOffset.width + val.translation.width,
                                            height: lastOffset.height + val.translation.height
                                        )
                                    }
                                }
                                .onEnded { _ in
                                    lastOffset = offset
                                    if scale <= 1.05 {
                                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    }
                                }
                        )
                    )
                    .onTapGesture(count: 2) {
                        HapticManager.impact(style: .medium)
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            if scale > 1.1 {
                                scale = 1.0
                                offset = .zero
                                lastOffset = .zero
                            } else {
                                scale = 3.0
                            }
                        }
                    }
            }
            
            // Top Bar
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(plate.title)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                        Text(scale > 1.05 ? String(format: "%.1fx Zoom • Two-Finger Pinch / Pan", scale) : "Two-finger pinch to zoom • Double-tap to expand")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundColor(scale > 1.05 ? ObsidianTheme.neonAmber : Color.white.opacity(0.6))
                    }
                    
                    Spacer()
                    
                    if scale > 1.05 {
                        Button(action: {
                            HapticManager.impact(style: .light)
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                scale = 1.0
                                lastScale = 1.0
                                offset = .zero
                                lastOffset = .zero
                            }
                        }) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(ObsidianTheme.neonCyan)
                                .padding(8)
                                .background(Color.white.opacity(0.15))
                                .clipShape(Circle())
                        }
                    }
                    
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(ObsidianTheme.neonAmber)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(8)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .background(Color.black.opacity(0.75))
                
                Spacer()
            }
        }
    }
}
