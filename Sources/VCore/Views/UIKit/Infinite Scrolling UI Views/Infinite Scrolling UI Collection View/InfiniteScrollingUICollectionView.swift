//
//  InfiniteScrollingUICollectionView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import OSLog

/// `UICollectionView` that handles infinite scrolling.
///
/// Contains property `paginationState`, controls pagination state.
/// When insufficient data is loaded in`UICollectionView`, or when pagination occurs, property is set to `loading` and delegate method is called.
/// Network call or persistent storage fetch request can be made.
/// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
///
/// Three methods must be called from `UIView` or `UIViewController` to ensure proper functionality:
/// - `detectPaginationFromScrollViewDidScroll`, which detects pagination on scroll.
/// - `detectPaginationFromCollectionViewCellForItem`, which detects instance in which loaded cells do not fill up `UICollectionView`'s content. So, pagination is called.
/// - `viewForSupplementaryElement`, which returns `UIActivityIndicator`.
///
/// `collectionViewDidScrollToBottom(sender:)` can be implemented as:
///
///     final class ViewController:
///         UIViewController,
///         UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
///         UICollectionViewDataSource,
///         InfiniteScrollingUICollectionViewDelegate
///     {
///         private lazy var collectionView: InfiniteScrollingUICollectionView = {
///             let layout: UICollectionViewFlowLayout = .init()
///             layout.minimumLineSpacing = 0
///             layout.minimumInteritemSpacing = 0
///             layout.scrollDirection = .vertical
///
///             let collectionView: InfiniteScrollingUICollectionView = .init(frame: .zero, collectionViewLayout: layout)
///
///             collectionView.translatesAutoresizingMaskIntoConstraints = false
///
///             collectionView.delegate = self
///             collectionView.dataSource = self
///             collectionView.infiniteScrollingDelegate = self
///
///             collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
///
///             return collectionView
///         }()
///
///         private static var dataChunk: [UIColor] { [.red, .green, .blue, .systemPink, .yellow] }
///         private var data: [UIColor] = ViewController.dataChunk
///
///         override func viewDidLoad() {
///             super.viewDidLoad()
///
///             view.backgroundColor = UIColor.systemBackground
///
///             view.addSubview(collectionView)
///             NSLayoutConstraint.activate([
///                 collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
///                 collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
///                 collectionView.topAnchor.constraint(equalTo: view.topAnchor),
///                 collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
///             ])
///
///             collectionView.reloadData()
///         }
///
///         func scrollViewDidScroll(_ scrollView: UIScrollView) {
///             collectionView.detectPaginationFromScrollViewDidScroll(scrollView)
///         }
///
///         func collectionView(
///             _ collectionView: UICollectionView,
///             layout collectionViewLayout: UICollectionViewLayout,
///             sizeForItemAt indexPath: IndexPath
///         ) -> CGSize {
///             .init(dimension: collectionView.frame.size.width / 3)
///         }
///
///         func collectionView(
///             _ collectionView: UICollectionView,
///             numberOfItemsInSection section: Int
///         ) -> Int {
///             data.count
///         }
///
///         func collectionView(
///             _ collectionView: UICollectionView,
///             cellForItemAt indexPath: IndexPath
///         ) -> UICollectionViewCell {
///             self.collectionView.detectPaginationFromCollectionViewCellForItem()
///
///             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
///
///             cell.contentView.backgroundColor = data[indexPath.row]
///
///             return cell
///         }
///
///         func collectionView(
///             _ collectionView: UICollectionView,
///             viewForSupplementaryElementOfKind kind: String,
///             at indexPath: IndexPath
///         ) -> UICollectionReusableView {
///             self.collectionView.viewForSupplementaryElement(kind: kind, at: indexPath)
///         }
///
///         func collectionViewDidScrollToBottom(
///             sender infiniteScrollingUICollectionView: InfiniteScrollingUICollectionView
///         ) {
///             DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
///                 guard let self else { return }
///
///                 data.append(contentsOf: Self.dataChunk)
///
///                 collectionView.paginationState = .canPaginate
///                 collectionView.reloadData()
///             }
///         }
///     }
///
open class InfiniteScrollingUICollectionView: UICollectionView {
    // MARK: Properties - Appearance
    private let appearance: InfiniteScrollingUICollectionViewAppearance
    
    /// Offset that needs to be dragged vertically up for pagination to occur.
    open var paginationOffset: CGFloat = 20
    
    // MARK: Properties - State
    /// Controls pagination state.
    /// When insufficient data is loaded in`UICollectionView`, or when pagination occurs, property is set to `loading` and delegate method is called.
    /// Network call or persistent storage fetch request can be made.
    /// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
    open var paginationState: PaginationState = .canPaginate
        { didSet { setActivityIndicatorState() } }
    
    // MARK: Properties - Delegate
    /// Delegate.
    open weak var infiniteScrollingDelegate: (any InfiniteScrollingUICollectionViewDelegate & UICollectionViewDataSource & UIScrollViewDelegate)?
    
