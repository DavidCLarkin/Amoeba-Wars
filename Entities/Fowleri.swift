//
//  Fowleri.swift
//  Amoeba Wars
//
//  Created by David on 30/11/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import SpriteKit
import GameplayKit

class Fowleri: GKEntity
{
    
    init(team: Team, entityManager: EntityManager)
    {
        super.init()
        let imageName = team.rawValue=="Left" ? ImageName.FowleriLeft : ImageName.FowleriRight;
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(texture: texture)
        spriteComponent.node.name = "Fowleri"
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
        addComponent(HealthComponent(health: 150, maxHealth: 150))
        addComponent(AttackComponent(entityManager: entityManager, spriteComponent: spriteComponent))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
