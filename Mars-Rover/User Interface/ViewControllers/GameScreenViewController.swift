//
//  GameScreenViewController.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import UIKit

class GameScreenViewController: UIViewController {
  var viewModel: GameScreenViewModel?

  @IBOutlet private var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    bindViewModel()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel?.getLocalMaps()
  }

  @IBAction private func backButtonAction(_ sender: Any) {
    viewModel?.coordinator?.goBack()
  }

  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(
      UINib(nibName: L10n.ViewControllers.MapTableViewCell.id, bundle: nil),
      forCellReuseIdentifier: L10n.ViewControllers.MapTableViewCell.id
    )
  }

  private func bindViewModel() {
    viewModel?.maps.bind { [weak self] _ in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
    viewModel?.mapsError.bind { [weak self] error in
      guard let error = error else { return }
      self?.showSimpleNotificationAlert(
        title: L10n.ViewControllers.GameScreen.Error.title,
        description: error.localizedDescription,
        buttonAction: nil
      )
    }
  }
}

extension GameScreenViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel?.maps.value.count ?? .zero
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard
      let map = viewModel?.maps.value[indexPath.row],
      let path = viewModel?.findPath(map: map)
    else { return }
    viewModel?.coordinator?.coordinateToGameScreenScene(
      map: map,
      path: path
    )
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
    cell.configure(
      mapLabel: map.label,
      mapLastEdit: map.lastEdited
    )
    return cell
  }
}
