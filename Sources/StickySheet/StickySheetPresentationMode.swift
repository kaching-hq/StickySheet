//
//  StickySheetPresentationMode.swift
//  StickySheet
//
//  Created by Peter Verhage on 02/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

public struct StickySheetPresentationMode {
    internal var coordinator: StickySheetCoordinator?
    
    public var isPresented: Bool {
        get {
            coordinator?.viewController != nil
        }
    }
    
    init(coordinator: StickySheetCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    public func dismiss() {
        coordinator?.dismiss()
    }
}

private struct StickySheetPresentationModeEnvironmentKey: EnvironmentKey {
    static var defaultValue: Binding<StickySheetPresentationMode> = .constant(StickySheetPresentationMode())
}

public extension EnvironmentValues {
    var stickySheetPresentationMode: Binding<StickySheetPresentationMode> {
        get { self[StickySheetPresentationModeEnvironmentKey.self] }
        set { self[StickySheetPresentationModeEnvironmentKey.self] = newValue}
    }
}
