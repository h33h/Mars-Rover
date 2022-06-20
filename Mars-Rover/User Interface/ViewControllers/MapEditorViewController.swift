//
//  MapEditorViewController.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import UIKit

class MapEditorViewController: UIViewController {
  var viewModel: MapEditorViewModel?

  @IBOutlet private var addMapButton: UIButton!
  @IBOutlet private var syncMapsButton: UIButton!
  @IBOutlet private var backButton: UIButton!
  @IBOutlet private var mapsTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    bindViewModel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel?.syncMaps()
  }

  @IBAction private func addMapButton(_ sender: Any) {
    viewModel?.coordinator?.coordinateToMapEditorScene(map: nil)
  }
  @IBAction private func syncMapsButton(_ sender: Any) {
    viewModel?.syncMaps()
  }
  @IBAction private func goBackButton(_ sender: Any) {
    viewModel?.coordinator?.goBack()
  }

  private func setupTableView() {
    mapsTableView.delegate = self
    mapsTableView.dataSource = self
    mapsTableView.register(
      UINib(
        nibName: L10n.ViewControllers.MapTableViewCell.id,
        bundle: nil),
      forCellReuseIdentifier: L10n.ViewControllers.MapTableViewCell.id
    )
  }

  private func bindViewModel() {
    viewModel?.maps.bind { [weak self] _ in
      DispatchQueue.main.async {
        self?.mapsTableView.reloadData()
      }
    }
    viewModel?.mapsError.bind { [weak self] error in
      if let error = error {
        self?.showSimpleNotificationAlert(
          title: L10n.ViewControllers.MapEditor.Error.title,
          description: error.localizedDescription
        )
      }
    }
  }
}

extension MapEditorViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel?.maps.value.count ?? .zero
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: L10n.ViewControllers.MapTableViewCell.id,
        for: indexPath
      ) as? MapTableViewCell,
      let map = viewModel?.maps.value[indexPath.row]
    else { return UITableViewCell() }
    cell.selectionStyle = .none
    cell.configure(mapLabel: map.label, mapLastEdit: map.lastEdited)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delete = UIContextualAction(style: .destructive, title: .none) { [weak self] _, _, completion in
      guard
        let self = self,
        let map = self.viewModel?.maps.value[indexPath.row]
      else { return completion(false) }
      tableView.beginUpdates()
      self.viewModel?.mapAction(action: .remove(map: map))
      self.viewModel?.maps.value.removeAll { $0 == map }
      tableView.deleteRows(at: [indexPath], with: .fade)
      tableView.endUpdates()
      completion(true)
    }
    delete.image = UIImage(
      systemName: L10n.ViewControllers.MapEditor.Images.delete
    )
    let edit = UIContextualAction(style: .normal, title: .none) { [weak self] _, _, completion in
      guard let this = self else { return completion(false) }
      this.viewModel?.coordinator?.coordinateToMapEditorScene(map: this.viewModel?.maps.value[indexPath.row].copy() as? RealmMap)
      completion(true)
    }
    edit.image = UIImage(
      systemName: L10n.ViewControllers.MapEditor.Images.edit
    )
    edit.backgroundColor =  .blue

    let config = UISwipeActionsConfiguration(actions: [delete, edit])
    config.performsFirstActionWithFullSwipe = false

    return config
  }
}
