//
//  SimpleTableView.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import UIKit

final class SimpleTableView: UITableViewController {

  var filterd: Developer.Major = .none {
    didSet {
      tableView.reloadSections(.init(integer: 0), with: .fade)
    }
  }

  let storage = Storage.shared

  lazy var menuItems: [UIAction] = [
    UIAction(title: "iOS", image: nil, identifier: nil, handler: { _ in
      self.filterd = .iOS
    }),
    UIAction(title: "Android", image: nil, identifier: nil, handler: { _ in
      self.filterd = .android
    }),
    UIAction(title: "Backend", image: nil, identifier: nil, handler: { _ in
      self.filterd = .backend
    }),
    UIAction(title: "FrontEnd", image: nil, identifier: nil, handler: { _ in
      self.filterd = .frontend
    }),
    UIAction(title: "None", image: nil, identifier: nil, state: .on, handler: { _ in
      self.filterd = .none
    }),

  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(SimpleCell.self, forCellReuseIdentifier: SimpleCell.reuseIdentifier)
    navigationBarConfigure()
  }

  private func navigationBarConfigure() {
    let filterBarButton = UIBarButtonItem(systemItem: .compose, primaryAction: nil, menu: .init(title: "", image: nil, identifier: nil, options: .singleSelection, children: menuItems))
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDeveloper))
    navigationItem.rightBarButtonItems = [filterBarButton, addButton]
  }

  private func tableViewFiltering() {
    tableView.reloadSections(.init(integer: 0), with: .right)
  }

  @objc func addDeveloper() {
    let alert = UIAlertController(title: "추가하기", message: "", preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = "이름"
    }

    alert.addTextField { textField in
      textField.placeholder = "Major"
    }

    let add = UIAlertAction(title: "저장", style: .default) { [unowned self]  _ in
      let developer = Developer()
      developer.name = alert.textFields?[0].text ?? "Unknown"
      developer.major = Developer.Major(rawValue: alert.textFields?[1].text ?? "") ?? .none
      addTableView(developer: developer)
    }

    let cancel = UIAlertAction(title: "취소", style: .cancel)
    alert.addAction(add)
    alert.addAction(cancel)
    present(alert, animated: true)
  }

  private func addTableView(developer: Developer) {
    tableView.beginUpdates()
    storage.developers.append(developer)
    guard let row = storage.filteredByMajor(major: filterd).firstIndex(of: developer) else {
      tableView.endUpdates()
      return
    }
    let indexPath = IndexPath(row: row, section: 0)
    tableView.insertRows(at: [indexPath], with: .right)
    tableView.endUpdates()
  }
}

//MARK: - DataSource
extension SimpleTableView {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    storage.filteredByMajor(major: filterd).count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCell.reuseIdentifier, for: indexPath) as! SimpleCell

    let developer = storage.filteredByMajor(major: filterd)[indexPath.row]
    cell.cellConfigure(developer: developer)

    return cell
  }
}

//MARK: - Delegate
extension SimpleTableView {
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.beginUpdates()
      let deleteItem = storage.filteredByMajor(major: filterd)[indexPath.row]
      let index = storage.developers.firstIndex(of: deleteItem)!
      storage.developers.remove(at: index)
      tableView.deleteRows(at: [indexPath], with: .fade)
      tableView.endUpdates()
    }
  }

  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .delete
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
