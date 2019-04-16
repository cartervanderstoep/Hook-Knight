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
    
    
    
    var attacked: Bool=false
    
    
    
    
    
    init()
    {
        
    }
    
    init(theScene: SKScene)
    {
        scene=theScene
        
    }
    
    

    func update() {
        
    }
}
