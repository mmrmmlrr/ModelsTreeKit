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
  
  private var adapter: TableViewAdapter<Int>!
  private let list = OrderedList<Int>(parent: nil)
  private var dataAdapter: OrderedListDataAdapter<Int>!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      dataAdapter = OrderedListDataAdapter(list: list)
      dataAdapter.groupingCriteria = { $0 > 3 ? "2" : "1" }
      adapter = TableViewAdapter(dataSource: dataAdapter, tableView: tableView)
      
      adapter.registerCellClass(TestCell.self)
      adapter.nibNameForObjectMatching = { _ in String(TestCell) }
      
      var arr = [Int]()
      for i in 0...100 {
        arr.append(i)
      }
      
      list.performUpdates { $0.append(arr) }

    }



}

