//
//  RXCLoadingStateSimpleLoadingView.swift
//  iOS-Sample
//
//  Created by ruixingchen on 1/18/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

///一个简单的Loading界面
open class RXCLoadingStateSimpleLoadingView: UIView {

    public let indicator:UIActivityIndicatorView

    public init(style: UIActivityIndicatorView.Style) {
        self.indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        self.addSubview(indicator)
        self.indicator.startAnimating()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.indicator.center = self.center
    }

}
