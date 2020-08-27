//
//  ActivityIndicator.swift
//  SwiftSampleApp
//
//  Created by Vipin Aggarwal on 22/04/19.
//  Copyright © 2019 Vipin Aggarwal. All rights reserved.
//

import UIKit

class ActivityIndicator: NSObject {

    var spinner: UIActivityIndicatorView!
    var grayView: UIView!
    var superView: UIView!


    func setupActivityIndicatorOn(view: UIView) {
        grayView = UIView(frame: view.bounds)
        grayView.backgroundColor = UIColor.gray
        grayView.alpha = 0.5
        grayView.isUserInteractionEnabled = false
        view.addSubview(grayView)

        if let parentSize = superView?.frame.size {
            let x = parentSize.width/2 - 25
            let y = parentSize.height/2 - 25

            spinner = UIActivityIndicatorView(frame: CGRect(x: x, y: y, width: 50, height: 50) )
            spinner.style = .gray
            spinner.color = .blue
            view.addSubview(spinner)
            view.bringSubviewToFront(grayView)
            view.bringSubviewToFront(spinner)
        }
    }

    func startActivityIndicatorOn(_ view: UIView) {
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.superView = view
            weakSelf?.setupActivityIndicatorOn(view: view)
            weakSelf?.spinner.startAnimating()
        }
    }

    func stopActivityIndicator() {
        weak var weakSelf = self

        DispatchQueue.main.async {
            weakSelf?.spinner.stopAnimating()
            weakSelf?.spinner.removeFromSuperview()
            weakSelf?.grayView.isHidden = true
            weakSelf?.grayView.removeFromSuperview()
        }
    }
}
