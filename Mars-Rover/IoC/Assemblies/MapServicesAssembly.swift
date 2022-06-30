//
//  MapServicesAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class MapServicesAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MapsJournalService.self) { _ in
      MapsJournalService()
    }
    .inObjectScope(.container)

    container.register(FirebaseMapsActionService.self) { _ in
      FirebaseMapsActionService()
    }
    .inObjectScope(.container)

    container.register(FirebaseMapsService.self) { resolver in
      let service = FirebaseMapsService()
      service.mapActionService = resolver.resolve(FirebaseMapsActionService.self)
      return service
    }
    .inObjectScope(.container)

    container.register(RealmMapsActionService.self) { _ in
      RealmMapsActionService()
    }
    .inObjectScope(.container)

    container.register(RealmMapsService.self) { resolver in
      let service = RealmMapsService()
      service.mapActionService = resolver.resolve(RealmMapsActionService.self)
      return service
    }
    .inObjectScope(.container)

    container.register(MapsSyncService.self) { resolver in
      let service = MapsSyncService()
      service.journalService = resolver.resolve(MapsJournalService.self)
      service.firebaseMapService = resolver.resolve(FirebaseMapsService.self)
      service.realmMapService = resolver.resolve(RealmMapsService.self)
      return service
    }
    .inObjectScope(.container)
  }
}
