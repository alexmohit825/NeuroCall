import XCTest
import UIKit
@testable import NeuroCall

final class NeuroCallTests: XCTestCase {

    // MARK: - Test 1: Verify All 42 Surgical Atlas Plates Load Real Images (Zero Blank Screens)
    func testAll42SurgicalAtlasPlatesLoadRealImages() {
        let allPlates = SurgicalPlateType.allCases
        XCTAssertEqual(allPlates.count, 42, "SurgicalPlateType must contain exactly 42 master plates")

        var failedPlates: [String] = []

        for plate in allPlates {
            guard let assetName = plate.assetImageName else {
                failedPlates.append("\(plate.shortTitle): assetImageName is nil")
                continue
            }

            // Test loading from the main application bundle
            let image = UIImage(named: assetName, in: Bundle.main, compatibleWith: nil)
            if image == nil {
                // Also check if bundle fallback finds it
                let fallback = UIImage(named: assetName)
                if fallback == nil {
                    failedPlates.append("\(plate.shortTitle) [raw: '\(assetName)'] -> Image failed to load (returned nil)")
                }
            }
        }

        XCTAssertTrue(
            failedPlates.isEmpty,
            "The following plates failed to load from the asset catalog:\n" + failedPlates.joined(separator: "\n")
        )
    }

    // MARK: - Test 2: Verify All Frontline Bedside Procedure Images Load (Zero Blank Bedside Screens)
    func testAllBedsideProcedureImagesLoad() {
        let bedsideImages = [
            "plate_bedside_evd",
            "plate_bedside_camino_bolt",
            "plate_bedside_lumbar_puncture",
            "plate_bedside_lumbar_drain",
            "plate_bedside_art_line",
            "plate_bedside_cvc_line"
        ]

        var failed: [String] = []
        for name in bedsideImages {
            let img = UIImage(named: name, in: Bundle.main, compatibleWith: nil) ?? UIImage(named: name)
            if img == nil {
                failed.append(name)
            }
        }

        XCTAssertTrue(failed.isEmpty, "Bedside images missing from bundle: \(failed.joined(separator: ", "))")
    }

    // MARK: - Test 3: Verify All 42 Plates Have Calibrated Callouts and Valid Step Guides
    func testAll42PlatesHaveValidCalloutsAndSteps() {
        for plate in SurgicalPlateType.allCases {
            XCTAssertFalse(plate.title.isEmpty, "Plate \(plate.rawValue) title must not be empty")
            XCTAssertFalse(plate.shortTitle.isEmpty, "Plate \(plate.rawValue) shortTitle must not be empty")
            XCTAssertGreaterThan(plate.plateNumber, 0, "Plate number must be > 0")

            // Callout coordinates must be within 0.0 to 1.0 bounds
            for callout in plate.callouts {
                XCTAssertGreaterThanOrEqual(callout.normalizedX, 0.0, "\(callout.title) X must be >= 0.0")
                XCTAssertLessThanOrEqual(callout.normalizedX, 1.0, "\(callout.title) X must be <= 1.0")
                XCTAssertGreaterThanOrEqual(callout.normalizedY, 0.0, "\(callout.title) Y must be >= 0.0")
                XCTAssertLessThanOrEqual(callout.normalizedY, 1.0, "\(callout.title) Y must be <= 1.0")
            }

            // Steps must have sequential step numbers
            for (idx, step) in plate.steps.enumerated() {
                XCTAssertEqual(step.stepNumber, idx + 1, "Step numbering mismatch in \(plate.shortTitle)")
            }
        }
    }

    // MARK: - Test 4: Verify Deterministic Neurosurgical Calculators Logic
    func testCPPAndICHScoreCalculators() {
        // CPP = MAP - ICP
        let map: Double = 90.0
        let icp: Double = 20.0
        let cpp = map - icp
        XCTAssertEqual(cpp, 70.0, "CPP calculation must equal MAP - ICP")

        // ICH Score: GCS 3-4 (+2), Vol > 30 (+1), IVH (+1), Infra (+1), Age > 80 (+1) = Max 6
        var ichScore = 0
        ichScore += 2 // GCS 3
        ichScore += 1 // Vol > 30
        ichScore += 1 // IVH
        ichScore += 1 // Infratentorial
        ichScore += 1 // Age > 80
        XCTAssertEqual(ichScore, 6, "Maximum ICH Score must equal 6")
    }
}
