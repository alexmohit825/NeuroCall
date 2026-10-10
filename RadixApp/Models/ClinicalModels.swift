import Foundation
import SwiftUI

// MARK: - Spinal Levels & Anatomic Roots
public enum SpinalLevel: String, CaseIterable, Identifiable {
    case C5, C6, C7, C8, T1
    case L2, L3, L4, L5, S1
    
    public var id: String { rawValue }
    
    public var region: String {
        switch self {
        case .C5, .C6, .C7, .C8, .T1: return "Cervical"
        case .L2, .L3, .L4, .L5, .S1: return "Lumbosacral"
        }
    }
}

// MARK: - Peripheral Nerves
public enum PeripheralNerve: String, CaseIterable, Identifiable {
    case medianWrist = "Median Nerve (Carpal Tunnel)"
    case medianArm = "Median Nerve (Pronator Teres Branch)"
    case ulnarElbow = "Ulnar Nerve (Cubital Tunnel)"
    case ulnarGuyon = "Ulnar Nerve (Guyon Canal)"
    case radialSpiral = "Radial Nerve (Spiral Groove)"
    case radialPIN = "Posterior Interosseous Nerve (PIN)"
    case commonPeroneal = "Common Peroneal (Fibular Neck)"
    case deepPeroneal = "Deep Peroneal (Anterior Compartment)"
    case superficialPeroneal = "Superficial Peroneal (Lateral)"
    case tibialNerve = "Tibial Nerve (Tarsal Tunnel)"
    case femoralNerve = "Femoral Nerve"
    case obturatorNerve = "Obturator Nerve"
    case lateralFemoralCutaneous = "Lateral Femoral Cutaneous (LFCN)"
    
    public var id: String { rawValue }
}

// MARK: - Key Muscles
public struct KeyMuscle: Identifiable {
    public let id = UUID()
    public let name: String
    public let action: String
    public let rootLevels: [SpinalLevel]
    public let primaryRoot: SpinalLevel
    public let peripheralNerve: PeripheralNerve
    public let isKeyDifferentiator: Bool
    public let arbitrationPearl: String
    
    public init(name: String, action: String, rootLevels: [SpinalLevel], primaryRoot: SpinalLevel, peripheralNerve: PeripheralNerve, isKeyDifferentiator: Bool, arbitrationPearl: String) {
        self.name = name
        self.action = action
        self.rootLevels = rootLevels
        self.primaryRoot = primaryRoot
        self.peripheralNerve = peripheralNerve
        self.isKeyDifferentiator = isKeyDifferentiator
        self.arbitrationPearl = arbitrationPearl
    }
}

// MARK: - Emergency Protocol Model
public struct NeuroEmergencyProtocol: Identifiable {
    public let id = UUID()
    public let title: String
    public let category: String
    public let urgencyBadge: String
    public let surgicalThresholds: [String]
    public let medicalDosing: [String]
    public let sbarTemplate: String
}

// MARK: - Scan Reading Checklist Model
public struct ScanReadingProtocol: Identifiable {
    public let id = UUID()
    public let modality: String // "Head CT" or "Spine MRI"
    public let stepNumber: Int
    public let mnemonicLetter: String
    public let targetStructure: String
    public let normalAppearance: String
    public let acuteCriticalRedFlags: [String]
    public let pitfallWarning: String
    public let accentColor: Color
}
