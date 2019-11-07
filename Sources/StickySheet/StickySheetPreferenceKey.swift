//
//  StickySheetPreferenceKey.swift
//  StickySheet
//
//  Created by Peter Verhage on 09/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

internal struct StickySheetPreferenceKey: PreferenceKey {
    typealias Value = StickySheet?
    
    static var defaultValue: Value = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let result = nextValue() ?? value
        value = result
    }
}
