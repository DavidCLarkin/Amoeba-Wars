//
//  MeleeComponent.swift
//  Amoeba Wars
//
//  Created by David on 02/01/2019.
//  Copyright © 2019 David Larkin. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MeleeComponent: GKComponent
{
    
    let damage: CGFloat
    let damageRate: CGFloat
    var lastDamageTime: TimeInterval
    let aoe: Bool
    let entityManager: EntityManager
    
    init(damage: CGFloat, damageRate: CGFloat, aoe: Bool, entityManager: EntityManager)
    {
        self.damage = damage
        self.damageRate = damageRate
        self.aoe = aoe
        self.lastDamageTime = 0
        self.entityManager = entityManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        
        super.update(deltaTime: seconds)
        
        guard let teamComponent = entity?.component(ofType: TeamComponent.self),
            let spriteComponent = entity?.component(ofType: SpriteComponent.self) else
        {
                return
        }
        
        var aoeDamageCaused = false
        let enemyEntities = entityManager.entitiesForTeam(teamComponent.team.oppositeTeam())
        for enemyEntity in enemyEntities
        {
            
            // getting components
            guard let enemySpriteComponent = enemyEntity.component(ofType: SpriteComponent.self),
                let enemyHealthComponent = enemyEntity.component(ofType: HealthComponent.self) else
            {
                    continue
            }
            
            // Check collision
            if (spriteComponent.node.calculateAccumulatedFrame().intersects(enemySpriteComponent.node.calculateAccumulatedFrame()))
            {
                
                // Check damage rate
                if (CGFloat(CACurrentMediaTime() - lastDamageTime) > damageRate)
                {
                    
                    // Cause damage
                    if (aoe)
                    {
                        aoeDamageCaused = true
                    }
                    else
                    {
                        lastDamageTime = CACurrentMediaTime()
                    }
                    
                    // Subtract health
                    enemyHealthComponent.takeDamage(damage: Int(damage))
                    
                    if(enemyHealthComponent.currentHealth <= 0)
                    {
                        print("Removing Entity")
                        entityManager.remove(entity!)
                    }
                }
            }
        }
        
        if (aoeDamageCaused)
        {
            lastDamageTime = CACurrentMediaTime()
        }
        
    }
    
}
