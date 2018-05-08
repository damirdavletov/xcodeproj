import Foundation
import xcodeproj
import XCTest

class PBXSourcesBuildPhaseSpec: XCTestCase {
    var subject: PBXSourcesBuildPhase!

    override func setUp() {
        super.setUp()
        subject = PBXSourcesBuildPhase(files: ["file"])
    }

    func test_init_initializesThePropertiesCorrectly() {
        XCTAssertEqual(subject.buildActionMask, PBXBuildPhase.defaultBuildActionMask)
        XCTAssertEqual(subject.files, ["file"])
        XCTAssertEqual(subject.runOnlyForDeploymentPostprocessing, false)
    }

    func test_itHasTheCorrectIsa() {
        XCTAssertEqual(PBXSourcesBuildPhase.isa, "PBXSourcesBuildPhase")
    }

    func test_equals_returnsTheCorrectValue() {
        let one = PBXSourcesBuildPhase(files: ["file"])
        let another = PBXSourcesBuildPhase(files: ["file"])
        XCTAssertEqual(one, another)
    }

    private func testDictionary() -> [String: Any] {
        return [
            "files": ["file"],
        ]
    }
}
