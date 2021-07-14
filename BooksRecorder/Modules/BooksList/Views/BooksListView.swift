//
//  BooksListView.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit

class BooksListView: UIView {
    var numberOfRowsInSection: ((Int) -> Int)?
    var cellWillAppear: ((IBooksListTableCell, IndexPath) -> Void)?
    var titleForHeaderInSection: ((Int) -> String)?
    
    private let booksTableView = UITableView(frame: .zero, style: .grouped)
    
    func configureView() {
        self.addSubviews()
        self.configureBooksTableView()
    }
    
    func reloadData() {
        self.booksTableView.reloadData()
    }
    
    func enableEmptyListView() {
        let emptyListLabel = UILabel()
        emptyListLabel.text = "Empty list"
        emptyListLabel.textColor = UIColor(red: 216 / 255.0,
                                           green: 216 / 255.0,
                                           blue: 216 / 255.0,
                                           alpha: 1.0)
        emptyListLabel.font = .systemFont(ofSize: 24, weight: .bold)
        emptyListLabel.textAlignment = .center
        self.booksTableView.backgroundView = emptyListLabel
    }
    
    func disableEmptyListView() {
        self.booksTableView.backgroundView = nil
    }
}

extension BooksListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.tintColor = .black
        headerView.backgroundConfiguration?.backgroundColor = .white
        headerView.textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
}

extension BooksListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleForHeaderInSection?(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRowsInSection?(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BooksListTableViewCell.identifier,
                                                 for: indexPath) as? BooksListTableViewCell
        else { return UITableViewCell() }
        self.cellWillAppear?(cell, indexPath)
        return cell
    }
}

private extension BooksListView {
    func addSubviews() {
        self.addSubview(self.booksTableView)
    }
    
    func configureBooksTableView() {
        self.booksTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.booksTableView.register(BooksListTableViewCell.self,
                                     forCellReuseIdentifier: BooksListTableViewCell.identifier)
        self.booksTableView.dataSource = self
        self.booksTableView.delegate = self
        self.booksTableView.tableFooterView = UIView()
        self.booksTableView.backgroundColor = .white
    }
}
