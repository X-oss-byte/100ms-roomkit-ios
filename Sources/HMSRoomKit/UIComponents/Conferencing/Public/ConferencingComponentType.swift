//
//  PreviewComponentType.swift
//  HMSSDK
//
//  Created by Pawan Dixit on 25/07/2023.
//  Copyright © 2023 100ms. All rights reserved.
//

import Foundation
import HMSSDK

extension HMSConferenceScreen {
    
    internal enum InternalType {
        case `default`(DefaultType)
        case liveStreaming(DefaultType)
    }
    
    public enum `Type` {
        
        case `default`(((inout DefaultType) -> Void) = {_ in})
        case liveStreaming(((inout DefaultType) -> Void) = {_ in})
        
        internal func process() -> InternalType {
            
            switch self {
            case .default(let closure):
                var screen: DefaultType = .default
                closure(&screen)
                return InternalType.default(screen)
            case .liveStreaming(let closure):
                var screen: DefaultType = .default
                closure(&screen)
                return InternalType.liveStreaming(screen)
            }
        }
    }
    
    public struct DefaultType {
        
        public static let `default`: Self = .init()
        internal init() {}

        public var chat: Chat? = .default
        
        public struct Chat {
            
            public static let `default`: Self = .init()
            internal init() {}
            
            public enum InitialState {
                case open
                case close
            }
            
            public var initialState: InitialState = .close
            public var isOverlay: Bool = false
            public var allowsPinningMessages: Bool = true
            
            public init(initialState: InitialState, isOverlay: Bool, allowsPinningMessages: Bool) {
                self.initialState = initialState
                self.isOverlay = isOverlay
                self.allowsPinningMessages = allowsPinningMessages
            }
        }
        
        public var tileLayout: TileLayout? = TileLayout(grid: .default)
        
        public struct TileLayout: Codable {
            
            public static let defaultGrid: Self = .init(grid: .default)
            
            public let grid: Grid
            
            public init(grid: Grid) {
                self.grid = grid
            }
            
            public struct Grid: Codable {
                
                public static let `default`: Self = .init()
                internal init(){}
                
                public var isLocalTileInsetEnabled: Bool = false
                public var prominentRoles: [String] = []
                public var canSpotlightParticipant: Bool = true
                
                public init(isLocalTileInsetEnabled: Bool, prominentRoles: [String], canSpotlightParticipant: Bool) {
                    self.isLocalTileInsetEnabled = isLocalTileInsetEnabled
                    self.prominentRoles = prominentRoles
                    self.canSpotlightParticipant = canSpotlightParticipant
                }
            }
        }
        
        public var onStageExperience: OnStageExperience? = nil
        public struct OnStageExperience {
            public let onStageRoleName: String
            public let rolesWhoCanComeOnStage: [String]
            public let bringToStageLabel: String
            public let removeFromStageLabel: String
        }
        
        public var brb: BRB? = .default
        public struct BRB {
            public static let `default`: Self = .init()
            internal init() {}
        }
        
        public var participantList: ParticipantList? = .default
        public struct ParticipantList {
            public static let `default`: Self = .init()
            internal init() {}
        }
        
        public init(chat: Chat? = .default, tileLayout: TileLayout? = .init(grid: .default), onStageExperience: OnStageExperience? = nil, brb: BRB? = .default, participantList: ParticipantList? = .default) {
            self.chat = chat
            self.tileLayout = tileLayout
            self.onStageExperience = onStageExperience
            self.brb = brb
            self.participantList = participantList
        }
    }
}
