//
//  IndexTableView.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import UIKit

final class IndexTableView: UITableViewController {

  let menu: [String] = [
    "Simple Table View",
    "Complex Collection View",
    "Diffable Table View"
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    menu.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    cell.textLabel?.text = menu[indexPath.row]
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
      case 0:
        let controller = SimpleTableView()
        navigationController?.pushViewController(controller, animated: true)
      case 1:
        let controller = SearchDeveloperViewController()
        navigationController?.pushViewController(controller, animated: true)
      case 2:
        let controller = DiffableTableView()
        navigationController?.pushViewController(controller, animated: true)
      default:
        return
    }
  }
}
