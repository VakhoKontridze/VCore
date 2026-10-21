//
//  DefaultImageRepositoryTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21/10/26.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import os
import Testing
@testable import VCore

// Runs on `MainActor` to simulate real-life scenario, where `ImageStore` calls the repository from a view.

@Suite
struct DefaultImageRepositoryTests {
    // MARK: Tests
    @Test
    func testFetchRunsOffMainThread() async throws {
        let imageFetchWorker: ThreadRecordingImageRepositoryFetchWorker = .init()
        
        let imageDiskCache: ThreadRecordingImageDiskCache = .init()

        let repository: DefaultImageRepository = .init(
            imageFetchWorker: imageFetchWorker,
            imageMemoryCache: DefaultImageMemoryCache(),
            imageDiskCache: imageDiskCache,
            imageProgressMemoryCache: DefaultImageProgressMemoryCache()
        )

        _ = try await repository.fetchOriginalImage(
            parameter: .data(data: try #require(Self.imageData)),
            cachePolicy: .useCache,
            cacheStorage: .all,
            progressCacheStorage: .memory
        )

        #expect(imageDiskCache.didReadOnMainThread == false)
        #expect(imageFetchWorker.didFetchOnMainThread == false)

        // Disk write is detached, so it's awaited separately
        let didWriteOnMainThread: Bool = try await withTimeout(
            timeout: .seconds(5),
            operation: {
                let isMainThread: Bool? = await imageDiskCache.writes.first { _ in true }

                return try #require(isMainThread as Bool?) // Cast disambiguates unwrapping from asserting `true`
            }
        )

        #expect(didWriteOnMainThread == false)
    }

    // MARK: Helpers
    private static var imageData: Data? {
        PlatformImage(
            size: CGSize(dimension: 10),
            color: {
#if os(watchOS)
                UIColor.blue
#else
                PlatformColor.systemBlue
#endif
            }()
        )?
        .jpegData(compressionQuality: 1)
    }

    // MARK: Types
    nonisolated private final class ThreadRecordingImageRepositoryFetchWorker: DefaultImageRepositoryFetchWorker, @unchecked Sendable {
        // MARK: Properties
        private let lock: OSAllocatedUnfairLock<Bool?> = .init(initialState: nil)

        var didFetchOnMainThread: Bool? { lock.withLock { $0 } }

        // MARK: Operations
        override func fetchImage(
            data: Data
        ) async throws -> PlatformImage {
            lock.withLock { $0 = Thread.isMainThread }

            return try await super.fetchImage(data: data)
        }
    }

    nonisolated private final class ThreadRecordingImageDiskCache: MockImageDiskCache, @unchecked Sendable {
        // MARK: Properties
        private let lock: OSAllocatedUnfairLock<Bool?> = .init(initialState: nil)

        private let writeStream: AsyncStream<Bool>
        private let writeContinuation: AsyncStream<Bool>.Continuation

        var didReadOnMainThread: Bool? { lock.withLock { $0 } }

        var writes: AsyncStream<Bool> { writeStream }

        // MARK: Initializers
        override init() {
            let (stream, continuation): (AsyncStream<Bool>, AsyncStream<Bool>.Continuation) = AsyncStream.makeStream()

            self.writeStream = stream
            self.writeContinuation = continuation

            super.init()
        }

        // MARK: Operations
        override func get(
            key: ImageDiskCacheOriginalKey
        ) -> PlatformImage? {
            lock.withLock { $0 = Thread.isMainThread }

            return nil // Misses, so that repository fetches
        }

        override func set(
            key: ImageDiskCacheOriginalKey,
            image: PlatformImage
        ) {
            writeContinuation.yield(Thread.isMainThread)
        }
    }
}
