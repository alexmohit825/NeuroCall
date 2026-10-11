import SwiftUI

// MARK: - Atlas Amalgam Hub (Option B + Option C Unified Command Center)
// Unites the Native SceneKit 3D Spatial Simulator and the High-Definition Photorealistic Atlas
// with zero compromise on neurosurgical anatomical fidelity.

public struct AtlasAmalgamHubView: View {
    @State private var activeEngineMode: AtlasEngineMode = .spatial3D
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // Master Engine Mode Selector Switcher
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    ForEach(AtlasEngineMode.allCases, id: \.self) { mode in
                        Button(action: {
                            HapticManager.impact(style: .medium)
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                activeEngineMode = mode
                            }
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: mode.iconName)
                                    .font(.system(size: 12, weight: .bold))
                                Text(mode.displayName)
                                    .font(.system(size: 12, weight: .bold))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(activeEngineMode == mode ? mode.accentColor.opacity(0.2) : ObsidianTheme.vitreousGlass)
                            .foregroundColor(activeEngineMode == mode ? mode.accentColor : ObsidianTheme.textSecondary)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(activeEngineMode == mode ? mode.accentColor : ObsidianTheme.borderSubtle, lineWidth: 1.5))
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.top, 8)
            }
            .background(ObsidianTheme.surfaceElevated)
            
            Divider()
                .background(ObsidianTheme.borderSubtle)
            
            // Engine View Container
            Group {
                switch activeEngineMode {
                case .spatial3D:
                    NeurosurgicalSpatial3DView()
                case .hdAtlas:
                    PhotorealisticSurgicalAtlasView()
                case .radiographicMRI:
                    PicturesqueMRIAtlasView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(ObsidianTheme.surfaceVoid)
    }
}

public enum AtlasEngineMode: String, CaseIterable {
    case spatial3D = "spatial_3d"
    case hdAtlas = "hd_atlas"
    case radiographicMRI = "radiographic_mri"
    
    public var displayName: String {
        switch self {
        case .spatial3D: return "3D Spatial Cockpit"
        case .hdAtlas: return "HD Micro-Corridors"
        case .radiographicMRI: return "MRI Radiography"
        }
    }
    
    public var iconName: String {
        switch self {
        case .spatial3D: return "rotate.3d.fill"
        case .hdAtlas: return "cross.case.fill"
        case .radiographicMRI: return "brain.head.profile"
        }
    }
    
    public var accentColor: Color {
        switch self {
        case .spatial3D: return ObsidianTheme.neonCyan
        case .hdAtlas: return ObsidianTheme.neonAmber
        case .radiographicMRI: return ObsidianTheme.neonPurple
        }
    }
}
