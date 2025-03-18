//
//  GameScene.swift
//  NinjaJumper Shared
//
//  Created by Philip Werner on 2023-05-31.
//

import SpriteKit

class GameScene: SKScene {
  
    private var ninja = SKSpriteNode()
    private var ninjaRunningFrames: [SKTexture] = []

    var terrain = SKSpriteNode()
    var terrainMovingFrames: [SKTexture] = []
    
  
  override func didMove(to view: SKView) {
      backgroundColor = .blue
      
        let count = 1...10
        // print("count = ", count)
       
         for number in count {
          
            print("number = ", number)
        }
      
        buildNinja()
        animateNinja()
      
        physicsWorld.gravity = CGVector(dx: 0, dy: -10)
      
        ninja.physicsBody?.affectedByGravity = true
      
        buildTerrain()
        animateTerrain()
      
      
      
      
    //  terrain.strokeColor = .black
    //  terrain.fillColor = .black
    //  terrain.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 30))
    //  terrain.physicsBody?.affectedByGravity = false
    //  terrain.physicsBody?.isDynamic = false
     // terrain.position = .init(x: 300, y: 0)
    //  addChild(terrain)
      
      
      
      
      
  }
    func buildTerrain() {
        let terrainAnimatedAtlas = SKTextureAtlas(named: "floors")
        var floorMovingFrames: [SKTexture] = []
        
        let numFloorImages = terrainAnimatedAtlas.textureNames.count
        for i in 1..<numFloorImages+1 {
            let terrainTextureName = "floor\(i)"
            floorMovingFrames.append(terrainAnimatedAtlas.textureNamed(terrainTextureName))
        }
        
        terrainMovingFrames = floorMovingFrames
        
        let firstFloorFrameTexture = terrainMovingFrames[0]
        terrain = SKSpriteNode(texture: firstFloorFrameTexture)
        terrain.position = CGPoint(x: 400, y:0)
  
        addChild(terrain)
        
        terrain.physicsBody = SKPhysicsBody(rectangleOf: terrain.size)
        
        terrain.physicsBody?.affectedByGravity = false
        terrain.physicsBody?.isDynamic = false
        
    }
    
    func animateTerrain() {
        
        terrain.run(SKAction.repeatForever(
          SKAction.animate(with: terrainMovingFrames,
                           timePerFrame: 0.3,
                           resize: false,
                           restore: true)),
          withKey:"runningInPlaceNinja")
      }
    
    
    
      func buildNinja() {
          let ninjaAnimatedAtlas = SKTextureAtlas(named: "running")
          var runningFrames: [SKTexture] = []
        
          let numImages = ninjaAnimatedAtlas.textureNames.count
          for i in 0..<numImages {
              let ninjaTextureName = "Run__00\(i)"
              print("ninjaTextureName = ", ninjaTextureName)
              runningFrames.append(ninjaAnimatedAtlas.textureNamed(ninjaTextureName))
          }
          ninjaRunningFrames = runningFrames
        
        
          let firstFrameTexture = ninjaRunningFrames[0]
          ninja = SKSpriteNode(texture: firstFrameTexture)
          ninja.setScale(0.2)
          ninja.position = CGPoint(x: frame.midX, y: frame.midY)
          addChild(ninja)
        
          ninja.physicsBody = SKPhysicsBody(rectangleOf: ninja.size)
        
      }
    
      func animateNinja() {
        ninja.run(SKAction.repeatForever(
          SKAction.animate(with: ninjaRunningFrames,
                           timePerFrame: 0.1,
                           resize: false,
                           restore: true)),
          withKey:"runningInPlaceNinja")
      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        print("touch has occured")
        
        ninja.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
        
        
    }
    
    
    
    
}



extension GameScene: SKPhysicsContactDelegate {
    
}
