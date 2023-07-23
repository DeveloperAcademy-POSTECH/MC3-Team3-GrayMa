//
//  Ex+MyStrengthNoteEntity.swift
//  Dots
//
//  Created by 정승균 on 2023/07/21.
//

import Foundation

extension MyStrengthNoteEntity {
    public static func ==(lhs: MyStrengthNoteEntity, rhs: MyStrengthNoteEntity) -> Bool {
        return lhs.myStrengthNoteID == rhs.myStrengthNoteID
    }
}
