//
//  DataSource.swift
//  Diario
//
//  Created by iredefbmac_36 on 31/07/25.
//

import SwiftUI
import SwiftData

class DataSource {
    let dataContainer: ModelContainer
    let dataContext: ModelContext
    
    @MainActor
    static let shared = DataSource()
    
    @MainActor
    private init() {
        self.dataContainer = try! ModelContainer(for: NotebookModel.self, DayModel.self)
        self.dataContext = dataContainer.mainContext
    }
    
    func saveChanges() {
        do {
            try dataContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func appendNotebook(notebook: NotebookModel) {
        self.dataContext.insert(notebook)
        saveChanges()
    }
    
    func fetchNotebooks() -> [NotebookModel] {
        do {
            return try dataContext.fetch(FetchDescriptor<NotebookModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateNotebook(notebook: NotebookModel, updatedNotebook: NotebookModel) {
        let notebookFound = fetchNotebooks().first(where: { fetchedNotebook in
            fetchedNotebook.id == notebook.id
        })
        
        notebookFound?.entries = updatedNotebook.entries
        notebookFound?.sprite = updatedNotebook.sprite
        notebookFound?.date = updatedNotebook.date
        notebookFound?.name = updatedNotebook.name
        
        saveChanges()
    }
    
    func deleteNotebook(notebook: NotebookModel) {
        dataContext.delete(notebook)
        saveChanges()
    }
    
    func appendDay(day: DayModel) {
        self.dataContext.insert(day)
        saveChanges()
    }
    
    func fetchDays() -> [DayModel] {
        do {
            return try dataContext.fetch(FetchDescriptor<DayModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateDay(day: DayModel, updatedDay: DayModel) {
        let dayFound = fetchDays().first(where: { fetchedDay in
            fetchedDay.id == day.id
        })
        
        dayFound?.day = updatedDay.day
        dayFound?.emojiSprite = updatedDay.emojiSprite
        dayFound?.memo = updatedDay.memo
        
        saveChanges()
    }
    
    func deleteDay(day: DayModel) {
        dataContext.delete(day)
        saveChanges()
    }
}
