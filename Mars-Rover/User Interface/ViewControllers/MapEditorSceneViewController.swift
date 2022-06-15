//
//  MapEditorSceneViewController.swift
//  Mars Rover
//
//  Created by XXX on 17.11.21.
//

import SceneKit

class MapEditorSceneViewController: UIViewController, Storyboarded {
  // MARK: - MapEditorSceneViewController: Variables
  var coordinator: BackFlow?
  private var viewModel: MapEditorSceneViewModel?
  private var scnScene: SCNScene?
  private var selectedBlock: Obstacle?

  // MARK: - MapEditorSceneViewController: IBOutlet Variables
  @IBOutlet private var scnView: SCNView!
  @IBOutlet private var topStackView: UIStackView!
  @IBOutlet private var bottomStackView: UIStackView!

  // MARK: - MapEditorSceneViewController: LifeCycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
      setupScene()
      addTapRecognizers()
      setupMap()
      setupButtons()
  }

  // MARK: - MapEditorSceneViewController: IBAction Methods
  @IBAction private func randomMapAction(_ sender: Any) {
    viewModel?.mapAction(type: .generateRandomMap)
  }

  @IBAction private func saveAction(_ sender: Any) {
    viewModel?.saveMap(controller: self)
  }

  @IBAction private func exitAction(_ sender: Any) {
    coordinator?.goBack()
  }

  // MARK: - MapEditorSceneViewController: Methods
  func setViewModel(viewModel: MapEditorSceneViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - MapEditorSceneViewController: ViewDidLoad Methods
  private func setupScene() {
    guard let scnScene = SCNScene(named: "mapScene.scn", inDirectory: "art.scnassets") else { return }
    self.scnScene = scnScene
    scnView.scene = scnScene
  }

  private func setupMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(withName: "board", recursively: true)
    else { return }
    if let mapManagerNode = viewModel?.mapCreator.mapNode {
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
    longPress.minimumPressDuration = 0
    longPress.addTarget(self, action: #selector(longPressAction))
    scnView.gestureRecognizers = [tapRecognizer, longPress]
  }

  private func setupButtons() {
    for obstacle in Obstacle.allCases {
      let button = UIButton()
      button.setTitle(obstacle.toString(), for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.addTarget(self, action: #selector(blockButtonAction), for: .touchUpInside)
      bottomStackView.addArrangedSubview(button)
    }
  }

  // MARK: - MapEditorSceneViewController: HandleTap Methods
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
      viewModel?.mapAction(type: .replaceMapBlock(replacingNode: replacingNode, block: selectedBlock))
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
        viewModel?.mapAction(type: .replaceMapBlock(replacingNode: replacingNode, block: selectedBlock))
    }
  }

  // MARK: - MapEditorSceneViewController: BlockSelectionTap Method
  @objc
  private func blockButtonAction(sender: UIButton) {
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

  // MARK: - MapEditorSceneViewController: ClearMap Method
  private func clearMap() {
    guard
      let scnScene = scnScene,
      let mapNode = scnScene.rootNode.childNode(withName: "board", recursively: true)
    else { return }
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }

  deinit {
    clearMap()
  }
}
