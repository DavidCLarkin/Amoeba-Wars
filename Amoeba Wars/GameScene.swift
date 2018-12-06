//
//  GameScene.swift
//  Amoeba Wars
//
//  Created by David on 23/11/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    let margin = CGFloat(100)
    
    var histolyticaButton: ButtonNode!
    var fowleriButton: ButtonNode!
    var proteusButton: ButtonNode!
    
    let coinLeftLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let coinRightLabel = SKLabelNode(fontNamed: "Courier-Bold")
    
    var lastUpdateTimeInterval: TimeInterval = 0
    
    var gameOver = false
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView)
    {
        entityManager = EntityManager(scene: self)
        physicsWorld.contactDelegate = self
        self.size = CGSize(width: 1024, height: 768)
        self.anchorPoint = CGPoint(x: 0,y: 0)
        // Create entity manager
        
        // Start background music
        //let bgMusic = SKAudioNode(fileNamed: SoundFile.BackgroundMusic)
        //bgMusic.autoplayLooped = true
        //addChild(bgMusic)
        
        // Add background
        let background = SKSpriteNode(imageNamed: ImageName.Background)
        background.anchorPoint = CGPoint(x: 0,y:0)
        background.position = CGPoint(x: 0,y: 0)
        background.zPosition = Layer.Background
        background.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(background)
        
        // Add histolytica button
        histolyticaButton = ButtonNode(iconName: ImageName.HistolyticaLeft, text: String(GameConfig.HistolyticaCost), onButtonPress: histolyticaPressed)
        histolyticaButton.zPosition = Layer.HUD
        histolyticaButton.position = CGPoint(x: size.width * 0.25, y: margin + histolyticaButton.size.height / 2)
        self.addChild(histolyticaButton)
        
        // Add fowleri button
        
        fowleriButton = ButtonNode(iconName: ImageName.FowleriLeft, text: String(GameConfig.FowleriCost), onButtonPress: fowleriPressed)
        fowleriButton.zPosition = Layer.HUD
        fowleriButton.position = CGPoint(x: size.width * 0.50, y: margin + fowleriButton.size.height / 2)
        self.addChild(fowleriButton)
        
        // Add proteus button
        proteusButton = ButtonNode(iconName: ImageName.ProteusLeft, text: String(GameConfig.ProteusCost), onButtonPress: proteusPressed)
        proteusButton.zPosition = Layer.HUD
        proteusButton.position = CGPoint(x: size.width * 0.75, y: margin + proteusButton.size.height / 2)
        self.addChild(proteusButton)
        
        // Add coin left indicator
        let coinLeft = SKSpriteNode(imageNamed: ImageName.Coin)
        coinLeft.name = "coinLeft"
        coinLeft.zPosition = Layer.HUD
        
        coinLeft.position = CGPoint(x: margin + coinLeft.size.width/2,
                                    y: size.height - margin - coinLeft.size.height/2)
        addChild(coinLeft)
        coinLeftLabel.fontSize = 50
        coinLeftLabel.fontColor = SKColor.black
        coinLeftLabel.zPosition = Layer.HUD
        coinLeftLabel.position = CGPoint(x: coinLeft.position.x + coinLeft.size.width/2 + margin / 2, y: coinLeft.position.y)
        coinLeftLabel.horizontalAlignmentMode = .left
        coinLeftLabel.verticalAlignmentMode = .center
        coinLeftLabel.text = "0"
        self.addChild(coinLeftLabel)
        
        // Add coin right indicator
        let coinRight = SKSpriteNode(imageNamed: ImageName.Coin)
        coinRight.name = "coinRight"
        coinRight.zPosition = Layer.HUD
        
        coinRight.position = CGPoint(x: size.width - margin - coinRight.size.width/2 ,
                                    y: size.height - margin - coinRight.size.height/2)
        addChild(coinRight)
        coinRightLabel.fontSize = 50
        coinRightLabel.fontColor = SKColor.black
        coinRightLabel.zPosition = Layer.HUD
        coinRightLabel.position = CGPoint(x: coinRight.position.x + coinRight.size.width/2 - margin, y: coinRight.position.y)
        coinRightLabel.horizontalAlignmentMode = .right
        coinRightLabel.verticalAlignmentMode = .center
        coinRightLabel.text = "0"
        self.addChild(coinRightLabel)
        
        // Add base left
        let baseLeft = Base(imageName: ImageName.BaseLeftDefense, team: .teamLeft, entityManager: entityManager)
        if let spriteComponent = baseLeft.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2 + margin, y: size.height/2)
        }
        entityManager.add(baseLeft)
        
        
        // Add base right
        let baseRight = Base(imageName: ImageName.BaseRightDefense, team: .teamRight, entityManager: entityManager)
        if let spriteComponent = baseRight.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = CGPoint(x: size.width/2 + spriteComponent.node.size.width/2 + margin * 2, y: size.height/2)
        }
        entityManager.add(baseRight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else
        {
            return
        }
        let touchLocation = touch.location(in: self)
        print("\(touchLocation)")
        
        if gameOver {
            let newScene = GameScene(size: size)
            newScene.scaleMode = scaleMode
            view?.presentScene(newScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            return
        }
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        entityManager.update(deltaTime)
        
        // update player left coins
        if let playerLeft = entityManager.base(for: .teamLeft),
            let playerLeftBase = playerLeft.component(ofType: BaseComponent.self)
        {
            coinLeftLabel.text = "\(playerLeftBase.coins)"
        }
        
        // update player right coins
        if let playerRight = entityManager.base(for: .teamRight),
            let playerRightBase = playerRight.component(ofType: BaseComponent.self)
        {
            coinRightLabel.text = "\(playerRightBase.coins)"
        }
        
    }
    
    //MARK: - Button methods
    func histolyticaPressed()
    {
        print("Histolytica pressed")
        entityManager.spawnHistolytica(team: .teamLeft)
        
    }
    
    func fowleriPressed()
    {
        print("Fowleri pressed")
        entityManager.spawnFowleri(team: .teamLeft)
    }
    
    func proteusPressed()
    {
        print("Proteus pressed")
        entityManager.spawnProteus(team: .teamLeft)
    }
    
    func collisionBetween(amoeba: SKNode, object: SKNode)
    {
        if amoeba.name == "Histolytica" {
            print("\(amoeba.name)")
        } else if object.name == "Histolytica" {
            print("\(object.name)")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        print("collision")
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == "Histolytica" {
            collisionBetween(amoeba: nodeA, object: nodeB)
        } else if nodeB.name == "Histolytica" {
            collisionBetween(amoeba: nodeB, object: nodeA)
        }
    }
}
