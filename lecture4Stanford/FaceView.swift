//
//  FaceView.swift
//  lecture4Stanford
//
//  Created by Hye Sun Hong on 6/16/16.
//  Copyright © 2016 Vaporware. All rights reserved.
//

// Comment comment 

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.90
    var mouthCurvature: Double = -0.3

    
    var skullRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    // Drawing code
    private var skullCenter: CGPoint
    {
        return CGPoint(x: bounds.midX, y: bounds.midY)// or :  var skullCenter = convertPoint(center, fromView: superview)
    }
    
    private struct Ratios{
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    
    }
    
    private enum Eye{
     case Left
     case Right
    
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius: CGFloat) -> UIBezierPath{
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: withRadius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false)
        
        //        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: false)
        
        path.lineWidth = 5.0
        return path

    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint
    {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye{
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        
        return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
    }
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y:skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        let smileOffset = CGFloat(max(-1, min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x:mouthRect.maxX, y:mouthRect.minY)
        let cp1 = CGPoint(x:mouthRect.minX + mouthRect.width/3, y:mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x:mouthRect.maxX - mouthRect.width/3, y:mouthRect.minY + smileOffset)
        
        
        //return UIBezierPath(rect: mouthRect)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        return path
    }
    
    override func drawRect(rect: CGRect)
    {
    //   let skull = pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius)
    //  UIColor.blueColor().set() // setFill, setStroke, set = fill+ stroke
    //   skull.stroke()
          UIColor.blueColor().set() // setFill, setStroke, set = fill+ stroke
        pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
        
    }
 

}
