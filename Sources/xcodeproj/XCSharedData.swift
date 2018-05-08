import Basic
import Foundation

public final class XCSharedData {

    // MARK: - Attributes

    /// Shared data schemes.
    public var schemes: [XCScheme]

    /// Shared data breakpoints.
    public var breakpoints: XCBreakpointList?

    // MARK: - Init

    /// Initializes the shared data with its properties.
    ///
    /// - Parameters:
    ///   - schemes: shared data schemes.
    ///   - breakpoints: shared data breakpoints.
    public init(schemes: [XCScheme], breakpoints: XCBreakpointList? = nil) {
        self.schemes = schemes
        self.breakpoints = breakpoints
    }

    /// Initializes the XCSharedData reading the content from the disk.
    ///
    /// - Parameter path: path where the .xcshareddata is.
    public init(path: AbsolutePath) throws {
        if !path.exists {
            throw XCSharedDataError.notFound(path: path)
        }
        schemes = path.glob("xcschemes/*.xcscheme")
            .compactMap { try? XCScheme(path: $0) }
        breakpoints = try? XCBreakpointList(path: path.appending(RelativePath("xcdebugger/Breakpoints_v2.xcbkptlist")))
    }
}

/// XCSharedData errors.
///
/// - notFound: the share data hasn't been found.
public enum XCSharedDataError: Error, CustomStringConvertible {
    case notFound(path: AbsolutePath)

    public var description: String {
        switch self {
        case let .notFound(path):
            return "xcshareddata not found at path \(path.asString)"
        }
    }
}
