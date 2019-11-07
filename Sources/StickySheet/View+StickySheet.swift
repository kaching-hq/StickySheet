//
//  View+StickySheet.swift
//  StickySheet
//
//  Created by Peter Verhage on 02/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//

import SwiftUI

private struct StickySheetIsPresented<Sheet>: ViewModifier where Sheet: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let content: () -> Sheet
    
    func sheet() -> StickySheet {
        StickySheet(
            content: { AnyView(self.content()) },
            onDismiss: onDismiss,
            shouldDismiss: { !self.isPresented },
            resetBinding: { self.isPresented = false }
        )
    }
    
    func body(content: Content) -> some View {
        // We can't directly set a preference on content because if there are other sheet modifiers
        // at the same level in the view hierachy, the preferences would overwrite each-other.
        // We use an empty background view as workaround.
        content.background(
            EmptyView()
                .preference(
                    key: StickySheetPreferenceKey.self,
                    value: isPresented ? sheet() : nil
                )
        )
    }
}

private struct StickySheetItem<Item, Sheet>: ViewModifier where Item: Identifiable, Sheet: View {
    @Binding var item: Item?
    let onDismiss: (() -> Void)?
    let content: (Item) -> Sheet
    
    func sheet(for item: Item) -> StickySheet {
        StickySheet(
            content: { AnyView(self.content(item)) },
            onDismiss: onDismiss,
            shouldDismiss: { self.item?.id != item.id },
            resetBinding: { self.item = nil }
        )
    }
    
    func body(content: Content) -> some View {
        // We can't directly set a preference on content because if there are other sheet modifiers
        // at the same level in the view hierachy, the preferences would overwrite each-other.
        // We use an empty background view as workaround.
        content.background(
            EmptyView()
                .preference(
                    key: StickySheetPreferenceKey.self,
                    value: self.item != nil ? self.sheet(for: self.item!) : nil
                )
        )
    }
}

public extension View {
    func stickySheet<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content: View {
        modifier(StickySheetIsPresented(isPresented: isPresented, onDismiss: onDismiss, content: content))
    }
    
    func stickySheet<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item: Identifiable, Content: View {
        modifier(StickySheetItem(item: item, onDismiss: onDismiss, content: content))
    }
}
