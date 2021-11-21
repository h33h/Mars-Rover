//
//  MapEditorSceneViewModel.swift
//  Mars Rover
//
//  Created by XXX on 19.11.21.
//

import Foundation
import SceneKit

enum MapType {
  case new
  case existed
}

class MapEditorSceneViewModel {
  // MARK: - MapEditorSceneViewModel: Variables
  private var mapModelData: RealmMapModelData?
  private var mapManager: MapManagerProtocol?
  private var currentMapType: MapType?
  private var realmMaps: RealmMapsServceProtocol?
  private var journalSevice: MapsJournalServiceProtocol?

  // MARK: - MapEditorSceneViewModel: Methods
  func setupMapManager(type: MapBoardCreateType) {
    switch type {
    case .newMap:
      currentMapType = .new
      mapManager = MapManager(rowsCount: 9, colomnsCount: 16)
    case .fromMap(let mapModelData):
      currentMapType = .existed
      mapManager = MapManager(mapModelData: mapModelData)
    }
  }

  func mapAction(type: MapBoardActionType) {
    switch type {
    case .clear:
      mapManager?.mapAction(action: .clear)
    case let .replaceMapBlock(replacingNode, block):
      mapManager?.mapAction(action: .replaceMapBlock(replacingNode: replacingNode, block: block))
    case .generateRandomMap:
      mapManager?.mapAction(action: .generateRandomMap)
    }
  }

  func setJournalService(service: MapsJournalServiceProtocol) {
    self.journalSevice = service
  }

  func setRealmService(service: RealmMapsServceProtocol) {
    self.realmMaps = service
  }

  func getMapNode() -> SCNNode? {
    mapManager?.getMapNode()
  }

  func setMapModel(map: RealmMapModelData) {
    self.mapModelData = map
  }

  func saveMap(controller: UIViewController) {
    guard let currentMapType = currentMapType else { return }
    switch currentMapType {
    case .new:
      guard let newMap = mapManager?.getMapModelData() else { return }
      let mapNameAlert = UIAlertController(title: "Save Map", message: "Enter new map title", preferredStyle: .alert)
      mapNameAlert.addTextField()
      let mapAddAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
        guard let mapName = mapNameAlert.textFields?.first?.text else { return }
        newMap.mapLabel = mapName
        self?.realmMaps?.mapAction(is: .addMap(newMap))
        self?.journalSevice?.journal(action: .addMap(newMap))
      }
      mapNameAlert.addAction(mapAddAction)
      mapNameAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
      controller.present(mapNameAlert, animated: true, completion: nil)
    case .existed:
      guard let mapModel = mapManager?.getMapModelData() else { return }
      self.realmMaps?.mapAction(is: .editMap(mapModel))
      self.journalSevice?.journal(action: .editMap(mapModel))
    }
  }
}
