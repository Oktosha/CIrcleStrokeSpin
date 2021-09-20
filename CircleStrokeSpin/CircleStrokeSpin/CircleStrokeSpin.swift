//
//  CircleStrokeSpin.swift
//  CircleStrokeSpin
//
//  Created by Daria Kolodzey on 9/15/21.
//
//  The code below is a modified version of
//  https://github.com/ninjaprox/NVActivityIndicatorView
//  So here is the original copyright and the original license

// The MIT License (MIT)

// Copyright (c) 2016 Vinh Nguyen

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit
import SwiftUI

final class CircleStrokeSpinView : UIView {
    
    public var size: CGSize = CGSize(width: 0, height: 0)
    private(set) public var isAnimating: Bool = false
    public var color: CGColor = UIColor.blue.cgColor
    public var lineWidth: CGFloat = 2
    
    public final func startAnimating() {
        guard !isAnimating else {
            return
        }
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setUpAnimation()
    }
    
    public final func stopAnimating() {
        guard isAnimating else {
            return
        }
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }
    
    private final func setUpAnimation() {
        layer.sublayers = nil
        let minEdge = min(size.width, size.height)
        let circle = getCircleStroke(size: CGSize(width: minEdge, height: minEdge))
        let frame = CGRect(
            x: (size.width - minEdge) / 2,
            y: (size.height - minEdge) / 2,
            width: minEdge,
            height: minEdge
        )
        circle.frame = frame
        circle.add(CircleStrokeSpinView.animation, forKey: "animation")
        layer.addSublayer(circle)
    }
    
    private static var animation: CAAnimationGroup {
        
        let beginTime: Double = 0.5
        let strokeStartDuration: Double = 1.2
        let strokeEndDuration: Double = 0.7

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1

        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = .forwards
        
        return groupAnimation
    }
    
    
    private func getCircleStroke(size: CGSize) -> CAShapeLayer {
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()

        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: -(.pi / 2),
                    endAngle: .pi + .pi / 2,
                    clockwise: true)
        layer.fillColor = nil
        layer.strokeColor = color
        layer.lineWidth = lineWidth
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        return layer
    }
}


struct CircleStrokeSpinCore: UIViewRepresentable {
    
    var isLoading: Bool
    var size: CGSize
    var color: CGColor
    var lineWidth: CGFloat
    
    typealias UIViewType = CircleStrokeSpinView

    func makeUIView(context: Context) -> CircleStrokeSpinView {
        return CircleStrokeSpinView()
    }

    func updateUIView(_ uiView: CircleStrokeSpinView, context: Context) {
        uiView.stopAnimating()
        
        uiView.size = size
        uiView.lineWidth = lineWidth
        uiView.color = color
        
        if (isLoading) {
            uiView.startAnimating()
        }
    }
}

struct CircleStrokeSpin: View {
    var isLoading = true
    var color = UIColor.blue.cgColor
    var lineWidth: CGFloat = 2
    var body: some View {
        return GeometryReader { geometry in
            CircleStrokeSpinCore(isLoading: isLoading, size: geometry.size, color: color, lineWidth: lineWidth)
        }
    }
}
