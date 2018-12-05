//
//  AIComponent.swift
//  Amoeba Wars
//
//  Created by David on 30/11/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import SpriteKit
import GameplayKit

class AIComponent : GKComponent
{
    var lastSpawn = TimeInterval(0)
    var waitTime = TimeInterval(0)
    let entityManager: EntityManager
    var coins: Int?
    enum Amoeba : UInt32
    {
        case Proteus
        case Fowleri
        case Histolytica
        
        static func randomAmoeba() -> Amoeba
        {
            // choose random amoeba
            let rand = arc4random_uniform(3)
            return Amoeba(rawValue: rand)!
        }
        
    }
    
    init(entityManager: EntityManager)
    {
        self.entityManager = entityManager
        self.coins = 0
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)
        
        coins = entityManager.base(for: .teamRight)?.component(ofType: BaseComponent.self)?.coins
        
        // 3
        let spawnInterval = TimeInterval(0.75)
        if CACurrentMediaTime() - lastSpawn > spawnInterval
        {
            lastSpawn = CACurrentMediaTime()
            switch Amoeba.randomAmoeba()
            {
            case .Proteus:
                entityManager.spawnProteus(team: .teamRight)
            case .Fowleri:
                entityManager.spawnFowleri(team: .teamRight)
            case .Histolytica:
                entityManager.spawnHistolytica(team: .teamRight)
            }
            //entityManager.spawnProteus(team: .teamRight)
            
        }
    }
}
