//
//  GameScene.swift
//  Joystick_derek
//
//  Created by Manfred Hauffen on 04.01.18.
//  Copyright © 2018 Manfred Hauffen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let joystick = Joystick()
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 150, height: 150))
    
    override func didMove(to view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 75)
        player.physicsBody?.mass = 0.10
        player.position.y = self.size.width / 2
        player.position.x = self.size.height / 2
        
        addChild(joystick)
        addChild(player)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.showJoystick(touch: touches.first!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.moveJoystick(touch: touches.first!)
        
        joystick.joystickAction = { (x: CGFloat, y: CGFloat) in
            self.player.physicsBody?.applyForce(CGVector(dx: x * 70, dy: y * 70))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.hideJoystick()
    }
    
}


