import Foundation

public struct SwiftUtils {
    public private(set) var text = "Hello, World!"

    public init() {
    }

  public func calculateTime() -> Double {
        let now = Date().timeIntervalSince1970
        return now
    }
}
