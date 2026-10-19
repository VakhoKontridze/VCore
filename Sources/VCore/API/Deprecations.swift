//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

nonisolated extension CachedKeyedManagedTask {
    @available(*, deprecated, renamed: "values")
    public var value: [Key: Success]? {
        values
    }
}

nonisolated extension ImageProgressMemoryCache {
    @available(*, deprecated, renamed: "cancel(key:)")
    public func delete(
        key: ImageProgressMemoryCacheOriginalKey,
        cancel: Bool
    ) {
        if cancel {
            self.cancel(key: key)
        }
    }

    @available(*, deprecated, renamed: "cancel(key:cancelAllSizes:)")
    public func delete(
        key: ImageProgressMemoryCacheResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    ) {
        if cancel {
            self.cancel(
                key: key,
                cancelAllSizes: deleteAllSizes
            )
        }
    }

    @available(*, deprecated, renamed: "cancelAll(type:)")
    public func deleteAll(
        type: ImageProgressMemoryCacheCacheType,
        cancel: Bool
    ) {
        if cancel {
            cancelAll(type: type)
        }
    }
}
