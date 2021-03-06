//
//  GameViewController.swift
//  Amoeba Wars
//
//  Created by David on 23/11/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{

    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        if let view = self.view as! SKView?
        {
            if let scene = SKScene(fileNamed: "GameScene")
            {
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
