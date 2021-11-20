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
  private var viewModel: MapEditorSceneViewModel?
  private var scnScene: SCNScene?
  private var selectedBlock: Obstacle?
  @IBOutlet private var scnView: SCNView!
  @IBOutlet var topStackView: UIStackView!
  @IBOutlet var bottomStackView: UIStackView!
  override func viewDidLoad() {
    super.viewDidLoad()
      setupScene()
      setupMap()
      setupButtons()
  }
  @IBAction func randomMapAction(_ sender: Any) {
    viewModel?.mapAction(type: .generateRandomMap)
  }
  @IBAction func saveAction(_ sender: Any) {
    viewModel?.saveMap(controller: self)
  }
  @IBAction func exitAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  func setViewModel(viewModel: MapEditorSceneViewModel) {
    self.viewModel = viewModel
  }

  func setupScene() {
    guard let scnScene = SCNScene(named: "mapEditorScene.scn", inDirectory: "GameAssets.scnassets") else { return }
    self.scnScene = scnScene
    scnView?.scene = scnScene
    let tapRecognizer = UITapGestureRecognizer()
    tapRecognizer.numberOfTapsRequired = 1
    tapRecognizer.numberOfTouchesRequired = 1
    tapRecognizer.addTarget(self, action: #selector(sceneTapped))
    scnView.gestureRecognizers = [tapRecognizer]
  }

  @objc func sceneTapped(sender: UITapGestureRecognizer) {
    let location = sender.location(in: scnView)
    let hitResults = scnView.hitTest(location, options: nil)
    if !hitResults.isEmpty {
      let resultNode = hitResults[0].node
      guard let selectedBlock = selectedBlock, Obstacle.getObstacle(node: resultNode) != nil else { return }
      viewModel?.mapAction(type: .replaceMapBlock(replacingNode: resultNode, block: selectedBlock))
    }
  }

  func setupButtons() {
    for obstacle in Obstacle.allCases {
      let button = UIButton()
      button.setTitle(obstacle.toString(), for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.addTarget(self, action: #selector(blockButtonAction), for: .touchUpInside)
      bottomStackView.addArrangedSubview(button)
    }
  }

  @objc func blockButtonAction(sender: UIButton) {
    guard let title = sender.titleLabel?.text else { return }
    bottomStackView.arrangedSubviews.forEach { button in
      guard let button = button as? UIButton else { return }
      button.setTitleColor(.white, for: .normal)
    }
    sender.setTitleColor(.yellow, for: .normal)
    switch title {
    case "Solid Ground":
      selectedBlock = .solidGround
    case "Sand":
      selectedBlock = .sand
    case "Hole":
      selectedBlock = .pit
    case "Hill":
      selectedBlock = .hill
    default:
      selectedBlock = nil
    }
  }

  func setupMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(withName: "board", recursively: true)
    else { return }
    if let mapManagerNode = viewModel?.getMapNode() {
      clearMap()
      mapNode.addChildNode(mapManagerNode)
    }
  }

  private func clearMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(withName: "board", recursively: true)
    else { return }
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }
}
