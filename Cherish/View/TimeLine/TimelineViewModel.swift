//
//  TimelineViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/13.
//

import Foundation
import CoreData

class TimeLineViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var recordsEntity: [RecordEntity] = []
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "TimelineContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR Loading Data", error)
            }
        }
        fetchTimeline()
    }
    
    func fetchTimeline() {
        let request = NSFetchRequest<RecordEntity>(entityName: "RecordEntity")
        
        do {
            recordsEntity = try container.viewContext.fetch(request).sorted(by: {
                if $0.date == nil || $1.date == nil {
                    return false
                } else {
                    return $0.date! > $1.date!
                }
            })
        } catch let error{
            print("ERROR Fetching", error)
        }
    }
    
    func addRecord(date: Date, title: String, context: String, kind: Record) {
        let newRecord = RecordEntity(context: container.viewContext)
        print("date", date)
        newRecord.date = date
        newRecord.title = title
        newRecord.context = context
        newRecord.kind = kind.rawValue
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchTimeline()
        } catch let error {
            print("ERROR Saving", error)
        }
    }
    
    func clearData() {
        do {
            try container.viewContext.save()
            fetchTimeline()
        } catch let error {
            print("ERROR Saving", error)
        }
    }
    
    func removeAll() {
        for record in recordsEntity {
            container.viewContext.delete(record)
        }
        do {
            try container.viewContext.save()
        } catch {
            print("ERROR removeAll", error)
        }
        saveData()
    }
    
    func updateRecord(originDate: Date, date: Date, title: String, context: String) {
        for result in recordsEntity where result.date == originDate {
            print("date", date)
            print(#function)
            result.title = title
            result.date = date
            result.context = context
        }
        saveData()
    }
    
    func removeRecord(id: Date) {
        if let removeRecord = recordsEntity.first(where: { $0.date == id }) {
            context.delete(removeRecord)
            saveData()
        }
    }
}
