//
//  CircularTimerView.swift
//  WakeUpNow
//
//  Created by 서혜림 on 5/16/24.
//

import UIKit

class CircularTimerView: UIView {
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
        backgroundLayer = createCircularLayer(strokeColor: ColorPalette.wakeBrightGray.cgColor, fillColor: UIColor.clear.cgColor)
        foregroundLayer = createCircularLayer(strokeColor: ColorPalette.wakeRed.cgColor, fillColor: UIColor.clear.cgColor)
        foregroundLayer.strokeEnd = 0

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
    }

    private func createCircularLayer(strokeColor: CGColor, fillColor: CGColor) -> CAShapeLayer {
        let circularLayer = CAShapeLayer()
        circularLayer.fillColor = fillColor
        circularLayer.strokeColor = strokeColor
        circularLayer.lineWidth = 20
        circularLayer.lineCap = .round
        return circularLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayerPath(for: backgroundLayer)
        updateLayerPath(for: foregroundLayer)
    }

    private func updateLayerPath(for layer: CAShapeLayer) {
        layer.frame = bounds
        layer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true).cgPath
    }

    func updateProgress(_ progress: CGFloat) {
        self.progress = progress
    }

    func resetProgress() {
        progress = 0.0
    }
}
