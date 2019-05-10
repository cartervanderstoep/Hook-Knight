//
//  GameScene.swift
//  Hook Knight
//
//  Created by Game Design Shared on 3/28/19.
//  Copyright © 2019 Game Design Shared. All rights reserved.
//

import SpriteKit
import GameplayKit


public struct physTypes
{
    static let None:UInt32 =      0b00000000
    static let Player:UInt32 =    0b00000001
    static let Ground:UInt32 =    0b00000010
    static let Death:UInt32 =     0b00000100
    static let Enemy:UInt32 =     0b00001000
    static let Item:UInt32 =      0b00010000
    
    
}// phystypes


 class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameStart:Bool = true
    
    var screenPassed:Bool=false
    var upPressed:Bool=false
    var downPressed:Bool=false
    var rightPressed:Bool=false
    var leftPressed:Bool=false
    var playerDead:Bool=false
    var zipLineGet=false
    
    var zipPressed:Bool=false
    
    
    
    var blockPlacement:Int=0
    var stageCount:Int=1
    var itemAmount:Int=0
    var damageTaken:Int=0
    var zipCount:Int=0
    
    
    var lastJump=NSDate()
    
    var player=HookKnightClass()
    
    var deetleEnemy:beetleClass?
    
    var deathBlock=SKSpriteNode(imageNamed: "deathMote")
    
    var leftBarrier=SKSpriteNode(imageNamed: "barrier")
    
    var itemIcon=SKSpriteNode(imageNamed: "zipIcon")
    
    var abilityUse=SKSpriteNode(imageNamed: "zipline")
    
    var shield1=SKSpriteNode(imageNamed: "health1")
    
    var shield2=SKSpriteNode(imageNamed: "health2")
    
    var shield3=SKSpriteNode(imageNamed: "health3")
    
    var entList=[baseEnemyClass]()
    
    
    override func didMove(to view: SKView) {
        
        //deetleEnemy=beetleClass(theScene: self)
        
        physicsWorld.contactDelegate = self as SKPhysicsContactDelegate
        player.sprite.physicsBody=SKPhysicsBody(rectangleOf:player.sprite.size)
        player.sprite.physicsBody!.categoryBitMask=physTypes.Player
        player.sprite.physicsBody!.contactTestBitMask=physTypes.Enemy
        player.sprite.physicsBody!.collisionBitMask=physTypes.Ground
        player.sprite.physicsBody!.contactTestBitMask=physTypes.Item
        player.sprite.physicsBody!.allowsRotation=false
        player.sprite.physicsBody!.affectedByGravity=true
        player.sprite.physicsBody!.isDynamic=true
       
        addChild(player.sprite)
        player.sprite.name="player"
        player.sprite.isHidden=false
        
        
       
        
        
        deathBlock.position.y = -size.height/2 + deathBlock.size.height-32
        deathBlock.zPosition=6
        deathBlock.physicsBody=SKPhysicsBody(rectangleOf: deathBlock.size)
        deathBlock.physicsBody!.categoryBitMask=physTypes.Death
        deathBlock.physicsBody!.contactTestBitMask=physTypes.Player
        deathBlock.physicsBody!.collisionBitMask=physTypes.None
        deathBlock.physicsBody!.affectedByGravity=false
        deathBlock.physicsBody!.allowsRotation=false
        deathBlock.physicsBody!.isDynamic=false
        addChild(deathBlock)
        deathBlock.name="death barrier"
        
        leftBarrier.position.x = -size.width/1.87 + leftBarrier.size.width + 5
        leftBarrier.physicsBody=SKPhysicsBody(rectangleOf: leftBarrier.size)
        leftBarrier.physicsBody!.categoryBitMask=physTypes.Ground
        leftBarrier.physicsBody!.affectedByGravity=false
        leftBarrier.physicsBody!.allowsRotation=false
        leftBarrier.physicsBody!.isDynamic=false
        addChild(leftBarrier)
        leftBarrier.name="leftScreenBarrier"
        
        
        abilityUse.physicsBody=SKPhysicsBody(rectangleOf: abilityUse.size)
        abilityUse.physicsBody!.categoryBitMask=physTypes.Ground
        abilityUse.physicsBody!.isDynamic=false
        abilityUse.physicsBody!.affectedByGravity=false
        abilityUse.physicsBody!.allowsRotation=false
       
        
        abilityUse.name="ability"
        
        shield1.position.y = size.height/2.5
        shield1.position.x = -size.width/2.3
        addChild(shield1)
        
        shield2.position.y = size.height/2.5
        shield2.position.x = -size.width/2.3 + 90
        addChild(shield2)
        
        shield3.position.y = size.height/2.5
        shield3.position.x = -size.width/2.3 + 180
        addChild(shield3)
        
        
        makeLevel()
        
    }// didmove
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }//if a is less than b
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }//else
        
        if firstBody.node!.name != nil && secondBody.node!.name != nil
        {
            
            if firstBody.node!.name!.contains("player") && secondBody.node!.name!.contains("death")
            {
               player.sprite.isHidden=true
                if zipLineGet==true
                {
                    zipLineGet=false
                }
                
            }// if you hit the death barrier
            
            if firstBody.node!.name!.contains("player") && secondBody.node!.name!.contains("yarn")
            {
                print("collected")
                
                itemIcon.removeFromParent()
                zipLineGet=true
            }// if you run into the yarn
  

             if firstBody.node!.name!.contains("player") && secondBody.node!.name!.contains("deetle")
            {
                print("Player - Beetle")
                 var index:Int=0
                for i in 0 ..< entList.count
                {
                    if secondBody.node! == entList[i].sprite
                    {
                        index=i
                    }
                } // for loop
                if firstBody.node!.position.y-firstBody.node!.frame.size.height/2 >= secondBody.node!.position.y+secondBody.node!.frame.size.height/5
                {
                    print("i should be dead")
                   
                   
                    entList[index].die()
                    entList.remove(at: index)
                    
                }// if you land on a deetle
                else
                {
                    entList[index].die()
                    entList.remove(at: index)
                    damageTaken+=1
                    print(damageTaken)
                    
                    player.sprite.physicsBody!.applyImpulse(CGVector(dx: -25, dy: 30))
                    
                    if damageTaken==1
                    {
                        shield3.isHidden=true
                    }
                    
                    if damageTaken==2
                    {
                        shield2.isHidden=true
                    }
                    
                    if damageTaken == 3
                    {
                        player.sprite.isHidden=true
                        shield1.isHidden=true
                    }
                    
                }
                
            }// if you make contact with a deetle
        }// if there are names for the bodies
        
    }// didBegin
    
    
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
            stageCount=1
            itemIcon.removeFromParent()
            shield3.isHidden=false
            shield2.isHidden=false
            shield1.isHidden=false
            damageTaken=0
            
            zipLineGet=false
            
            
        case 49:
            upPressed=true
            
        case 1:
            downPressed=true
            
        case 2:
            rightPressed=true
            
        case 0:
            leftPressed=true
        case 8:
            
            zipPressed=true
            
            
            
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }// switch statement
       
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
        }// another switch statement
        
    }// key up
    
    
    
    func makeLevel()
    {
        itemAmount=0
        for ents in entList
        {
            ents.sprite.removeFromParent()
        }
        entList.removeAll()
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
                if spawnChance > 0.7
                {
                    height += 3
                }
                else if spawnChance > 0.55
                {
                    height += 0
                }
                else if spawnChance > 0.25
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
                    player.sprite.physicsBody!.velocity = .zero
                    player.sprite.isHidden=false
                    
                    
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
                    if platform != 0
                    {
                        let tempbeetleClass = beetleClass(theScene: self)
                        entList.append(tempbeetleClass)
                        tempbeetleClass.sprite.position.x=block.position.x+64
                        tempbeetleClass.sprite.position.y=block.position.y+50
                        print("Ent")
                        tempbeetleClass.sprite.zPosition=10
                        
                    }// spawning deetles on every platform except the first one
                    
                    
                    
                }//  block generation
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
    }// gridout function
    
    func checkKeys()
    {
       
    
        
        if upPressed==true && -lastJump.timeIntervalSinceNow > 0.7
        {
            
            player.sprite.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 85))
            lastJump = NSDate()
        }// if you press jump
            else
            {
                upPressed=false
            }
            
            if downPressed==true
            {
                player.sprite.position.y-=5
            }
            if rightPressed==true
            {
                player.sprite.position.x+=7
            }
            if leftPressed==true
            {
                player.sprite.position.x-=7
            }
    }// check keys function
        
    
    
    func checkBoundaries()
    {
        if player.sprite.position.x-32>size.width/2
        {
            makeLevel()
            stageCount+=1
            print(stageCount)
            itemIcon.removeFromParent()
            
            
        
        }// if you go off the right side of the screen
    }// check boundaries function
    
    func placeItem()
    {
       // if stageCount == 10
       // {
            if  itemAmount < 1 && player.sprite.isHidden==false && zipLineGet==false
            {
                itemIcon.physicsBody = SKPhysicsBody(rectangleOf: itemIcon.size)
                itemIcon.physicsBody!.categoryBitMask=physTypes.Item
                itemIcon.physicsBody!.contactTestBitMask=physTypes.Player
                itemIcon.physicsBody!.collisionBitMask=physTypes.Player
                itemIcon.physicsBody!.isDynamic=false
                itemIcon.physicsBody!.affectedByGravity=false
                itemIcon.physicsBody!.allowsRotation=false
                itemIcon.zPosition=5
                addChild(itemIcon)
                itemIcon.name="yarn"
                itemAmount+=1
            }// spawning  the yarn
            else if player.sprite.isHidden==true || player.sprite.position.x > size.width
            {
                itemIcon.removeFromParent()
            }
        
      // } // if you reach stage ten
        
        
    } // place item function
    
    
    func zipLine()
    {
    
        let tempAbilityUse=abilityUse
        
        if zipLineGet==true
        {
            
            var zipPointX:CGFloat=player.sprite.position.x
            var zipPointY:CGFloat=player.sprite.position.y - 50
            tempAbilityUse.zPosition=10
            
            if zipPressed == true && zipCount<1
            {
                addChild(tempAbilityUse)
                tempAbilityUse.position.x = zipPointX
                tempAbilityUse.position.y = zipPointY
                zipCount+=1
            }// if we can place a zipline
                
                
                if player.sprite.position.x > size.width/2
                {
                    print ("delete")
                    tempAbilityUse.removeFromParent()
                    zipCount=0
                    zipPressed=false
                }// if the player goes off the right edge of the screen.
            
            }// if you grap the zipline
        else if zipLineGet==false
        {
            tempAbilityUse.removeFromParent()
            zipCount=0
            zipPressed=false
        }// if you dont have the zipline
       
    }// zipline function
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if player.sprite.isHidden==false
        {
            checkKeys()
        }
        checkBoundaries()
        for ent in entList
        {
            ent.update()
        }
        placeItem()
        zipLine()
        
        
    }// update
}// literally the entire game
