//
//  BooksListTableViewCell.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit

protocol IBooksListTableCell: AnyObject {
    func setBookName(_ name: String)
    func setBookDate(_ date: String)
    func setBookDateColor(_ color: UIColor)
}

class BooksListTableViewCell: UITableViewCell {
    static let identifier = "BooksListTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: BooksListTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BooksListTableViewCell: IBooksListTableCell {
    func setBookName(_ name: String) {
        self.textLabel?.text = name
    }
    
    func setBookDate(_ date: String) {
        self.detailTextLabel?.text = date
    }
    
    func setBookDateColor(_ color: UIColor) {
        self.detailTextLabel?.textColor = color
    }
}
