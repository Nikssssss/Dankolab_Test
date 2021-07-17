//
//  SpinnerView.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 16.07.2021.
//

import UIKit

class SpinnerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func startAnimating() {
        CATransaction.begin()
        self.addRotatingAnimation()
        self.addScalingAnimation()
        CATransaction.commit()
    }
}

private extension SpinnerView {
    func configureView() {
        let outerCircle = self.createOuterCircle()
        let innerCircle = self.createInnerCircle()
        let indicatorCircle = self.createIndicatorCircle()
        self.layer.addSublayer(outerCircle)
        self.layer.insertSublayer(innerCircle, above: outerCircle)
        self.layer.insertSublayer(indicatorCircle, above: outerCircle)
    }
    
    func createOuterCircle() -> CAShapeLayer {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0,
                                                     width: Constants.outerDiameter,
                                                     height: Constants.outerDiameter))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = Constants.outerFillColor
        circleLayer.lineWidth = Constants.outerStrokeWidth
        circleLayer.strokeColor = Constants.outerStrokeColor
        self.createGradient(on: circleLayer, with: circlePath)
        return circleLayer
    }
    
    func createInnerCircle() -> CAShapeLayer {
        let offset = (Constants.outerDiameter - Constants.innerDiameter) / 2
        let circlePath = UIBezierPath(ovalIn: CGRect(x: offset, y: offset,
                                                     width: Constants.innerDiameter,
                                                     height: Constants.innerDiameter))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = Constants.innerFillColor
        circleLayer.lineWidth = Constants.innerStrokeWidth
        circleLayer.strokeColor = Constants.innerStrokeColor
        return circleLayer
    }
    
    func createIndicatorCircle() -> CAShapeLayer {
        let xOffset = (Constants.outerDiameter / 2) - (Constants.indicatorDiameter / 2)
        let yOffset: CGFloat = 1.0
        let circlePath = UIBezierPath(ovalIn: CGRect(x: xOffset, y: yOffset,
                                                     width: Constants.indicatorDiameter,
                                                     height: Constants.indicatorDiameter))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = Constants.indicatorFillColor
        return circleLayer
    }
    
    func createGradient(on layer: CAShapeLayer, with path: UIBezierPath) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = path.bounds
        gradientLayer.colors = [
            Constants.gradientFirstColor,
            Constants.gradientSecondColor
        ]
        gradientLayer.locations = [0, 1]
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        gradientLayer.mask = mask
        
        layer.addSublayer(gradientLayer)
        self.animateGradientLayer(gradientLayer)
    }
    
    func animateGradientLayer(_ gradientLayer: CAGradientLayer) {
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = Constants.animationDuration / 2
        gradientChangeAnimation.autoreverses = true
        gradientChangeAnimation.repeatCount = Float.infinity
        gradientChangeAnimation.toValue = [
            Constants.gradientSecondColor,
            Constants.gradientFirstColor
        ]
        gradientChangeAnimation.fillMode = .removed
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    func addRotatingAnimation() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = Constants.animationDuration
        rotateAnimation.repeatCount = .infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func addScalingAnimation() {
        let scalingAnimation = CABasicAnimation(keyPath: "transform.scale")
        scalingAnimation.fromValue = 1
        scalingAnimation.toValue = 0.9
        scalingAnimation.autoreverses = true
        scalingAnimation.duration = Constants.animationDuration / 2
        scalingAnimation.repeatCount = .infinity
        self.layer.add(scalingAnimation, forKey: nil)
    }
}

private struct Constants {
    static let outerDiameter: CGFloat = 100
    static let innerDiameter: CGFloat = 70
    static let outerFillColor = UIColor(red: 99 / 255.0,
                                        green: 149 / 255.0,
                                        blue: 255 / 255.0,
                                        alpha: 1.0).cgColor
    static let outerStrokeColor = UIColor(red: 30 / 255.0,
                                          green: 0 / 255.0,
                                          blue: 255 / 255.0,
                                          alpha: 1.0).cgColor
    static let outerStrokeWidth: CGFloat = 1.5
    static let innerFillColor = UIColor.white.cgColor
    static let innerStrokeColor = UIColor(red: 30 / 255.0,
                                          green: 0 / 255.0,
                                          blue: 255 / 255.0,
                                          alpha: 1.0).cgColor
    static let innerStrokeWidth: CGFloat = 1.5
    static let indicatorDiameter: CGFloat = 13
    static let indicatorFillColor = UIColor.black.cgColor
    static let gradientFirstColor = UIColor(red: 255 / 255.0,
                                            green: 71 / 255.0,
                                            blue: 249 / 255.0,
                                            alpha: 1.0).cgColor
    static let gradientSecondColor = UIColor(red: 33 / 255.0,
                                             green: 240 / 255.0,
                                             blue: 255 / 255.0,
                                             alpha: 1.0).cgColor
    static let animationDuration = 2.0
}
