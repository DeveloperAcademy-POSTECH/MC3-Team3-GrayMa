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
