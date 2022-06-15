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
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func configure(mapLabel: String, mapLastEdit: String) {
    self.mapLabel.text = mapLabel
    self.mapLastEditLabel.text = mapLabel
  }
}
