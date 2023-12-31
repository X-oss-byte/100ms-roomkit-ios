//
//  HMSRolePickerView.swift
//  HMSSDK
//
//  Created by Pawan Dixit on 16/08/2023.
//  Copyright © 2023 100ms. All rights reserved.
//

import SwiftUI
import HMSSDK
import HMSRoomModels

struct HMSRolePickerOptionsView: View {
    @EnvironmentObject var currentTheme: HMSUITheme
    @EnvironmentObject var roomModel: HMSRoomModel
    @Binding var selectedOption: HMSRecipient
    
    @State var searchQuery: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            HMSOptionsHeaderView(title: "Send Message To") {
                presentationMode.wrappedValue.dismiss()
            } onBack: {}
            HStack {
                HMSSearchField(searchText: $searchQuery, placeholder: "Search for participants", style: .dark)
            }.padding(.horizontal, 24)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Button {
                        selectedOption = .everyone
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(assetName: "group")
                                .foreground(.onSurfaceHigh)
                            Text(HMSRecipient.everyone.toString())
                                .font(.subtitle2Semibold14)
                                .foreground(.onSurfaceHigh)
                        }
                        .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 0))
                    }
                    HMSDivider(color: currentTheme.colorTheme.borderBright)
                    Text("Roles")
                        .font(.overlineMedium)
                        .foreground(.onSurfaceMedium)
                        .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 0))
                    ForEach(roomModel.roles, id: \.name) { role in
                        Button {
                            selectedOption = .role(role)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text(role.name.capitalized)
                                .font(.subtitle2Semibold14)
                                .foreground(.onSurfaceHigh)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 24)
                        }
                    }
                    HMSDivider(color: currentTheme.colorTheme.borderBright)
                    Text("Participants")
                        .font(.overlineMedium)
                        .foreground(.onSurfaceMedium)
                        .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 0))
                    ForEach(roomModel.peerModels.filter({ searchQuery.isEmpty ? true : $0.name.contains(searchQuery) })) { peer in
                        Button {
#if !Preview
                            selectedOption = .peer(peer.peer)
#else
                            selectedOption = .peer(peer)
#endif
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text(peer.name)
                                .font(.subtitle2Semibold14)
                                .foreground(.onSurfaceHigh)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 24)
                        }
                    }
                }
            }
            
        }
        .background(.surfaceDefault, cornerRadius: 8, ignoringEdges: .all)
    }
}


struct HMSRolePickerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
#if Preview
        HMSRolePickerOptionsView(selectedOption: .constant(.everyone)).environmentObject(HMSUITheme()).environmentObject(HMSRoomModel.dummyRoom(20))
#endif
    }
}
