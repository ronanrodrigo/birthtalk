import XCTest
@testable import Birthtalk

class ValidateNameEntityTests: XCTestCase {

    func testIsValidIsFalseWhenNameIsBlank() {
        let isValid = ValidateNameEntity(name: "").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsTrueWhenNameIsNotBlank() {
        let isValid = ValidateNameEntity(name: "name").isValid()

        XCTAssertTrue(isValid)
    }

}
