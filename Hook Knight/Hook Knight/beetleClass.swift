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
    var sprite=SKSpriteNode(imageNamed:"Deetle")
    
    
    
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
        
    }
    
    func move()
    {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func update() {
    
    }
}
