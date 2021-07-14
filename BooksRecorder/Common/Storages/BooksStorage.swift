//
//  BooksStorage.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation
import CoreData

protocol IBooksStorage: AnyObject {
    var validBooks: [BookDto] { get }
    var overdueBooks: [BookDto] { get }
    var count: Int { get }
    func loadBooks()
    func addBook(_ bookDto: BookDto) -> Bool
    func editBook(_ oldBookDto: BookDto, using editedBookDto: BookDto) -> Bool
    func removeBook(at row: Int)
}

final class BooksStorage: IBooksStorage {
    var validBooks: [BookDto] {
        return self.books.compactMap { book in
            guard let bookName = book.name,
                  let deadlineDate = book.deadlineDate,
                  self.getDay(from: deadlineDate) >= self.getDay(from: Date())
            else { return nil }
            return BookDto(name: bookName, deadlineDate: deadlineDate)
        }
    }
    
    var overdueBooks: [BookDto] {
        return self.books.compactMap { book in
            guard let bookName = book.name,
                  let deadlineDate = book.deadlineDate,
                  self.getDay(from: deadlineDate) < self.getDay(from: Date())
            else { return nil }
            return BookDto(name: bookName, deadlineDate: deadlineDate)
        }
    }
    
    var count: Int {
        return self.books.count
    }
    
    private let persistentContainer: NSPersistentContainer
    private let mainContext: NSManagedObjectContext
    
    private var books = [Book]()
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "BooksRecorder")
        self.persistentContainer.loadPersistentStores { _, _ in }
        self.mainContext = self.persistentContainer.viewContext
    }
    
    func loadBooks() {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        self.books = (try? self.mainContext.fetch(fetchRequest)) ?? []
    }
    
    func addBook(_ bookDto: BookDto) -> Bool {
        guard self.getBookIfExists(with: bookDto.name) == nil
        else { return false }
        let book = Book(context: self.mainContext)
        book.name = bookDto.name
        book.deadlineDate = bookDto.deadlineDate
        try? self.mainContext.save()
        return true
    }
    
    func editBook(_ oldBookDto: BookDto, using editedBookDto: BookDto) -> Bool {
        guard let oldBook = self.getBookIfExists(with: oldBookDto.name)
        else { return false }
        if oldBookDto.name != editedBookDto.name
            && self.getBookIfExists(with: editedBookDto.name) != nil {
            return false
        }
        oldBook.name = editedBookDto.name
        oldBook.deadlineDate = editedBookDto.deadlineDate
        try? self.mainContext.save()
        return true
    }
    
    func removeBook(at row: Int) {
        guard row >= 0, row < self.books.count,
              let deletedBookName = self.books[row].name,
              let deletedBook = self.getBookIfExists(with: deletedBookName)
        else { return }
        self.mainContext.delete(deletedBook)
        try? self.mainContext.save()
    }
}

private extension BooksStorage {
    func getBookIfExists(with name: String) -> Book? {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Book.name)) = %@", name)
        return try? self.mainContext.fetch(fetchRequest).first
    }
    
    func getDay(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date).day ?? 0
    }
}
