import SwiftUI
import SceneKit

// MARK: - Neurosurgical Spatial 3D Engine (Option B)
// Native Apple SceneKit 3D Interactive Cranial & Spinal Simulator
// Delivers real 360° rotational orbit, PBR bone shading, sutural landmarks,
// craniotomy flap cutouts, burr holes, and surgical trajectory vectors.

public struct NeurosurgicalSpatial3DView: View {
    @State private var selectedModel: SpatialModelType = .cranium
    @State private var selectedApproach: SurgicalApproachPreset = .pterional
    @State private var boneOpacity: Float = 1.0
    @State private var showSutures: Bool = true
    @State private var showVascular: Bool = true
    @State private var showCraniotomyFlap: Bool = true
    @State private var showHotspots: Bool = true
    @State private var showTrajectoryRays: Bool = true
    @State private var activePin: SpatialAnatomicalPin? = nil
    @State private var cameraPreset: CameraPreset = .anterolateral
    
    // SceneKit State
    @State private var scene: SCNScene = SCNScene()
    @State private var cameraNode: SCNNode = SCNNode()
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // 3D Viewport Header
            viewportHeader
            
            // The 3D SceneKit Viewport
            ZStack {
                SceneKitContainerView(
                    scene: scene,
                    cameraNode: cameraNode,
                    selectedModel: selectedModel,
                    selectedApproach: selectedApproach,
                    boneOpacity: boneOpacity,
                    showSutures: showSutures,
                    showVascular: showVascular,
                    showCraniotomyFlap: showCraniotomyFlap,
                    showHotspots: showHotspots,
                    showTrajectoryRays: showTrajectoryRays,
                    onSelectPin: { pin in
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            activePin = pin
                        }
                    }
                )
                .background(Color(hex: "080B10"))
                .ignoresSafeArea(edges: .horizontal)
                
