//
//  HMSSegmentedControl.swift
//  HMSRoomKit
//
//  Created by Dmitry Fedoseyev on 16.08.2023.
//  Based on  https://blog.logrocket.com/build-swiftui-segmented-customizable-control/#creating-customizable-picker
//  Copyright © 2023 100ms. All rights reserved.
//

import SwiftUI

public struct HMSSegmentedControl<Data, Content> : View where Data: Hashable, Content: View {
    
    public let sources: [Data]
    public let selection: Data?
    private let itemBuilder: (Data) -> Content
    @State private var backgroundColor: Color = Color.black.opacity(0.05)
    func pickerBackgroundColor(_ color: Color) -> HMSSegmentedControl {
        var view = self
        view._backgroundColor = State(initialValue: color)
        return view
    }
    
    @State private var cornerRadius: CGFloat?
    func cornerRadius(_ cornerRadius: CGFloat) -> HMSSegmentedControl {
        var view = self
        view._cornerRadius = State(initialValue: cornerRadius)
        return view
    }
    @State private var borderColor: Color?
    func borderColor(_ borderColor: Color) -> HMSSegmentedControl {
        var view = self
        view._borderColor = State(initialValue: borderColor)
        return view
    }
    @State private var borderWidth: CGFloat?
    func borderWidth(_ borderWidth: CGFloat) -> HMSSegmentedControl {
        var view = self
        view._borderWidth = State(initialValue: borderWidth)
        return view
    }
    
    public init(
        _ sources: [Data],
        selection: Data?,
        @ViewBuilder itemBuilder: @escaping (Data) -> Content
    ) {
        self.sources = sources
        self.selection = selection
        self.itemBuilder = itemBuilder
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            if let selection = selection, let selectedIdx = sources.firstIndex(of: selection) {
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: cornerRadius ?? 6.0)
                            .foregroundColor(.accentColor)
                            .padding(EdgeInsets(top: borderWidth ?? 2, leading: borderWidth ?? 2, bottom: borderWidth ?? 2, trailing: borderWidth ?? 2))
                            .frame(width: geo.size.width / CGFloat(sources.count))
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                            .animation(.spring().speed(1.5), value: borderWidth)
                            .offset(x: geo.size.width / CGFloat(sources.count) * CGFloat(selectedIdx), y: 0)
                    }.frame(height: 36)
            }
            
            HStack(spacing: 0) {
                ForEach(sources, id: \.self) { item in
                    itemBuilder(item)
                }
            }
        }.background(
            RoundedRectangle(cornerRadius: cornerRadius ?? 6.0)
                .fill(
                    backgroundColor,
                    strokeBorder: borderColor ?? Color.clear,
                    lineWidth: borderWidth ?? .zero
                )
        )
        
    }
}

