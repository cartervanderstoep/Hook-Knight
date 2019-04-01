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
    
    
    override func didMove(to view: SKView) {
        
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
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
       
    }
    
    func makeLevel()
    {
        
            var height:Int=0
            var hole:Bool=false
            for platform in 0...8
            {
                let spawnChance = random(min: 0, max: 1)
                if spawnChance > 0.75
                {
                    height += 1
                }
                else if spawnChance > 0.5
                {
                    height += 0
                }
                else if spawnChance > 0.25
                {
                    height -= 1
                }
                else
                {
                    hole=true
                }
                if height < 0
                {
                    height = 0
                }
                if height > 8
                {
                    height=8
                }
                if !hole
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
        
    }// make level
    
    func gridOut(x: Int, y: Int) -> CGPoint
    {
        var retPoint=CGPoint()
        retPoint.x=CGFloat(x)*64+32-size.width/2
        retPoint.y=CGFloat(y)*64-32-size.height/4
        return retPoint
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
