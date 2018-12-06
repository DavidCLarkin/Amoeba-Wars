//
//  AttackComponent.swift
//  Amoeba Wars
//
//  Created by David on 06/12/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import SpriteKit
import GameplayKit

class AttackComponent : GKComponent
{
    let entityManager: EntityManager
    let spriteComponent: SpriteComponent
    
    init(entityManager: EntityManager, spriteComponent: SpriteComponent)
    {
        self.entityManager = entityManager
        self.spriteComponent = spriteComponent
        super.init()
        
        setUpCollision()
        
    }
    
    func setUpCollision()
    {
        spriteComponent.node.physicsBody = SKPhysicsBody(texture: spriteComponent.node.texture!, size: spriteComponent.node.texture!.size())
        spriteComponent.node.physicsBody?.isDynamic = false
        spriteComponent.node.physicsBody?.contactTestBitMask = (spriteComponent.node.physicsBody?.collisionBitMask)!
        print("node name: \(spriteComponent.node.name)")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
