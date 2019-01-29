//
//  RXCLoadingStateSimpleEmptyView.swift
//  iOS-Sample
//
//  Created by ruixingchen on 1/18/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class RXCLoadingStateSimpleEmptyView: UIView {

    let titleLabel:UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -32)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
