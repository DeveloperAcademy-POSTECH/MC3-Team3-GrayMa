//
//  Ex+DotsModel_Create.swift
//  Dots
//
//  Created by 정승균 on 2023/07/19.
//

import Foundation
import CoreData

enum CreateStatus {
    case redunant
    case ok
}

extension DotsModel {
    func addStrength(name: String) -> CreateStatus {
        if checkRedundantVaildation(name) {
            print("중복임")
            
            return .redunant
        } else {
            let newStrength = StrengthEntity(context: manager.context)
            newStrength.strengthName = name
            newStrength.strengthColor = "red"
            
            save()
            
            return .ok
        }
    }
    
    func addMyStrength(strengthLevel: Int16, strengthName: String) {
        let newMyStrength = MyStrengthEntity(context: manager.context)
        guard let strength = findStrengthFromName(strengthName) else { return }
        
        newMyStrength.myStrengthUUID = UUID()
        newMyStrength.strengthLevel = strengthLevel
        newMyStrength.ownStrength = strength
        
        save()
    }
    
    func findStrengthFromName(_ name: String) -> StrengthEntity? {
        return strength.first { entity in
            entity.strengthName == name
        }
    }
    
    func checkRedundantVaildation(_ name: String) -> Bool {
        return strength.contains { entity in
            entity.strengthName == name
        } || myStrength.contains(where: { entity in
            entity.ownStrength?.strengthName == name
        })
    }
    
    func addNetworking() {
        let newNetworking = NetworkingPersonEntity(context: manager.context)
        
        newNetworking.peopleID = UUID()
        newNetworking.company = "회사"
        newNetworking.contanctNum = "010-1111-1111"
        newNetworking.email = "sffwfe@naver.com"
        newNetworking.job = "직업2"
        newNetworking.linkedIn = "링크드인 주소"
        newNetworking.addToStrengthSet([strength[0], strength[1]])
        save()
    }
    
    func addMyNote(date: Date, content: String) {
        let newMyNote = MyStrengthNoteEntity(context: manager.context)
        
        newMyNote.myStrengthNoteID = UUID()
        newMyNote.date = date
        newMyNote.content = content
        
        save()
    }
    
    func updateMyNote(id: UUID, date: Date, content: String) {
        guard let noteIndex = myNotes.firstIndex(where: { $0.myStrengthNoteID == id }) else { return }
        myNotes[noteIndex].date = date
        myNotes[noteIndex].content = content
        
        save()
    }

}

extension DotsModel {
    func deleteConnection(offsets: IndexSet) {
        guard let firstIndex = offsets.first, firstIndex < networkingPeople.count else { return }
        
        let toDeletePerson = networkingPeople[firstIndex]
        print(toDeletePerson.name)
        manager.context.delete(toDeletePerson)
        
        save()
    }
}
