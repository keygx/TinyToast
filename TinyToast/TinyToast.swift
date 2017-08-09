//
//  TinyToast.swift
//  TinyToast
//
//  Created by keygx on 2017/08/08.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit

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
    func getDurationTime() -> Double {
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

var baseWindow: BaseWindow?

public class TinyToast {
    private let windowWidthRatio: CGFloat = 0.95 // 95% of parent screen width
    private let windowAlphaValue: CGFloat = 0.85
    private let fontSize: CGFloat = 15.0
    private let margin: CGFloat = 15.0
    private let fadeDuration: Double = 0.5
    
    // Direction of Statusbar
    private var orientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    // Size of ToastView
    private var toastViewRect: CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * windowWidthRatio, height: UIScreen.main.bounds.height)
    }
    // Charactors counts of 1 line
    private var oneLineLength: CGFloat {
        return floor(toastViewRect.width * windowWidthRatio / fontSize)
    }
    // Label Width
    private var labelWidth: CGFloat {
        return oneLineLength * fontSize
    }
    
    public init() {}
    
    public func show(message: String, valign: TinyToastDisplayVAlign = .center, duration: TinyToastDisplayDuration) -> Void {
        // Create UIWindow
        baseWindow = createWindow(orientation: orientation)
        guard let baseWindow = baseWindow else {
            return
        }
        baseWindow.alpha = 0
        baseWindow.isUserInteractionEnabled = false
        baseWindow.windowLevel = UIWindowLevelNormal
        
        // Create Label
        let messageLabel = createMessageLabel(message: message)
        
        // Create Toast
        let toastView = createToastView(messageLabelWidth: messageLabel.bounds.width, messageLabelHeight: messageLabel.bounds.height)
        toastView.addSubview(messageLabel)
        
        // Rotate Toast View
        let angle = getAngle(orientation: orientation)
        toastView.transform = CGAffineTransform(rotationAngle: angle.0)
        baseWindow.addSubview(toastView)
        
        // Centering
        toastView.center = baseWindow.center
        
        // Toast View Position
        switch valign {
        case .top:
            switch angle.1 {
            case .up:
                toastView.frame.origin.y = margin
            case .left:
                toastView.frame.origin.x = margin
            case .right:
                toastView.frame.origin.x = baseWindow.frame.width - toastView.frame.width - margin
            case .down:
                toastView.frame.origin.y = baseWindow.frame.height - toastView.frame.height - margin
            }
        case .bottom:
            switch angle.1 {
            case .up:
                toastView.frame.origin.y = baseWindow.frame.height - toastView.frame.height - margin
            case .left:
                toastView.frame.origin.x = baseWindow.frame.width - toastView.frame.width - margin
            case .right:
                toastView.frame.origin.x = margin
            case .down:
                toastView.frame.origin.y = margin
            }
        default:
            break
        }
        
        // Show Toast
        self.show(duration.getDurationTime())
    }
}

extension TinyToast {
    // Create UIWindow
    private func createWindow(orientation: UIInterfaceOrientation) -> BaseWindow {
        switch orientation {
        case .landscapeLeft:
            fallthrough
        case .landscapeRight:
            // LandscapeLeft | LandscapeRight
            return BaseWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
        default:
            // Unknown | Portrait | PortraitUpsideDown
            return BaseWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        }
    }
    
    // Create Label
    private func createMessageLabel(message: String) -> UILabel {
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 12, y: 9, width: labelWidth, height: 10))
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.isUserInteractionEnabled = false
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: fontSize)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = NSTextAlignment.left
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        return messageLabel
    }
    
    // Create Toast View
    private func createToastView(messageLabelWidth: CGFloat, messageLabelHeight: CGFloat) -> UIView {
        let toastView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: messageLabelWidth + 12 + 12, height: messageLabelHeight + 9 + 9 + 1))
        toastView.backgroundColor = UIColor.black
        toastView.isUserInteractionEnabled = false
        toastView.layer.cornerRadius = 7.0
        toastView.layer.borderColor = UIColor.gray.cgColor
        toastView.layer.borderWidth = 1
        toastView.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        toastView.layer.shadowColor = UIColor.black.cgColor
        toastView.layer.shadowOpacity = 0.3
        return toastView
    }
    
    // Rotate Toast View
    /**
     * View does not rotate automatically, so it fits the screen.
     */
    private func getAngle(orientation: UIInterfaceOrientation) -> (CGFloat, TinyToastDisplayDirection) {
        switch (orientation) {
        case .portrait:
            // Portrait
            return (CGFloat(0.0 * CGFloat.pi / 180.0), .up)
        case .portraitUpsideDown:
            // PortraitUpsideDown
            return (CGFloat(180.0 * CGFloat.pi / 180.0), .down)
        case .landscapeLeft:
            // LandscapeLeft
            return (CGFloat(-90.0 * CGFloat.pi / 180.0), .left)
        case .landscapeRight:
            // LandscapeRight
            return (CGFloat(90.0 * CGFloat.pi / 180.0), .right)
        default:
            // Unknown
            return (CGFloat(0.0 * CGFloat.pi / 180.0), .up)
        }
    }
}

extension TinyToast {
    private func show(_ duration: Double) -> Void {
        guard let baseWindow = baseWindow else {
            return
        }
        
        // Make baseWindow keyWindow
        baseWindow.makeKey()
        
        // Display baseWindow
        baseWindow.makeKeyAndVisible()
        
        // Fade in
        UIView.animate(
            withDuration: fadeDuration,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                baseWindow.alpha = self.windowAlphaValue
                return
        },
            completion:nil)
        
        // Toast display duration
        let delay = duration * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.dismiss()
        })
    }
    
    private func dismiss() -> Void {
        // Fade out
        UIView.animate(
            withDuration: fadeDuration,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                baseWindow?.alpha = 0
                return
        },
            completion: {
                (value: Bool) in
                baseWindow?.removeFromSuperview()
                baseWindow = nil
        })
    }
}
