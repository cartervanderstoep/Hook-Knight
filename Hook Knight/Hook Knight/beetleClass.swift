//
//  beetleClass.swift
//  Hook Knight
//
//  Created by Game Design Shared on 4/16/19.
//  Copyright © 2019 Game Design Shared. All rights reserved.
//

import Foundation
import SpriteKit




class beetleClass:baseEnemyClass
{
    var startingSpeed=CGVector(dx: 50, dy: 0)
    
    var lastTurnCheck=NSDate()
    
    override init()
    {
        super.init()
        speed=10
    }
    
    override init(theScene: SKScene)
    {
        super.init(theScene: theScene)
        scene=theScene
        speed=10
        sprite=SKSpriteNode(imageNamed:"Deetle")
        scene!.addChild(sprite)
        sprite.name="deetle"
        sprite.physicsBody=SKPhysicsBody(texture: sprite.texture!, alphaThreshold: 0, size: sprite.size)
        sprite.physicsBody!.categoryBitMask=physTypes.Enemy
        sprite.physicsBody!.contactTestBitMask=physTypes.Player
        sprite.physicsBody!.collisionBitMask=physTypes.Ground | physTypes.Player
        sprite.physicsBody!.allowsRotation=false
        sprite.physicsBody!.affectedByGravity=true
        sprite.physicsBody!.isDynamic=true
        sprite.isHidden=false
        
        if startDirection > 0.5
        {
            startingSpeed.dx *= -1
        }
        
       
        
        let patrol = SKAction.sequence([SKAction.move(by: CGVector(dx: -128, dy: 0), duration: 1.5), SKAction.move(by: CGVector(dx: 128, dy: 0), duration: 1.5)])
        
        
        
        sprite.run(SKAction.repeatForever(patrol))
        
    }
    
    
    
    
    
    
    
    override func update() {
       
       
    }
    

}
