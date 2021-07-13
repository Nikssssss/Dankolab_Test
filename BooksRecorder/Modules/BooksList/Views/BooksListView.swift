//
//  BooksListView.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit

class BooksListView: UIView {
    private let booksTableView = UITableView()
    
    func configureView() {
        
    }
}

extension BooksListView: UITableViewDelegate {
    
}

extension BooksListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
    }
}