                // HUD Compass & 3D Gizmo Badge
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Circle().fill(ObsidianTheme.neonCyan).frame(width: 8, height: 8)
                                Text("SCENEKIT 3D SPATIAL ENGINE")
                                    .font(.system(size: 10, weight: .black))
                                    .tracking(1.5)
                                    .foregroundColor(ObsidianTheme.neonCyan)
                            }
                            Text(selectedModel.displayName)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(ObsidianTheme.textPrimary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(ObsidianTheme.vitreousGlass)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
                        
                        Spacer()
                        
                        // Camera Preset Quick Buttons
                        HStack(spacing: 6) {
                            ForEach(CameraPreset.presets(for: selectedModel), id: \.self) { preset in
                                Button(action: {
                                    HapticManager.impact(style: .light)
                                    cameraPreset = preset
                                    animateCamera(to: preset)
                                }) {
                                    Text(preset.shortName)
                                        .font(.system(size: 10, weight: .bold))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 6)
                                        .background(cameraPreset == preset ? ObsidianTheme.neonCyan.opacity(0.25) : ObsidianTheme.vitreousGlass)
                                        .foregroundColor(cameraPreset == preset ? ObsidianTheme.neonCyan : ObsidianTheme.textSecondary)
                                        .cornerRadius(8)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(cameraPreset == preset ? ObsidianTheme.neonCyan : ObsidianTheme.borderSubtle, lineWidth: 1))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Selected Pin Tactical Popover HUD
                    if let pin = activePin {
                        tacticalPinCard(pin: pin)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.horizontal, 14)
                            .padding(.bottom, 10)
                    }
                }
            }
            .frame(height: 380)
            
            // Cockpit Controls Tray
            controlsTray
        }
        .background(ObsidianTheme.surfaceVoid)
        .onAppear {
            setup3DScene()
        }
        .onChange(of: selectedModel) { _, _ in
            setup3DScene()
            activePin = nil
        }
        .onChange(of: selectedApproach) { _, _ in
            setup3DScene()
        }
        .onChange(of: boneOpacity) { _, _ in
            updateMaterialOpacity()
        }
        .onChange(of: showSutures) { _, _ in
            toggleLayer(name: "sutures", isVisible: showSutures)
        }
        .onChange(of: showVascular) { _, _ in
            toggleLayer(name: "vascular", isVisible: showVascular)
        }
        .onChange(of: showCraniotomyFlap) { _, _ in
            toggleLayer(name: "craniotomy_flap", isVisible: showCraniotomyFlap)
        }
        .onChange(of: showHotspots) { _, _ in
            toggleLayer(name: "hotspots", isVisible: showHotspots)
        }
        .onChange(of: showTrajectoryRays) { _, _ in
            toggleLayer(name: "trajectories", isVisible: showTrajectoryRays)
        }
    }
    
    // MARK: - Header
    private var viewportHeader: some View {
        HStack {
            // Model Selector (Cranium vs Cervical vs Lumbar)
            Picker("Model", selection: $selectedModel) {
                ForEach(SpatialModelType.allCases, id: \.self) { model in
                    Text(model.displayName).tag(model)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
        }
        .background(ObsidianTheme.surfaceElevated)
    }
    
    // MARK: - Controls Tray
    private var controlsTray: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Approach Preset Selector
                VStack(alignment: .leading, spacing: 8) {
                    Text("SURGICAL APPROACH CORRIDOR")
                        .font(.system(size: 10, weight: .black))
                        .tracking(1.5)
                        .foregroundColor(ObsidianTheme.neonCyan)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(SurgicalApproachPreset.presets(for: selectedModel), id: \.self) { approach in
                                Button(action: {
                                    HapticManager.impact(style: .medium)
                                    selectedApproach = approach
                                    setup3DScene()
                                    if let firstPin = approach.associatedPins.first {
                                        activePin = firstPin
                                    }
                                }) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(approach.title)
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(selectedApproach == approach ? ObsidianTheme.neonCyan : ObsidianTheme.textPrimary)
                                        Text(approach.subtitle)
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundColor(ObsidianTheme.textMuted)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedApproach == approach ? ObsidianTheme.neonCyan.opacity(0.18) : ObsidianTheme.vitreousGlass)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedApproach == approach ? ObsidianTheme.neonCyan : ObsidianTheme.borderSubtle, lineWidth: 1.5))
                                }
                            }
                        }
                    }
                }
                
                // Bone Opacity & Layer Toggles
                VStack(spacing: 12) {
                    // Opacity Slider
                    HStack {
                        Image(systemName: "circle.lefthalf.filled")
                            .font(.system(size: 12))
                            .foregroundColor(ObsidianTheme.neonAmber)
                        Text("Bone Opacity:")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ObsidianTheme.textSecondary)
                        Spacer()
                        Text("\(Int(boneOpacity * 100))%")
                            .font(.system(size: 12, weight: .heavy))
                            .foregroundColor(ObsidianTheme.neonAmber)
                    }
                    
                    Slider(value: Binding(
                        get: { Double(boneOpacity) },
                        set: { boneOpacity = Float($0) }
                    ), in: 0.15...1.0)
                    .tint(ObsidianTheme.neonAmber)
                    
                    // Quick Layer Toggles
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        layerToggleButton(title: "Sutural Landmarks", icon: "pencil.line", isOn: $showSutures, color: ObsidianTheme.neonCyan)
                        layerToggleButton(title: "Vascular Conduits", icon: "waveform.path.ecg", isOn: $showVascular, color: ObsidianTheme.neonRose)
                        layerToggleButton(title: "Craniotomy Flap", icon: "square.dashed", isOn: $showCraniotomyFlap, color: ObsidianTheme.neonAmber)
                        layerToggleButton(title: "Landmark Hotspots", icon: "mappin.and.ellipse", isOn: $showHotspots, color: ObsidianTheme.neonPurple)
                    }
                }
                .padding(14)
                .background(ObsidianTheme.surfaceElevated)
                .cornerRadius(14)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
                
                // Approach Tactical Specs
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "cross.case.fill")
                            .font(.system(size: 12))
                            .foregroundColor(ObsidianTheme.neonGreen)
                        Text("OPERATIONAL SURGICAL PROTOCOL")
                            .font(.system(size: 10, weight: .black))
                            .tracking(1.5)
                            .foregroundColor(ObsidianTheme.neonGreen)
                    }
                    
                    Text(selectedApproach.protocolTitle)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(ObsidianTheme.textPrimary)
                    
                    Text(selectedApproach.protocolDescription)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(ObsidianTheme.textSecondary)
                        .lineSpacing(3)
                    
                    // Pitfalls and Danger Zones
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 11))
                                .foregroundColor(ObsidianTheme.neonRose)
                            Text("DANGER ZONES & AVOIDANCE:")
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(ObsidianTheme.neonRose)
                        }
                        
                        ForEach(selectedApproach.dangerPoints, id: \.self) { danger in
                            HStack(alignment: .top, spacing: 6) {
                                Circle().fill(ObsidianTheme.neonRose).frame(width: 4, height: 4).padding(.top, 5)
                                Text(danger)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(ObsidianTheme.textSecondary)
                            }
                        }
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ObsidianTheme.neonRose.opacity(0.08))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(ObsidianTheme.neonRose.opacity(0.25), lineWidth: 1))
                }
                .padding(14)
                .background(ObsidianTheme.surfaceElevated)
                .cornerRadius(14)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
            }
            .padding(14)
            .padding(.bottom, 30)
        }
    }
    
    // MARK: - Tactical Pin HUD Card
    private func tacticalPinCard(pin: SpatialAnatomicalPin) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Circle().fill(pin.color).frame(width: 8, height: 8)
                Text(pin.name)
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundColor(ObsidianTheme.textPrimary)
                Spacer()
                Text(pin.typeTag)
                    .font(.system(size: 9, weight: .black))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(pin.color.opacity(0.2))
                    .foregroundColor(pin.color)
                    .cornerRadius(4)
                
                Button(action: {
                    withAnimation { activePin = nil }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(ObsidianTheme.textMuted)
                }
            }
            
            Text(pin.coordinatesFormula)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(ObsidianTheme.neonCyan)
            
            Text(pin.clinicalSignificance)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(ObsidianTheme.textSecondary)
                .lineLimit(2)
        }
        .padding(10)
        .background(ObsidianTheme.surfaceElevated.opacity(0.95))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(pin.color.opacity(0.6), lineWidth: 1.5))
        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
    }
    
    private func layerToggleButton(title: String, icon: String, isOn: Binding<Bool>, color: Color) -> some View {
        Button(action: {
            HapticManager.impact(style: .light)
            isOn.wrappedValue.toggle()
        }) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 11))
                    .foregroundColor(isOn.wrappedValue ? color : ObsidianTheme.textMuted)
                Text(title)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(isOn.wrappedValue ? ObsidianTheme.textPrimary : ObsidianTheme.textMuted)
                Spacer()
                Circle()
                    .fill(isOn.wrappedValue ? color : Color.gray.opacity(0.3))
                    .frame(width: 6, height: 6)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(isOn.wrappedValue ? color.opacity(0.12) : ObsidianTheme.surfaceVoid)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(isOn.wrappedValue ? color.opacity(0.4) : ObsidianTheme.borderSubtle, lineWidth: 1))
        }
    }
    
    // MARK: - SceneKit Generation Logic
    private func setup3DScene() {
        let newScene = SCNScene()
        
        // 1. Camera Node
        let camera = SCNCamera()
        camera.zNear = 0.1
        camera.zFar = 100.0
        camera.fieldOfView = 50
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 7.5)
        newScene.rootNode.addChildNode(cameraNode)
        
        // 2. Realistic Studio Lighting
        // Key Directional Light (Soft Warm Sun)
        let keyLight = SCNLight()
        keyLight.type = .directional
        keyLight.intensity = 1000
        keyLight.color = UIColor(red: 1.0, green: 0.98, blue: 0.94, alpha: 1.0)
        let keyNode = SCNNode()
        keyNode.light = keyLight
        keyNode.eulerAngles = SCNVector3(x: -0.6, y: 0.8, z: 0)
        newScene.rootNode.addChildNode(keyNode)
        
        // Fill Directional Light (Cool Sky Blue)
        let fillLight = SCNLight()
        fillLight.type = .directional
        fillLight.intensity = 550
        fillLight.color = UIColor(red: 0.82, green: 0.90, blue: 1.0, alpha: 1.0)
        let fillNode = SCNNode()
        fillNode.light = fillLight
        fillNode.eulerAngles = SCNVector3(x: 0.4, y: -0.9, z: 0)
        newScene.rootNode.addChildNode(fillNode)
        
        // Ambient Light (Dark Cockpit Shadow)
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.intensity = 350
        ambientLight.color = UIColor(red: 0.15, green: 0.18, blue: 0.22, alpha: 1.0)
        let ambientNode = SCNNode()
        ambientNode.light = ambientLight
        newScene.rootNode.addChildNode(ambientNode)
        
        // 3. Build Anatomical Model Hierarchy
        switch selectedModel {
        case .cranium:
            buildCranialModel(in: newScene)
        case .cervicalSpine:
            buildCervicalSpineModel(in: newScene)
        case .lumbarSpine:
            buildLumbarSpineModel(in: newScene)
        }
        
        self.scene = newScene
    }
    
    // MARK: - Cranium Model Generator
    private func buildCranialModel(in scene: SCNScene) {
        let craniumRoot = SCNNode()
        craniumRoot.name = "model_root"
        
        // A. Calvaria Vault Dome (Ellipsoid Bone Geometry)
        let calvariaGeo = SCNSphere(radius: 2.1)
        calvariaGeo.segmentCount = 64
        
        let boneMaterial = SCNMaterial()
        boneMaterial.name = "bone_material"
        boneMaterial.diffuse.contents = UIColor(red: 0.89, green: 0.84, blue: 0.74, alpha: CGFloat(boneOpacity))
        boneMaterial.roughness.contents = 0.55
        boneMaterial.metalness.contents = 0.05
        boneMaterial.specular.contents = UIColor(white: 0.35, alpha: 1.0)
        calvariaGeo.materials = [boneMaterial]
        
        let calvariaNode = SCNNode(geometry: calvariaGeo)
        calvariaNode.name = "calvaria_node"
        calvariaNode.scale = SCNVector3(x: 0.88, y: 1.05, z: 1.15) // Anatomical cranial proportions
        calvariaNode.position = SCNVector3(x: 0, y: 0.3, z: 0)
        craniumRoot.addChildNode(calvariaNode)
        
        // B. Facial Skeleton & Skull Base (Orbit, Zygoma, Maxilla, Mandible)
        buildFacialSkeleton(parent: craniumRoot, boneMaterial: boneMaterial)
        
        // C. Sutural Lines (Coronal, Sagittal, Squamosal, Lambdoid)
        let suturesNode = SCNNode()
        suturesNode.name = "sutures"
        buildCranialSutures(parent: suturesNode)
        suturesNode.isHidden = !showSutures
        craniumRoot.addChildNode(suturesNode)
        
        // D. Vascular Conduits (Middle Meningeal Artery & Transverse/Sigmoid Sinus)
        let vascularNode = SCNNode()
        vascularNode.name = "vascular"
        buildCranialVessels(parent: vascularNode)
        vascularNode.isHidden = !showVascular
        craniumRoot.addChildNode(vascularNode)
        
        // E. Craniotomy Bone Flap & Trephine Burr Holes
        let flapNode = SCNNode()
        flapNode.name = "craniotomy_flap"
        buildCraniotomyFlap(approach: selectedApproach, parent: flapNode)
        flapNode.isHidden = !showCraniotomyFlap
        craniumRoot.addChildNode(flapNode)
        
        // F. Anatomical Landmark Hotspot Pins
        let hotspotsNode = SCNNode()
        hotspotsNode.name = "hotspots"
        for pin in selectedApproach.associatedPins {
            buildHotspotPinNode(pin: pin, parent: hotspotsNode)
        }
        hotspotsNode.isHidden = !showHotspots
        craniumRoot.addChildNode(hotspotsNode)
        
        // G. Surgical Trajectory Rays (e.g. EVD Kocher's point ray to Monro)
        let trajNode = SCNNode()
        trajNode.name = "trajectories"
        buildTrajectoryRays(approach: selectedApproach, parent: trajNode)
        trajNode.isHidden = !showTrajectoryRays
        craniumRoot.addChildNode(trajNode)
        
        scene.rootNode.addChildNode(craniumRoot)
    }
    
    // MARK: - Facial Skeleton Builder
    private func buildFacialSkeleton(parent: SCNNode, boneMaterial: SCNMaterial) {
        // Zygomatic Arches (Bilateral)
        for side: Float in [-1.0, 1.0] {
            let zygomaGeo = SCNCylinder(radius: 0.12, height: 1.4)
            zygomaGeo.materials = [boneMaterial]
            let zygomaNode = SCNNode(geometry: zygomaGeo)
            zygomaNode.position = SCNVector3(x: side * 1.6, y: -0.4, z: 0.6)
            zygomaNode.eulerAngles = SCNVector3(x: 0.3, y: side * 0.2, z: side * 0.7)
            parent.addChildNode(zygomaNode)
            
            // Orbit Rim (Supraorbital & Infraorbital)
            let orbitGeo = SCNTorus(ringRadius: 0.42, pipeRadius: 0.08)
            orbitGeo.materials = [boneMaterial]
            let orbitNode = SCNNode(geometry: orbitGeo)
            orbitNode.position = SCNVector3(x: side * 0.72, y: -0.2, z: 1.35)
            orbitNode.eulerAngles = SCNVector3(x: 1.45, y: 0, z: side * 0.15)
            parent.addChildNode(orbitNode)
        }
        
        // Maxilla / Nasal Bone Bridge
        let nasalGeo = SCNBox(width: 0.4, height: 0.8, length: 0.3, chamferRadius: 0.08)
        nasalGeo.materials = [boneMaterial]
        let nasalNode = SCNNode(geometry: nasalGeo)
        nasalNode.position = SCNVector3(x: 0, y: -0.35, z: 1.4)
        parent.addChildNode(nasalNode)
        
        // Mandible Base Contour
        let mandibleGeo = SCNTorus(ringRadius: 1.1, pipeRadius: 0.14)
        mandibleGeo.materials = [boneMaterial]
        let mandibleNode = SCNNode(geometry: mandibleGeo)
        mandibleNode.position = SCNVector3(x: 0, y: -1.4, z: 0.4)
        mandibleNode.scale = SCNVector3(x: 1.0, y: 0.5, z: 1.2)
        parent.addChildNode(mandibleNode)
    }
    
    // MARK: - Cranial Sutures
    private func buildCranialSutures(parent: SCNNode) {
        let sutureMaterial = SCNMaterial()
        sutureMaterial.diffuse.contents = UIColor(red: 0.4, green: 0.32, blue: 0.22, alpha: 0.85)
        
        // Coronal Suture (Transverse arch anteriorly)
        let coronalGeo = SCNTorus(ringRadius: 1.95, pipeRadius: 0.025)
        coronalGeo.materials = [sutureMaterial]
        let coronalNode = SCNNode(geometry: coronalGeo)
        coronalNode.position = SCNVector3(x: 0, y: 0.55, z: 0.3)
        coronalNode.eulerAngles = SCNVector3(x: 0.35, y: 0, z: 0)
        parent.addChildNode(coronalNode)
        
        // Sagittal Suture (Midline anteroposterior)
        let sagittalGeo = SCNCylinder(radius: 0.025, height: 2.6)
        sagittalGeo.materials = [sutureMaterial]
        let sagittalNode = SCNNode(geometry: sagittalGeo)
        sagittalNode.position = SCNVector3(x: 0, y: 2.1, z: -0.1)
        sagittalNode.eulerAngles = SCNVector3(x: 1.57, y: 0, z: 0)
        parent.addChildNode(sagittalNode)
        
        // Squamosal Suture (Temporal arch)
        for side: Float in [-1.0, 1.0] {
            let squamosalGeo = SCNTorus(ringRadius: 0.85, pipeRadius: 0.022)
            squamosalGeo.materials = [sutureMaterial]
            let squamosalNode = SCNNode(geometry: squamosalGeo)
            squamosalNode.position = SCNVector3(x: side * 1.7, y: 0.1, z: 0.1)
            squamosalNode.eulerAngles = SCNVector3(x: 0, y: side * 1.57, z: 0)
            parent.addChildNode(squamosalNode)
        }
    }
    
    // MARK: - Cranial Vessels
    private func buildCranialVessels(parent: SCNNode) {
        let mmaMaterial = SCNMaterial()
        mmaMaterial.diffuse.contents = UIColor(red: 0.88, green: 0.15, blue: 0.25, alpha: 0.9) // Arterial red
        
        let sinusMaterial = SCNMaterial()
        sinusMaterial.diffuse.contents = UIColor(red: 0.15, green: 0.45, blue: 0.88, alpha: 0.85) // Venous blue
        
        // Middle Meningeal Artery (MMA) Anterior & Posterior Branch (Right Pterion)
        let mmaTrunk = SCNCylinder(radius: 0.03, height: 1.2)
        mmaTrunk.materials = [mmaMaterial]
        let mmaTrunkNode = SCNNode(geometry: mmaTrunk)
        mmaTrunkNode.position = SCNVector3(x: 1.72, y: 0.0, z: 0.45)
        mmaTrunkNode.eulerAngles = SCNVector3(x: 0.25, y: 0.2, z: 0.3)
        parent.addChildNode(mmaTrunkNode)
        
        let mmaAnterior = SCNCylinder(radius: 0.022, height: 1.0)
        mmaAnterior.materials = [mmaMaterial]
        let mmaAntNode = SCNNode(geometry: mmaAnterior)
        mmaAntNode.position = SCNVector3(x: 1.62, y: 0.8, z: 0.6)
        mmaAntNode.eulerAngles = SCNVector3(x: 0.6, y: -0.2, z: 0.4)
        parent.addChildNode(mmaAntNode)
        
        // Transverse-Sigmoid Sinus (Posterolateral confluence to jugular bulb)
        let sinusGeo = SCNTorus(ringRadius: 1.6, pipeRadius: 0.07)
        sinusGeo.materials = [sinusMaterial]
        let sinusNode = SCNNode(geometry: sinusGeo)
        sinusNode.position = SCNVector3(x: 0, y: -0.3, z: -0.6)
        sinusNode.eulerAngles = SCNVector3(x: 0.2, y: 0, z: 0)
        parent.addChildNode(sinusNode)
    }
    
    // MARK: - Craniotomy Flap & Burr Holes
    private func buildCraniotomyFlap(approach: SurgicalApproachPreset, parent: SCNNode) {
        let flapMaterial = SCNMaterial()
        flapMaterial.diffuse.contents = UIColor(red: 0.95, green: 0.65, blue: 0.15, alpha: 0.75) // Amber luminous flap
        
        let burrMaterial = SCNMaterial()
        burrMaterial.diffuse.contents = UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 0.95)
        
        switch approach {
        case .pterional, .miniPterional:
            // Pterional Osteotomy Border (Frontotemporal curvilinear cut)
            let flapGeo = SCNTorus(ringRadius: 0.9, pipeRadius: 0.04)
            flapGeo.materials = [flapMaterial]
            let flapNode = SCNNode(geometry: flapGeo)
            flapNode.position = SCNVector3(x: 1.55, y: 0.45, z: 0.45)
            flapNode.eulerAngles = SCNVector3(x: 0.25, y: 1.15, z: 0.2)
            parent.addChildNode(flapNode)
            
            // Burr Holes: 1. MacCarty Keyhole (Fronto-orbital), 2. Temporal Posterior, 3. Frontal Superior
            let holes = [
                SCNVector3(x: 1.45, y: 0.25, z: 1.1),  // Keyhole
                SCNVector3(x: 1.75, y: 0.95, z: 0.35), // Superior Frontal
                SCNVector3(x: 1.78, y: -0.1, z: 0.2)   // Posterior Temporal
            ]
            for h in holes {
                let burrGeo = SCNCylinder(radius: 0.09, height: 0.3)
                burrGeo.materials = [burrMaterial]
                let burrNode = SCNNode(geometry: burrGeo)
                burrNode.position = h
                burrNode.eulerAngles = SCNVector3(x: 0, y: 1.57, z: 0)
                parent.addChildNode(burrNode)
            }
            
        case .bifrontalTrauma:
            // Large Coronal Decompressive Flap
            let flapGeo = SCNBox(width: 2.2, height: 1.4, length: 0.1, chamferRadius: 0.05)
            flapGeo.materials = [flapMaterial]
            let flapNode = SCNNode(geometry: flapGeo)
            flapNode.position = SCNVector3(x: 0, y: 1.1, z: 1.0)
            flapNode.eulerAngles = SCNVector3(x: 0.65, y: 0, z: 0)
            parent.addChildNode(flapNode)
            
        case .retrosigmoid:
            // Retrosigmoid Asterion Trephine
            let flapGeo = SCNCylinder(radius: 0.75, height: 0.15)
            flapGeo.materials = [flapMaterial]
            let flapNode = SCNNode(geometry: flapGeo)
            flapNode.position = SCNVector3(x: 1.35, y: -0.15, z: -1.2)
            flapNode.eulerAngles = SCNVector3(x: 0.3, y: 2.4, z: 0)
            parent.addChildNode(flapNode)
            
        default:
            break
        }
    }
    
    // MARK: - Hotspot Pin Nodes
    private func buildHotspotPinNode(pin: SpatialAnatomicalPin, parent: SCNNode) {
        let pinContainer = SCNNode()
        pinContainer.name = "pin_\(pin.id)"
        
        // Pin Head Sphere
        let sphereGeo = SCNSphere(radius: 0.09)
        let sphereMat = SCNMaterial()
        sphereMat.diffuse.contents = pin.uiColor
        sphereMat.emission.contents = pin.uiColor.withAlphaComponent(0.4)
        sphereGeo.materials = [sphereMat]
        let sphereNode = SCNNode(geometry: sphereGeo)
        sphereNode.position = SCNVector3(x: 0, y: 0.22, z: 0)
        pinContainer.addChildNode(sphereNode)
        
        // Needle Shaft
        let shaftGeo = SCNCylinder(radius: 0.015, height: 0.22)
        let shaftMat = SCNMaterial()
        shaftMat.diffuse.contents = UIColor.white
        shaftGeo.materials = [shaftMat]
        let shaftNode = SCNNode(geometry: shaftGeo)
        shaftNode.position = SCNVector3(x: 0, y: 0.11, z: 0)
        pinContainer.addChildNode(shaftNode)
        
        pinContainer.position = pin.position3D
        parent.addChildNode(pinContainer)
    }
    
    // MARK: - Trajectory Rays
    private func buildTrajectoryRays(approach: SurgicalApproachPreset, parent: SCNNode) {
        let rayMaterial = SCNMaterial()
        rayMaterial.diffuse.contents = UIColor(red: 0.0, green: 0.95, blue: 0.85, alpha: 0.85) // Cyan laser trajectory
        
        if approach == .kocherEVD {
            // Ray from Kocher's point into Foramen of Monro
            let rayGeo = SCNCylinder(radius: 0.02, height: 2.2)
            rayGeo.materials = [rayMaterial]
            let rayNode = SCNNode(geometry: rayGeo)
            rayNode.position = SCNVector3(x: 0.65, y: 1.15, z: 0.45)
            rayNode.eulerAngles = SCNVector3(x: -0.65, y: -0.2, z: 0.35)
            parent.addChildNode(rayNode)
        }
    }
    
    // MARK: - Spine Models
    private func buildCervicalSpineModel(in scene: SCNScene) {
        let spineRoot = SCNNode()
        spineRoot.name = "model_root"
        
        let boneMat = SCNMaterial()
        boneMat.diffuse.contents = UIColor(red: 0.88, green: 0.83, blue: 0.72, alpha: CGFloat(boneOpacity))
        boneMat.roughness.contents = 0.5
        
        let discMat = SCNMaterial()
        discMat.diffuse.contents = UIColor(red: 0.35, green: 0.65, blue: 0.85, alpha: 0.85) // Blue disc annulus
        
        let cordMat = SCNMaterial()
        cordMat.diffuse.contents = UIColor(red: 0.95, green: 0.85, blue: 0.45, alpha: 0.9) // Yellow spinal cord
        
        // Build 5 vertebral levels (C3 to C7)
        for i in 0..<5 {
            let yOffset: Float = Float(i) * 0.95 - 1.9
            
            // Vertebral Body (Anterior)
            let bodyGeo = SCNCylinder(radius: 0.75, height: 0.55)
            bodyGeo.materials = [boneMat]
            let bodyNode = SCNNode(geometry: bodyGeo)
            bodyNode.position = SCNVector3(x: 0, y: yOffset, z: 0.6)
            spineRoot.addChildNode(bodyNode)
            
            // Intervertebral Disc
            if i < 4 {
                let discGeo = SCNCylinder(radius: 0.72, height: 0.22)
                discGeo.materials = [discMat]
                let discNode = SCNNode(geometry: discGeo)
                discNode.position = SCNVector3(x: 0, y: yOffset + 0.4, z: 0.6)
                spineRoot.addChildNode(discNode)
            }
            
            // Spinous Process & Lamina (Posterior)
            let spinousGeo = SCNBox(width: 0.25, height: 0.4, length: 1.2, chamferRadius: 0.05)
            spinousGeo.materials = [boneMat]
            let spinousNode = SCNNode(geometry: spinousGeo)
            spinousNode.position = SCNVector3(x: 0, y: yOffset - 0.1, z: -0.9)
            spinousNode.eulerAngles = SCNVector3(x: -0.3, y: 0, z: 0)
            spineRoot.addChildNode(spinousNode)
            
            // Lateral Masses (Bilateral C3-C7)
            for side: Float in [-1.0, 1.0] {
                let massGeo = SCNCylinder(radius: 0.28, height: 0.65)
                massGeo.materials = [boneMat]
                let massNode = SCNNode(geometry: massGeo)
                massNode.position = SCNVector3(x: side * 0.95, y: yOffset, z: -0.2)
                spineRoot.addChildNode(massNode)
            }
        }
        
        // Spinal Cord Tube Passing through canal
        let cordGeo = SCNCylinder(radius: 0.38, height: 5.2)
        cordGeo.materials = [cordMat]
        let cordNode = SCNNode(geometry: cordGeo)
        cordNode.position = SCNVector3(x: 0, y: 0, z: -0.15)
        spineRoot.addChildNode(cordNode)
        
        scene.rootNode.addChildNode(spineRoot)
    }
    
    private func buildLumbarSpineModel(in scene: SCNScene) {
        let spineRoot = SCNNode()
        spineRoot.name = "model_root"
        
        let boneMat = SCNMaterial()
        boneMat.diffuse.contents = UIColor(red: 0.88, green: 0.83, blue: 0.72, alpha: CGFloat(boneOpacity))
        boneMat.roughness.contents = 0.55
        
        // Massive Lumbar Vertebra L4 & L5
        for i in 0..<2 {
            let yOffset: Float = Float(i) * 1.8 - 0.9
            
            // Massive Kidney-Shaped Body
            let bodyGeo = SCNCylinder(radius: 1.3, height: 0.9)
            bodyGeo.materials = [boneMat]
            let bodyNode = SCNNode(geometry: bodyGeo)
            bodyNode.position = SCNVector3(x: 0, y: yOffset, z: 0.9)
            spineRoot.addChildNode(bodyNode)
            
            // Pedicles (Target for pedicle screw)
            for side: Float in [-1.0, 1.0] {
                let pedicleGeo = SCNCylinder(radius: 0.32, height: 1.1)
                pedicleGeo.materials = [boneMat]
                let pedicleNode = SCNNode(geometry: pedicleGeo)
                pedicleNode.position = SCNVector3(x: side * 1.0, y: yOffset + 0.15, z: 0.05)
                pedicleNode.eulerAngles = SCNVector3(x: 1.57, y: side * 0.25, z: 0)
                spineRoot.addChildNode(pedicleNode)
            }
            
            // Massive Spinous Process
            let spinousGeo = SCNBox(width: 0.45, height: 0.9, length: 1.6, chamferRadius: 0.08)
            spinousGeo.materials = [boneMat]
            let spinousNode = SCNNode(geometry: spinousGeo)
            spinousNode.position = SCNVector3(x: 0, y: yOffset - 0.1, z: -1.3)
            spineRoot.addChildNode(spinousNode)
        }
        
        scene.rootNode.addChildNode(spineRoot)
    }
    
    // MARK: - Material & Layer Runtime Modifiers
    private func updateMaterialOpacity() {
        scene.rootNode.enumerateChildNodes { node, _ in
            if let mats = node.geometry?.materials {
                for m in mats where m.name == "bone_material" {
                    m.diffuse.contents = UIColor(red: 0.89, green: 0.84, blue: 0.74, alpha: CGFloat(boneOpacity))
                }
            }
        }
    }
    
    private func toggleLayer(name: String, isVisible: Bool) {
        if let node = scene.rootNode.childNode(withName: name, recursively: true) {
            node.isHidden = !isVisible
        }
    }
    
    private func animateCamera(to preset: CameraPreset) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.8
        cameraNode.position = preset.position
        cameraNode.eulerAngles = preset.eulerAngles
        SCNTransaction.commit()
    }
}

