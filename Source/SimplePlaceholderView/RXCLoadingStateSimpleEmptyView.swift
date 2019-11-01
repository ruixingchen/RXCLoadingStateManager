//
//  RXCLoadingStateSimpleEmptyView.swift
//  iOS-Sample
//
//  Created by ruixingchen on 1/18/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

///简单的EmptyView
open class RXCLoadingStateSimpleEmptyView: UIView {

    public let titleLabel:UILabel = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -32).isActive = true
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = UIColor.clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -32).isActive = true
    }

}
