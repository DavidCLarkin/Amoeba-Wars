//
//  Histolytica.swift
//  Amoeba Wars
//
//  Created by David on 30/11/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import SpriteKit
import GameplayKit

class Histolytica: GKEntity
{
    
    init(team: Team, entityManager: EntityManager)
    {
        super.init()
        let imageName = team.rawValue=="Left" ? ImageName.HistolyticaLeft : ImageName.HistolyticaRight;
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(texture: texture)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
        addComponent(HealthComponent(health: 100, maxHealth: 100))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
