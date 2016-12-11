//
//  ViewController.swift
//  ModelsTreeDemo
//
//  Created by Aleksey on 20.08.16.
//  Copyright © 2016 Aleksey Chernish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var searchBar: UISearchBar!
  
  private var adapter: TableViewAdapter<Int>!
  private var dataAdapter: ObjectsDataSource<Int>!
  let list = UnorderedList<Int>(parent: nil, objects: [5, 4])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let listAdapter = UnorderedListDataAdapter<Int, String>(list: list)
    listAdapter.groupContentsSortingCriteria = { $0 < $1 }
    list.performUpdates {
      $0.insert([1, 2, 9])
    }
    
    let staticSource = createStaticDataSource()
    
    dataAdapter = CompoundDataAdapter(dataSources: [staticSource, listAdapter])
    adapter = TableViewAdapter(dataSource: dataAdapter, tableView: tableView)
    
    adapter.registerCellClass(TestCell.self)
    adapter.nibNameForObjectMatching = { _ in String(describing: TestCell.self) }
    adapter.didSelectCell.subscribeNext { _, _, object in print(object) }.ownedBy(self)
  }
  
  private func createStaticDataSource() -> ObjectsDataSource<Int> {
    let source = StaticDataSource<Int>()
    source.sections = [StaticObjectsSection(title: nil, objects: [1, 2, 3])]
    
    return source
  }
  
  @IBAction private func addMore(sender: AnyObject?) {
        list.performUpdates { $0.delete([5, 4]) }
  }
  
}
