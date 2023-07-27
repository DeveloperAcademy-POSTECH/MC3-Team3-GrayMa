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

//        VStack{
//            // 상단 메뉴바
//            HStack{
//                Text("\(Image(systemName: "chevron.left")) 인맥관리")
//                    .font(.system(size: 22))
//                    .foregroundColor(Color.theme.primary)
//                    .onTapGesture { dismiss() }
//
//                Spacer()
//                    .frame(width: 248)
//
//                Text("완료")
//                    .font(.system(size: 22))
//                    .foregroundColor(Color.theme.primary)
//
//                    .onTapGesture {
//                        dotsModel.up(profileImgIdx: coreDataUSerProfileImgIdx, name: coreDataUserName, company: coreaDataUserCompany, job: coreDataUserJob, phoneNum: coreDataUserPhone, email: coreDataUserEmail, snsUrl: coreDataUserSNS /*, userStrength: coreDataUserStrength*/)
//                        //인맥 추가 알림 띄움
//                        addAlert = true
//                    }
//            }
//
//            ScrollView(showsIndicators: false){
//                //이미지 추가
//                contactsImageSelect(userName: coreDataUserName, coreDataUserIdx: $coreDataUSerProfileImgIdx)
//                    .onTapGesture {
//                        userImgModal = true
//                    }
//                    .sheet(isPresented: $userImgModal) {
//                        ProfileImageModal(userName: coreDataUserName, userImageIdx: $coreDataUSerProfileImgIdx)
//                            .presentationDetents([.height(UIScreen.main.bounds.height * 0.4)])
//                    }
//
//
//                VStack (alignment: .leading){
//
//                    ContactsNameField(UserInputName: $coreDataUserName, fieldFocus: fieldFocus)
//
//                    ContactsCompanyField(UserInputCompany: $coreaDataUserCompany)
//
//                    ContactsJobField(UserInputJob: $coreDataUserJob)
//
//                    ContactsPhoneField(UserInputPhone: $coreDataUserPhone, fieldFocus: fieldFocus)
//
//                    ContactsEmailField(UserInputEmail: $coreDataUserEmail)
//
//                    ContactsSNSField(UserInputSNS: $coreDataUserSNS)
//
//                    ContactsStrengthField(UserInputStrengthArr: $coreDataUserStrength)
//
//                    //선택된 강점 표시 부분
//                    ForEach(coreDataUserStrength, id: \.self) { Strength in
//                        Text(Strength)
//                    }
//
//                }
//            }
//        }
//    }
//
//    .alert(isPresented: $addAlert) {
//        Alert(title: Text("알림"),
//              message: Text("인맥이 추가되었습니다."),
//              dismissButton: .default(Text("확인"), action: {
//            // 모달을 닫습니다.
//            presentationMode.wrappedValue.dismiss()
//            modalComtrol = false
//        }))
//    }
//    .onAppear{
//        if !(selectedUserName?.isEmpty ?? true){
//            let selectedUser = fetchContact(name: selectedUserName ?? "")
//            for contact in selectedUser {
//                coreDataUserName = contact.Name
//
//                coreaDataUserCompany = contact.Company ?? ""
//                coreDataUserJob = contact.Job ?? ""
//
//                coreDataUserPhone = contact.PhoneNumber ?? ""
//                coreDataUserEmail = contact.Email ?? ""
//                //coreDataUserSNS = contact.SNS ?? ""
//            }
//        }

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
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton)
        .navigationBarItems(trailing: SaveButton)
    }
    
    private var BackButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 3) {
                Image(systemName: "chevron.backward")
                Text("프로필")
            }
        }
    }
    
    private var SaveButton: some View {
        Button {
            dotsModel.updateNetworking(id: person.peopleID!, profileImgIdx: Int(person.profileImageIndex), name: editedName, company: editedCompany, job: editedJob, phoneNum: editedPhoneNum, email: editedMail, snsUrl: editedLink)
                dismiss()
        } label: {
            Text("저장")
        }
    }
}
