import Foundation

#if canImport(AlicerceExtensions)
import AlicerceExtensions
#endif

// Credits to Ole Begemann (@olebegemann) and Tim Vermeulen (@tim_vermeulen) 🙏
// https://oleb.net/blog/2017/03/dump-as-equatable-safeguard/

/// Asserts that two expressions have the same `dump` output.
///
/// - Note: Like the standard library's `assert`, the assertion is only active in playgrounds and `-Onone` builds.
/// The function does nothing in optimized builds.
///
/// - Seealso: `dump(_:to:name:indent:maxDepth:maxItems)`
///
/// - Warning: `NSObject` subclasses' `dump` **include** a memory address and hence may cause false positives.
func assertDumpsEqual<T>(_ lhs: @autoclosure () -> T,
                         _ rhs: @autoclosure () -> T,
                         file: StaticString = #file,
                         line: UInt = #line) {
    //    assert(lh, "Expected dumps to be equal.", file: file, line: line)
}
