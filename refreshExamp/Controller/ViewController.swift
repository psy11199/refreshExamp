//
//  ViewController.swift
//  refreshExamp
//
//  Created by 김성남 on 2018. 9. 12..
//  Copyright © 2018년 김성남. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var refreshControl = UIRefreshControl()
  var number = ["1","2","3","4","5","6","7","8","9", "10"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.registerCell(type: taCell.self)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action:  #selector(sortArray), for: UIControlEvents.valueChanged)
    self.tableView.addSubview(self.refreshControl)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  
  @objc func sortArray() {
    let sortedAlphabet = number.reversed()
    
    for (index, element) in sortedAlphabet.enumerated() {
      number[index] = element
    }
    
    tableView.reloadData()
    self.refreshControl.endRefreshing()
  }
}


extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.number.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taCell", for: indexPath)

    self.configuretaCell(cell: cell, indexPath: indexPath)
    return cell
  }

  func configuretaCell(cell: UITableViewCell, indexPath: IndexPath) {
    let cell = cell as! taCell
    cell.titleLabel.text = self.number[indexPath.row]
  }


  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
  }
}
