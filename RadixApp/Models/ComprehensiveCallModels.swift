import Foundation
import SwiftUI

// MARK: - Acuity & Triage Levels
public enum TriageAcuity: String, CaseIterable, Codable {
    case immediate = "Immediate" // 🔴
    case urgent = "Urgent"       // 🟠
    case routine = "Routine"     // 🟡
    case stable = "Stable"       // 🟢
    
    public var color: Color {
        switch self {
        case .immediate: return .red
        case .urgent: return .orange
        case .routine: return .yellow
        case .stable: return .green
        }
    }
    
    public var icon: String {
        switch self {
        case .immediate: return "exclamationmark.octagon.fill"
        case .urgent: return "exclamationmark.triangle.fill"
        case .routine: return "clock.fill"
        case .stable: return "checkmark.circle.fill"
        }
    }
}

// MARK: - Patient Model
public struct CallPatient: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    public var mrn: String
    public var location: String // e.g. "Neuro ICU Bed 4", "7 West 702"
    public var diagnosis: String
    public var acuity: TriageAcuity
    public var gcs: String
    public var pupils: String
    public var hardware: String // e.g. "Right EVD @ 10 cmH2O", "Camino bolt"
    public var contingencyPlan: String // "If pupil blows -> STAT CT + 3% 250cc"
    public var keyTasks: [String]
    
    public init(name: String, mrn: String, location: String, diagnosis: String, acuity: TriageAcuity, gcs: String, pupils: String, hardware: String, contingencyPlan: String, keyTasks: [String]) {
        self.name = name
        self.mrn = mrn
        self.location = location
        self.diagnosis = diagnosis
        self.acuity = acuity
        self.gcs = gcs
        self.pupils = pupils
        self.hardware = hardware
        self.contingencyPlan = contingencyPlan
        self.keyTasks = keyTasks
    }
}

// MARK: - Consult Model
public struct ConsultRecord: Identifiable, Codable {
    public var id = UUID()
    public var timestamp: Date
    public var patientAgeGender: String
    public var referringService: String // "Trauma", "ED", "Stroke Neurology"
    public var callbackNumber: String
    public var chiefComplaint: String
    public var gcs: Int
    public var pupils: String
    public var motorExam: String
    public var anticoagulation: String // "On Eliquis 5mg BID", "None"
    public var imagingSummary: String // "12 mm right acute SDH with 6 mm shift"
    public var generatedPlan: String
    public var isCompleted: Bool
    
    public init(patientAgeGender: String, referringService: String, callbackNumber: String, chiefComplaint: String, gcs: Int, pupils: String, motorExam: String, anticoagulation: String, imagingSummary: String, generatedPlan: String, isCompleted: Bool = false) {
        self.timestamp = Date()
        self.patientAgeGender = patientAgeGender
        self.referringService = referringService
        self.callbackNumber = callbackNumber
        self.chiefComplaint = chiefComplaint
        self.gcs = gcs
        self.pupils = pupils
        self.motorExam = motorExam
        self.anticoagulation = anticoagulation
        self.imagingSummary = imagingSummary
        self.generatedPlan = generatedPlan
        self.isCompleted = isCompleted
    }
}

// MARK: - Medication Quick Reference Model
public struct MedicationReferenceItem: Identifiable {
    public var id = UUID()
    public var name: String
    public var category: String // "Anti-Epileptic", "Hyperosmolar", "Reversal Agent", "Steroid"
    public var standardDosing: String
    public var renalAdjustment: String
    public var emergencyRole: String
    public var monitoringPearls: [String]
}
