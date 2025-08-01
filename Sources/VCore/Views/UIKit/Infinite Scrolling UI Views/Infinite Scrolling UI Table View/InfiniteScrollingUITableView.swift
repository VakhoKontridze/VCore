//
//  InfiniteScrollingUITableView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// `UITableView` that handles infinite scrolling.
///
/// Contains property `paginationState`, controls pagination state.
/// When insufficient data is loaded in`UITableView`, or when pagination occurs, property is set to `loading` and delegate method is called.
/// Network call or persistent storage fetch request can be made.
/// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
///
/// Two methods must be called from `UIView` or `UIViewController` to ensure proper functionality:
/// - `detectPaginationFromScrollViewDidScroll`, which detects pagination on scroll.
/// - `detectPaginationFromTableViewCellForRow`, which detects instance in which loaded cells do not fill up UITableViews's content. So, pagination is called.
///
/// `tableViewDidScrollToBottom(sender:)` can be implemented as:
///
///     final class ViewController:
///         UIViewController,
///         UITableViewDelegate, UITableViewDataSource,
///         InfiniteScrollingUITableViewDelegate
///     {
///         private lazy var tableView: InfiniteScrollingUITableView = {
///             let tableView: InfiniteScrollingUITableView = .init()
///
///             tableView.translatesAutoresizingMaskIntoConstraints = false
///
///             tableView.delegate = self
///             tableView.dataSource = self
///             tableView.infiniteScrollingDelegate = self
///
///             tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
///
///             return tableView
///         }()
///
///         private static var dataChunk: [String] { (1...5).map { String($0) } }
///         private var data: [String] = ViewController.dataChunk
///
///         override func viewDidLoad() {
///             super.viewDidLoad()
///
///             view.backgroundColor = UIColor.systemBackground
///
///             view.addSubview(tableView)
///             NSLayoutConstraint.activate([
///                 tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
///                 tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
///                 tableView.topAnchor.constraint(equalTo: view.topAnchor),
///                 tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
///             ])
///
///             tableView.reloadData()
///         }
///
///         func scrollViewDidScroll(_ scrollView: UIScrollView) {
///             tableView.detectPaginationFromScrollViewDidScroll(scrollView)
///         }
///
///         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
///             data.count
///         }
///
///         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
///             self.tableView.detectPaginationFromTableViewCellForRow()
///
///             guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
///
///             cell.textLabel?.text = data[indexPath.row]
///
///             return cell
///         }
///
///         func tableViewDidScrollToBottom(sender infiniteScrollingUITableView: InfiniteScrollingUITableView) {
///             DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
///                 guard let self else { return }
///
///                 data.append(contentsOf: Self.dataChunk)
///
///                 tableView.paginationState = .canPaginate
///                 tableView.reloadData()
///             }
///         }
///     }
///
open class InfiniteScrollingUITableView: UITableView {
    // MARK: Properties - Appearance
    private let appearance: InfiniteScrollingUITableViewAppearance
    
    // MARK: Properties - State
    /// Controls pagination state.
    /// When insufficient data is loaded in`UITableView`, or when pagination occurs, property is set to `loading` and delegate method is called.
    /// Network call or persistent storage fetch request can be made.
    /// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
    open var paginationState: PaginationState = .canPaginate
        { didSet { setActivityIndicatorState() } }
    
    // MARK: Properties - Delegate
    /// Delegate.
    open weak var infiniteScrollingDelegate: (any InfiniteScrollingUITableViewDelegate & UITableViewDataSource & UIScrollViewDelegate)?
    
    // MARK: Properties - Flags
    private var isFirstLayoutSubviews: Bool = false
    
    // MARK: Initializers
    /// Initializes `InfiniteScrollingUITableView`.
    public init(
        appearance: InfiniteScrollingUITableViewAppearance = .init(),
        frame: CGRect = .zero,
        style: UITableView.Style = .plain
    ) {
        self.appearance = appearance
        super.init(frame: frame, style: style)
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
    
    // MARK: Detection
    /// Detects pagination on scroll.
    open func detectPaginationFromScrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.didScrollToBottom(offset: appearance.paginationOffset) else { return }
        
        paginate()
    }
    
    /// Detects instance in which loaded cells do not fill up UITableViews's content. So, pagination is called.
    open func detectPaginationFromTableViewCellForRow() {
        guard !contentHeightExceedsTableViewHeight else { return }
        
        paginate()
    }
    
    // MARK: Pagination
    private func paginate() {
        guard paginationState == .canPaginate else { return }
        
        paginationState = .loading
        infiniteScrollingDelegate?.tableViewDidScrollToBottom(sender: self)
    }
    
    // MARK: Activity Indicator
    private func setActivityIndicatorState() {
        switch paginationState {
        case .loading:
            guard frame.size.width != 0 else { return }
            
            tableFooterView = InfiniteScrollingUITableViewActivityIndicatorView(
                appearance: appearance,
                tableView: self
            )
            
        case .canPaginate, .cannotPaginate:
            tableFooterView = nil
        }
    }
}

#endif

#if os(iOS) // iOS-only example

#Preview {
    final class ViewController:
        UIViewController,
        UITableViewDelegate, UITableViewDataSource,
        InfiniteScrollingUITableViewDelegate
    {
        // MARK: Subviews
        private lazy var tableView: InfiniteScrollingUITableView = {
            let tableView: InfiniteScrollingUITableView = .init()

            tableView.translatesAutoresizingMaskIntoConstraints = false

            tableView.delegate = self
            tableView.dataSource = self
            tableView.infiniteScrollingDelegate = self

            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

            return tableView
        }()

        // MARK: Properties
        private lazy var data: [String] = page
        private var page: [String] = (1...5).map { String($0) }

        // MARK: Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = UIColor.systemBackground

            view.addSubview(tableView)

            NSLayoutConstraint.activate([
                tableView.constraintLeading(to: view),
                tableView.constraintTrailing(to: view),
                tableView.constraintTop(to: view, layoutGuide: .safeArea),
                tableView.constraintBottom(to: view)
            ])

            tableView.reloadData()
        }

        // MARK: Scroll View Delegate
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            tableView.detectPaginationFromScrollViewDidScroll(scrollView)
        }

        // MARK: Table View Delegate
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            data.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            self.tableView.detectPaginationFromTableViewCellForRow()

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return .init() }

            cell.textLabel?.text = data[indexPath.row]

            return cell
        }

        // MARK: Infinite Scrolling Table View Delegate
        func tableViewDidScrollToBottom(sender infiniteScrollingUITableView: InfiniteScrollingUITableView) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self else { return }

                data.append(contentsOf: page)

                tableView.paginationState = .canPaginate
                tableView.reloadData()
            }
        }
    }

    return ViewController()
}

#endif
