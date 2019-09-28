//
//  TinyToastView.swift
//  TinyToast
//
//  Created by keygx on 2017/08/08.
//  Copyright © 2017年 keygx. All rights reserved.
//

import UIKit

protocol TinyToastDelegate {
    func didCompleted()
}

class TinyToastView {
    private let windowWidthRatio: CGFloat = 0.95 // 95% of parent screen width
    private let windowAlphaValue: CGFloat = 0.95
    private let fontSize: CGFloat = 15.0
    private let margin: CGFloat = 15.0
    private let fadeDuration: Double = 0.5

    private var toastWindow: UIWindow?
    var delegate: TinyToastDelegate?
    
    // Size of ToastView
    private var toastViewRect: CGRect {
        return CGRect(x: 0,
                      y: 0,
                      width: UIScreen.main.bounds.width * windowWidthRatio,
                      height: UIScreen.main.bounds.height)
    }
    // Charactors counts of 1 line
    private var oneLineLength: CGFloat {
        return floor(toastViewRect.width * windowWidthRatio / fontSize)
    }
    // Label Width
    private var labelWidth: CGFloat {
        return oneLineLength * fontSize
    }
    
    init() {}
    
    func show(message: String, valign: TinyToastDisplayVAlign = .center, duration: TimeInterval) -> Void {
        // Create UIWindow
        toastWindow = createWindow(orientation: TinyToastViewController.orientation)
        guard let toastWindow = toastWindow else {
            self.delegate?.didCompleted()
            return
        }
        
        // RootViewController
        let tinyToastViewController = TinyToastViewController()
        
        // Create Label
        let messageLabel = createMessageLabel(message: message, isDarkMode: toastWindow.isDarkMode)
        
        // Create Toast
        let toastView = createToastView(messageLabelWidth: messageLabel.bounds.width,
                                        messageLabelHeight: messageLabel.bounds.height, isDarkMode: toastWindow.isDarkMode)
        toastView.addSubview(messageLabel)
        
        // Rotate Toast View
        let angle = getAngle(orientation: TinyToastViewController.orientation)
        toastView.transform = CGAffineTransform(rotationAngle: angle.0)
        tinyToastViewController.view.addSubview(toastView)
        
        // Centering
        toastView.center = tinyToastViewController.view.center
        
        // Toast View Position
        switch valign {
        case .top:
            switch angle.1 {
            case .up:
                toastView.frame.origin.y =
                    margin + getExtraMargin(orientation: .up, valign: .top)
            case .left:
                toastView.frame.origin.x =
                    margin + getExtraMargin(orientation: .left, valign: .top)
            case .right:
                toastView.frame.origin.x =
                    toastWindow.frame.width - toastView.frame.width
                    - margin - getExtraMargin(orientation: .right, valign: .top)
            case .down:
                toastView.frame.origin.y =
                    toastWindow.frame.height - toastView.frame.height
                    - margin - getExtraMargin(orientation: .down, valign: .top)
            }
        case .bottom:
            switch angle.1 {
            case .up:
                toastView.frame.origin.y =
                    toastWindow.frame.height - toastView.frame.height
                    - margin - getExtraMargin(orientation: .up, valign: .bottom)
            case .left:
                toastView.frame.origin.x =
                    toastWindow.frame.width - toastView.frame.width
                    - margin - getExtraMargin(orientation: .left, valign: .bottom)
            case .right:
                toastView.frame.origin.x =
                    margin + getExtraMargin(orientation: .right, valign: .bottom)
            case .down:
                toastView.frame.origin.y =
                    margin + getExtraMargin(orientation: .down, valign: .bottom)
            }
        default:
            break
        }
        
        toastWindow.alpha = 0
        toastWindow.isUserInteractionEnabled = false
        toastWindow.rootViewController = tinyToastViewController
        
        // Show Toast
        self.show(duration)
    }
}

extension TinyToastView {
    // Create UIWindow
    private func createWindow(orientation: UIInterfaceOrientation) -> UIWindow {
        return WindowBuilder.build(frame: UIScreen.main.bounds, orientation: orientation)
    }
    
