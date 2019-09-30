//
//  TinyToast.swift
//  TinyToast
//
//  Created by keygx on 2019/09/29.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit

public class TinyToast: TinyToastDelegate {
    // Singlton
    public static let shared = TinyToast()
    // Toast
    private let toastHandler = TinyToastHandler()
    // Queue List
    private var queue: [TinyToastModel] {
        didSet {
            if queue.count == 1 {
                next()
            }
        }
    }
    // Is Queued
    private var isQueued: Bool {
        if !queue.isEmpty {
            return true
        }
        return false
    }
    
    private init() {
        queue = [TinyToastModel]()
        toastHandler.delegate = self
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
        toastHandler.dismiss()
    }
    
    public func dismissAll() {
        if !isQueued {
            return
        }
        toastHandler.dismiss()
        AsyncUtil.sync {
            queue.removeAll()
        }
    }
}

extension TinyToast {
    private func next() {
        if !isQueued {
            return
        }
        toastHandler.show(message: queue[0].message, valign: queue[0].valign, duration: queue[0].duration)
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
