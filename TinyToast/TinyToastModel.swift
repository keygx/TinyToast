//
//  TinyToastModel.swift
//  TinyToast
//
//  Created by keygx on 2017/08/10.
//  Copyright © 2017年 keygx. All rights reserved.
//

import Foundation

struct TinyToastModel {
    var message: String
    var valign: TinyToastDisplayVAlign
    var duration: TimeInterval
    
    init(message: String, valign: TinyToastDisplayVAlign, duration: TimeInterval) {
        self.message = message
        self.valign = valign
        self.duration = duration
    }
}
