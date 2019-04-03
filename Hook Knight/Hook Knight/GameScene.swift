//
//  GameScene.swift
//  Hook Knight
//
//  Created by Game Design Shared on 3/28/19.
//  Copyright © 2019 Game Design Shared. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameStart:Bool = true
    
    var screenPassed:Bool=false
    var upPressed:Bool=false
    var downPressed:Bool=false
    var rightPressed:Bool=false
    var leftPressed:Bool=false
    
    var blockPlacement:Int=0
    var player=HookKnightClass()
    
    override func didMove(to view: SKView) {
        
        addChild(player.sprite)
       
        
        makeLevel()
        
    }
    
    
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
            for node in self.children
            {
                if node.name!=="block"
                {
                    node.removeFromParent()
                }
            }
            makeLevel()
        case 13:
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
       
    }
    
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
            
        
        case 13:
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
        
    }
    
    
    
    func makeLevel()
    {
        
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
                    
                }
                
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
        if upPressed==true
        {
            player.sprite.position.y+=10
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
            player.sprite.position.x = -size.width/2.5
        
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        checkKeys()
        checkBoundaries()
    }
}
