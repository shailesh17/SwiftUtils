import Foundation
import XCTest
@testable import SwiftUtils

final class SwiftUtilsTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
      XCTAssertEqual(SwiftUtils().text, "Hello, World!")
    }
  
  func testCalculateTime() throws {
    let now = Date().timeIntervalSince1970
    XCTAssertTrue(SwiftUtils().calculateTime() >= now)
  }
}
