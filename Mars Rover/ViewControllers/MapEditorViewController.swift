//
//  MapEditorViewController.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import UIKit

class MapEditorViewController: UIViewController, Storyboarded {
  // MARK: - MapEditorViewController: Variables
  var coordinator: MapEditorCoordinator?
  private var viewModel = MapEditorViewModel(
    journalService: MapsJournalService.shared,
    realmMapsSevice: RealmMapsServce.shared,
    syncService: MapsSyncService.shared
  )

  // MARK: - MapEditorViewController: IBOutlet Variables
  @IBOutlet var addMapButton: UIButton!
  @IBOutlet var syncMapsButton: UIButton!
  @IBOutlet var backButton: UIButton!
  @IBOutlet var mapsTableView: UITableView!

  // MARK: - MapEditorViewController: LifeCycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    mapsTableView.delegate = self
    mapsTableView.dataSource = self
    mapsTableView.register(
      UINib(nibName: "MapTableViewCell", bundle: nil),
      forCellReuseIdentifier: "MapTableViewCell"
    )
    viewModel.isUpdated.bind { isUpdated in
      if isUpdated {
        self.viewModel.getLocalMaps()
        DispatchQueue.main.async {
          self.mapsTableView.reloadData()
        }
        self.viewModel.isUpdated.value.toggle()
      }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.syncMaps()
  }

  // MARK: - MapEditorViewController: IBAction Methods
  @IBAction private func addMapButton(_ sender: Any) {
    coordinator?.goToMapEditorScene(map: nil)
  }
  @IBAction private func syncMapsButton(_ sender: Any) {
    viewModel.syncMaps()
  }
  @IBAction private func goBackButton(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}

extension MapEditorViewController: UITableViewDataSource, UITableViewDelegate {
  // MARK: - MapEditorViewController: TableView Delegate & DataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.maps.value.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
      withIdentifier: "MapTableViewCell",
      for: indexPath
      ) as? MapTableViewCell
    else { return UITableViewCell() }
    cell.selectionStyle = .none
    let mapModel = viewModel.maps.value[indexPath.row]
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .medium
    dateFormatter.dateStyle = .medium
    cell.mapLabel.text = mapModel.mapLabel
    cell.mapLastEditLabel.text = dateFormatter.string(from: mapModel.lastEdited)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delete = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, completion in
      guard let this = self else { return completion(false) }
      tableView.beginUpdates()
      this.viewModel.mapAction(action: .removeMap(this.viewModel.maps.value[indexPath.row].id))
      tableView.deleteRows(at: [indexPath], with: .fade)
      tableView.endUpdates()
      completion(true)
    }
    delete.image = UIImage(systemName: "trash")

    let edit = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completion in
      guard let this = self else { return completion(false) }
      this.coordinator?.goToMapEditorScene(map: this.viewModel.maps.value[indexPath.row])
      completion(true)
    }
    edit.image = UIImage(systemName: "pencil")
    edit.backgroundColor =  .blue

    let config = UISwipeActionsConfiguration(actions: [delete, edit])
    config.performsFirstActionWithFullSwipe = false

    return config
  }
}
