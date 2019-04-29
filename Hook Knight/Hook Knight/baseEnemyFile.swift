//
//  baseEnemyFile.swift
//  Hook Knight
//
//  Created by Game Design Shared on 4/16/19.
//  Copyright © 2019 Game Design Shared. All rights reserved.
//

import Foundation
import SpriteKit





class baseEnemyClass
{
    public var scene: SKScene?
    var speed:CGFloat=0
    var startDirection:CGFloat=random(min: 0, max: 1.0)
    var sprite=SKSpriteNode()
    
    
    
    var attacked: Bool=false
    

    
    
    init()
    {
        
    }
    
    init(theScene: SKScene)
    {
        scene=theScene
        
    }
    
    func move()
    {
        print(startDirection)
        if startDirection<0.5
        {
            if sprite.physicsBody!.velocity.dx < 100
            {
                sprite.physicsBody!.applyForce(CGVector(dx: 50, dy: 0))
            }
        }
        else if startDirection>0.5
        {
            if sprite.physicsBody!.velocity.dx < -100
            {
                sprite.physicsBody!.applyForce(CGVector(dx: -50, dy: 0))
            }
        }
    }
    
    func die()
    {
        sprite.removeFromParent()
    }

    func update() {
        move()
    }
}
