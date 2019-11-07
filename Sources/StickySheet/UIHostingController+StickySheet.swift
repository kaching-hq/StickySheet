//
//  UIHostingController+StickySheet.swift
//  StickySheet
//
//  Created by Peter Verhage on 07/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

public extension UIHostingController {
    static func withStickySheetSupport(rootView: Content) -> UIViewController {
        let coordinator = StickySheetCoordinator()
        
        let stickySheetSupportingRootView =
            StickySheetSupport(coordinator: coordinator) {
                rootView
            }

        let viewController = UIHostingController<StickySheetSupport<Content>>(rootView: stickySheetSupportingRootView)
        coordinator.viewController = viewController
        
        return viewController
    }
}
