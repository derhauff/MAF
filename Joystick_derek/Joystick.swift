//
//  Joystick.swift
//  Joystick_derek
//
//  Created by Manfred Hauffen on 04.01.18.
//  Copyright © 2018 Manfred Hauffen. All rights reserved.
//

import Foundation
import SpriteKit

class Joystick: SKNode {
    
    // Eigenschaften
    var joystick = SKShapeNode()
    var stick = SKShapeNode()
    
    let maxRange: CGFloat = 10
    
    var xValue: CGFloat = 0
    var yValue: CGFloat = 0
    
    var joystickAction: ((_ x: CGFloat, _ y: CGFloat) -> ())?
    
    override init() {
        
        let joystickRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let joystickPath = UIBezierPath(ovalIn: joystickRect)
        
        // Joystick
    
        
        joystick = SKShapeNode(path: joystickPath.cgPath, centered: true)
        joystick.lineWidth = 2
        joystick.strokeColor = UIColor.white
        joystick.fillColor = UIColor(white: 1, alpha: 2)
//        joystick.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        
        // Stick
        let stickRect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let stickPath = UIBezierPath(ovalIn: stickRect)
        
        stick = SKShapeNode(path: stickPath.cgPath, centered: true)
        stick.lineWidth = 2
        stick.strokeColor = UIColor(white: 0.2, alpha: 1)
        stick.fillColor = UIColor(white: 0, alpha: 0.5)
        
        super.init()
        
        addChild(joystick)
        addChild(stick)
        
        isHidden = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methoden
    func showJoystick(touch: UITouch) {
        isHidden = false
        position = touch.location(in: parent!)
    }
    
    func hideJoystick() {
        isHidden = true
        stick.position = joystick.position
        xValue = 0
        yValue = 0
    }
    
    func moveJoystick(touch: UITouch) {
        let p = touch.location(in: self)
        let x = p.x.clamped(-maxRange, maxRange)
        let y = p.y.clamped(-maxRange, maxRange)
    
        stick.position = CGPoint(x: x, y: y)
        xValue = x / maxRange
        yValue = y / maxRange
        
        if let joystickAction = self.joystickAction {
            joystickAction(xValue, yValue)
        }
    }
    
}

extension CGFloat {
    
    func clamped(_ v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
        
    }
    
    
}
