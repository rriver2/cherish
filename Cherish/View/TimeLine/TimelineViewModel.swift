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
            recordsEntity = try container.viewContext.fetch(request)
        } catch let error{
            print("ERROR Fetching", error)
        }
    }
    
    func addRecord(date: Date, title: String, context: String, kind: Record) {
        let newRecord = RecordEntity(context: container.viewContext)
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
}
