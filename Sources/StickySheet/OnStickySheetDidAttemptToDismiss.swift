//
//  OnStickySheetDidAttemptToDismiss.swift
//  StickySheet
//
//  Created by Peter Verhage on 02/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

internal class StickySheetDidAttemptToDismissCallback: Equatable {
    let action: () -> Void
    
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    static func == (lhs: StickySheetDidAttemptToDismissCallback, rhs: StickySheetDidAttemptToDismissCallback) -> Bool {
        return lhs === rhs
    }
}

internal struct StickySheetDidAttemptToDismissCallbacksPreferenceKey: PreferenceKey {
    typealias Value = [StickySheetDidAttemptToDismissCallback]
    
    static var defaultValue: Value = []
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

public extension View {
    func onStickySheetDidAttemptToDismiss(perform action: @escaping () -> Void) -> some View {
        return preference(key: StickySheetDidAttemptToDismissCallbacksPreferenceKey.self, value: [StickySheetDidAttemptToDismissCallback(action)])
    }
}
