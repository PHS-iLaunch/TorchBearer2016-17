
import SpriteKit
import AudioToolbox

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ninja = Ninja()
    var ground = Ground()
    var ground2 = Ground()
    var bg = Background()
    var bg2 = Background()
    var ceiling = Ceiling()
    var ceiling2 = Ceiling()
    var pillar = Pillar()
    var pillar2 = Pillar()
    var restartButton = SKSpriteNode()
    var timer = Timer()
    var timer2 = Timer()
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameOver = false
    var cash = 0
    var cashLabel = SKLabelNode()
    var menuButton = SKSpriteNode()
    var levelsButton = SKSpriteNode()

    override func didMove(to view: SKView) {
        //Set up environment
        self.anchorPoint = CGPoint(x:0,y:0)
        self.physicsWorld.gravity = CGVector(dx:0,dy:-9.8)
        self.physicsWorld.contactDelegate = self
        createScene()
    }
    
    //Spawn Bullet
    func spawnBullet(){
        let bullet = Bullet(scene:self)
        self.addChild(bullet)
    }
    
    //Spawn Coin
    func spawnCoin(){
        let coin = Coin(scene:self)
        self.addChild(coin)
    }
    
    //Contact Function
    func didBegin(_ contact:SKPhysicsContact){
        let body1 = contact.bodyA
        let body2 = contact.bodyB
        if body1.categoryBitMask == PhysicsMasks.Ninja && body2.categoryBitMask == PhysicsMasks.Ground || body1.categoryBitMask == PhysicsMasks.Ground && body2.categoryBitMask == PhysicsMasks.Ninja{
            ninja.animate()
        }
        if body1.categoryBitMask == PhysicsMasks.Ninja && body2.categoryBitMask == PhysicsMasks.Bullet || body1.categoryBitMask == PhysicsMasks.Bullet && body2.categoryBitMask == PhysicsMasks.Ninja{
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            if !gameOver{
                restart()
            }
        }
        if body1.categoryBitMask == PhysicsMasks.Ninja && body2.categoryBitMask == PhysicsMasks.Coin || body1.categoryBitMask == PhysicsMasks.Coin && body2.categoryBitMask == PhysicsMasks.Ninja{
            for node in [body1.node,body2.node]{
                if let someCoin = node as? Coin{
                    cash+=someCoin.value
                    //Make coin animation
                    let coin = SKSpriteNode(imageNamed: "Coin1")
                    coin.zPosition = 6
                    coin.position = someCoin.position
                    coin.size = someCoin.size
                    self.addChild(coin)
                    let fly = SKAction.move(to: CGPoint(x:self.frame.width-150,y:self.frame.height-12), duration: 0.2)
                    let scale = SKAction.scale(to: CGSize(width:20,height:20), duration: 0.2)
                    let delete = SKAction.removeFromParent()
                    let blit = SKAction.run{self.cashLabel.text = String(self.cash)}
                    coin.run(fly)
                    coin.run(SKAction.sequence([scale,delete,blit]))
                    //Make number animation
                    let added = SKLabelNode(fontNamed: "Press Start K")
                    added.text = "+\(someCoin.value)"
                    added.horizontalAlignmentMode = .left
                    added.verticalAlignmentMode = .center
                    added.position = CGPoint(x:cashLabel.position.x+50,y:cashLabel.position.y)
                    added.fontSize = 30
                    added.zPosition = 6
                    self.addChild(added)
                    let jiggle1 = SKAction.rotate(byAngle: CGFloat(M_PI)/15, duration: 0.2)
                    let jiggle2 = SKAction.rotate(byAngle: -CGFloat(M_PI)/15, duration: 0.2)
                    let drift = SKAction.move(by: CGVector(dx:20,dy:40), duration: 0.4)
                    let fade = SKAction.fadeOut(withDuration: 0.4)
                    added.run(SKAction.sequence([fade,delete]))
                    added.run(SKAction.sequence([jiggle1,jiggle2]))
                    added.run(drift)
                    someCoin.removeFromParent()
                }
            }
        }
    }
    
    func createScene(){
        //Make Scene
        bg = Background(scene: self)
        self.addChild(bg)
        ninja = Ninja(scene:self)
        self.addChild(ninja)
        ground = Ground(scene:self)
        self.addChild(ground)
        ceiling = Ceiling(scene:self)
        self.addChild(ceiling)
        pillar = Pillar(scene:self)
        self.addChild(pillar)
        
        scoreLabel = SKLabelNode(fontNamed: "Press Start K")
        scoreLabel.text = String(score)
        scoreLabel.fontSize = 30
        scoreLabel.zPosition = 10
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x:self.frame.width/2,y:self.frame.height-45)
        self.addChild(scoreLabel)
        
        let coinIcon = SKSpriteNode(imageNamed: "Coin1")
        coinIcon.position = CGPoint(x:self.frame.width-175,y:self.frame.height-45)
        coinIcon.size = CGSize(width:20,height:20)
        coinIcon.zPosition = 6
        self.addChild(coinIcon)
        
        cashLabel = SKLabelNode(fontNamed: "Press Start K")
        cashLabel.horizontalAlignmentMode = .left
        cashLabel.verticalAlignmentMode = .center
        cashLabel.position = CGPoint(x:self.frame.width-150,y:self.frame.height-45)
        cashLabel.text = String(cash)
        cashLabel.fontSize = 20
        cashLabel.zPosition = 6
        self.addChild(cashLabel)
        
        //Make Bullet
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.spawnBullet),userInfo:nil, repeats:true)
        
        //Make Coins
        timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.spawnCoin),userInfo:nil, repeats:true)
    }
    
    func restart(){
        gameOver = true
        toSave.totalCash+=cash
        if score>toSave.highScore{
            toSave.highScore = score
        }
        let overlay = SKSpriteNode(color:.white,size:self.size)
        overlay.alpha = 0.45
        overlay.position = CGPoint(x:self.frame.width/2,y:self.frame.height/2)
        overlay.zPosition = 5
        self.addChild(overlay)
        
        let offset = self.frame.width
        
        let red = SKSpriteNode(color:.red,size:CGSize(width:self.frame.width,height:self.frame.height/3))
        red.anchorPoint = CGPoint(x:0,y:0.5)
        red.position = CGPoint(x:self.frame.width/3-150+offset,y:self.frame.height/1.8)
        red.zPosition = 5
        red.alpha = 0.5
        self.addChild(red)
        
        scoreLabel.removeFromParent()
        let newScoreLabel = SKLabelNode(fontNamed: "Press Start K")
        newScoreLabel.fontSize = 20
        newScoreLabel.zPosition = 6
        newScoreLabel.fontColor = .black
        newScoreLabel.text = ("Score: \(score)")
        newScoreLabel.horizontalAlignmentMode = .left
        newScoreLabel.position = CGPoint(x:self.frame.width/3+offset,y:self.frame.height-140)
        self.addChild(newScoreLabel)
        
        let highScoreLabel:SKLabelNode = SKLabelNode(fontNamed: "Press Start K")
        highScoreLabel.text = "HighScore: \(toSave.highScore)"
        highScoreLabel.fontColor = .black
        highScoreLabel.fontSize = 20
        highScoreLabel.zPosition = 6
        highScoreLabel.horizontalAlignmentMode = .left
        highScoreLabel.position = CGPoint(x:self.frame.width/3+offset,y:self.frame.height-170)
        self.addChild(highScoreLabel)
        
        let cashLabel:SKLabelNode = SKLabelNode(fontNamed: "Press Start K")
        cashLabel.text = "Total Cash: \(toSave.totalCash)"
        cashLabel.fontColor = .black
        cashLabel.fontSize = 20
        cashLabel.zPosition = 6
        cashLabel.horizontalAlignmentMode = .left
        cashLabel.position = CGPoint(x:self.frame.width/3+offset,y:self.frame.height-200)
        self.addChild(cashLabel)
        
        //Create a restart Button
        restartButton = SKSpriteNode(imageNamed:"restart")
        restartButton.scale(to:CGSize(width: self.frame.height/3, height: self.frame.height/3))
        restartButton.position = CGPoint(x:self.frame.width/3-100+offset, y:self.frame.height/1.8)
        restartButton.zPosition = 6
        self.addChild(restartButton)
        
        //Create a back to home button
        menuButton = SKSpriteNode(imageNamed: "Menu")
        menuButton.size = CGSize(width: self.frame.height*0.507, height:self.frame.height/7)
        menuButton.position = CGPoint(x:restartButton.position.x-restartButton.size.width/2+menuButton.size.width/2-offset,y:restartButton.position.y-restartButton.size.height/2-menuButton.size.height/2-15-offset)
        menuButton.zPosition = 7
        self.addChild(menuButton)
        
        //Create a back to home button
        levelsButton = SKSpriteNode(imageNamed: "Levels")
        levelsButton.size = CGSize(width: self.frame.height*0.507, height:self.frame.height/7)
        levelsButton.position = CGPoint(x:restartButton.position.x-restartButton.size.width/2+menuButton.size.width/2+menuButton.size.width+15-offset,y:restartButton.position.y-restartButton.size.height/2-menuButton.size.height/2-15-offset)
        levelsButton.zPosition = 7
        self.addChild(levelsButton)
        
        //Create a Game Over Text
        let label:SKLabelNode = SKLabelNode(fontNamed: "Press Start K")
        label.text = "Game Over"
        label.fontColor = .black
        label.fontSize = 60
        label.zPosition = 7
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x:self.frame.width/2,y:self.frame.height/1.3+offset)
        self.addChild(label)
        
        let moveLeft = SKAction.moveBy(x: -offset, y: 0, duration: 0.5)
        let moveDown = SKAction.moveBy(x: 0, y: -offset, duration: 0.5)
        let moveUp = SKAction.moveBy(x: 0, y: offset, duration: 0.5)
        red.run(moveLeft)
        newScoreLabel.run(moveLeft)
        highScoreLabel.run(moveLeft)
        cashLabel.run(moveLeft)
        restartButton.run(moveLeft)
        menuButton.run(moveUp)
        levelsButton.run(moveUp)
        label.run(moveDown)
        
    }
    
    func reset(){
        timer.invalidate()
        timer2.invalidate()
        self.removeAllActions()
        self.removeAllChildren()
        gameOver = false
        score = 0
        cash = 0
        createScene()
    }
    
    //Touch Recognition Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {//What to do if a user touches to screen
        ninja.thrust()
        for touch in touches{
            if restartButton.contains(touch.location(in:self)) && gameOver{
                reset()
            }
            if menuButton.contains(touch.location(in:self)) && gameOver{
                let t = SKTransition.doorsOpenVertical(withDuration: 0.5)
                let scene = Main(size:self.size)
                scene.scaleMode = .aspectFill
                view?.presentScene(scene,transition:t)
            }
            if levelsButton.contains(touch.location(in:self)) && gameOver{
                let t = SKTransition.doorsOpenVertical(withDuration: 0.5)
                let scene = Home(size:self.size)
                scene.scaleMode = .aspectFill
                view?.presentScene(scene,transition:t)
            }
        }
    }
    
    //Update Function
    override func update(_ currentTime: TimeInterval) {
        if ground.position.x+ground.size.width/2<=self.frame.width{
            ground2 = Ground(scene:self,xPos:ground.position.x+ground.size.width)
            self.addChild(ground2)
            ground = ground2
        }
        if ceiling.position.x+ceiling.size.width/2<=self.frame.width{
            ceiling2 = Ceiling(scene:self,xPos:ceiling.position.x+ceiling.size.width)
            self.addChild(ceiling2)
            ceiling = ceiling2
        }
        if bg.position.x+bg.size.width/2<=self.frame.width{
            bg2 = Background(scene:self,xPos:bg.position.x+bg.size.width)
            self.addChild(bg2)
            bg = bg2
        }
        if pillar.position.x+pillar.size.width/2<=self.frame.width{
            pillar2 = Pillar(scene:self,xPos:pillar.position.x+pillar.size.width)
            self.addChild(pillar2)
            pillar = pillar2
        }
        if (ninja.physicsBody?.velocity.dy)!<CGFloat(0) && ninja.position.y>ground.frame.height+ninja.size.height/2+self.frame.height/20{
            ninja.noThrust()
        }
        for node in self.children{
            if node.name == "bullet"{
                if let bullet = node as? Bullet{
                    if bullet.position.x<ninja.position.x && !bullet.passed && !gameOver{
                        score += 1
                        scoreLabel.text = String(score)
                        bullet.passed = true
                    }
                }
            }
        }
    }
}
