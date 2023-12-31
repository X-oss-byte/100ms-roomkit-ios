//
//  HMSPinnedChatMessageView.swift
//  HMSSDK
//
//  Created by Pawan Dixit on 16/08/2023.
//  Copyright © 2023 100ms. All rights reserved.
//

import SwiftUI

struct HMSPinnedChatMessageView: View {
    
    let text: String
    var isPartOfTransparentChat: Bool
    var onUnpin: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "pin").foreground(.onSurfaceMedium)
            Text(text)
                .font(.captionRegular12)
                .foreground(isPartOfTransparentChat ? .white : .onSurfaceHigh)
                .shadow(color: isPartOfTransparentChat ? .black : .clear, radius: 3, y: 1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                onUnpin()
            } label: {
                Image(systemName: "xmark")
            }.foreground(.onSurfaceMedium)
        }
        .padding(12)
        .cornerRadius(8)
    }
}

struct HMSPinnedChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        HMSPinnedChatMessageView(text: "This is pinned message", isPartOfTransparentChat: true) {}
            .environmentObject(HMSUITheme())
    }
}
