//
//  DotsModel.swift
//  Dots
//
//  Created by 정승균 on 2023/07/17.
//

import Foundation
import CoreData

class DotsModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var myStrength: [MyStrengthEntity] = []
    @Published var strength: [StrengthEntity] = []
    @Published var myNotes: [MyStrengthNoteEntity] = []
    @Published var networkingPeople: [NetworkingPersonEntity] = []
    @Published var networkingNotes: [NetworkingNoteEntity] = []
    
    
    init() {
        getModel()
    }
    
    func save() {
        // 메모리에 올라온 객체 모두 제거
        myStrength.removeAll()
        strength.removeAll()
        myNotes.removeAll()
        networkingPeople.removeAll()
        networkingNotes.removeAll()
        
        // 저장된 객체를 새로 뽑아옴
        manager.save()
        self.getModel()
    }
    
}

// Get Methods
extension DotsModel {
    func getModel() {
        getMyStrength()
        getStrength()
        getMyNotes()
        getNetworkingPeople()
        getNetworkingNotes()
    }
    
    func getMyStrength() {
        let request = NSFetchRequest<MyStrengthEntity>(entityName: "MyStrengthEntity")
        do {
            myStrength = try manager.context.fetch(request)
            print("MyStrength : \(myStrength)")
        } catch let error {
            print("Fetching Error. \(error.localizedDescription)")
        }
    }
    
    func getStrength() {
        let request = NSFetchRequest<StrengthEntity>(entityName: "StrengthEntity")
        do {
            strength = try manager.context.fetch(request)
            print("Strength : \(strength)")
            for i in strength {
                print(i.strengthName)
            }
        } catch let error {
            print("Fetching Error. \(error.localizedDescription)")
        }
    }
    
    func getMyNotes() {
        let request = NSFetchRequest<MyStrengthNoteEntity>(entityName: "MyStrengthNoteEntity")
        
        // 최신순 정렬
        let descendingSort = NSSortDescriptor(keyPath: \MyStrengthNoteEntity.date, ascending: false)
        
        request.sortDescriptors = [descendingSort]
        
        do {
            myNotes = try manager.context.fetch(request)
            print("MyNote : \(myNotes)")
        } catch let error {
            print("Fetching Error. \(error.localizedDescription)")
        }
    }
    
    func getNetworkingPeople() {
        let request = NSFetchRequest<NetworkingPersonEntity>(entityName: "NetworkingPersonEntity")
        do {
            networkingPeople = try manager.context.fetch(request)
            print("NetworkingPeople : \(networkingPeople)")
        } catch let error {
            print("Fetching Error. \(error.localizedDescription)")
        }
    }
    
    func getNetworkingNotes() {
        let request = NSFetchRequest<NetworkingNoteEntity>(entityName: "NetworkingNoteEntity")
        do {
            networkingNotes = try manager.context.fetch(request)
            print("NetworkingNote : \(networkingNotes)")
        } catch let error {
            print("Fetching Error. \(error.localizedDescription)")
        }
    }
}

extension DotsModel {
    func addExampleNetworkingPeople() {
        //Test data
        let newEntity1 = NetworkingPersonEntity(context: manager.context)
        newEntity1.peopleID = UUID()
        newEntity1.profileImageIndex = Int16(2)
        newEntity1.name = "김철수"
        newEntity1.company = "apple"
        newEntity1.contanctNum = "010-1111-2222"
        newEntity1.email = "kkkk@mail.com"
        newEntity1.job = "Dev"
        newEntity1.linkedIn = "linkedin.com/lol"
        
        let newEntity2 = NetworkingPersonEntity(context: manager.context)
        newEntity2.peopleID = UUID()
        newEntity2.profileImageIndex = Int16(2)
        newEntity2.name = "김래쉬"
        newEntity2.company = "apple"
        newEntity2.contanctNum = "010-1111-2222"
        newEntity2.email = "kkkk@mail.com"
        newEntity2.job = "Dev"
        newEntity2.linkedIn = "linkedin.com/lol"
        
        save()
    }
}
