

import SpriteKit

class Home: SKScene {
    var ground = Ground()
    var ground2 = Ground()
    var bg = Background()
    var bg2 = Background()
    var ceiling = Ceiling()
    var ceiling2 = Ceiling()
    var pillar = Pillar()
    var pillar2 = Pillar()
    var timer = Timer()
    var count = 3
    var title = SKLabelNode()
    var ninja = Ninja()
    var countdownLabel = PulsatingText()
    var hasSwiped:Bool = false
    var nextLevel = SKSpriteNode()
    
    let myDefaults = UserDefaults.standard
    override func didMove(to view: SKView) {
        //Set up environment
        self.anchorPoint = CGPoint(x:0,y:0)
        self.physicsWorld.gravity = CGVector(dx:0,dy:-9.8)
        self.name = "Home"
        //Make Scene
        bg = Background(scene: self)
        self.addChild(bg)
        ground = Ground(scene:self)
        self.addChild(ground)
        ceiling = Ceiling(scene:self)
        self.addChild(ceiling)
        pillar = Pillar(scene:self)
        self.addChild(pillar)
        
        title = SKLabelNode(fontNamed: "Press Start K")
        title.text = "The Caves"
        title.fontSize = 50
        title.zPosition = 3
        title.horizontalAlignmentMode = .center
        title.position = CGPoint(x:self.frame.width/2,y:self.frame.height-120)
        self.addChild(title)
        
        ninja = Ninja(scene:self)
        ninja.position.x = -500*self.frame.width
        self.addChild(ninja)
        
        let swipe = PulsatingText(fontNamed: "Press Start K")
        swipe.zPosition = 3
        swipe.horizontalAlignmentMode = .center
        swipe.position = CGPoint(x:self.frame.width/2,y:self.frame.height-200)
        swipe.setTextFontSizeAndPulsate("Swipe Left to Play!", theFontSize: 20)
        self.addChild(swipe)
        
        nextLevel = SKSpriteNode(imageNamed: "Arrow")
        nextLevel.setScale(0.01)
        nextLevel.position = CGPoint(x:self.frame.width/2,y:nextLevel.size.height/2)
        nextLevel.zPosition = 6
        nextLevel.pulsate()
        self.addChild(nextLevel)
        
        let Gesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:#selector(self.swipe))
        Gesture.direction = .left
        view.addGestureRecognizer(Gesture)
        
        let dGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:#selector(self.nextScene))
        dGesture.direction = .up
        view.addGestureRecognizer(dGesture)
    }
    
    func swipe(gesture:UISwipeGestureRecognizer){
        if self.name == "Home" && !hasSwiped{
            hasSwiped = true
            pushAway()
        }
    }
    
    func nextScene(gesture:UISwipeGestureRecognizer){
        let scene = RuinsHome(size:self.size)
        let t = SKTransition.push(with: .up,duration:0.2)
        scene.scaleMode = .aspectFill
        view?.presentScene(scene,transition:t)
    }
    
    func pushAway(){
        let push = SKAction.moveBy(x: -self.frame.width*2, y: 0, duration: 0.3)
        let delete = SKAction.removeFromParent()
        let sequence = SKAction.sequence([push,delete])
        for node in self.children{
            if node.name != "bg" && node.name != "ground" && node.name != "ceiling" && node.name != "pillars"{
                node.run(sequence)
            }
        }
        let newNinja = Ninja(scene:self)
        newNinja.position.x = -100
        let run = SKAction.moveBy(x:100+self.frame.width/6+ninja.size.width/2,y:0,duration:4)
        newNinja.run(run)
        self.addChild(newNinja)
        
        countdownLabel = PulsatingText(fontNamed: "Press Start K")
        countdownLabel.zPosition = 3
        countdownLabel.fontColor = .red
        countdownLabel.setTextFontSizeAndPulsate("", theFontSize: 100)
        countdownLabel.horizontalAlignmentMode = .center
        countdownLabel.position = CGPoint(x:self.frame.width/2,y:self.frame.height-120)
        self.addChild(countdownLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown),userInfo:nil, repeats:true)
    }
    
    func countdown(){
        if count>0{
            countdownLabel.text = String(count)
        }
        else if count==0{
            countdownLabel.fontSize = 30
            countdownLabel.fontColor = .white
            countdownLabel.text = "Dodge the Missiles!"
        }
        else if count<0{
            let scene = GameScene(size:self.size)
            scene.scaleMode = .aspectFill
            view?.presentScene(scene)
        }
        count-=1
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
    }
}
