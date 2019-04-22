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
        sprite.physicsBody=SKPhysicsBody(rectangleOf:sprite.size)
        sprite.physicsBody!.categoryBitMask=physTypes.Enemy
        sprite.physicsBody!.collisionBitMask=physTypes.Ground | physTypes.Player
        sprite.physicsBody!.allowsRotation=false
        sprite.physicsBody!.affectedByGravity=true
        sprite.physicsBody!.isDynamic=true
        sprite.isHidden=false
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
