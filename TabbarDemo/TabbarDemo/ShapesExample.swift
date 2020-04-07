//
//  ShapesExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/7.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI
// MARK: - 基本图形介绍
struct ShapesExample: View {
    var body: some View {
        ZStack {
            // 矩形
            Rectangle()
                .fill(Color.black)
                .frame(width: 200, height: 200)

            // 圆角矩形
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.red)
                .frame(width: 200, height: 200)

            // 弧度矩形
            Capsule()
                .fill(Color.green)
                .frame(width: 100, height: 50)

            // 椭圆
            Ellipse()
                .fill(Color.blue)
                .frame(width: 100, height: 50)

            // 正圆
            Circle()
                .fill(Color.white)
                .frame(width: 100, height: 50)
        }
    }
}

// MARK: - 绘制示例1
struct DrawSpiroSquareExample: View {
    struct SpiroSquare: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()

            let rotations = 5
            let amount = .pi / CGFloat(rotations)
            let transform = CGAffineTransform(rotationAngle: amount)

            for _ in 0 ..< rotations {
                path = path.applying(transform)

                path.addRect(CGRect(x: -rect.width / 2, y: -rect.height / 2, width: rect.width, height: rect.height))
            }

            return path
        }
    }
    
    var body: some View {
        SpiroSquare()
            .stroke()
            .frame(width: 200, height: 200)
    }
}

// MARK: - 绘制示例2
struct DrawStarExample: View {
    struct Star: Shape {
        // store how many corners the star has, and how smooth/pointed it is
        let corners: Int
        let smoothness: CGFloat

        func path(in rect: CGRect) -> Path {
            // ensure we have at least two corners, otherwise send back an empty path
            guard corners >= 2 else { return Path() }

            // draw from the center of our rectangle
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

            // start from directly upwards (as opposed to down or to the right)
            var currentAngle = -CGFloat.pi / 2

            // calculate how much we need to move with each star corner
            let angleAdjustment = .pi * 2 / CGFloat(corners * 2)

            // figure out how much we need to move X/Y for the inner points of the star
            let innerX = center.x * smoothness
            let innerY = center.y * smoothness

            // we're ready to start with our path now
            var path = Path()

            // move to our initial position
            path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

            // track the lowest point we draw to, so we can center later
            var bottomEdge: CGFloat = 0

            // loop over all our points/inner points
            for corner in 0..<corners * 2  {
                // figure out the location of this point
                let sinAngle = sin(currentAngle)
                let cosAngle = cos(currentAngle)
                let bottom: CGFloat

                // if we're a multiple of 2 we are drawing the outer edge of the star
                if corner.isMultiple(of: 2) {
                    // store this Y position
                    bottom = center.y * sinAngle

                    // …and add a line to there
                    path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
                } else {
                    // we're not a multiple of 2, which means we're drawing an inner point

                    // store this Y position
                    bottom = innerY * sinAngle

                    // …and add a line to there
                    path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
                }

                // if this new bottom point is our lowest, stash it away for later
                if bottom > bottomEdge {
                    bottomEdge = bottom
                }

                // move on to the next corner
                currentAngle += angleAdjustment
            }

            // figure out how much unused space we have at the bottom of our drawing rectangle
            let unusedSpace = (rect.height / 2 - bottomEdge) / 2

            // create and apply a transform that moves our path down by that amount, centering the shape vertically
            let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
            return path.applying(transform)
        }
    }
    
    var body: some View {
        // 试试把smothness改到1然后看看效果吧
        Star(corners: 5, smoothness: 0.45)
               .fill(Color.red)
               .frame(width: 200, height: 200)
               .background(Color.green)

       }
}

// MARK: - 绘制示例3
struct DrawCheckerboardExample: View {
    struct Checkerboard: Shape {
        let rows: Int
        let columns: Int

        func path(in rect: CGRect) -> Path {
            var path = Path()

            // figure out how big each row/column needs to be
            let rowSize = rect.height / CGFloat(rows)
            let columnSize = rect.width / CGFloat(columns)

            // loop over all rows and columns, making alternating squares colored
            for row in 0 ..< rows {
                for column in 0 ..< columns {
                    if (row + column).isMultiple(of: 2) {
                        // this square should be colored; add a rectangle here
                        let startX = columnSize * CGFloat(column)
                        let startY = rowSize * CGFloat(row)

                        let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                        path.addRect(rect)
                    }
                }
            }

            return path
        }
    }
    
    var body: some View {
        Checkerboard(rows: 16, columns: 16)
            .fill(Color.red)
            .frame(width: 200, height: 200)
    }
}

// MARK: - 桥接UIBezierPath CGPath
// 如果你有现成的UIBeUIBezierPath或者CGPath，你可以很方便的把他们转到SwiftUI上面使用，通过继承Path协议

// 假设这是你的path
extension UIBezierPath {
    /// The Unwrap logo as a Bezier path.
    static var logo: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.534, y: 0.5816))
        path.addCurve(to: CGPoint(x: 0.1877, y: 0.088), controlPoint1: CGPoint(x: 0.534, y: 0.5816), controlPoint2: CGPoint(x: 0.2529, y: 0.4205))
        path.addCurve(to: CGPoint(x: 0.9728, y: 0.8259), controlPoint1: CGPoint(x: 0.4922, y: 0.4949), controlPoint2: CGPoint(x: 1.0968, y: 0.4148))
        path.addCurve(to: CGPoint(x: 0.0397, y: 0.5431), controlPoint1: CGPoint(x: 0.7118, y: 0.5248), controlPoint2: CGPoint(x: 0.3329, y: 0.7442))
        path.addCurve(to: CGPoint(x: 0.6211, y: 0.0279), controlPoint1: CGPoint(x: 0.508, y: 1.1956), controlPoint2: CGPoint(x: 1.3042, y: 0.5345))
        path.addCurve(to: CGPoint(x: 0.6904, y: 0.3615), controlPoint1: CGPoint(x: 0.7282, y: 0.2481), controlPoint2: CGPoint(x: 0.6904, y: 0.3615))
        return path
    }
}


struct BridgePathExample: View {
    struct ScaledBezier: Shape {
        let bezierPath: UIBezierPath

        func path(in rect: CGRect) -> Path {
            let path = Path(bezierPath.cgPath)

            // Figure out how much bigger we need to make our path in order for it to fill the available space without clipping.
            let multiplier = min(rect.width, rect.height)

            // Create an affine transform that uses the multiplier for both dimensions equally.
            let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)

            // Apply that scale and send back the result.
            return path.applying(transform)
        }
    }
    
    var body: some View {
        ScaledBezier(bezierPath: .logo)
            .stroke(lineWidth: 2)
            .frame(width: 200, height: 200)
    }
}
