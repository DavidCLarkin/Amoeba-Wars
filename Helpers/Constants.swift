//
//  Constants.swift
//  Amoeba Wars
//
//  Created by David on 23/11/2018.
//  Copyright © 2018 David Larkin. All rights reserved.
//

import SpriteKit


import UIKit

struct ImageName
{
    static let Background = "Background"
    static let BaseLeftAttack = "Base_Left_Attack"
    static let BaseLeftDefense = "Base_Left_Defence"
    static let BaseRightAttack = "Base_Right_Attack"
    static let BaseRightDefense = "Base_Right_Defence"
    static let ButtonSelected = "Button_Selected"
    static let Button = "Button"
    static let Coin = "Coin"
    static let FowleriRight = "FowleriRight"
    static let FowleriLeft = "FowleriLeft"
    static let HistolyticaLeft = "HistolyticaLeft"
    static let HistolyticaRight = "HistolyticaRight"
    static let LaserLeft = "LaserLeft"
    static let LaserRight = "LaserRight"
    static let ProteusLeft = "ProteusLeft"
    static let ProteusRight = "ProteusRight"
}

struct Layer
{
    static let Background: CGFloat = 0
    static let BaseLeftAttack: CGFloat = 1
    static let BaseLeftDefense: CGFloat = 1
    static let BaseRightAttack: CGFloat = 1
    static let BaseRightDefense: CGFloat = 1
    static let ButtonSelected: CGFloat = 3
    static let Button: CGFloat = 3
    static let Coin: CGFloat = 2
    static let FowleriRight: CGFloat = 2
    static let FowleriLeft: CGFloat = 2
    static let HistolyticaLeft: CGFloat = 2
    static let HistolyticaRight: CGFloat = 2
    static let LaserLeft: CGFloat = 2
    static let LaserRight: CGFloat = 2
    static let ProteusLeft: CGFloat = 2
    static let ProteusRight: CGFloat = 2
    static let Amoeba: CGFloat = 2
    static let HUD: CGFloat = 4
}

struct PhysicsCategory {
}

struct GameConfig
{
    static let HistolyticaCost = 10
    static let FowleriCost = 25
    static let ProteusCost = 50
    
}
