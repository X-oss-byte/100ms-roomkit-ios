//
//  HMSLocalPeerView.swift
//  HMSRoomKit
//
//  Created by Pawan Dixit on 15/06/2023.
//  Copyright © 2023 100ms. All rights reserved.
//

import SwiftUI
import HMSSDK
import HMSRoomModels

public struct HMSPeerScreenTile: View {
    
    // Params
    @ObservedObject public var peerModel: HMSPeerModel
    public var isZoomAndPanEnabled = true
    
    public init(peerModel: HMSPeerModel, isZoomAndPanEnabled: Bool = true){
        self.peerModel = peerModel
        self.isZoomAndPanEnabled = isZoomAndPanEnabled
    }
    
    public var body: some View {
        
        GeometryReader { proxy in
            Group {
                if let screenTrack = peerModel.screenTrackModels.first {
                    HMSVideoTrackView(trackModel: screenTrack, contentMode: .scaleAspectFit, isZoomAndPanEnabled: isZoomAndPanEnabled)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
//            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .bottomLeading) {
                HMSParticipantScreenNameLabel(peerModel: peerModel)
                    .padding(10)
            }
        }
    }
}

struct HMSPeerScreenTile_Previews: PreviewProvider {
    static var previews: some View {
#if Preview
        HMSPeerScreenTile(peerModel: HMSPeerModel())
            .environmentObject(HMSUITheme())
#endif
    }
}
