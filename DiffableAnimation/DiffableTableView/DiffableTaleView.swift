//
//  SimpleTableView.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import UIKit
import SwiftUI

final class DiffableTableView: UITableViewController {

  enum Section {
    case main
  }

  var filterd: Developer.Major = .none {
    didSet {
      configureSnapshot()
    }
  }

  let storage = Storage.shared
  var dataSource: UITableViewDiffableDataSource<Section, Developer>!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(SimpleCell.self, forCellReuseIdentifier: SimpleCell.reuseIdentifier)

    let menuItems: [UIAction] = [
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

    let filterBarButton = UIBarButtonItem(systemItem: .compose, primaryAction: nil, menu: .init(title: "", image: nil, identifier: nil, options: .singleSelection, children: menuItems))
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDeveloper))
    navigationItem.rightBarButtonItems = [filterBarButton, addButton]
    configureDataSource()
    configureSnapshot()
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
    storage.developers.append(developer)
    configureSnapshot()
  }
}

//MARK: - DataSource
extension DiffableTableView {
  func configureDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, Developer>(tableView: tableView, cellProvider: { tableView, indexPath, developer in
      let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCell.reuseIdentifier, for: indexPath) as! SimpleCell
      cell.cellConfigure(developer: developer)
      return cell
    })
  }

  func configureSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Developer>()
    snapshot.appendSections([.main])
    snapshot.appendItems(storage.filteredByMajor(major: filterd), toSection: .main)
    dataSource.defaultRowAnimation = .fade
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

//MARK: - delegate
extension DiffableTableView {
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      guard let deleteItem = dataSource.itemIdentifier(for: indexPath) else { return }
      storage.deleteItem(deleteItem)
      configureSnapshot()
    }
  }

  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .delete
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let developer = dataSource.itemIdentifier(for: indexPath) else { return }
    let hosting = UIHostingController(rootView: CardDetailView(developer: developer))
    navigationController?.pushViewController(hosting, animated: true)
  }
}
