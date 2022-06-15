//
//  GameScreenSceneViewController.swift
//  Mars Rover
//
//  Created by XXX on 24.11.21.
//

import SceneKit

class GameScreenSceneViewController: UIViewController {
  var coordinator: BackFlow?
  private var viewModel: GameScreenSceneViewModel?
  private var scnScene: SCNScene?
  @IBOutlet private var scnView: SCNView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupScene()
    clearNodes()
    setupMap()
    setupMarsRover()
  }

  @IBAction private func playAgainAction(_ sender: Any) {
    viewModel?.completeMap()
  }

  @IBAction private func exitAction(_ sender: Any) {
    coordinator?.goBack()
  }

  func setViewModel(viewModel: GameScreenSceneViewModel) {
    self.viewModel = viewModel
  }

  private func setupScene() {
    guard let scnScene = SCNScene(named: "mapScene.scn", inDirectory: "art.scnassets") else { return }
    scnView.scene = scnScene
    self.scnScene = scnScene
  }

  private func setupMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(withName: "board", recursively: true)
    else { return }
    if let mapManagerNode = viewModel?.mapCreator.mapNode {
      mapNode.addChildNode(mapManagerNode)
    }
  }

  private func setupMarsRover() {
    guard
      let scnScene = scnScene,
      let roverNode = scnScene.rootNode.childNode(withName: "rover", recursively: true)
    else { return }
    if let roverManagerNode = viewModel?.roverManager.marsRover {
      roverNode.addChildNode(roverManagerNode)
    }
  }

  private func clearNodes() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(withName: "board", recursively: true),
      let roverNode = scnScene.rootNode.childNode(withName: "rover", recursively: true)
    else { return }
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
    roverNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }
}
