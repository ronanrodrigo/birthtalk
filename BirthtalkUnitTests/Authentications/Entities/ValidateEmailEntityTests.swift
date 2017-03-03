import XCTest
@testable import Birthtalk

class ValidateEmailEntityTests: XCTestCase {

    func testIsValidIsFalseWhenEmailIsEmpty() {
        let isValid = ValidateEmailEntity(email: "").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsFalseWhenEmailIsWithoutDomain() {
        let isValid = ValidateEmailEntity(email: "invalid@gmail").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsFalseWhenEmailIsWithInvalidCharacter() {
        let isValid = ValidateEmailEntity(email: "invalid@gmail,com").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsFalseWhenEmailIsWithouthProvider() {
        let isValid = ValidateEmailEntity(email: "invalid@.com").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsFalseWhenEmailIsIncomplete() {
        let isValid = ValidateEmailEntity(email: "invalid@").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsFalseWhenEmailHasOnlyTheUsername() {
        let isValid = ValidateEmailEntity(email: "invalid").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsFalseWhenEmailHas💩() {
        let isValid = ValidateEmailEntity(email: "invalid💩@gmail.com").isValid()

        XCTAssertFalse(isValid)
    }

    func testIsValidIsTrueWhenEmailIsComplete() {
        let isValid = ValidateEmailEntity(email: "valid@gmail.com").isValid()

        XCTAssertTrue(isValid)
    }

}
