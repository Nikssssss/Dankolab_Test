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
        let indicatorCircle = self.createIndicatorCirce()
        self.layer.addSublayer(outerCircle)
        self.layer.insertSublayer(innerCircle, above: outerCircle)
        self.layer.insertSublayer(indicatorCircle, above: outerCircle)
    }
    
    func createOuterCircle() -> CAShapeLayer {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor(red: 99 / 255.0,
                                        green: 149 / 255.0,
                                        blue: 255 / 255.0,
                                        alpha: 1.0).cgColor
        circleLayer.lineWidth = 1.5
        circleLayer.strokeColor = UIColor(red: 30 / 255.0,
                                          green: 0 / 255.0,
                                          blue: 255 / 255.0,
                                          alpha: 1.0).cgColor
        self.createGradient(on: circleLayer, with: circlePath)
        return circleLayer
    }
    
    func createInnerCircle() -> CAShapeLayer {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 15, y: 15, width: 70, height: 70))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 1.5
        circleLayer.strokeColor = UIColor(red: 30 / 255.0,
                                          green: 0 / 255.0,
                                          blue: 255 / 255.0,
                                          alpha: 1.0).cgColor
        return circleLayer
    }
    
    func createIndicatorCirce() -> CAShapeLayer {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 43.5, y: 1, width: 13, height: 13))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        return circleLayer
    }
    
    func createGradient(on layer: CAShapeLayer, with path: UIBezierPath) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = path.bounds
        gradientLayer.colors = [
            UIColor(red: 255 / 255.0,
                    green: 71 / 255.0,
                    blue: 249 / 255.0,
                    alpha: 1.0).cgColor,
            UIColor(red: 33 / 255.0,
                    green: 240 / 255.0,
                    blue: 255 / 255.0,
                    alpha: 1.0).cgColor
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
        gradientChangeAnimation.duration = 1.0
        gradientChangeAnimation.autoreverses = true
        gradientChangeAnimation.repeatCount = Float.infinity
        gradientChangeAnimation.toValue = [
            UIColor(red: 33 / 255.0,
                    green: 240 / 255.0,
                    blue: 255 / 255.0,
                    alpha: 1.0).cgColor,
            UIColor(red: 255 / 255.0,
                    green: 71 / 255.0,
                    blue: 249 / 255.0,
                    alpha: 1.0).cgColor
        ]
        gradientChangeAnimation.fillMode = .removed
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    func addRotatingAnimation() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 2
        rotateAnimation.repeatCount = .infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func addScalingAnimation() {
        let scalingAnimation = CABasicAnimation(keyPath: "transform.scale")
        scalingAnimation.fromValue = 1
        scalingAnimation.toValue = 0.9
        scalingAnimation.autoreverses = true
        scalingAnimation.duration = 1
        scalingAnimation.repeatCount = .infinity
        self.layer.add(scalingAnimation, forKey: nil)
    }
}
