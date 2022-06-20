//
//  MapTableViewCell.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import UIKit

class MapTableViewCell: UITableViewCell {
  @IBOutlet private var mapLabel: UILabel!
  @IBOutlet private var mapLastEditLabel: UILabel!

  func configure(mapLabel: String, mapLastEdit: Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .medium
    dateFormatter.dateStyle = .medium
    self.mapLabel.text = mapLabel
    self.mapLastEditLabel.text = dateFormatter.string(from: mapLastEdit)
  }
}
