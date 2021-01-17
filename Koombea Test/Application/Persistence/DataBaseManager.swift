//
//  DataBaseManager.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import Foundation
import CouchbaseLiteSwift

class DataBaseManager {
    
    static var shared  = DataBaseManager()
    private let dbName = "posts-database"
    private let database: Database?
    
    private init() {
        self.database = try? Database(name: dbName)
    }
    
    func flushDB() throws {
        guard let database = database else { return }
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
        
        try query
            .execute()
            .allResults()
            .forEach { result in
                if let object = result.dictionary(forKey: dbName),
                   let id = object.string(forKey: "uid"),
                   let document = database.document(withID: id) {
                    try database.deleteDocument(document)
                }
            }
    }
     
    func saveDictionary(_ dictionary: [String : Any], forKey key: String) throws {
        guard let database = database else { return }
        
        let mutableDoc = MutableDocument(id: key, data: dictionary)
        try database.saveDocument(mutableDoc)
    }
    
    func getAllRecords() throws -> [[String : Any]] {
        guard let database = database else { return [] }
        
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
        
        let result = try query
            .execute()
            .allResults()
            .compactMap { $0.dictionary(forKey: dbName)?.toDictionary() }
        
        return result
    }
}
