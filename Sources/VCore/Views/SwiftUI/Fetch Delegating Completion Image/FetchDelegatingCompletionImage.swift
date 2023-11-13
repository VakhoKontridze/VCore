//
//  FetchDelegatingCompletionImage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.07.23.
//

import SwiftUI

// MARK: - Fetch Delegating Completion Image
/// `View` that asynchronously loads and displays an `Image` with a delegated fetch handler.
///
/// Completion-based equivalent of `FetchDelegatingAsyncImage`.
///
/// Request can be customized with access token and headers, implement custom caching, and more.
///
///     var body: some View {
///         FetchDelegatingCompletionImage(
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
///         .frame(dimension: 200)
///     }
///
///     ...
///
///     private var cache: NSCache<NSString, UIImage> = .init()
///
///     private func fetchImage(
///         url: URL,
///         completion: @escaping (Result<Image, any Error>) -> Void
///     ) {
///         let key: NSString = .init(string: url.absoluteString)
///
///         switch cache.object(forKey: key) {
///         case nil:
///             ...
///
///             ...(completion: {
///                 ...
///
///                 cache.setObject(uiImage, forKey: key)
///
///                 completion(.success(Image(uiImage: uiImage)))
///             })
///
///         case let uiImage?:
///             completion(.success(Image(uiImage: uiImage)))
///         }
///     }
///
public struct FetchDelegatingCompletionImage<Parameter, Content, PlaceholderContent>: View
    where
        Parameter: Equatable,
        Content: View,
        PlaceholderContent: View
{
    // MARK: Properties
    private let uiModel: FetchDelegatingCompletionImageUIModel

    private let parameter: Parameter?
    private let fetchHandler: (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void

    private let content: FetchDelegatingCompletionImageContent<Content, PlaceholderContent>

    @State private var parameterFetched: Parameter? // Needed for avoiding fetching an-already fetched image
    @State private var result: Result<Image, any Error>?

    // MARK: Initializers
    /// Initializes `FetchDelegatingCompletionImage` with parameter and fetch method.
    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void
    )
        where
            Content == Never,
            PlaceholderContent == Never
    {
        self.uiModel = uiModel
        self.parameter = parameter
        self.fetchHandler = fetchHandler
        self.content = .empty
    }

    /// Initializes `FetchDelegatingCompletionImage` with parameter, fetch method, and content.
    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void,
        @ViewBuilder content: @escaping (Image) -> Content
    )
        where
            PlaceholderContent == Never
    {
        self.uiModel = uiModel
        self.parameter = parameter
        self.fetchHandler = fetchHandler
        self.content = .content(
            content: content
        )
    }

    /// Initializes `FetchDelegatingCompletionImage` with parameter, fetch method, content, and placeholder content.
    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder placeholderContent: @escaping () -> PlaceholderContent
    ) {
        self.uiModel = uiModel
        self.parameter = parameter
        self.fetchHandler = fetchHandler
        self.content = .contentPlaceholder(
            content: content,
            placeholder: placeholderContent
        )
    }

    /// Initializes `FetchDelegatingCompletionImage` with parameter, fetch method, and phase-dependent content.
    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    )
        where PlaceholderContent == Never
    {
        self.uiModel = uiModel
        self.parameter = parameter
        self.fetchHandler = fetchHandler
        self.content = .contentWithPhase(
            content: content
        )
    }

    // MARK: Body
    public var body: some View {
        ZStack(content: { // `ZSack` is used as a container
            switch content {
            case .empty:
                if case .success(let image) = result {
                    image
                } else {
                    defaultPlaceholder
                }

            case .content(let content):
                if case .success(let image) = result {
                    content(image)
                } else {
                    defaultPlaceholder
                }

            case .contentPlaceholder(let content, let placeholderContent):
                if case .success(let image) = result {
                    content(image)
                } else {
                    placeholderContent()
                }

            case .contentWithPhase(let content):
                content({
                    switch result {
                    case nil: AsyncImagePhase.empty
                    case .success(let image): AsyncImagePhase.success(image)
                    case .failure(let error): AsyncImagePhase.failure(error)
                    }
                }())
            }
        })
        .applyModifier({
            if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
                $0
                    .onChange(
                        of: parameter,
                        initial: true,
                        { (_, newValue) in  fetch(from: newValue) }
                    )
            } else {
                $0
                    .onAppear(perform: { fetch(from: parameter) })
                    .onChange(of: parameter, perform: { fetch(from: $0) })
            }
        })
        .onDisappear(perform: {
            if uiModel.removesImageOnDisappear { reset() }
        })
    }

    private var defaultPlaceholder: some View {
        uiModel.placeholderColor
    }

    // MARK: Fetch
    private func fetch(
        from parameter: Parameter?
    ) {
        guard let parameter else {
            zeroData()
            return
        }

        guard parameter != parameterFetched else { return }

        parameterFetched = parameter
        if uiModel.removesImageOnParameterChange { result = nil }

        fetchHandler(parameter, { result = $0 })
    }

    private func zeroData() {
        parameterFetched = nil
        result = nil
    }

    private func reset() {
        zeroData()
    }
}
