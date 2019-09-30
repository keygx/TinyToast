//
//  TinyToastHandler.swift
//  TinyToast
//
//  Created by keygx on 2019/09/29.
//  Copyright © 2019 keygx. All rights reserved.
//

import UIKit

protocol TinyToastDelegate {
    func didCompleted()
}

final class TinyToastHandler {
    private let windowAlphaValue: CGFloat = 0.95
    private let fadeDuration: Double = 0.5
    
    private var toastWindow: UIWindow?
    private var tinyToastViewController: TinyToastViewController?
    var delegate: TinyToastDelegate?
    
    func show(message: String, valign: TinyToastDisplayVAlign = .center, duration: TimeInterval) -> Void {
        // Create UIWindow
        toastWindow = WindowBuilder.build(frame: UIScreen.main.bounds, orientation: TinyToastViewController.orientation)
        guard toastWindow != nil else {
            self.delegate?.didCompleted()
            return
        }
        
        // RootViewController
        tinyToastViewController = TinyToastViewController()
        tinyToastViewController?.message = message
        tinyToastViewController?.valign = valign
        toastWindow?.rootViewController = tinyToastViewController
        
        // Fade in
        AsyncUtil.onMainThread({
            AsyncUtil.sync {
                UIView.animate(
                    withDuration: self.fadeDuration,
                delay: 0.0,
                options: .curveEaseIn,
                animations: {
                    self.toastWindow?.alpha = self.windowAlphaValue
                },
                completion: { _ in
                    self.dismiss()
                })
            }
        }, delay: duration)
    }
    
    func dismiss() -> Void {
        // Fade out
        AsyncUtil.onMainThread({
            AsyncUtil.sync {
                UIView.animate(
                    withDuration: self.fadeDuration,
                    delay: 0.0,
                    options: .curveEaseIn,
                    animations: {
                        self.toastWindow?.alpha = 0.0
                    },
                    completion: { _ in
                        self.tinyToastViewController = nil
                        self.toastWindow?.removeFromSuperview()
                        self.toastWindow = nil
                        self.delegate?.didCompleted()
                })
            }
        }, delay: 0.0)
    }
}

extension TinyToastHandler {
    // Create UIWindow
    private func createWindow(orientation: UIInterfaceOrientation) -> UIWindow {
        return WindowBuilder.build(frame: UIScreen.main.bounds, orientation: orientation)
    }
}
