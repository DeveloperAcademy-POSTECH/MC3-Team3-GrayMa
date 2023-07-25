//
//  StrengthVisualization.swift
//  Dots
//
//  Created by 정승균 on 2023/07/25.
//

import SwiftUI
import SpriteKit

struct StrengthVisualization: View {
    var scene: SKScene {
            let scene = GameScene()
            scene.size = CGSize(width: 300, height: 300) // Scene 크기 설정
            scene.scaleMode = .fill
            return scene
        }

        var body: some View {
            // SpriteKit을 SwiftUI 뷰로 감싸기 위해 SpriteView 사용
            SpriteView(scene: scene, options: .allowsTransparency)
//                .frame(width: 300, height: 300) // Scene 크기에 맞게 뷰 크기 설정
        }
}

// SKScene 클래스
class GameScene: SKScene {
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            
        }
    }
    
    override func didMove(to view: SKView) {
        // 배경 색상 설정
        self.backgroundColor = .white

//        // 원 생성
//        let circle = createCircle(radius: 50)
//        circle.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        self.addChild(circle)
        
        let composite = TouchCompositeNode(color: .red)
        composite.position = CGPoint(x: 100, y:100)
             
        let backgroundNode = SKSpriteNode(color: .blue,
                                          size: CGSize(width: 500, height: 500))
        backgroundNode.position = CGPoint(x: 100, y: 100)
             
        self.addChild(backgroundNode)
        self.addChild(composite)
    }

    // 원 생성하는 함수
    private func createCircle(radius: CGFloat) -> SKShapeNode {
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.fillColor = .blue
        circle.strokeColor = .clear
        circle.name = "circle"
        circle.isUserInteractionEnabled = true
        return circle
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print(touch)
            let location = touch.location(in: self)
            print(location)
            if let node = self.atPoint(location) as? SKShapeNode {
                // 원을 터치하면 크기 변경
                let scaleAction = SKAction.scale(by: 1.5, duration: 0.2)
                node.run(scaleAction)
//                print("터치")
            }
            print("터치2")
        }
    }

//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//            if let node = self.atPoint(location) as? SKShapeNode {
//                // 원을 드래그하면 크기 변경
//                let scaleAction = SKAction.scale(by: 1.5, duration: 0.2)
//                node.run(scaleAction)
//            }
//        }
//    }
}

class TouchSpriteNode: SKSpriteNode {
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
         
    // For macOS replace this method with `mouseDown(with:)`
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // User has touched this node
    }
}

class TouchCompositeNode: SKNode {
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
    
    let tau = CGFloat.pi * 2
    
    required init(color: SKColor, radius: CGFloat = 100) {
        super.init()
        
        stride(from: 0, to: tau, by: tau / 6).forEach {
            
            let node = SKShapeNode(circleOfRadius: 20)
            
            node.fillColor = color
            node.position = CGPoint(x: sin($0) * radius,
                                    y: cos($0) * radius)
            
            addChild(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // For macOS replace this method with `mouseDown(with:)`
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // User has touched this node
        self.position = .zero
    }
}

struct StrengthVisualization_Previews: PreviewProvider {
    static var previews: some View {
        StrengthVisualization()
    }
}
