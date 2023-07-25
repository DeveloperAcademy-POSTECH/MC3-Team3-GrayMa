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

enum RedundantCheck {
    case exist
    case redunant
    case new
}

extension DotsModel {
    func addStrength(name: String) -> CreateStatus {
        let checkedValue = checkRedundantVaildation(name)
        
        switch checkedValue {
        case .exist:
            print("이미 존재하는 거라 안만들어도 됨.")
            
            return .ok
        case .redunant:
            print("중복임")
            
            return .redunant
        case .new:
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

    func changeLevel(strengthLevel: Int16, strengthName: String) {
        guard let myStrength = findMyStrengthFromName(strengthName) else { return }
        
        myStrength.strengthLevel = strengthLevel
        
        save()
    }
    
    func findMyStrengthFromName(_ name: String) -> MyStrengthEntity? {
        return myStrength.first { entity in
            entity.ownStrength?.strengthName == name
        }
    }
    
    func checkRedundantVaildation(_ name: String) -> RedundantCheck {
        if myStrength.contains(where: { entity in
            entity.ownStrength?.strengthName == name
        }) {
            return .redunant
        } else if strength.contains(where: { entity in
            entity.strengthName == name
        }) {
            return .exist
        } else {
            return .new
        }
    }
    
    func addNetworking(profileImgIdx: Int, name: String, company: String, job: String, phoneNum: String, email: String, snsUrl: String) {
        let newNetworking = NetworkingPersonEntity(context: manager.context)
        
        newNetworking.peopleID = UUID()
        newNetworking.profileImageIndex = Int16(profileImgIdx)
        newNetworking.name = name
        newNetworking.company = company
        newNetworking.contanctNum = phoneNum
        newNetworking.email = email
        newNetworking.job = job
        newNetworking.linkedIn = snsUrl
        
        // 동적으로 수정
        //newNetworking.addToStrengthSet([strength[0], strength[1]])
        
        save()
    }
    
    func addMyNote(date: Date, content: String, strength: MyStrengthEntity) {
        let newMyNote = MyStrengthNoteEntity(context: manager.context)
        
        newMyNote.myStrengthNoteID = UUID()
        newMyNote.date = date
        newMyNote.content = content
        newMyNote.relatedStrength = strength
        
        save()
    }
    
    func addConnectionNote(date: Date, content: String, connection: NetworkingPersonEntity) {
        let newConnectionNote = NetworkingNoteEntity(context: manager.context)
        
        newConnectionNote.networkingNoteID = UUID()
        newConnectionNote.date = date
        newConnectionNote.content = content
        newConnectionNote.relatedPerson = connection
        
        save()
    }
    
    func updateMyNote(id: UUID, date: Date, content: String) {
        guard let noteIndex = myNotes.firstIndex(where: { $0.myStrengthNoteID == id }) else { return }
        myNotes[noteIndex].date = date
        myNotes[noteIndex].content = content
        
        save()
    }
    
    func updateConnectionNote(id: UUID, date: Date, content: String) {
        guard let noteIndex = networkingNotes.firstIndex(where: { $0.networkingNoteID == id }) else { return }
        networkingNotes[noteIndex].date = date
        networkingNotes[noteIndex].content = content
        
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
    
    func deleteConnection(person: NetworkingPersonEntity) {
        let targetEntity = networkingPeople.first {
            $0 == person
        }
        
        guard let targetEntity = targetEntity else {
            print("삭제 실패")
            
            return
        }
        
        manager.context.delete(targetEntity)
        
        save()
    }
    
    func deleteMyStrength(myStrength entity: MyStrengthEntity) {
        let targetEntity = myStrength.first {
            $0.myStrengthUUID == entity.myStrengthUUID
        }
        
        guard let targetEntity = targetEntity else { return }
        
        manager.context.delete(targetEntity)
        
        save()
    }
    
    func deleteMyNote(myNote entity: MyStrengthNoteEntity) {
        let targetEntity = myNotes.first {
            $0.myStrengthNoteID == entity.myStrengthNoteID
        }
        
        guard let targetEntity = targetEntity else { return }
        
        manager.context.delete(targetEntity)
        
        save()
    }
}
