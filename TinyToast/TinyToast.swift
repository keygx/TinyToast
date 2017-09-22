//
//  TinyToast.swift
//  TinyToast
//
//  Created by keygx on 2017/08/09.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit

public class TinyToast: TinyToastDelegate {
    // Singlton
    public static let shared = TinyToast()
    // Toast
    let toast = TinyToastView()
    // Queue List
    var queue: [TinyToastModel] {
        didSet {
            if queue.count == 1 {
                next()
            }
        }
    }
    // Is Queued
    var isQueued: Bool {
        if !queue.isEmpty {
            return true
        }
        return false
    }
    
    private init() {
        queue = [TinyToastModel]()
        toast.delegate = self
    }
}

extension TinyToast {
    // Duration: Pre-Settings
    public func show(message: String, valign: TinyToastDisplayVAlign = .center, duration: TinyToastDisplayDuration) {
        AsyncUtil.sync {
            queue.append(TinyToastModel(message: message, valign: valign, duration: duration.getDurationTime()))
        }
    }
    
    // Duration: User Setting
    public func show(message: String, valign: TinyToastDisplayVAlign = .center, duration: TimeInterval) {
        AsyncUtil.sync {
            queue.append(TinyToastModel(message: message, valign: valign, duration: duration))
        }
    }
    
    public func dismiss() {
        if !isQueued {
            return
        }
        toast.dismiss()
    }
    
    public func dismissAll() {
        if !isQueued {
            return
        }
        toast.dismiss()
        AsyncUtil.sync {
            queue.removeAll()
        }
    }
}

extension TinyToast {
    func next() {
        if !isQueued {
            return
        }
        toast.show(message: queue[0].message, valign: queue[0].valign, duration: queue[0].duration)
    }
    
    func didCompleted() {
        if isQueued {
            AsyncUtil.sync {
                queue.removeFirst()
                next()
            }
        }
    }
}
