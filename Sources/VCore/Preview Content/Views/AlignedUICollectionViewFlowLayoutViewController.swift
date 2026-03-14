//
//  AlignedUICollectionViewFlowLayoutViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.01.24.
//

#if DEBUG

#if canImport(UIKit) && !os(watchOS)

import UIKit

final class AlignedUICollectionViewFlowLayoutViewController:
    UIViewController,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
{
    // MARK: Properties - Model
    private var data: [UIColor] = [[UIColor]](repeating: [.red, .green, .blue], count: 10).flatMap { $0 }.shuffled()
    
    // MARK: Properties - Subviews
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
            AlignedUICollectionViewCell.self,
            forCellWithReuseIdentifier: AlignedUICollectionViewCell.dequeueID
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

    private let layout: UICollectionViewFlowLayout

    // MARK: Initializers
    init(layout: UICollectionViewFlowLayout) {
        self.layout = layout
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
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
            view.backgroundColor = UIColor.red

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
            view.backgroundColor = UIColor.blue

            return view

        default:
            fatalError() // Unsafe (DEBUG)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlignedUICollectionViewCell.dequeueID, for: indexPath)
                as? AlignedUICollectionViewCell
        else {
            fatalError() // Unsafe (DEBUG)
        }

        cell.configure(color: data[indexPath.row])

        return cell
    }
}

private final class AlignedUICollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var widthConstraint: NSLayoutConstraint?

    static var dequeueID: String { .init(describing: self) }

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 0).withPriority(.defaultLow)
                .storing(in: &widthConstraint),
            contentView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Configuration
    func configure(color: UIColor) {
        contentView.backgroundColor = color.withAlphaComponent(0.3)
        widthConstraint?.constant = CGFloat.random(in: 20...100)
    }
}

#endif

#endif
