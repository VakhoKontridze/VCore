//
//  Preview_AlignedUICollectionViewFlowLayoutViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.01.24.
//

#if DEBUG

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Aligned UI Collection View Flow Layout View Controller
final class Preview_AlignedUICollectionViewFlowLayoutViewController:
    UIViewController,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
{
    // MARK: Subviews
    private lazy var collectionView: UICollectionView = {
        do {
            layout.headerReferenceSize = CGSize(width: 0, height: 10)
            layout.footerReferenceSize = CGSize(width: 0, height: 10)

            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10

            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }

        let collectionView: UICollectionView = .init(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            Preview_AlignedUICollectionViewCell.self,
            forCellWithReuseIdentifier: Preview_AlignedUICollectionViewCell.dequeueID
        )

        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: UICollectionReusableView.self)
        )
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: UICollectionReusableView.self)
        )

        return collectionView
    }()

    // MARK: Properties
    private let layout: UICollectionViewFlowLayout
    private var data: [UIColor] = [[UIColor]].init(repeating: [.red, .green, .blue], count: 10).flatMap { $0 }.shuffled()

    // MARK: Initializers
    init(layout: UICollectionViewFlowLayout) {
        self.layout = layout
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

#if !(os(tvOS) || os(watchOS))
        view.backgroundColor = UIColor.systemBackground
#endif

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.constraintLeading(to: view, constant: 20),
            collectionView.constraintTrailing(to: view, constant: -20),
            collectionView.constraintTop(to: view, layoutGuide: .safeArea, constant: 20),
            collectionView.constraintBottom(to: view, layoutGuide: .safeArea, constant: -20)
        ])

        collectionView.reloadData()
    }

    // MARK: Collection View DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: String(describing: UICollectionReusableView.self),
                for: indexPath
            )

            view.frame = CGRect(
                origin: view.frame.origin,
                size: CGSize(width: collectionView.frame.size.width, height: 10)
            )
            view.backgroundColor = .red

            return view

        case UICollectionView.elementKindSectionFooter:
            let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: String(describing: UICollectionReusableView.self),
                for: indexPath
            )

            view.frame = CGRect(
                origin: view.frame.origin,
                size: CGSize(width: collectionView.frame.size.width, height: 10)
            )
            view.backgroundColor = .blue

            return view

        default:
            fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Preview_AlignedUICollectionViewCell.dequeueID, for: indexPath)
                as? Preview_AlignedUICollectionViewCell
        else {
            fatalError()
        }

        cell.configure(color: data[indexPath.row])

        return cell
    }
}

// MARK: - Aligned UI Collection View Cell
private final class Preview_AlignedUICollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var widthConstraint: NSLayoutConstraint?

    static var dequeueID: String { .init(describing: self) }

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        NSLayoutConstraint.activate([
            contentView.constraintWidth(to: nil, priority: .defaultLow)
                .storing(in: &widthConstraint),
            contentView.constraintHeight(to: nil, constant: 32)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Configuration
    func configure(color: UIColor) {
        contentView.backgroundColor = color.withAlphaComponent(0.3)
        widthConstraint?.constant = .random(in: 20...100)
    }
}

#endif

#endif
