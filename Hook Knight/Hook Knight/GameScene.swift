//
//  GameScene.swift
//  Hook Knight
//
//  Created by Game Design Shared on 3/28/19.
//  Copyright © 2019 Game Design Shared. All rights reserved.
//

import SpriteKit
import GameplayKit


struct physTypes
{
    static let None:UInt32 =    0b00000000
    static let Player:UInt32 =    0b00000001
    static let Ground:UInt32 =    0b00000010
}// phystypes


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameStart:Bool = true
    
    var screenPassed:Bool=false
    var upPressed:Bool=false
    var downPressed:Bool=false
    var rightPressed:Bool=false
    var leftPressed:Bool=false
    
    var blockPlacement:Int=0
    
    var lastJump=NSDate()
    
    var player=HookKnightClass()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self as SKPhysicsContactDelegate
        player.sprite.physicsBody=SKPhysicsBody(rectangleOf:player.sprite.size)
        player.sprite.physicsBody!.categoryBitMask=physTypes.Player
        player.sprite.physicsBody!.allowsRotation=false
        player.sprite.physicsBody!.affectedByGravity=true
        player.sprite.physicsBody!.isDynamic=true
        
        
        
        addChild(player.sprite)
       player.sprite.name="player"
        
        makeLevel()
        
    }// didmove
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
            
        case 15:
           
            makeLevel()
        case 49:
            upPressed=true
            
        case 1:
            downPressed=true
            
        case 2:
            rightPressed=true
            
        case 0:
            leftPressed=true
            
            
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
       
    }// keydown
    
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
            
        
        case 49:
            upPressed=false
            
        case 1:
            downPressed=false
            
        case 2:
            rightPressed=false
            
        case 0:
            leftPressed=false
            
            
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
        
    }// key up
    
    
    
    func makeLevel()
    {
        for node in self.children
        {
            if node.name != nil
            {
                if node.name!=="block"
                {
                    node.removeFromParent()
                }
            }// if node isnt nil
        }// for node in self
        
            var height:Int=0
            var hole:Bool=false
            for platform in 0...7
            {
                let spawnChance = random(min: 0, max: 1)
                if spawnChance > 0.85
                {
                    height += 3
                }
                else if spawnChance > 0.7
                {
                    height += 0
                }
                else if spawnChance > 0.4
                {
                    height -= 3
                }
                else
                {
                    hole=true
                }
                
                if platform==0
                {
                    height=blockPlacement
                    player.sprite.position.y = CGFloat(height)*64+32-size.height/4
                    player.sprite.position.x = -size.width/2.2 + 25
                }// if platform = 0
                
                if height < 0
                {
                    height = 0
                }
                if height > 6
                {
                    height=6
                }
                if !hole || platform==7 || platform==0
                {
                    let block=SKSpriteNode(imageNamed: "platformA")
                    block.position=gridOut(x:platform, y: height)
                    addChild(block)
                    block.physicsBody=SKPhysicsBody(rectangleOf: block.size)
                    block.physicsBody!.categoryBitMask=physTypes.Ground
                    block.physicsBody!.isDynamic=false
                    block.physicsBody!.affectedByGravity=false
                    block.physicsBody!.allowsRotation=false
                    block.name="block"
                }
                else
                {
                    hole=false
                }
            }// for loop
        blockPlacement=height
       
    }// make level
    
    func gridOut(x: Int, y: Int) -> CGPoint
    {
        var retPoint=CGPoint()
        retPoint.x=CGFloat(x)*128+64-size.width/2
        retPoint.y=CGFloat(y)*64-32-size.height/4
        return retPoint
    }
    
    func checkKeys()
    {
       
    
        
        if upPressed==true && -lastJump.timeIntervalSinceNow > 2.0
        {
            
            player.sprite.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 10))
            lastJump = NSDate()
        }
            else
            {
                upPressed=false
            }
            
            if downPressed==true
            {
                player.sprite.position.y-=10
            }
            if rightPressed==true
            {
                player.sprite.position.x+=10
            }
            if leftPressed==true
            {
                player.sprite.position.x-=10
            }
    }
        
    
    
    func checkBoundaries()
    {
        if player.sprite.position.x-32>size.width/2
        {
            makeLevel()
        
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        checkKeys()
        checkBoundaries()
    }
}
