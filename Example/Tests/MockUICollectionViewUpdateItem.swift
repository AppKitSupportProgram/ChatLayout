//
// ChatLayout
// MockUICollectionViewUpdateItem.swift
// https://github.com/ekazaev/ChatLayout
//
// Created by Eugene Kazaev in 2020-2025.
// Distributed under the MIT license.
//
// Become a sponsor:
// https://github.com/sponsors/ekazaev
//

@testable import ChatLayout
import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

class MockUICollectionViewUpdateItem: NSUICollectionViewUpdateItem {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
    
    typealias Action = NSCollectionView.UpdateAction
    
#endif

    // swiftlint:disable identifier_name
    var _indexPathBeforeUpdate: IndexPath?
    var _indexPathAfterUpdate: IndexPath?
    var _updateAction: Action
    // swiftlint:enable identifier_name

    init(indexPathBeforeUpdate: IndexPath?, indexPathAfterUpdate: IndexPath?, action: Action) {
        _indexPathBeforeUpdate = indexPathBeforeUpdate
        _indexPathAfterUpdate = indexPathAfterUpdate
        _updateAction = action
        super.init()
    }

    override var indexPathBeforeUpdate: IndexPath? {
        _indexPathBeforeUpdate
    }

    override var indexPathAfterUpdate: IndexPath? {
        _indexPathAfterUpdate
    }

    override var updateAction: Action {
        _updateAction
    }
}
