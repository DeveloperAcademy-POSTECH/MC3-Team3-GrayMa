//
//  ConnectionProfileEditView.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/27.
//

import SwiftUI

struct ConnectionProfileEditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dotsModel: DotsModel
    let person: NetworkingPersonEntity
    
    @State private var editedName: String = ""
    @State private var editedCompany: String = ""
    @State private var editedJob: String = ""
    @State private var editedPhoneNum: String = ""
    @State private var editedMail: String = ""
    @State private var editedLink: String = ""
    
    var body: some View {
        VStack {
            if let existingName = person.name,
               let existingCompany = person.company,
               let existingJob = person.job,
               let existingPhoneNume = person.contanctNum,
               let existingMail = person.email,
               let existingLink = person.linkedIn {
                TextField(existingName.isEmpty ? "이름" : existingName, text: $editedName)
                TextField(existingCompany.isEmpty ? "회사" : existingCompany, text: $editedCompany)
                TextField(existingJob.isEmpty ? "직무" : existingJob, text: $editedJob)
                TextField(existingPhoneNume.isEmpty ? "연락처" : existingPhoneNume, text: $editedPhoneNum)
                TextField(existingMail.isEmpty ? "이메일" : existingMail, text: $editedMail)
                TextField(existingLink.isEmpty ? "링크드인주소" : existingLink, text: $editedLink)
            }
            
            Button {
            dotsModel.updateNetworking(id: person.peopleID!, profileImgIdx: Int(person.profileImageIndex), name: editedName, company: editedCompany, job: editedJob, phoneNum: editedPhoneNum, email: editedMail, snsUrl: editedLink)
                dismiss()
            } label: {
                Text("저장")
            }
        }
    }
}
