//
//  TinyToastViewController.swift
//  TinyToast
//
//  Created by keygx on 2019/09/29.
//  Copyright © 2019 keygx. All rights reserved.
//

import UIKit

final class TinyToastViewController: UIViewController {
    var message: String = ""
    var valign: TinyToastDisplayVAlign = .center
    
    private var toastView: UIView?
    private let windowWidthRatio: CGFloat = 0.95 // 95% of parent screen width
    private let fontSize: CGFloat = 15.0
    private let margin: CGFloat = 15.0
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
    
    // Direction of Statusbar
    static var orientation: UIInterfaceOrientation {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .portrait
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        switch TinyToastViewController.orientation {
        case .landscapeLeft, .landscapeRight:
            // LandscapeLeft | LandscapeRight
            return true
        default:
            // Unknown | Portrait | PortraitUpsideDown
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = false
        
        // Create Label
        let messageLabel = createMessageLabel(message: message)
        
        // Create Toast
        toastView = createToastView(messageLabelWidth: messageLabel.bounds.width,
                                    messageLabelHeight: messageLabel.bounds.height)
        
        toastView?.addSubview(messageLabel)
    }
    
    override func viewWillLayoutSubviews() {
        guard let toastView = toastView else { return }
        
        // Rotate Toast View
        let angle = getAngle(orientation: TinyToastViewController.orientation)
        toastView.transform = CGAffineTransform(rotationAngle: angle.0)
        view.addSubview(toastView)
        
        // Centering
        toastView.center = view.center
        
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
                    view.frame.width - toastView.frame.width
                    - margin - getExtraMargin(orientation: .right, valign: .top)
            case .down:
                toastView.frame.origin.y =
                    view.frame.height - toastView.frame.height
                    - margin - getExtraMargin(orientation: .down, valign: .top)
            }
        case .bottom:
            switch angle.1 {
            case .up:
                toastView.frame.origin.y =
                    view.frame.height - toastView.frame.height
                    - margin - getExtraMargin(orientation: .up, valign: .bottom)
            case .left:
                toastView.frame.origin.x =
                    view.frame.width - toastView.frame.width
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
    }
}

extension TinyToastViewController {
    // Create Label
    private func createMessageLabel(message: String) -> UILabel {
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 12, y: 9, width: labelWidth, height: 10))
        if view.isDarkMode {
            messageLabel.textColor = UIColor.black
        } else {
           messageLabel.textColor = UIColor.white
        }
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.isUserInteractionEnabled = false
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: fontSize)
        messageLabel.textAlignment = NSTextAlignment.left
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        return messageLabel
    }
    
    // Create Toast View
    private func createToastView(messageLabelWidth: CGFloat, messageLabelHeight: CGFloat) -> UIView {
        let toastView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: messageLabelWidth + 12 + 12, height: messageLabelHeight + 9 + 9 + 1))
        if view.isDarkMode {
            toastView.backgroundColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 128.0/255.0, alpha: 0.98)
            toastView.layer.borderColor = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 67.0/255.0, alpha: 0.98).cgColor
        } else {
            toastView.backgroundColor = UIColor.black
            toastView.layer.borderColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.95).cgColor
        }
        toastView.isUserInteractionEnabled = false
        toastView.layer.cornerRadius = 8.0
        toastView.layer.borderWidth = 1.0
        toastView.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        toastView.layer.shadowColor = UIColor.darkGray.cgColor
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
