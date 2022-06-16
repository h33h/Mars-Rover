//
//  MapEditorSceneViewModel.swift
//  Mars Rover
//
//  Created by XXX on 19.11.21.
//

import SceneKit

class MapEditorSceneViewModel {
  // MARK: - MapEditorSceneViewModel: Variables
  let mapCreator: MapCreatorProtocol
  let realmMapsService: RealmMapsServiceProtocol
  let journalService: MapsJournalServiceProtocol

  init(realmMapsService: RealmMapsServiceProtocol, journalService: MapsJournalServiceProtocol, mapCreator: MapCreatorProtocol) {
    self.realmMapsService = realmMapsService
    self.journalService = journalService
    self.mapCreator = mapCreator
  }

  // MARK: - MapEditorSceneViewModel: Methods
  func mapAction(type: EditMapAction) {
    switch type {
    case .clearMapNodes:
      mapCreator.mapModel(action: .clearMapNodes)
    case let .replaceMapBlock(replacingNode, block):
      mapCreator.mapModel(action: .replaceMapBlock(replacingNode: replacingNode, block: block))
    case .generateRandomMap:
      mapCreator.mapModel(action: .generateRandomMap)
    }
  }

  func saveMap(controller: UIViewController) {
    switch mapCreator.mapType {
    case .new:
      let mapNameAlert = UIAlertController(title: "Save Map", message: "Enter new map title", preferredStyle: .alert)
      mapNameAlert.addTextField()
      let mapAddAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
        guard let this = self, let mapName = mapNameAlert.textFields?.first?.text else { return }
        this.mapCreator.currentMap.mapLabel = mapName
        this.realmMapsService.mapAction(is: .add(map: this.mapCreator.currentMap))
        this.journalService.journal(action: .add(map: this.mapCreator.currentMap))
      }
      mapNameAlert.addAction(mapAddAction)
      mapNameAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
      controller.present(mapNameAlert, animated: true, completion: nil)
    case .existed:
      self.realmMapsService.mapAction(is: .edit(map: mapCreator.currentMap))
      self.journalService.journal(action: .edit(map: mapCreator.currentMap))
    }
  }
}
