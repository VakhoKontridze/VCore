//
//  ImageDiskCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import SwiftUI
import CryptoKit
import OSLog

/// Image disk cache.
public final class ImageDiskCache: ImageDiskCacheProtocol {
    // MARK: Properties - URLs
    private let rootURL: URL
    private let originalDirectory: URL
    private let resizedDirectory: URL
    
    // MARK: Properties - Configuration
    private let configuration: ImageDiskCacheConfiguration
    
    // MARK: Properties - Queue
    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.image-disk-cache",
        attributes: .concurrent
    )

    // MARK: Initializers
    /// Initializes `ImageDiskCache`.
    public init(
        rootURL: URL? = nil,
        configuration: ImageDiskCacheConfiguration = .default
    ) {
        let rootURL: URL = {
            if let rootURL {
                return rootURL
            }
            
            let cacheURL: URL =
                FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first ??
                FileManager.default.temporaryDirectory
            
            return cacheURL
                .appending(
                    path: "image_repository",
                    directoryHint: .isDirectory
                )
        }()
        self.rootURL = rootURL
        
        self.originalDirectory = rootURL
            .appending(
                path: "original",
                directoryHint: .isDirectory
            )
        
        self.resizedDirectory = rootURL
            .appending(
                path: "resized",
                directoryHint: .isDirectory
            )
        
        self.configuration = configuration
        
        do {
            try FileManager.default.createDirectory(
                at: originalDirectory,
                withIntermediateDirectories: true
            )
            
        } catch {
            Logger.imageStoreAndRepository.error("Failed to create directory at '\(self.originalDirectory.path(percentEncoded: false))': \(error.localizedDescription)")
        }
        
        do {
            try FileManager.default.createDirectory(
                at: resizedDirectory,
                withIntermediateDirectories: true
            )
            
        } catch {
            Logger.imageStoreAndRepository.error("Failed to create directory at '\(self.resizedDirectory.path(percentEncoded: false))': \(error.localizedDescription)")
        }
    }

    // MARK: Operation - Get
    public func get(
        key: ImageDiskCache_OriginalKey
    ) -> PlatformImage? {
        guard
            let fileName: String = fileName(key: key)
        else {
            return nil
        }
        
        let url: URL = fileURL(
            directory: originalDirectory,
            name: fileName
        )
        
        return read(url: url)
    }

    public func get(
        key: ImageDiskCache_ResizedKey
    ) -> PlatformImage? {
        guard
            let fileName: String = fileName(key: key)
        else {
            return nil
        }
        
        let url: URL = fileURL(
            directory: resizedDirectory,
            name: fileName
        )
        
        return read(url: url)
    }

    // MARK: Operation - Set
    public func set(
        key: ImageDiskCache_OriginalKey,
        image: PlatformImage
    ) {
        guard
            let fileName: String = fileName(key: key)
        else {
            return
        }
        
        let url: URL = fileURL(
            directory: originalDirectory,
            name: fileName
        )
        
        write(
            image: image,
            url: url,
            quality: configuration.originalCompressionQuality
        )
    }

    public func set(
        key: ImageDiskCache_ResizedKey,
        image: PlatformImage
    ) {
        guard
            let fileName: String = fileName(key: key)
        else {
            return
        }
        
        let url: URL = fileURL(
            directory: resizedDirectory,
            name: fileName
        )
        
        write(
            image: image,
            url: url,
            quality: configuration.resizedCompressionQuality
        )
    }

    // MARK: Operation - Delete
    public func delete(
        key: ImageDiskCache_OriginalKey
    ) {
        guard
            let fileName: String = fileName(key: key)
        else {
            return
        }
        
        let url: URL = fileURL(
            directory: originalDirectory,
            name: fileName
        )
        
        do {
            try FileManager.default.removeItem(at: url)
            
        } catch let error as CocoaError where error.code == .fileNoSuchFile {
            // ...
            
        } catch {
            Logger.imageStoreAndRepository.error("Failed to create directory at '\(url.path(percentEncoded: false))': \(error.localizedDescription)")
        }
    }

    public func delete(
        key: ImageDiskCache_ResizedKey,
        deleteAllSizes: Bool
    ) {
        if deleteAllSizes {
            guard
                let identifier: String = key.parameter.diskIdentifier
            else {
                return
            }
            
            let fileURLs: [URL]
            do {
                fileURLs = try FileManager.default.contentsOfDirectory(
                    at: resizedDirectory,
                    includingPropertiesForKeys: nil,
                    options: .skipsHiddenFiles
                )
            } catch {
                Logger.imageStoreAndRepository.error("Failed to read contents of directory at '\(self.resizedDirectory.path(percentEncoded: false))': \(error.localizedDescription)")
                return
            }
            
            let identifierHash: String = sha256(identifier)
            
            for url in fileURLs {
                let name: String = url.deletingPathExtension().lastPathComponent
                
                if name.hasPrefix("\(identifierHash)_") {
                    do {
                        try FileManager.default.removeItem(at: url)
                        
                    } catch let error as CocoaError where error.code == .fileNoSuchFile {
                        // ...
                        
                    } catch {
                        Logger.imageStoreAndRepository.error("Failed to remove file at '\(url.path(percentEncoded: false))': \(error.localizedDescription)")
                    }
                }
            }
            
        } else {
            guard
                let fileName: String = fileName(key: key)
            else {
                return
            }
            
            let url: URL = fileURL(
                directory: resizedDirectory,
                name: fileName
            )
            
            do {
                try FileManager.default.removeItem(at: url)
                
            } catch let error as CocoaError where error.code == .fileNoSuchFile {
                // ...
                
            } catch {
                Logger.imageStoreAndRepository.error("Failed to create directory at '\(url.path(percentEncoded: false))': \(error.localizedDescription)")
            }
        }
    }

    // MARK: Operation - Delete All
    public func deleteAll(
        type: ImageDiskCache_CacheType
    ) {
        if type.contains(.original) {
            do {
                try FileManager.default.removeItem(at: originalDirectory)
                
            } catch let error as CocoaError where error.code == .fileNoSuchFile {
                // ...
                
            } catch {
                Logger.imageStoreAndRepository.error("Failed to create directory at '\(self.originalDirectory.path(percentEncoded: false))': \(error.localizedDescription)")
            }
            
            do {
                try FileManager.default.createDirectory(
                    at: originalDirectory,
                    withIntermediateDirectories: true
                )
                
            } catch {
                Logger.imageStoreAndRepository.error("Failed to create directory at '\(self.originalDirectory.path(percentEncoded: false))': \(error.localizedDescription)")
            }
        }
        
        if type.contains(.resized) {
            do {
                try FileManager.default.removeItem(at: resizedDirectory)
                
            } catch let error as CocoaError where error.code == .fileNoSuchFile {
                // ...
                
            } catch {
                Logger.imageStoreAndRepository.error("Failed to create directory at '\(self.resizedDirectory.path(percentEncoded: false))': \(error.localizedDescription)")
            }
            
            do {
                try FileManager.default.createDirectory(
                    at: resizedDirectory,
                    withIntermediateDirectories: true
                )
                
            } catch {
                Logger.imageStoreAndRepository.error("Failed to create directory at '\(self.resizedDirectory.path(percentEncoded: false))': \(error.localizedDescription)")
            }
        }
    }

    // MARK: Operation - Evict
    public func evictIfNeeded() {
        evict(
            directory: originalDirectory,
            maxBytes: configuration.originalMaxBytes,
            maxAge: configuration.maxAge
        )
        
        evict(
            directory: resizedDirectory,
            maxBytes: configuration.resizedMaxBytes,
            maxAge: configuration.maxAge
        )
    }

    private func evict(
        directory: URL,
        maxBytes: Int,
        maxAge: TimeInterval
    ) {
        let resourceKeys: Set<URLResourceKey> = [
            .fileSizeKey,
            .contentModificationDateKey
        ]
        
        let fileURLs: [URL]
        do {
            fileURLs = try FileManager.default.contentsOfDirectory(
                at: directory,
                includingPropertiesForKeys: Array(resourceKeys),
                options: .skipsHiddenFiles
            )
            
        } catch {
            Logger.imageStoreAndRepository.error("Failed to read contents directory at '\(directory.path(percentEncoded: false))': \(error.localizedDescription)")
            return
        }

        typealias Entry = (url: URL, size: Int, date: Date)
        let entries: [Entry] = fileURLs.compactMap { url in
            guard
                let values: URLResourceValues = try? url.resourceValues(forKeys: resourceKeys),
                let size: Int = values.fileSize,
                let date: Date = values.contentModificationDate
            else {
                return nil
            }
            
            return (url, size, date)
        }

        // 1. Age-based eviction.
        // Runs always, regardless of size budget.
        let cutoffDate: Date = Date.now.addingTimeInterval(-maxAge)
        
        for entry in entries {
            if entry.date < cutoffDate {
                do {
                    try FileManager.default.removeItem(at: entry.url)
                    
                } catch let error as CocoaError where error.code == .fileNoSuchFile {
                    // ...
                    
                } catch {
                    Logger.imageStoreAndRepository.error("Failed to create directory at '\(entry.url.path(percentEncoded: false))': \(error.localizedDescription)")
                }
            }
        }

        // 2. LRU size-based eviction
        let entries2: [Entry] = entries.filter { $0.date >= cutoffDate }
        let totalBytes: Int = entries2.reduce(0) { $0 + $1.size }
        
        if totalBytes > maxBytes {
            let sortedEntries: [Entry] = entries2.sorted(by: \.date)
            
            var freed: Int = 0
            let toFree: Int = totalBytes - maxBytes

            for entry in sortedEntries {
                do {
                    try FileManager.default.removeItem(at: entry.url)
                    
                } catch let error as CocoaError where error.code == .fileNoSuchFile {
                    // ...
                    
                } catch {
                    Logger.imageStoreAndRepository.error("Failed to create directory at '\(entry.url.path(percentEncoded: false))': \(error.localizedDescription)")
                }
                
                freed += entry.size
                
                if freed >= toFree {
                    break
                }
            }
        }
    }
    
    // MARK: Helpers - File
    private func fileName(
        key: ImageDiskCache_OriginalKey
    ) -> String? {
        guard
            let identifier: String = key.parameter.diskIdentifier
        else {
            return nil
        }
        
        return sha256(identifier)
    }

    private func fileName(
        key: ImageDiskCache_ResizedKey
    ) -> String? {
        guard
            let identifier: String = key.parameter.diskIdentifier
        else {
            return nil
        }
        
        return sha256("\(identifier)_\(Int(key.width))x\(Int(key.height))")
    }

    private func fileURL(
        directory: URL,
        name: String
    ) -> URL {
        directory
            .appending(
                path: "\(name).jpg",
                directoryHint: .notDirectory
            )
    }

    // MARK: Helpers - Read / Write
    private func read(
        url: URL
    ) -> PlatformImage? {
        guard
            FileManager.default.fileExists(atPath: url.path())
        else {
            return nil
        }

        // Bump modification date — used as LRU access time
        do {
            try FileManager.default.setAttributes(
                [
                    .modificationDate: Date.now
                ],
                ofItemAtPath: url.path()
            )
            
        } catch {
            Logger.imageStoreAndRepository.error("Failed to set attributes to file at '\(url.path(percentEncoded: false))': \(error.localizedDescription)")
        }

        return PlatformImage(
            contentsOfFile: url.path()
        )
    }

    private func write(
        image: PlatformImage,
        url: URL,
        quality: CGFloat
    ) {
        guard
            let data: Data = image.jpegData(compressionQuality: quality)
        else {
            return
        }
        
        do {
            try data.write(
                to: url,
                options: .atomic // Writes to a temp file then renames, which prevents corrupt reads on crash
            )
            
        } catch {
            Logger.imageStoreAndRepository.error("Failed to create file at '\(url.path(percentEncoded: false))': \(error.localizedDescription)")
        }
    }

    // MARK: Helpers - Hashing
    private func sha256(
        _ string: String
    ) -> String {
        let digest: SHA256Digest = SHA256.hash(
            data: Data(string.utf8)
        )
        
        return digest
            .map { String(format: "%02x", $0) }
            .joined()
    }
}
