//
//  ViewController.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import UIKit
import SwiftUI

class SearchDeveloperViewController: UIViewController {

  enum Section {
    case main
  }

  enum Test {
    case single
    case triple
  }

  var test: Test = .single

  lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
  var dataSource: UICollectionViewDiffableDataSource<Section, Developer>!

  let storage = Storage.shared

  override func viewDidLoad() {
    super.viewDidLoad()
    collcetionViewConfigure()
    collectionView.backgroundColor = .systemIndigo
  }

  private func collcetionViewConfigure() {
    view.addSubview(collectionView)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(ProfileCardCell.self, forCellWithReuseIdentifier: ProfileCardCell.identifier)
    collectionView.delegate = self
    configureDataSource()
    configureSnapshot()
    start()
  }

  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Developer>(collectionView: collectionView) { collectionView, indexPath, developer in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCardCell.identifier, for: indexPath) as! ProfileCardCell
      cell.configure(developer)
      return cell
    }
  }

  func configureSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Developer>()
    snapshot.appendSections([.main])
    snapshot.appendItems(storage.filteredDevelopers, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

    let section = NSCollectionLayoutSection(group: group)
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }

}

extension SearchDeveloperViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let developer = dataSource.itemIdentifier(for: indexPath)!
    let hosting = UIHostingController(rootView: CardDetailView(developer: developer))
    navigationController?.pushViewController(hosting, animated: true)

    

  }
}

extension SearchDeveloperViewController {
  @objc func toggle() {

    switch test {
      case .single:
        let developer = storage.developers.randomElement()!
        developer.searcable.toggle()
        DispatchQueue.main.async {
          self.configureSnapshot()
        }
      case .triple:
        var randomIndex: [Int] = []
        let developersCount = storage.developers.count
        while randomIndex.count < 3 {
          let randomInt = Int.random(in: 0..<developersCount)
          if !randomIndex.contains(randomInt) {
            randomIndex.append(randomInt)
          }
        }
        randomIndex.forEach { index in
          storage.developers[index].searcable.toggle()
        }
        DispatchQueue.main.async {
          self.configureSnapshot()
        }
    }

  }

  func start() {
    Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(toggle), userInfo: nil, repeats: true)
  }
}
