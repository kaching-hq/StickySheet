//
//  StickySheetIsModalInPresentation.swift
//  StickySheet
//
//  Created by Peter Verhage on 02/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

internal struct StickySheetIsModalInPresentationPreferenceKey: PreferenceKey {
    typealias Value = Bool?
    
    static var defaultValue: Value = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() ?? value
    }
}

public extension View {
    func stickySheetIsModalInPresentation(_ value: Bool) -> some View {
        return preference(key: StickySheetIsModalInPresentationPreferenceKey.self, value: value)
    }
}
