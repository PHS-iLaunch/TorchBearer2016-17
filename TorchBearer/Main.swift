

import SpriteKit

class Main: SKScene {
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
        title.text = "Torch Bearer"
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
        swipe.setTextFontSizeAndPulsate("Swipe Left for Levels!", theFontSize: 20)
        self.addChild(swipe)
        
        let Gesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:#selector(self.swipe))
        Gesture.direction = .left
        view.addGestureRecognizer(Gesture)
    }
    
    func swipe(gesture:UISwipeGestureRecognizer){
        if self.name == "Home" && !hasSwiped{
            hasSwiped = true
            let scene = Home(size:self.size)
            let t = SKTransition.push(with: .left, duration: 0.2)
            scene.scaleMode = .aspectFill
            view?.presentScene(scene,transition:t)
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
    }
}