    // Create Label
    private func createMessageLabel(message: String, isDarkMode: Bool) -> UILabel {
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 12, y: 9, width: labelWidth, height: 10))
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.isUserInteractionEnabled = false
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: fontSize)
        messageLabel.textAlignment = NSTextAlignment.left
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        if isDarkMode {
            messageLabel.textColor = UIColor.darkGray
        } else {
           messageLabel.textColor = UIColor.white
        }
        return messageLabel
    }
    
    // Create Toast View
    private func createToastView(messageLabelWidth: CGFloat, messageLabelHeight: CGFloat, isDarkMode: Bool) -> UIView {
        let toastView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: messageLabelWidth + 12 + 12, height: messageLabelHeight + 9 + 9 + 1))
        if isDarkMode {
            toastView.backgroundColor = UIColor.white
            toastView.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
            toastView.layer.shadowColor = UIColor.lightGray.cgColor
        } else {
            toastView.backgroundColor = UIColor.black
            toastView.layer.borderColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.95).cgColor
            toastView.layer.shadowColor = UIColor.darkGray.cgColor
        }
        toastView.isUserInteractionEnabled = false
        toastView.layer.cornerRadius = 8.0
        toastView.layer.borderWidth = 1
        toastView.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        toastView.layer.shadowOpacity = 0.4
        return toastView
    }
    
    // Rotate Toast View
    /**
     * View does not rotate automatically, so it fits the screen.
     */
    private func getAngle(orientation: UIInterfaceOrientation) -> (CGFloat, TinyToastDisplayDirection) {
        switch orientation {
        case .portrait, .landscapeLeft, .landscapeRight:
            return (CGFloat(0.0 * CGFloat.pi / 180.0), .up)
        case .portraitUpsideDown:
            return (CGFloat(180.0 * CGFloat.pi / 180.0), .down)
        default:
            return (CGFloat(0.0 * CGFloat.pi / 180.0), .up)
        }
    }
}

extension TinyToastView {
    private func show(_ duration: Double) -> Void {
        guard let toastWindow = toastWindow else {
            self.delegate?.didCompleted()
            return
        }
        
        // Fade in
        UIView.animate(
            withDuration: fadeDuration,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: {
                toastWindow.alpha = self.windowAlphaValue
                return
            },
            completion:nil)
        
        // Toast display duration
        AsyncUtil.onMainThread({
            self.dismiss()
        }, delay: duration)
    }
    
    func dismiss() -> Void {
        // Fade out
        UIView.animate(
            withDuration: fadeDuration,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: {
                self.toastWindow?.alpha = 0
                return
            },
            completion: {
                (value: Bool) in
                self.toastWindow?.removeFromSuperview()
                self.toastWindow = nil
                self.delegate?.didCompleted()
        })
    }
}

extension TinyToastView {
    func getExtraMargin(orientation: TinyToastDisplayDirection, valign: TinyToastDisplayVAlign) -> CGFloat {
        switch orientation {
        case .up:
            switch valign {
            case .top:
                return UIApplication.shared.statusBarFrame.size.height > 0.0
                    ? UIApplication.shared.statusBarFrame.size.height - 14.0 : 0.0
            case .bottom:
                if #available(iOS 11.0, *) {
                    return UIApplication.shared.keyWindow!.safeAreaInsets.bottom > 0.0
                        ? UIApplication.shared.keyWindow!.safeAreaInsets.bottom - 14.0 : 0.0
                } else {
                    return 0.0
                }
            default:
                return 0.0
            }
        case .left, .right:
            switch valign {
            case .top:
                return 0.0
            case .bottom:
                if #available(iOS 11.0, *) {
                    return UIApplication.shared.keyWindow!.safeAreaInsets.bottom > 0.0
                        ? UIApplication.shared.keyWindow!.safeAreaInsets.bottom - 6.0 : 0.0
                } else {
                    return 0.0
                }
            default:
                return 0.0
            }
        default:
            return 0.0
        }
    }
}
