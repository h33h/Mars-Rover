//
//  MapEditorViewController.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import UIKit

class MapEditorViewController: UIViewController, Storyboarded {
  var coordinator: MainMenuCoordinator?
  private var viewModel = MapEditorViewModel()
  @IBOutlet var addMapButton: UIButton!
  @IBOutlet var syncMapsButton: UIButton!
  @IBOutlet var backButton: UIButton!
  @IBOutlet var mapsTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    mapsTableView.delegate = self
    mapsTableView.dataSource = self
    mapsTableView.register(
      UINib(
        nibName: "MapTableViewCell",
        bundle: nil
      ),
      forCellReuseIdentifier: "MapTableViewCell"
    )
    viewModel.isUpdated.bind { isUpdated in
      if isUpdated {
        self.viewModel.getLocalMaps()
        DispatchQueue.main.async {
          self.mapsTableView.reloadData()
        }
        self.viewModel.isUpdated.value = false
      }
    }
    viewModel.syncMaps()
  }
  @IBAction func addMapButton(_ sender: Any) {
    viewModel.mapAction(
      action: .addMap(RealmMapModelData(
        mapLabel: "",
        lastEdited: Date(),
        map:
          RealmMapModel(
          rowCount: 9,
          colomnsCount: 16
          )
        )
      )
    )
    mapsTableView.reloadData()
  }
  @IBAction func syncMapsButton(_ sender: Any) {
    viewModel.syncMaps()
  }
  @IBAction func goBackButton(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}

extension MapEditorViewController: UITableViewDataSource, UITableViewDelegate {
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
    let mapModel = viewModel.maps.value[indexPath.row]
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    cell.mapLabel.text = mapModel.mapLabel
    cell.mapLastEditLabel.text = dateFormatter.string(from: mapModel.lastEdited)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.beginUpdates()
      viewModel.mapAction(action: .removeMap(viewModel.maps.value[indexPath.row].id))
      tableView.deleteRows(at: [indexPath], with: .fade)
      tableView.endUpdates()
    }
  }
}
