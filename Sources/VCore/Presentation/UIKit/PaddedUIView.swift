//
//  PaddedUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20/5/26.
//

import UIKit

/// Container that pads underlying `UIView`.
public final class PaddedUIView: UIView {
    // MARK: Properties - Appearance
    private var constraintLeading: NSLayoutConstraint?
    private var constraintTrailing: NSLayoutConstraint?
    private var constraintTop: NSLayoutConstraint?
    private var constraintBottom: NSLayoutConstraint?
    
    /// Leading margin.
    public var marginLeading: CGFloat {
        get { constraintLeading?.constant ?? 0 }
        set { constraintLeading?.constant = newValue }
    }
    
    /// Trailing margin.
    public var marginTrailing: CGFloat {
        get { (constraintTrailing?.constant).map { -$0 } ?? 0 }
        set { constraintTrailing?.constant = -newValue }
    }
    
    /// Top margin.
    public var marginTop: CGFloat {
        get { constraintTop?.constant ?? 0 }
        set { constraintTop?.constant = newValue }
    }
    
    /// Bottom margin.
    public var marginBottom: CGFloat {
        get { (constraintBottom?.constant).map { -$0 } ?? 0 }
        set { constraintBottom?.constant = -newValue }
    }
    
    // MARK: Properties - Subviews
    public let view: UIView
    
    // MARK: Initializers
    /// Initializes `PaddedUIView` with underlying view.
    public init(
        view: UIView
    ) {
        self.view = view
        super.init(frame: .zero)
        setUp()
    }
    
    /// Initializes `PaddedUIView` with underlying view and margins.
    public convenience init(
        leadingMargin: CGFloat,
        trailingMargin: CGFloat,
        topMargin: CGFloat,
        bottomMargin: CGFloat,
        view: UIView
    ) {
        self.init(view: view)
        
        setMargins(
            leading: leadingMargin,
            trailing: trailingMargin,
            top: topMargin,
            bottom: bottomMargin
        )
    }
    
    /// Initializes `PaddedUIView` with underlying view and margins.
    public convenience init(
        horizontalMargins: CGFloat,
        verticalMargins: CGFloat,
        view: UIView
    ) {
        self.init(view: view)
        
        setMargins(
            horizontal: horizontalMargins,
            vertical: verticalMargins
        )
    }
    
    /// Initializes `PaddedUIView` with underlying view and margins.
    public convenience init(
        margin: CGFloat,
        view: UIView
    ) {
        self.init(view: view)
        
        setMargins(
            margin: margin
        )
    }
    
    /// Initializes `PaddedUIView` with underlying view and margins.
    public convenience init(
        edgeInsets: UIEdgeInsets,
        view: UIView
    ) {
        self.init(view: view)
        
        setMargins(
            edgeInsets: edgeInsets
        )
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    private func setUp() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        addSubview(view)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor)
                .storing(in: &constraintLeading),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
                .storing(in: &constraintTrailing),
            view.topAnchor.constraint(equalTo: topAnchor)
                .storing(in: &constraintTop),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
                .storing(in: &constraintBottom),
        ])
    }
    
    // MARK: Configuration
    /// Sets margins.
    public func setMargins(
        leading: CGFloat,
        trailing: CGFloat,
        top: CGFloat,
        bottom: CGFloat
    ) {
        marginLeading = leading
        marginTrailing = trailing
        marginTop = top
        marginBottom = bottom
    }
    
    /// Sets horizontal and vertical margins.
    public func setMargins(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        marginLeading = horizontal
        marginTrailing = horizontal
        marginTop = vertical
        marginBottom = vertical
    }
    
    /// Sets margin.
    public func setMargins(
        margin: CGFloat
    ) {
        marginLeading = margin
        marginTrailing = margin
        marginTop = margin
        marginBottom = margin
    }
    
    /// Sets margins from `UIEdgeInsets`.
    public func setMargins(
        edgeInsets: UIEdgeInsets
    ) {
        marginLeading = edgeInsets.left
        marginTrailing = edgeInsets.right
        marginTop = edgeInsets.top
        marginBottom = edgeInsets.bottom
    }
}
