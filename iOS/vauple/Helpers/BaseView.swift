//
//  BaseView.swift
//  vauple
//
//  Created by Alexander Telegin on 21.08.2023.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() { }
}

