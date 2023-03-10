//
//  DelegatingAsyncImage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Delegating Async Image
/// `View` that asynchronously loads and displays an `Image` with a delegated fetch handler.
///
/// You can customize request with access token and headers, implement custom caching, and more.
///
/// UI model can be passed as a parameter.
///
///     var body: some View {
///         DelegatingAsyncImage(
///             from: URL(string: "https://somewebsite.com/content/image.jpg")!,
///             fetch: fetchImage,
///             content: { phase in
///                 if let image = phase.image {
///                     image
///                         .resizable()
///                         .fitToAspect(1, contentMode: .fill)
///
///                 } else if phase.error != nil {
///                     ErrorView()
///
///                 } else {
///                     ProgressView()
///                 }
///             }
///         )
///             .frame(dimension: 200)
///     }
///
///     ...
///
///     private var cache: NSCache<NSString, UIImage> = .init()
///
///     private func fetchImage(url: URL) async throws -> Image {
///         let key: NSString = .init(string: url.absoluteString)
///
///         switch cache.object(forKey: key) {
///         case nil:
///             var request: NetworkRequest = .init(url: url)
///             try request.addHeaders(encodable: JSONAuthorizedRequestHeaders(token: "token"))
///
///             let data: Data = try await NetworkClient.default.data(from: request)
///             guard let uiImage: UIImage = .init(data: data) else { throw NetworkClientError.invalidData }
///
///             cache.setObject(uiImage, forKey: key)
///
///             return .init(uiImage: uiImage)
///
///         case let uiImage?:
///             return .init(uiImage: uiImage)
///         }
///     }
///
public struct DelegatingAsyncImage<Resource, Content, PlaceholderContent>: View
    where
        Resource: Equatable,
        Content: View,
        PlaceholderContent: View
{
    // MARK: Properties
    private let uiModel: DelegatingAsyncImageUIModel
    
    private let resource: Resource?
    private let fetchHandler: (Resource) async throws -> Image
    
    private let content: DelegatingAsyncImageContent<Content, PlaceholderContent>
    
    @State private var resourceFetched: Resource? // Needed for avoiding fetching an-already fetched image
    @State private var task: Task<Void, Never>? // Needed for canceling task, if resource changes during fetch
    @State private var result: Result<Image, Error>?
    
    // MARK: Initializers
    /// Initializes `DelegatingAsyncImage` with resource and fetch method.
    public init(
        uiModel: DelegatingAsyncImageUIModel = .init(),
        from resource: Resource?,
        fetch fetchHandler: @escaping (Resource) async throws -> Image
    )
        where
            Content == Never,
            PlaceholderContent == Never
    {
        self.uiModel = uiModel
        self.resource = resource
        self.fetchHandler = fetchHandler
        self.content = .empty
    }
    
    /// Initializes `DelegatingAsyncImage` with resource, fetch method, and content.
    public init(
        uiModel: DelegatingAsyncImageUIModel = .init(),
        from resource: Resource?,
        fetch fetchHandler: @escaping (Resource) async throws -> Image,
        @ViewBuilder content: @escaping (Image) -> Content
    )
        where
            PlaceholderContent == Never
    {
        self.uiModel = uiModel
        self.resource = resource
        self.fetchHandler = fetchHandler
        self.content = .content(
            content: content
        )
    }
    
    /// Initializes `DelegatingAsyncImage` with resource, fetch method, content, and placeholder content.
    public init(
        uiModel: DelegatingAsyncImageUIModel = .init(),
        from resource: Resource?,
        fetch fetchHandler: @escaping (Resource) async throws -> Image,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder placeholderContent: @escaping () -> PlaceholderContent
    ) {
        self.uiModel = uiModel
        self.resource = resource
        self.fetchHandler = fetchHandler
        self.content = .contentPlaceholder(
            content: content,
            placeholder: placeholderContent
        )
    }

    /// Initializes `DelegatingAsyncImage` with resource, fetch method, and phase-dependent content.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    public init(
        uiModel: DelegatingAsyncImageUIModel = .init(),
        from resource: Resource?,
        fetch fetchHandler: @escaping (Resource) async throws -> Image,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    )
        where PlaceholderContent == Never
    {
        self.uiModel = uiModel
        self.resource = resource
        self.fetchHandler = fetchHandler
        self.content = .contentWithPhase(
            content: { content($0.toAsyncImagePhase) }
        )
    }
    
    // MARK: Body
    public var body: some View {
        DispatchQueue.main.async(execute: fetch)
        
        return Group(content: {
            switch content {
            case .empty:
                bodyEmpty()
            
            case .content(let content):
                bodyContent(content)
            
            case .contentPlaceholder(let content, let placeholderContent):
                bodyContentPlaceholder(content, placeholderContent)
            
            case .contentWithPhase(let content):
                bodyContentBodyWithPhase(content)
            }
        })
    }
    
    @ViewBuilder private func bodyEmpty() -> some View {
        if case .success(let image) = result {
            image
        } else {
            defaultPlaceholder
        }
    }
    
    @ViewBuilder private func bodyContent(
        @ViewBuilder _ content: (Image) -> Content
    ) -> some View {
        if case .success(let image) = result {
            content(image)
        } else {
            defaultPlaceholder
        }
    }
    
    @ViewBuilder private func bodyContentPlaceholder(
        @ViewBuilder _ content: (Image) -> Content,
        @ViewBuilder _ placeholderContent: () -> PlaceholderContent
    ) -> some View {
        if case .success(let image) = result {
            content(image)
        } else {
            placeholderContent()
        }
    }
    
    private func bodyContentBodyWithPhase(
        @ViewBuilder _ content: (AsyncImagePhaseBackwardsCompatible) -> Content
    ) -> some View {
        content({
            switch result {
            case nil: return .empty
            case .success(let image): return .success(image)
            case .failure(let error): return .failure(error)
            }
        }())
    }
    
    private var defaultPlaceholder: some View {
        uiModel.colors.placeholder
    }
    
    // MARK: Fetch
    private func fetch() {
        guard let resource else { zeroData(); return }
        
        guard resource != resourceFetched else { return }
        
        startData(resource)
        
        task = .init(operation: {
            do {
                let image: Image = try await fetchHandler(resource)
                guard !Task.isCancelled else { zeroData(); return }
                
                finalizeData(.success(image))
                
            } catch {
                guard !Task.isCancelled else { zeroData(); return }
                
                finalizeData(.failure(error))
            }
        })
    }
    
    private func zeroData() {
        resourceFetched = nil
        task?.cancel(); task = nil
        result = nil
    }
    
    private func startData(_ resource: Resource) {
        resourceFetched = resource
        task?.cancel(); task = nil
        result = nil
    }
    
    private func finalizeData(_ data: Result<Image, Error>) {
        task = nil
        result = data
    }
}
