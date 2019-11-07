//
//  StickySheetCoordinator.swift
//  StickySheet
//
//  Created by Peter Verhage on 02/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

internal class StickySheetCoordinator: NSObject, UIAdaptivePresentationControllerDelegate {
    private var sheet: StickySheet?
    private weak var presentingCoordinator: StickySheetCoordinator?
    
    internal var onDidAttemptToDismiss: [StickySheetDidAttemptToDismissCallback] = []

    internal weak var viewController: UIViewController? {
        didSet {
            viewController?.presentationController?.delegate = self
        }
    }
    
    var presentedCoordinator: StickySheetCoordinator?
    
    init(sheet: StickySheet? = nil, presentingCoordinator: StickySheetCoordinator? = nil) {
        self.sheet = sheet
        self.presentingCoordinator = presentingCoordinator
    }
    
    func present(sheet: StickySheet) {
        if let presentedSheet = presentedCoordinator?.sheet {
            if presentedSheet.shouldDismiss() {
                presentedCoordinator?.dismiss()
            } else {
                return
            }
        }
        
        let coordinator = StickySheetCoordinator(sheet: sheet, presentingCoordinator: self)
        
        let rootView =
            StickySheetSupport(coordinator: coordinator) {
                sheet.content()
            }
        
        let viewController = UIHostingController(rootView: rootView)
        coordinator.viewController = viewController
        presentedCoordinator = coordinator
        self.viewController?.present(viewController, animated: true)
    }
    
    func dismissPresentedSheet() {
        guard let presentedCoordinator = presentedCoordinator, let sheet = presentedCoordinator.sheet else { return }

        if let viewController = presentedCoordinator.viewController {
            presentedCoordinator.viewController = nil
            viewController.dismiss(animated: true)
        }
        
        self.presentedCoordinator = nil
        
        if !sheet.shouldDismiss() {
            sheet.resetBinding()
        }
        
        sheet.onDismiss?()
    }

    func dismiss() {
        guard let presentingCoordinator = presentingCoordinator, presentingCoordinator.presentedCoordinator === self else { return }
        presentingCoordinator.dismissPresentedSheet()
    }
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        for callback in onDidAttemptToDismiss {
            callback.action()
        }
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewController = nil
        dismiss()
    }
}