// MARK: - SceneKit UIViewRepresentable Wrapper
public struct SceneKitContainerView: UIViewRepresentable {
    public let scene: SCNScene
    public let cameraNode: SCNNode
    public let selectedModel: SpatialModelType
    public let selectedApproach: SurgicalApproachPreset
    public let boneOpacity: Float
    public let showSutures: Bool
    public let showVascular: Bool
    public let showCraniotomyFlap: Bool
    public let showHotspots: Bool
    public let showTrajectoryRays: Bool
    public let onSelectPin: (SpatialAnatomicalPin) -> Void
    
    public func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = scene
        scnView.allowsCameraControl = true // Enables native fluid 360° touch orbit & pinch-zoom!
        scnView.autoenablesDefaultLighting = false
        scnView.backgroundColor = UIColor(red: 0.03, green: 0.04, blue: 0.06, alpha: 1.0)
        scnView.antialiasingMode = .multisampling4X
        scnView.preferredFramesPerSecond = 60
        
        // Tap Gesture to Detect Pin Selection
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        context.coordinator.scnView = scnView
        
        return scnView
    }
    
    public func updateUIView(_ uiView: SCNView, context: Context) {
        if uiView.scene !== scene {
            uiView.scene = scene
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject {
        var parent: SceneKitContainerView
        weak var scnView: SCNView?
        
        init(_ parent: SceneKitContainerView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let view = scnView else { return }
            let location = gesture.location(in: view)
            let hitResults = view.hitTest(location, options: [:])
            
            for result in hitResults {
                var currentNode: SCNNode? = result.node
                while let node = currentNode {
                    if let name = node.name, name.starts(with: "pin_") {
                        let pinId = String(name.dropFirst(4))
                        if let pin = parent.selectedApproach.associatedPins.first(where: { $0.id == pinId }) {
                            HapticManager.impact(style: .medium)
                            parent.onSelectPin(pin)
                            return
                        }
                    }
                    currentNode = node.parent
                }
            }
        }
    }
}

// MARK: - Spatial Enums & Data Models
public enum SpatialModelType: String, CaseIterable {
    case cranium = "cranium"
    case cervicalSpine = "cervical_spine"
    case lumbarSpine = "lumbar_spine"
    
    public var displayName: String {
        switch self {
        case .cranium: return "3D Cranium & Skull Base"
        case .cervicalSpine: return "3D Cervical Segment (C3-C7)"
        case .lumbarSpine: return "3D Lumbar Column (L4-L5)"
        }
    }
}

public enum SurgicalApproachPreset: String, CaseIterable {
    case pterional = "pterional"
    case miniPterional = "mini_pterional"
    case bifrontalTrauma = "bifrontal_trauma"
    case retrosigmoid = "retrosigmoid"
    case kocherEVD = "kocher_evd"
    case acdfCervical = "acdf_cervical"
    case posteriorLateralMass = "posterior_lateral_mass"
    case lumbarTLIF = "lumbar_tlif"
    
    public static func presets(for model: SpatialModelType) -> [SurgicalApproachPreset] {
        switch model {
        case .cranium:
            return [.pterional, .miniPterional, .kocherEVD, .bifrontalTrauma, .retrosigmoid]
        case .cervicalSpine:
            return [.acdfCervical, .posteriorLateralMass]
        case .lumbarSpine:
            return [.lumbarTLIF]
        }
    }
    
    public var title: String {
        switch self {
        case .pterional: return "Pterional Approach"
        case .miniPterional: return "Mini-Pterional"
        case .bifrontalTrauma: return "Bifrontal Decompression"
        case .retrosigmoid: return "Retrosigmoid Corridor"
        case .kocherEVD: return "Kocher's EVD Trephine"
        case .acdfCervical: return "Anterior Cervical (ACDF)"
        case .posteriorLateralMass: return "Lateral Mass Screws"
        case .lumbarTLIF: return "Posterior Lumbar TLIF"
        }
    }
    
    public var subtitle: String {
        switch self {
        case .pterional: return "Sylvian fissure & ACI / MCA"
        case .miniPterional: return "Eyebrow / Keyhole corridor"
        case .bifrontalTrauma: return "Trauma bifrontal craniotomy"
        case .retrosigmoid: return "CPA, acoustic, petrosal vein"
        case .kocherEVD: return "Monro ventricle cannulation"
        case .acdfCervical: return "Smith-Robinson C5-C6 corridor"
        case .posteriorLateralMass: return "Roy-Camille / Magerl angles"
        case .lumbarTLIF: return "Transforaminal interbody fusion"
        }
    }
    
    public var protocolTitle: String {
        switch self {
        case .pterional: return "Classic Yasargil Pterional Craniotomy"
        case .miniPterional: return "Minimally Invasive Supraorbital Keyhole"
        case .bifrontalTrauma: return "Subfrontal Decompressive Craniectomy"
        case .retrosigmoid: return "Suboccipital Retrosigmoid Keyhole"
        case .kocherEVD: return "Frontal Horn Ventriculostomy"
        case .acdfCervical: return "Subaxial Anterior Cervical Discectomy"
        case .posteriorLateralMass: return "Subaxial Lateral Mass Fixation"
        case .lumbarTLIF: return "Minimally Invasive Lumbar Interbody Fusion"
        }
    }
    
    public var protocolDescription: String {
        switch self {
        case .pterional:
            return "Curvilinear skin incision 1 cm anterior to tragus extending behind hairline to midline. Interfascial temporalis dissection to spare facial nerve frontalis branch. Keyhole burr hole placed at MacCarty point (frontosphenoidal suture). Flatten sphenoid ridge down to meningo-orbital artery."
        case .miniPterional:
            return "Targeted 4 cm incision centered over the pterion or eyebrow. Indicated for unruptured anterior circulation aneurysms and sellar lesions. Significantly reduces temporalis atrophy and operative morbidity."
        case .bifrontalTrauma:
            return "Coronal bicoronal scalp flap reflected to supraorbital margins. Bilateral frontal bone flap crosses superior sagittal sinus at anterior third. Ligate sinus with 2-0 silk only if anterior to coronal suture."
        case .retrosigmoid:
            return "Incision 2 cm behind mastoid groove. Burr hole placed inferomedial to asterion to expose edge of transverse and sigmoid sinuses. Peel dura gently from bone; open dura with C-shaped cut facing sinuses."
        case .kocherEVD:
            return "Trephine placed 11 cm posterior from nasion, 3 cm lateral from midline. Perpendicular entry directed toward medial canthus in coronal plane and tragus in sagittal plane. Penetrate Monro at 5.5 to 6.5 cm."
        case .acdfCervical:
            return "Transverse skin crease incision over target disc. Dissect between sternocleidomastoid/carotid sheath laterally and trachea/esophagus medially. Sub-longus colli mobilization protects sympathetic chain."
        case .posteriorLateralMass:
            return "Roy-Camille trajectory (perpendicular, 10° lateral) or Magerl trajectory (25° lateral, 25° cephalad). Magerl minimizes nerve root injury while maximizing cortical bone purchase."
        case .lumbarTLIF:
            return "Unilateral facetectomy to access Kambin's triangle. Mobilize traversing nerve root medially. Avoid over-retraction of thecal sac. Prepare endplates thoroughly to prevent graft subsidence."
        }
    }
    
    public var dangerPoints: [String] {
        switch self {
        case .pterional, .miniPterional:
            return [
                "Frontalis branch injury if dissecting through superficial fat pad",
                "Middle meningeal artery tear during sphenoid ridge unroofing",
                "Excessive temporal lobe traction prior to Sylvian fissure release"
            ]
        case .bifrontalTrauma:
            return [
                "Superior sagittal sinus laceration while crossing midline",
                "Frontal sinus entry with secondary CSF rhinorrhea / mucocele",
                "Olfactory nerve avulsion during frontal lobe retraction"
            ]
        case .retrosigmoid:
            return [
                "Transverse/sigmoid sinus laceration during craniectomy",
                "Petrosal vein of Dandy avulsion leading to hemorrhagic cerebellar infarction",
                "Traction on CN VII/VIII complex causing sensorineural deafness"
            ]
        case .kocherEVD:
            return [
                "Cannulation too deep (>7.0 cm) penetrating basal ganglia or brainstem",
                "Trajectory too medial crossing midline into contralateral hemisphere",
                "Choroid plexus avulsion with intraventricular hemorrhage"
            ]
        case .acdfCervical:
            return [
                "Recurrent laryngeal nerve neuropraxia from excessive endotracheal cuff pressure",
                "Esophageal perforation from aggressive medial retractor blade placement",
                "Vertebral artery laceration lateral to uncinate processes"
            ]
        case .posteriorLateralMass:
            return [
                "Vertebral artery violation from over-convergent cervical screw angles",
                "C5 nerve root impingement from caudal screw trajectory"
            ]
        case .lumbarTLIF:
            return [
                "Exiting nerve root impingement during superior facetectomy",
                "Traversing root dural tear in axilla during interbody cage insertion",
                "Retroperitoneal great vessel laceration from aggressive annulotomy disc rongeur"
            ]
        }
    }
    
    public var associatedPins: [SpatialAnatomicalPin] {
        switch self {
        case .pterional, .miniPterional:
            return [
                SpatialAnatomicalPin(
                    id: "pterion",
                    name: "Pterion Landmark",
                    typeTag: "CRITICAL JUNCTURE",
                    color: ObsidianTheme.neonRose,
                    uiColor: UIColor(red: 0.95, green: 0.25, blue: 0.35, alpha: 1.0),
                    coordinatesFormula: "2 fingers above zygoma, 1 thumb behind frontozygomatic suture",
                    clinicalSignificance: "Junction of frontal, parietal, temporal, and greater sphenoid wing. MMA anterior branch runs on inner table. High risk of epidural hematoma upon trauma.",
                    position3D: SCNVector3(x: 1.65, y: 0.35, z: 0.6)
                ),
                SpatialAnatomicalPin(
                    id: "maccarty",
                    name: "MacCarty Keyhole",
                    typeTag: "OSTEOTOMY TARGET",
                    color: ObsidianTheme.neonAmber,
                    uiColor: UIColor(red: 0.95, green: 0.65, blue: 0.15, alpha: 1.0),
                    coordinatesFormula: "5 mm superior & 5 mm posterior to frontozygomatic suture",
                    clinicalSignificance: "Single trephine opening exposing both anterior cranial fossa frontal dura and periorbita simultaneously.",
                    position3D: SCNVector3(x: 1.45, y: 0.2, z: 1.1)
                ),
                SpatialAnatomicalPin(
                    id: "sphenoid_ridge",
                    name: "Sphenoid Ridge",
                    typeTag: "BONE DRILLING",
                    color: ObsidianTheme.neonCyan,
                    uiColor: UIColor(red: 0.0, green: 0.85, blue: 0.95, alpha: 1.0),
                    coordinatesFormula: "Lesser wing of sphenoid extending to anterior clinoid process",
                    clinicalSignificance: "Drilled flat down to meningo-orbital band to provide low, flat subfrontal and transsylvian view without brain retraction.",
                    position3D: SCNVector3(x: 1.35, y: -0.1, z: 0.75)
                )
            ]
        case .kocherEVD:
            return [
                SpatialAnatomicalPin(
                    id: "kocher",
                    name: "Kocher's Point",
                    typeTag: "VENTRICULAR ENTRY",
                    color: ObsidianTheme.neonCyan,
                    uiColor: UIColor(red: 0.0, green: 0.85, blue: 0.95, alpha: 1.0),
                    coordinatesFormula: "11 cm posterior to nasion, 3 cm lateral to midline (mid-pupillary line)",
                    clinicalSignificance: "Anterior to coronal suture. Safely avoids motor cortex. Trajectory toward medial canthus and tragus reaches Foramen of Monro.",
                    position3D: SCNVector3(x: 0.7, y: 1.95, z: 0.45)
                ),
                SpatialAnatomicalPin(
                    id: "coronal_suture",
                    name: "Coronal Suture",
                    typeTag: "ANATOMICAL BOUNDARY",
                    color: ObsidianTheme.neonPurple,
                    uiColor: UIColor(red: 0.7, green: 0.4, blue: 0.95, alpha: 1.0),
                    coordinatesFormula: "Transverse arch separating frontal from parietal calvaria",
                    clinicalSignificance: "Kocher's point must always be 1 to 2 cm anterior to this line to guarantee preservation of primary motor cortex.",
                    position3D: SCNVector3(x: 0.9, y: 1.7, z: 0.0)
                )
            ]
        case .bifrontalTrauma:
            return [
                SpatialAnatomicalPin(
                    id: "glabella",
                    name: "Glabella / Nasion",
                    typeTag: "MIDLINE REFERENCE",
                    color: ObsidianTheme.neonGreen,
                    uiColor: UIColor(red: 0.2, green: 0.85, blue: 0.4, alpha: 1.0),
                    coordinatesFormula: "Depression between eyebrows directly above nasal bridge",
                    clinicalSignificance: "Baseline zero point for all cranial stereotactic and emergency measurements.",
                    position3D: SCNVector3(x: 0, y: -0.1, z: 1.45)
                ),
                SpatialAnatomicalPin(
                    id: "sagittal_sinus",
                    name: "Superior Sagittal Sinus",
                    typeTag: "HIGH-FLOW VESSEL",
                    color: ObsidianTheme.neonRose,
                    uiColor: UIColor(red: 0.95, green: 0.2, blue: 0.3, alpha: 1.0),
                    coordinatesFormula: "Direct mid-sagittal line beneath sagittal suture",
                    clinicalSignificance: "Bilateral craniotomy requires crossing sinus. Elevate bone cautiously after freeing dura to prevent torrential venous sinus laceration.",
                    position3D: SCNVector3(x: 0, y: 2.15, z: 0.1)
                )
            ]
        case .retrosigmoid:
            return [
                SpatialAnatomicalPin(
                    id: "asterion",
                    name: "Asterion",
                    typeTag: "VENOUS JUNCTURE",
                    color: ObsidianTheme.neonPurple,
                    uiColor: UIColor(red: 0.75, green: 0.35, blue: 0.95, alpha: 1.0),
                    coordinatesFormula: "Junction of lambdoid, parietomastoid, and occipitomastoid sutures",
                    clinicalSignificance: "Superficial bony projection of transverse-sigmoid sinus knee. Burr hole placed inferomedial to asterion to avoid direct sinus puncture.",
                    position3D: SCNVector3(x: 1.4, y: -0.2, z: -1.0)
                ),
                SpatialAnatomicalPin(
                    id: "inion",
                    name: "Inion (External Occipital Protuberance)",
                    typeTag: "TORCULA LANDMARK",
                    color: ObsidianTheme.neonAmber,
                    uiColor: UIColor(red: 0.95, green: 0.65, blue: 0.15, alpha: 1.0),
                    coordinatesFormula: "Prominent midline bony projection at base of skull posteriorly",
                    clinicalSignificance: "Directly overlies the Confluence of Sinuses (Torcula Herophili). Key landmark for suboccipital midline craniectomy.",
                    position3D: SCNVector3(x: 0, y: -0.4, z: -1.8)
                )
            ]
        default:
            return []
        }
    }
}

public struct SpatialAnatomicalPin: Identifiable {
    public let id: String
    public let name: String
    public let typeTag: String
    public let color: Color
    public let uiColor: UIColor
    public let coordinatesFormula: String
    public let clinicalSignificance: String
    public let position3D: SCNVector3
}

public struct CameraPreset: Identifiable, Hashable, Equatable {
    public var id: String { shortName }
    public let shortName: String
    public let position: SCNVector3
    public let eulerAngles: SCNVector3
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(shortName)
    }
    
    public static func == (lhs: CameraPreset, rhs: CameraPreset) -> Bool {
        lhs.shortName == rhs.shortName
    }
    
    public static let anterolateral = CameraPreset(
        shortName: "Pterional 45°",
        position: SCNVector3(x: 4.8, y: 1.2, z: 5.5),
        eulerAngles: SCNVector3(x: -0.15, y: 0.7, z: 0)
    )
    
    public static let vertex = CameraPreset(
        shortName: "Vertex / EVD",
        position: SCNVector3(x: 0.8, y: 7.2, z: 1.8),
        eulerAngles: SCNVector3(x: -1.35, y: 0.15, z: 0)
    )
    
    public static let skullBase = CameraPreset(
        shortName: "Skull Base",
        position: SCNVector3(x: 0.0, y: -2.5, z: 7.0),
        eulerAngles: SCNVector3(x: 0.35, y: 0, z: 0)
    )
    
    public static let posterior = CameraPreset(
        shortName: "Retrosigmoid",
        position: SCNVector3(x: 4.5, y: -0.5, z: -5.8),
        eulerAngles: SCNVector3(x: 0.1, y: 2.45, z: 0)
    )
    
    public static func presets(for model: SpatialModelType) -> [CameraPreset] {
        switch model {
        case .cranium:
            return [.anterolateral, .vertex, .posterior, .skullBase]
        case .cervicalSpine:
            return [
                CameraPreset(shortName: "Anterior (ACDF)", position: SCNVector3(x: 0, y: 0, z: 6.8), eulerAngles: SCNVector3(0, 0, 0)),
                CameraPreset(shortName: "Lateral Mass", position: SCNVector3(x: 4.2, y: 0.5, z: -4.8), eulerAngles: SCNVector3(0, 2.4, 0))
            ]
        case .lumbarSpine:
            return [
                CameraPreset(shortName: "Posterior (TLIF)", position: SCNVector3(x: 0, y: 0, z: -6.8), eulerAngles: SCNVector3(0, 3.14, 0)),
                CameraPreset(shortName: "Pedicle Trajectory", position: SCNVector3(x: 3.5, y: 1.0, z: -5.0), eulerAngles: SCNVector3(-0.2, 2.5, 0))
            ]
        }
    }
}
