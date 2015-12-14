//
//  GameScene.swift
//  HelloTvGame
//
//  Created by Jim on 12/13/15.
//  Copyright (c) 2015 Jim. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
    }
    
    private lazy var ship: SKSpriteNode = {
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.name = "Spaceship"
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        return sprite
    }()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
            
            
            guard let _ = ship.parent else {
                ship.position = location
                self.addChild(ship)
                return
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            self.enumerateChildNodesWithName("Spaceship") { (node, _) -> Void in
                if let sprite = node as? SKSpriteNode {
                    let previousLocation = touch.previousLocationInNode(self)
                    let delta = CGVectorMake(location.x - previousLocation.x, location.y - previousLocation.y)
                    let deltaDist = sqrt(delta.dx*delta.dx + delta.dy*delta.dy)
                    let ratio = deltaDist/(sqrt(self.size.height*self.size.height + self.size.width*self.size.width))
                    let duration = Double(0.2 * ratio)
                    let action = SKAction.moveBy(delta, duration: duration)
                    sprite.runAction(action)
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
