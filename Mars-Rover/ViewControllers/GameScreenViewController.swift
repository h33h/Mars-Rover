//
//  GameScreenViewController.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import UIKit

class GameScreenViewController: UIViewController, Storyboarded {
  var coordinator: (GameScreenFlow & BackFlow)?
  private var viewModel = GameScreenViewModel(realmService: RealmMapsServce.shared)

  @IBOutlet private var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(
      UINib(nibName: "MapTableViewCell", bundle: nil),
      forCellReuseIdentifier: "MapTableViewCell"
    )
    viewModel.isUpdated.bind { isUpdated in
      if isUpdated {
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        self.viewModel.isUpdated.value = false
      }
    }
    viewModel.errorMessage.bind { message in
      guard let message = message else { return }
      self.showSimpleNotificationAlert(title: "Error", description: message, buttonAction: nil)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.getLocalMaps()
  }

  @IBAction private func backButtonAction(_ sender: Any) {
    coordinator?.goBack()
  }
}

extension GameScreenViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.maps.value.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard
      let path = viewModel.findPath(mapModelData: viewModel.maps.value[indexPath.row])
    else { return }
    coordinator?.coordinateToGameScreenScene(map: viewModel.maps.value[indexPath.row], path: path)
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
}
