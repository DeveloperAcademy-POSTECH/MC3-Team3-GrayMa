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
}
