//
//  Proteus.swift
//  Amoeba Wars
//
//  Created by David on 30/11/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import SpriteKit
import GameplayKit

class Proteus: GKEntity
{
    
    init(team: Team, entityManager: EntityManager)
    {
        super.init()
        let imageName = team.rawValue=="Left" ? ImageName.ProteusLeft : ImageName.ProteusRight;
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(texture: texture)
        spriteComponent.node.name = "Proteus"
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
        addComponent(HealthComponent(health: 300, maxHealth: 300))
        addComponent(MeleeComponent(damage: 150, damageRate: 1.5, aoe: true, entityManager: entityManager))
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
