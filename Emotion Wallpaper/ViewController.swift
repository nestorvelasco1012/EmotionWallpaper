//
//  ViewController.swift
//  Emotion Wallpaper
//
//  Created by Nestor Velasco on 8/9/23.
//

import UIKit
import ARKit
import CoreML


class ViewController: UIViewController {

    private let sceneView = ARSCNView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARWorldTrackingConfiguration.isSupported else { return }
     
        view.addSubview(sceneView)
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.session.run(ARFaceTrackingConfiguration(), options: [.resetTracking, .removeExistingAnchors])
    }


}

extension ViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else { return nil }
        let node = SCNNode(geometry: ARSCNFaceGeometry(device: device))
        //Projects the white lines on the face.
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
      guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return }
      faceGeometry.update(from: faceAnchor.geometry)
    }
    
}

