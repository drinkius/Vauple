//
//  UIView+Extensions.swift
//  truthordare
//
//  Created by Alexander Telegin on 20.08.2023.
//

import UIKit

class GradientView: UIView {

    init(
        from startColor: UIColor,
        to endColor: UIColor
    ) {
        super.init(frame: .zero)
        backgroundColor = .systemPink
//        addSlightAngledGradient(from: startColor, to: endColor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return superview?.bounds.size ?? CGSize.zero
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        invalidateIntrinsicContentSize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}

extension UIView {
    func addSlightAngledGradient(
        from startColor: UIColor,
        to endColor: UIColor
    ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]

        let angle = CGFloat(-45.0) // Specify the desired angle in degrees (-45.0 for a slight angled gradient)
        let startPoint = calculateGradientStartPoint(angle: angle, bounds: bounds)
        let endPoint = calculateGradientEndPoint(angle: angle, bounds: bounds)

        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func calculateGradientStartPoint(angle: CGFloat, bounds: CGRect) -> CGPoint {
        let startPointX = 0.5 - sin(angle * CGFloat.pi / 180.0) * 0.5
        let startPointY = 0.5 + cos(angle * CGFloat.pi / 180.0) * 0.5

        return CGPoint(x: startPointX, y: startPointY)
    }

    private func calculateGradientEndPoint(angle: CGFloat, bounds: CGRect) -> CGPoint {
        let endPointX = 0.5 + sin(angle * CGFloat.pi / 180.0) * 0.5
        let endPointY = 0.5 - cos(angle * CGFloat.pi / 180.0) * 0.5

        return CGPoint(x: endPointX, y: endPointY)
    }
}
