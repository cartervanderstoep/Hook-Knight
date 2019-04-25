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
        sprite.physicsBody=SKPhysicsBody(rectangleOf:sprite.size)
        sprite.physicsBody!.categoryBitMask=physTypes.Enemy
        sprite.physicsBody!.collisionBitMask=physTypes.Ground | physTypes.Player
        sprite.physicsBody!.allowsRotation=false
        sprite.physicsBody!.affectedByGravity=true
        sprite.physicsBody!.isDynamic=true
        sprite.isHidden=false
        
        if startDirection > 0.5
        {
            startingSpeed.dx *= -1
        }
        
    }
    
    
    
    
    override func move()
    {
        
        var turn:Bool=true
        
            if sprite.physicsBody!.velocity.dx < 100
            {
                sprite.physicsBody!.applyForce(startingSpeed)
            }
    
       
            if sprite.physicsBody!.velocity.dx > -100
            {
                sprite.physicsBody!.applyForce(startingSpeed)
            }
        
        
        if -lastTurnCheck.timeIntervalSinceNow>0.25
        {
            for this in scene!.children
            {
                if this.name != nil
                {
                    if this.name!.contains("block")
                    {
                        
                        
                        if this.contains(CGPoint(x: sprite.position.x + 33, y: sprite.position.y - 40))
                        {
                            turn = false
                            print("Right edge")
                        }
                        else if this.contains(CGPoint(x: sprite.position.x - 33, y: sprite.position.y - 40))
                        {
                            turn=false
                            print("Left edge")
                        }
                        
                        if turn
                        {
                            startingSpeed.dx *= -1
                        }
                     
                    }
                }
            }
             lastTurnCheck=NSDate()
        }
    }
    
    
    
    
    
    
    
    override func update() {
        move()
       
    }
    

}
