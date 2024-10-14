//
//  NSCollectionReusableView.swift
//  ChatLayout
//
//  Created by JH on 2024/1/12.
//  Copyright © 2024 Eugene Kazaev. All rights reserved.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public class CollectionReusableView: NSUIView, NSCollectionViewElement {
    public override var isFlipped: Bool { true }
}

#endif
