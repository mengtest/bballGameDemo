//
//  GameView.swift
//  basketballDemo
//
//  Created by Brett Berry on 6/23/16.
//  Copyright © 2016 Brett Berry. All rights reserved.
//

import SpriteKit

class GameView: SKView {
    
    var ball: SKShapeNode!
    var timeLabel = SKLabelNode()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let scene = SKScene(size: frame.size)
        scene.backgroundColor = UIColor.whiteColor()
        presentScene(scene)
        createHoop()
        createBall()
        createFloor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createHoop() {
        
        let width: CGFloat = frame.width * 3/5
        let height: CGFloat = width * 2/3
        let size = CGSize(width: width, height: height)
        let x = (frame.width - size.width) / 2
        let y = (frame.height - size.height) * (3/4)
        let rect = CGRectMake(x, y, size.width, size.height)
        let path = CGPathCreateWithRoundedRect(rect, 20, 20, nil)
        let backboard = SKShapeNode(path: path)
        backboard.strokeColor = UIColor.grayColor()
        backboard.lineWidth = 5
        backboard.zPosition = 0
        scene?.addChild(backboard)
        
        let innerRectSize = CGSize(width: size.width * (2/5), height: size.height * (2/5) + 10)
        let xOffset = x + size.width / 2 - innerRectSize.width / 2
        let yOffset = y + size.height / 2 - innerRectSize.height / 2
        let smallRect = CGRectMake(xOffset, yOffset, innerRectSize.width, innerRectSize.height)
        let smallPath = CGPathCreateWithRect(smallRect, nil)
        let innerRect = SKShapeNode(path: smallPath)
        innerRect.strokeColor = UIColor.grayColor()
        innerRect.lineWidth = 4
        backboard.addChild(innerRect)
        
        let hoopSize = CGSize(width: innerRectSize.width + 20, height: 0)
        let hoopRect = CGRectMake(xOffset - 10, yOffset, hoopSize.width, hoopSize.height)
        let hoopPath = CGPathCreateWithRoundedRect(hoopRect, 5, 0, nil)
        let hoop = SKShapeNode(path: hoopPath)
        hoop.strokeColor = UIColor.redColor()
        hoop.lineWidth = 7
        hoop.zPosition = 3
        scene?.addChild(hoop)
        
        let clockSize = CGSize(width: innerRectSize.width, height: innerRectSize.height / 2)
        let clockX = xOffset
        let clockY = y + size.height - innerRectSize.height / 4
        let clockRect = CGRectMake(clockX, clockY, clockSize.width, clockSize.height)
        let clockPath = CGPathCreateWithRoundedRect(clockRect, 5, 5, nil)
        let shotClock = SKShapeNode(path: clockPath)
        shotClock.fillColor = UIColor.lightGrayColor()
        shotClock.strokeColor = UIColor.lightGrayColor()
        backboard.addChild(shotClock)
        
        timeLabel.horizontalAlignmentMode = .Center
        timeLabel.verticalAlignmentMode = .Center
        timeLabel.position = CGPointMake(clockX + clockSize.width / 2, clockY + clockSize.height / 2)
        timeLabel.fontSize = 26
        timeLabel.text = "20.00"
        shotClock.addChild(timeLabel)
    }
    
    func createBall() {
        
        let size = CGSize(width: 100, height: 100)
        let location = CGPointMake((frame.width - size.width) / 2, 100)
        let rect = CGRectMake(location.x, location.y, size.width, size.height)
        let path = CGPathCreateWithEllipseInRect(rect, nil)
        ball = SKShapeNode(path: path)
        ball.fillColor = UIColor.orangeColor()
        ball.strokeColor = UIColor.orangeColor()
        
        let ballBody = SKPhysicsBody(circleOfRadius: size.width / 2, center: location)
        ballBody.mass = 1.0
        ballBody.affectedByGravity = false
        ballBody.categoryBitMask = PhysicsType.ball
        ballBody.collisionBitMask = PhysicsType.hoop
        ball.physicsBody = ballBody
        ball.alpha = 0.0
        ball.zPosition = 4
        scene?.addChild(ball)
        
        let fadeIn = SKAction.fadeInWithDuration(0.05)
        ball.runAction(fadeIn)
        
        let shadowSize = CGSize(width: size.width, height: size.height / 3)
        let shadowRect = CGRectMake(location.x, 90, shadowSize.width, shadowSize.height)
        let shadowPath = CGPathCreateWithEllipseInRect(shadowRect, nil)
        let shadow = SKShapeNode(path: shadowPath)
        shadow.name = "shadow"
        shadow.fillColor = UIColor.grayColor()
        shadow.strokeColor = UIColor.clearColor()
        shadow.zPosition = 3
        shadow.alpha = 0.4
        scene?.addChild(shadow)
        
        let highlightSize = CGSize(width: 2 * size.width / 3, height: 2 * size.height / 3)
        let highlightLocation = CGPointMake(location.x + highlightSize.width / 2 - 5, highlightSize.height / 3 + 100)
        let highlightRect = CGRectMake(highlightLocation.x, highlightLocation.y, highlightSize.width, highlightSize.height)
        let highlightPath = CGPathCreateWithEllipseInRect(highlightRect, nil)
        let highlight = SKShapeNode(path: highlightPath)
        highlight.fillColor = UIColor(red: 1, green: 153/255, blue: 51/255, alpha: 1)
        highlight.strokeColor = UIColor.clearColor()
        ball.addChild(highlight)
    }
    
    private func createFloor() {
        let size = CGSize(width: bounds.width, height: bounds.height / 4)
        let rect = CGRectMake(0, 0, size.width, size.height)
        let path = CGPathCreateWithRect(rect, nil)
        let floor = SKShapeNode(path: path)
        floor.fillColor = UIColor.lightGrayColor()
        floor.zPosition = 2
        scene?.addChild(floor)
    }
}


