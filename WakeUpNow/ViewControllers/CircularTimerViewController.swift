//
//  CircularTimerView.swift
//  WakeUpNow
//
//  Created by 서혜림 on 5/16/24.
//

import UIKit

class CircularTimerViewController: UIView {
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!

    var progress: CGFloat = 0 {
        didSet {
            foregroundLayer.strokeEnd = progress
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }

    private func setupLayers() {
        backgroundLayer = createCircularLayer(strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor)
        layer.addSublayer(backgroundLayer)

        foregroundLayer = createCircularLayer(strokeColor: UIColor.blue.cgColor, fillColor: UIColor.clear.cgColor)
        foregroundLayer.strokeEnd = 0
        layer.addSublayer(foregroundLayer)
    }

    private func createCircularLayer(strokeColor: CGColor, fillColor: CGColor) -> CAShapeLayer {
        let circularLayer = CAShapeLayer()
        circularLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true).cgPath
        circularLayer.fillColor = fillColor
        circularLayer.strokeColor = strokeColor
        circularLayer.lineWidth = 10
        circularLayer.lineCap = .round
        return circularLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
        backgroundLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true).cgPath

        foregroundLayer.frame = bounds
        foregroundLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true).cgPath
    }
}
