//
//  MapEditorSceneViewModel.swift
//  Mars Rover
//
//  Created by XXX on 19.11.21.
//

import SceneKit

class MapEditorSceneViewModel {
  weak var coordinator: BackFlow?
  var mapManager: MapManagerProtocol?
  var realmMapsService: RealmMapsServiceProtocol?
  var journalService: MapsJournalServiceProtocol?
  private(set) var map: RealmMap
  private(set) var mapType: MapType

  init(map: RealmMap, mapType: MapType) {
    self.map = map
    self.mapType = mapType
  }

  func mapManager(action: MapManagerAction) {
    switch action {
    case .clear:
      mapManager?.manager(action: .clear)
    case let .replaceBlock(replacingNode, block):
      mapManager?.manager(action: .replaceBlock(replacingNode: replacingNode, block: block))
    case .generateRandomMap:
      mapManager?.manager(action: .generateRandomMap)
    }
  }

  func saveMap(controller: UIViewController) {
    switch mapType {
    case .new:
      let mapNameAlert = UIAlertController(
        title: L10n.ViewModels.MapEditor.SaveMap.title,
        message: L10n.ViewModels.MapEditor.SaveMap.description,
        preferredStyle: .alert)
      mapNameAlert.addTextField()
      let mapAddAction = UIAlertAction(
        title: L10n.ViewModels.MapEditor.SaveMap.ok,
        style: .default
      ) { [weak self] _ in
        guard
          let self = self,
          let mapName = mapNameAlert.textFields?.first?.text,
          let mapContent = self.mapManager?.mapContent
        else { return }
        let map = RealmMap(
          id: .generate(),
          label: mapName,
          lastEdited: Date(),
          mapContent: mapContent)
        self.journalService?.journal(action: .add(map: map))
        self.realmMapsService?.mapAction(is: .add(map: map))
      }
      mapNameAlert.addAction(mapAddAction)
      mapNameAlert.addAction(UIAlertAction(
        title: L10n.ViewModels.MapEditor.SaveMap.cancel,
        style: .destructive,
        handler: nil)
      )
      controller.present(mapNameAlert, animated: true, completion: nil)
    case .existed:
      guard
        let mapContent = mapManager?.mapContent
      else { return }
      map.mapContent = mapContent
      self.journalService?.journal(action: .edit(map: map))
      self.realmMapsService?.mapAction(is: .edit(map: map))
    }
  }
}
