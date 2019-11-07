//
//  StickySheetSupport.swift
//  StickySheet
//
//  Created by Peter Verhage on 07/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

internal struct StickySheetSupport<Content>: View where Content: View {
    private let coordinator: StickySheetCoordinator
    private let content: () -> Content
    @State private var presentationMode: StickySheetPresentationMode
    
    init(coordinator: StickySheetCoordinator, @ViewBuilder content: @escaping () -> Content) {
        self.coordinator = coordinator
        self.content = content
        _presentationMode = State(initialValue: StickySheetPresentationMode(coordinator: coordinator))
    }
    
    var body: some View {
        content()
            .environment(\.stickySheetPresentationMode, $presentationMode)
            .onPreferenceChange(StickySheetPreferenceKey.self) { sheet in
                if let sheet = sheet {
                    self.coordinator.present(sheet: sheet)
                } else {
                    self.coordinator.dismissPresentedSheet()
                }
            }
            .onPreferenceChange(StickySheetDidAttemptToDismissCallbacksPreferenceKey.self) { value in
                self.coordinator.onDidAttemptToDismiss = value
            }
            .onPreferenceChange(StickySheetIsModalInPresentationPreferenceKey.self) { value in
                self.coordinator.viewController?.isModalInPresentation = value ?? false
            }
    }
}
