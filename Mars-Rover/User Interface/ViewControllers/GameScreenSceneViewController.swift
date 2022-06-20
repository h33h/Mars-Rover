//
//  GameScreenSceneViewController.swift
//  Mars Rover
//
//  Created by XXX on 24.11.21.
//

import SceneKit

class GameScreenSceneViewController: UIViewController {
  var viewModel: GameScreenSceneViewModel?
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
    viewModel?.coordinator?.goBack()
  }

  private func setupScene() {
    guard let scnScene = SCNScene(
      named: L10n.ViewControllers.GameScreenScene.path,
      inDirectory: L10n.ViewControllers.GameScreenScene.assetsPath)
    else { return }
    scnView.scene = scnScene
    self.scnScene = scnScene
  }

  private func setupMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(
        withName: L10n.ViewControllers.GameScreenScene.boardName,
        recursively: true
      )
    else { return }
    if let mapManagerNode = viewModel?.mapManager?.mapNode {
      mapNode.addChildNode(mapManagerNode)
    }
  }

  private func setupMarsRover() {
    guard
      let scnScene = scnScene,
      let roverNode = scnScene.rootNode.childNode(
        withName: L10n.ViewControllers.GameScreenScene.roverName,
        recursively: true
      )
    else { return }
    if let roverManagerNode = viewModel?.roverManager?.marsRover {
      roverNode.addChildNode(roverManagerNode)
    }
  }

  private func clearNodes() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(
        withName: L10n.ViewControllers.GameScreenScene.boardName,
        recursively: true
      ),
      let roverNode = scnScene.rootNode.childNode(
        withName: L10n.ViewControllers.GameScreenScene.roverName,
        recursively: true
      )
    else { return }
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
    roverNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }
}
