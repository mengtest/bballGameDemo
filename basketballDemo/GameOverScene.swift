//
//  GameOverScene.swift
//  basketballDemo
//
//  Created by Brett Berry on 9/15/16.
//  Copyright © 2016 Brett Berry. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {

    init(size: CGSize, score: Int, gameViewController: GameViewController) {
        super.init(size: size)
        backgroundColor = UIColor.whiteColor()
        scaleMode = .AspectFill
        addLabelsWithFinalScore(score)
        
        let delay = SKAction.waitForDuration(1.0)
        let replay = SKAction.runBlock() {
            let gameView = self.view
            let gameScene = GameScene(size: size, gameDelegate: gameViewController)
            gameViewController.gameScene = gameScene

            gameScene.setupGameScene()
            gameScene.physicsWorld.contactDelegate = gameViewController
            gameScene.delegate = gameViewController
            gameView?.presentScene(gameScene)
        }
        
        let replayGame = SKAction.sequence([delay, replay])
        runAction(replayGame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLabelsWithFinalScore(score: Int) {
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.position = CGPointMake(size.width / 2, size.height * 2/3)
        gameOverLabel.fontColor = UIColor.blackColor()
        gameOverLabel.fontSize = UIFont.systemFontSize() * 4
        addChild(gameOverLabel)
        
        let endScoreLabel = SKLabelNode()
        endScoreLabel.text = "\(score)"
        endScoreLabel.position = CGPointMake(frame.width / 2, frame.height / 2)
        endScoreLabel.fontSize = UIFont.systemFontSize() * 5
        endScoreLabel.fontColor = SKColor.blackColor()
        addChild(endScoreLabel)
        
        let basketsLabel = SKLabelNode(text: "baskets")
        basketsLabel.position = CGPointMake(frame.width / 2, frame.height / 2 - 75)
        basketsLabel.fontColor = SKColor.blackColor()
        basketsLabel.fontSize = UIFont.systemFontSize() * 4
        addChild(basketsLabel)
    }

}
