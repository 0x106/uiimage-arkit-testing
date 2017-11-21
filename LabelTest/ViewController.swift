//
//  ViewController.swift
//  LabelTest
//
//  Created by Jordan Campbell on 21/11/17.
//  Copyright © 2017 Atlas Innovation. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
//    var labels = [Label]()
    var labels = [ImageFromLabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        var index: Int = 0
        var x: Float = 0.0
        var y: Float = 0.0
        let size: Float = 0.25
        let N = 10
        for i in 0 ... N-1 {
            for k in 0 ... N-1 {
//                let display = ImageLabel()
//                let display = Label()
                let display = ImageFromLabel()
                self.labels.append(display)
            
                index = self.labels.count - 1
                x = Float(i) * size - (Float(N) * size * 0.5)
                y = Float(k) * size - (Float(N) * size * 0.5)
            
                self.sceneView.scene.rootNode.addChildNode(self.labels[index].node)
            
                self.labels[index].node.position = SCNVector3Make(x, y, -2)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

class Label {
    var node: SCNNode
    var display: UILabel
    var plane: SCNPlane
    
    init() {
        node = SCNNode()
        display = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(100), height: CGFloat(50)))
        plane = SCNPlane(width: 0.2, height: 0.1)
        
        display.adjustsFontSizeToFitWidth = true
        display.numberOfLines = 1
        display.backgroundColor = UIColor.magenta
        
        plane.firstMaterial?.diffuse.contents = display
        node.geometry = plane
        
        display.text = "test"
    }
}

class ImageFromLabel {
    var node: SCNNode
    var display: UILabel
    var plane: SCNPlane
    var image: UIImage
    
    init() {
        node = SCNNode()
        display = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(100), height: CGFloat(50)))
        plane = SCNPlane(width: 0.2, height: 0.1)
        
        display.adjustsFontSizeToFitWidth = true
        display.numberOfLines = 1
        display.backgroundColor = UIColor.magenta
        
        display.text = "test"
        image = UIImage.imageWithLabel(label: display)
        
        plane.firstMaterial?.diffuse.contents = image
        node.geometry = plane
    }
}


class ImageLabel {
    var node: SCNNode
    var display: UIImage
    var plane: SCNPlane
    
    init() {
        node = SCNNode()
        display = UIImage(named: "Image")!
        plane = SCNPlane(width: 0.2, height: 0.1)
        
        plane.firstMaterial?.diffuse.contents = display
        node.geometry = plane
    }
}

extension UIImage {
    class func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
}