    // MARK: Properties - Flags
    private var isFirstLayoutSubviews: Bool = false
    
    // MARK: Properties - Subviews
    private lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
    
    // MARK: Initializers
    /// Initializes `InfiniteScrollingUICollectionView`.
    public init(
        appearance: InfiniteScrollingUICollectionViewAppearance = .init(),
        frame: CGRect,
        collectionViewLayout: UICollectionViewLayout
    ) {
        self.appearance = appearance
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setUp()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if isFirstLayoutSubviews {
            isFirstLayoutSubviews = false
            
            if paginationState == .loading {
                setActivityIndicatorState()
            }
        }
    }
    
    // MARK: Setup
    private func setUp() {
        registerActivityIndicatorView()
    }
    
    private func registerActivityIndicatorView() {
        register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: UICollectionReusableView.self)
        )
        
        guard
            (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .vertical
        else {
            Logger.infiniteScrollingUICollectionView.critical("'scrollDirection' must be set to 'vertical' when using 'InfiniteScrollingUICollectionView'")
            return
        }
        
        (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(
            width: bounds.size.width,
            height: appearance.activityIndicatorContainerHeight
        )
    }
    
    // MARK: Detection
    /// Detects pagination on scroll.
    open func detectPaginationFromScrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.didScrollToBottom(offset: paginationOffset) else { return }
        
        paginate()
    }
    
    /// Detects instance in which loaded cells do not fill up UICollectionViews's content. So, pagination is called.
    open func detectPaginationFromCollectionViewCellForItem() {
        guard !contentHeightExceedsCollectionViewHeight else { return }
        
        paginate()
    }
    
    /// Returns `UIActivityIndicator`.
    open func viewForSupplementaryElement(kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard numberOfSections <= 1 else {
            Logger.infiniteScrollingUICollectionView.critical("'numberOfSections' must be set to '1' when using 'InfiniteScrollingUICollectionView'")
            return UICollectionReusableView()
        }
        
        guard kind == UICollectionView.elementKindSectionFooter else { return UICollectionReusableView() }
        
        let footer: UICollectionReusableView = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: UICollectionReusableView.self),
            for: indexPath
        )
        
        footer.addSubview(activityIndicator)
        
        activityIndicator.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: frame.size.width,
                height: appearance.activityIndicatorContainerHeight
            )
        )
        
        return footer
    }
    
    // MARK: Pagination
    private func paginate() {
        guard paginationState == .canPaginate else { return }
        
        paginationState = .loading
        infiniteScrollingDelegate?.collectionViewDidScrollToBottom(sender: self)
    }
    
    // MARK: Activity Indicator
    private func setActivityIndicatorState() {
        switch paginationState {
        case .loading:
            guard frame.size.width != 0 else { return }
            activityIndicator.startAnimating()
            
        case .canPaginate, .cannotPaginate:
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: Types
    /// Enumeration that represents state.
    public typealias PaginationState = InfiniteScrollingPaginationState
}

#endif

#if os(iOS) // iOS-only example

#Preview {
    final class ViewController:
        UIViewController,
        UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
        UICollectionViewDataSource,
        InfiniteScrollingUICollectionViewDelegate
    {
        // MARK: Properties - Data
        private lazy var data: [UIColor] = page
        private var page: [UIColor] { [.red, .green, .blue, .systemPink, .yellow] }
        
        // MARK: Properties - Subviews
        private lazy var collectionView: InfiniteScrollingUICollectionView = {
            let layout: UICollectionViewFlowLayout = .init()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .vertical

            let collectionView: InfiniteScrollingUICollectionView = .init(
                frame: .zero,
                collectionViewLayout: layout
            )

            collectionView.translatesAutoresizingMaskIntoConstraints = false

            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.infiniteScrollingDelegate = self

            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

            return collectionView
        }()

        // MARK: Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = UIColor.systemBackground

            view.addSubview(collectionView)

            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            collectionView.reloadData()
        }

        // MARK: Properties
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            .init(
                width: collectionView.frame.size.width / 3,
                height: collectionView.frame.size.width / 3
            )
        }

        // MARK: Scroll View Delegate
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            collectionView.detectPaginationFromScrollViewDidScroll(scrollView)
        }

        // MARK: Collection View Data Source
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            self.collectionView.detectPaginationFromCollectionViewCellForItem()

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

            cell.contentView.backgroundColor = data[indexPath.row]

            return cell
        }
        
        func collectionView(
            _ collectionView: UICollectionView,
            viewForSupplementaryElementOfKind kind: String,
            at indexPath: IndexPath
        ) -> UICollectionReusableView {
            self.collectionView.viewForSupplementaryElement(kind: kind, at: indexPath)
        }
        
        // MARK: Infinite Scrolling Table View Delegate
        func collectionViewDidScrollToBottom(sender infiniteScrollingCollectionView: InfiniteScrollingUICollectionView) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self else { return }

                data.append(contentsOf: page)

                collectionView.paginationState = .canPaginate
                collectionView.reloadData()
            }
        }
    }

    return ViewController()
}

#endif
