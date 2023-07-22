//
//  Ex+NetworkingPersonEntity.swift
//  Dots
//
//  Created by 정승균 on 2023/07/21.
//

import Foundation

extension NetworkingPersonEntity {
    public static func ==(lhs: NetworkingPersonEntity, rhs: NetworkingPersonEntity) -> Bool {
        return lhs.peopleID == rhs.peopleID
    }
}
