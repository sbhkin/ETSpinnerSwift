//
//  ETSpinner.swift
//  Ethan Tam
//
//  Created by Ethan on 4/8/15.
//  Copyright (c) 2015 EthanolStudio.com  All rights reserved.
//

import UIKit

public class ETSpinner: UIView {
    private var loadingView: UIActivityIndicatorView!
    let frameSize = CGSize(width: 200.0, height: 200.0)

    // MARK : - Signleton
    public class var shareInstance: ETSpinner {
        struct Singleton {
            static let instance = ETSpinner(frame : CGRect.zero)
        }
        return Singleton.instance
    }

    // MARK - Init
    public override init(frame:CGRect) {
        super.init(frame: frame)
        loadingView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        loadingView.frame.size = frameSize
        addSubview(loadingView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public class func show() -> Void {
        let window = UIApplication.sharedApplication().delegate?.window ?? nil
        if window == nil { return }
        let spinner = ETSpinner.shareInstance
        spinner.updateFrame()
        if spinner.superview == nil {
            spinner.alpha = 1.0
            window!.addSubview(spinner)
            spinner.loadingView.startAnimating()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }

    }

    public class func hideWithoutStatusBar() {
        let spinner = ETSpinner.shareInstance

        spinner.removeFromSuperview()
    }

    public class func hide() {
        let spinner = ETSpinner.shareInstance

        spinner.removeFromSuperview()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

    }

    public func updateFrame() {
        if let window = UIApplication.sharedApplication().delegate?.window ?? nil {
            if (APConstant.shouldShowLoadingSpinnerBlockingWholeScreen) {
                ETSpinner.shareInstance.frame = CGRectMake(
                    0,
                    0,
                    window.frame.size.width,
                    window.frame.size.height)
                ETSpinner.shareInstance.layer.cornerRadius = 0.0
                ETSpinner.shareInstance.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25);
            } else {
                ETSpinner.shareInstance.frame = CGRectMake(
                    CGRectGetMidX(window.frame) - 20.0,
                    CGRectGetMidY(window.frame) - 20.0,
                    40.0,
                    40.0)
                ETSpinner.shareInstance.layer.cornerRadius = 5.0
                ETSpinner.shareInstance.backgroundColor = UIColor(red: 8.0/255.0, green: 72.0/255.0, blue: 105.0/255.0, alpha: 0.5);
            }

        }

    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }

    //
    // observe the view frame and update the subviews layout
    //
    public override var frame: CGRect {
        didSet {
            if frame == CGRect.zero {
                return
            }
            loadingView.frame = bounds
            }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
