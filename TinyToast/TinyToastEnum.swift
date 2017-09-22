//
//  TinyToastEnum.swift
//  TinyToast
//
//  Created by keygx on 2017/08/09.
//  Copyright © 2017年 keygx. All rights reserved.
//

import Foundation

public enum TinyToastDisplayVAlign {
    case top
    case center
    case bottom
}

public enum TinyToastDisplayDuration {
    case short
    case normal
    case long
    case longLong
    func getDurationTime() -> TimeInterval {
        switch self {
        case .short:
            return 2.0
        case .normal:
            return 3.5
        case .long:
            return 5.0
        case .longLong:
            return 8.0
        }
    }
}

public enum TinyToastDisplayDirection {
    case up
    case left
    case right
    case down
}
