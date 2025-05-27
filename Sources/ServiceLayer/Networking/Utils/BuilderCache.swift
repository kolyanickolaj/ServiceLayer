import Foundation

protocol Builder {
    associatedtype T

    func build() -> T
}

typealias BuilderKey = Builder & Hashable

final class BuilderCache<T> {

    private let cache: Atomic<[AnyHashable: T]> = Atomic([:])

    init() {}

    func object<Key: BuilderKey>(_ key: Key) -> T where Key.T == T {
        return cache.modify {
            if let cached = $0[key] { return cached }

            let built = key.build()
            $0[key] = built
            return built
        }
    }

    func evict<Key: BuilderKey>(_ key: Key) where Key.T == T {
        cache.modify { $0.removeValue(forKey: key) }
    }

    func evictAll() {
        cache.modify { $0.removeAll() }
    }
}
