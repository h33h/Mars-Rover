//
//  MapEditorSceneViewController.swift
//  Mars Rover
//
//  Created by XXX on 17.11.21.
//

import SceneKit

class MapEditorSceneViewController: UIViewController {
  var viewModel: MapEditorSceneViewModel?
  private var scnScene: SCNScene?
  private var selectedBlock: Obstacle?

  @IBOutlet private var scnView: SCNView!
  @IBOutlet private var topStackView: UIStackView!
  @IBOutlet private var bottomStackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupScene()
    addTapRecognizers()
    setupMap()
    setupButtons()
  }

  @IBAction private func randomMapAction(_ sender: Any) {
    viewModel?.mapManager(action: .generateRandomMap)
  }

  @IBAction private func saveAction(_ sender: Any) {
    viewModel?.saveMap(controller: self)
  }

  @IBAction private func exitAction(_ sender: Any) {
    viewModel?.coordinator?.goBack()
  }

  private func setupScene() {
    guard
      let scnScene = SCNScene(
        named: L10n.ViewControllers.MapEditorScene.path,
        inDirectory: L10n.ViewControllers.MapEditorScene.assetsPath
      )
    else { return }
    self.scnScene = scnScene
    scnView.scene = scnScene
  }

  private func setupMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(
        withName: L10n.ViewControllers.MapEditorScene.boardName,
        recursively: true
      )
    else { return }
    if let mapManagerNode = viewModel?.mapManager?.mapNode {
      clearMap()
      mapNode.addChildNode(mapManagerNode)
    }
  }

  private func addTapRecognizers() {
    let tapRecognizer = UITapGestureRecognizer()
    tapRecognizer.numberOfTapsRequired = 1
    tapRecognizer.numberOfTouchesRequired = 1
    tapRecognizer.addTarget(self, action: #selector(sceneTapped))
    let longPress = UILongPressGestureRecognizer()
    longPress.minimumPressDuration = .zero
    longPress.addTarget(self, action: #selector(longPressAction))
    scnView.gestureRecognizers = [tapRecognizer, longPress]
  }

  private func setupButtons() {
    for obstacle in Obstacle.allCases {
      let button = UIButton()
      button.setTitle(obstacle.title, for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.addTarget(self, action: #selector(blockButtonAction), for: .touchUpInside)
      bottomStackView.addArrangedSubview(button)
    }
  }

  @objc
  private func longPressAction(sender: UILongPressGestureRecognizer) {
    let location = sender.location(in: scnView)
    let hitResults = scnView.hitTest(location, options: nil)
    for hit in hitResults {
      let resultNode = hit.node
      guard
        let selectedBlock = selectedBlock,
        let replacingNode = resultNode as? SCNBlockNode
      else { return }
      viewModel?.mapManager(action: .replaceBlock(replacingNode: replacingNode, block: selectedBlock))
    }
  }

  @objc
  private func sceneTapped(sender: UITapGestureRecognizer) {
    let location = sender.location(in: scnView)
    let hitResults = scnView.hitTest(location, options: nil)
    if !hitResults.isEmpty {
      guard
        let resultNode = hitResults.first?.node,
        let selectedBlock = selectedBlock,
        let replacingNode = resultNode as? SCNBlockNode
      else { return }
      viewModel?.mapManager(action: .replaceBlock(replacingNode: replacingNode, block: selectedBlock))
    }
  }

  @objc
  private func blockButtonAction(sender: UIButton) {
    guard let title = sender.titleLabel?.text else { return }
    bottomStackView.arrangedSubviews.forEach { button in
      guard let button = button as? UIButton else { return }
      button.setTitleColor(.white, for: .normal)
    }
    sender.setTitleColor(.yellow, for: .normal)
    switch title {
    case L10n.Entities.Obstacle.solidGround:
      selectedBlock = .solidGround
    case L10n.Entities.Obstacle.sand:
      selectedBlock = .sand
    case L10n.Entities.Obstacle.pit:
      selectedBlock = .pit
    case L10n.Entities.Obstacle.hill:
      selectedBlock = .hill
    default:
      selectedBlock = nil
    }
  }

  private func clearMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(
        withName: L10n.ViewControllers.MapEditorScene.boardName,
        recursively: true
      )
    else { return }
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }

  deinit {
    clearMap()
  }
}
