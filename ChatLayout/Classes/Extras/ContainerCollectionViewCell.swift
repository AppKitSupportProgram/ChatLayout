//
// ChatLayout
// ContainerCollectionViewCell.swift
// https://github.com/ekazaev/ChatLayout
//
// Created by Eugene Kazaev in 2020-2022.
// Distributed under the MIT license.
//

import Foundation
import UIKit

/// A container `UICollectionViewCell` that constraints its contained view to its margins.
public final class ContainerCollectionViewCell<CustomView: UIView>: UICollectionViewCell {

    /// Default reuse identifier is set with the class name.
    public static var reuseIdentifier: String {
        return String(describing: self)
    }

    /// Contained view.
    public lazy var customView = CustomView(frame: bounds)

    /// An instance of `ContainerCollectionViewCellDelegate`
    public weak var delegate: ContainerCollectionViewCellDelegate?

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    /// - Parameter frame: The frame rectangle for the view, measured in points. The origin of the frame is relative
    ///   to the superview in which you plan to add it.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    @available(*, unavailable, message: "Use init(reuseIdentifier:) instead")
    /// This constructor is unavailable.
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Performs any clean up necessary to prepare the view for use again.
    public override func prepareForReuse() {
        super.prepareForReuse()
        delegate?.prepareForReuse()
    }

    /// Gives the cell a chance to modify the attributes provided by the layout object.
    /// - Parameter layoutAttributes: The attributes provided by the layout object. These attributes represent the values that the layout intends to apply to the cell.
    /// - Returns: Modified `UICollectionViewLayoutAttributes`
    public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let chatLayoutAttributes = layoutAttributes as? ChatLayoutAttributes else {
            return super.preferredLayoutAttributesFitting(layoutAttributes)
        }
        delegate?.apply(chatLayoutAttributes)
        let resultingLayoutAttributes: ChatLayoutAttributes
        if let preferredLayoutAttributes = delegate?.preferredLayoutAttributesFitting(chatLayoutAttributes) {
            resultingLayoutAttributes = preferredLayoutAttributes
        } else if let chatLayoutAttributes = super.preferredLayoutAttributesFitting(chatLayoutAttributes) as? ChatLayoutAttributes {
            delegate?.modifyPreferredLayoutAttributesFitting(chatLayoutAttributes)
            resultingLayoutAttributes = chatLayoutAttributes
        } else {
            resultingLayoutAttributes = chatLayoutAttributes
        }
        return resultingLayoutAttributes
    }

    /// Applies the specified layout attributes to the view.
    /// - Parameter layoutAttributes: The layout attributes to apply.
    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let chatLayoutAttributes = layoutAttributes as? ChatLayoutAttributes else {
            return
        }
        super.apply(layoutAttributes)
        delegate?.apply(chatLayoutAttributes)
    }

    private func setupSubviews() {
        contentView.addSubview(customView)
        insetsLayoutMarginsFromSafeArea = false
        layoutMargins = .zero

        contentView.insetsLayoutMarginsFromSafeArea = false
        contentView.layoutMargins = .zero

        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

}
