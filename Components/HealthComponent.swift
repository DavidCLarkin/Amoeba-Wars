//
//  HealthComponent.swift
//  Amoeba Wars
//
//  Created by David on 05/12/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//
import SpriteKit
import GameplayKit

class HealthComponent : GKComponent
{
    var maxHealth: Int
    // currentHealth shouldn't be higher than maxHealth
    var currentHealth: Int
    {
        didSet
        {
            if currentHealth > maxHealth
            {
                currentHealth = maxHealth
            }
            else if currentHealth < 0
            {
                currentHealth = 0
            }
        }
    }
    
    init(health: Int, maxHealth: Int)
    {
        self.maxHealth = maxHealth
        if health > maxHealth
        {
            self.currentHealth = maxHealth
        }
        else
        {
            self.currentHealth = health
        }
        super.init()
    }
    
    func takeDamage(damage: Int)
    {
        currentHealth -= damage
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        if currentHealth > 0
        {
            // TODO take damage on collision
            // TODO remove from parent if health <= 0
            //print("health: \(currentHealth)")
            //takeDamage(damage: 1)
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
