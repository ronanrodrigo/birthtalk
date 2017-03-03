import XCTest
@testable import Birthtalk

class ValidatePasswordEntityTests: XCTestCase {

    func testIsValidIsFalseWhenPasswordIsBlank() {
        let isValid = ValidatePasswordEntity(password: "").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsFalseWhenPasswordIsLess5Char() {
        let isValid = ValidatePasswordEntity(password: "1234").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsTrueWhenPasswordIsGreatherThan5Char() {
        let isValid = ValidatePasswordEntity(password: "123456").isValid()

        XCTAssertTrue(isValid)
    }

    func testIsValidIsTrueWhenPasswordIsEqual5Char() {
        let isValid = ValidatePasswordEntity(password: "12345").isValid()

        XCTAssertTrue(isValid)
    }

}
