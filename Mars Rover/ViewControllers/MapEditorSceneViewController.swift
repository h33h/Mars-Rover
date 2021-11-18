//
//  MapEditorSceneViewController.swift
//  Mars Rover
//
//  Created by XXX on 17.11.21.
//

import UIKit
import QuartzCore
import SceneKit

class MapEditorSceneViewController: UIViewController, Storyboarded {
  var coordinator: MapEditorCoordinator?

  var scnView: SCNView!
  var scnScene: SCNScene!

  override func viewDidLoad() {
    super.viewDidLoad()
      setupScene()
  }

  func setupScene() {
    scnView = self.view as? SCNView
    let scnScene = SCNScene(named: "MapEditorScene.scn", inDirectory: "GameAssets.scnassets")
    self.scnScene = scnScene
    scnView.scene = scnScene
  }
}
