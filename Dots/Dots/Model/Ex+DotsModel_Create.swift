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
    
    // 인맥 강점 추가용 - 텍스트 중복 검사 후 db 추가
    func addConnectionStrengthName(person: NetworkingPersonEntity, name: String) -> CreateStatus {
        let checkedValue = checkRedundantVaildationForConnection(person: person, name: name)
        
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
    
    // 실제 해당 인맥에 강점을 추가하는 함수
    func addConnectionStrength(id: UUID, strengthNameList: [String] = []) {
        guard let personIndex = networkingPeople.firstIndex(where: { $0.peopleID == id }) else { return }
        
        var strengthList: [StrengthEntity] = []
        
        for name in strengthNameList {
            guard let strength = findStrengthFromName(name) else { return }
            strengthList.append(strength)
        }
        
        networkingPeople[personIndex].addToStrengthSet(NSSet(array: strengthList))

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
    
    func checkRedundantVaildationForConnection(person: NetworkingPersonEntity, name: String) -> RedundantCheck {
        let strengthSet = person.strengthSet?.allObjects as? [StrengthEntity] ?? []
        
        if strengthSet.contains(where: { entity in
            entity.strengthName == name
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
    
    func addNetworking(profileImgIdx: Int, name: String, company: String, job: String, phoneNum: String, email: String, snsUrl: String, strengthStringList: [String]) {
        let newNetworking = NetworkingPersonEntity(context: manager.context)
        
        newNetworking.peopleID = UUID()
        newNetworking.profileImageIndex = Int16(profileImgIdx)
        newNetworking.name = name
        newNetworking.company = company
        newNetworking.contanctNum = phoneNum
        newNetworking.email = email
        newNetworking.job = job
        newNetworking.linkedIn = snsUrl
        
        var strengthList: [StrengthEntity] = []
        
        for name in strengthStringList {
            guard let strength = findStrengthFromName(name) else { return }
            strengthList.append(strength)
        }
        
        newNetworking.addToStrengthSet(NSSet(array: strengthList))
        
        save()
    }
    
    func updateNetworking(id: UUID, profileImgIdx: Int, name: String, company: String, job: String, phoneNum: String, email: String, snsUrl: String, strengthList: [StrengthEntity] = []) {
        guard let personIndex = networkingPeople.firstIndex(where: { $0.peopleID == id }) else { return }
        
        networkingPeople[personIndex].profileImageIndex = Int16(profileImgIdx)
        networkingPeople[personIndex].name = name
        networkingPeople[personIndex].company = company
        networkingPeople[personIndex].contanctNum = phoneNum
        networkingPeople[personIndex].email = email
        networkingPeople[personIndex].job = job
        networkingPeople[personIndex].linkedIn = snsUrl
        
        // 동적으로 수정
//        newNetworking.addToStrengthSet(NSSet(array: strengthList))
        
        save()
    }
    
    func addNote(date: Date, content: String, entity: NSObject) {
        switch entity {
        case is MyStrengthEntity:
            let note = MyStrengthNoteEntity(context: manager.context)
            
            note.myStrengthNoteID = UUID()
            note.date = date
            note.content = content
            note.relatedStrength = (entity as! MyStrengthEntity)
            
        case is NetworkingPersonEntity:
            let note = NetworkingNoteEntity(context: manager.context)
            
            note.networkingNoteID = UUID()
            note.date = date
            note.content = content
            note.relatedPerson = (entity as! NetworkingPersonEntity)
            
        default:
            fatalError("Unable to addNote \(entity)")
        }
        
        save()
    }
    
    func updateNote(id: UUID, date: Date, content: String, entity: NSObject) {
        switch entity {
        case is MyStrengthNoteEntity:
            guard let noteIndex = myNotes.firstIndex(where: { $0.myStrengthNoteID == id }) else { return }
            myNotes[noteIndex].date = date
            myNotes[noteIndex].content = content
            
        case is NetworkingNoteEntity:
            guard let noteIndex = networkingNotes.firstIndex(where: { $0.networkingNoteID == id }) else { return }
            networkingNotes[noteIndex].date = date
            networkingNotes[noteIndex].content = content
            
        default:
            fatalError("Unable to updateNote \(entity)")
        }

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
    
//    func deleteConnectionStrength(strength entity: )
    
    func deleteNote(entity: NSObject) {
        switch entity {
        case let entity as MyStrengthNoteEntity:
            let targetEntity = myNotes.first {
                $0.myStrengthNoteID == entity.myStrengthNoteID
            }
            guard let targetEntity = targetEntity else { return }
            manager.context.delete(targetEntity)
            
        case let entity as NetworkingNoteEntity:
            let targetEntity = networkingNotes.first {
                $0.networkingNoteID == entity.networkingNoteID
            }
            guard let targetEntity = targetEntity else { return }
            manager.context.delete(targetEntity)
            
        default:
            fatalError("Unable to deleteNote \(entity)")
        }
        
        save()
    }
}
