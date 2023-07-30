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
    
    @State private var someThingWrongAlert = false
    @State private var showImageSelectModal = false
    @State private var fieldFocus = false
    
    @Binding var isProfileEdited: Bool
    
    let person: NetworkingPersonEntity
    
    @State private var editedImageIndex: Int = 1
    @State private var editedName: String = ""
    @State private var editedCompany: String = ""
    @State private var editedJob: String = ""
    @State private var editedPhoneNum: String = ""
    @State private var editedMail: String = ""
    @State private var editedLink: String = ""
    
    init(isProfileEdited: Binding<Bool>, person: NetworkingPersonEntity) {
        _isProfileEdited = isProfileEdited
        
        self.person = person

        _editedImageIndex = State(initialValue: Int(person.profileImageIndex))
        _editedName = State(initialValue: person.name ?? "")
        _editedCompany = State(initialValue: person.company ?? "")
        _editedJob = State(initialValue: person.job ?? "")
        _editedPhoneNum = State(initialValue: person.contanctNum ?? "")
        _editedMail = State(initialValue: person.email ?? "")
        _editedLink = State(initialValue: person.linkedIn ?? "")
    }
    
    var body: some View {
        ZStack {
            Color.theme.bgPrimary
            
            ScrollView(showsIndicators: false) {
                //이미지 추가
                ProfileImageView(imageIndex: editedImageIndex)
                    .onTapGesture {
                        showImageSelectModal.toggle()
                    }
                    .sheet(isPresented: $showImageSelectModal) {
                        EditImageModal(userImageIdx: $editedImageIndex)
                            .presentationDetents([.height(UIScreen.main.bounds.height * 0.4)])
                    }


                VStack {
                    ContactsNameField(UserInputName: $editedName, fieldFocus: fieldFocus)

                    ContactsCompanyField(UserInputCompany: $editedCompany)

                    ContactsJobField(UserInputJob: $editedJob)

                    ContactsPhoneField(UserInputPhone: $editedPhoneNum, fieldFocus: fieldFocus)

                    ContactsEmailField(UserInputEmail: $editedMail, fieldFocus: fieldFocus)

                    ContactsSNSField(UserInputSNS: $editedLink, fieldFocus: fieldFocus)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton)
        .navigationBarItems(trailing: SaveButton)
        
        .toolbarBackground(Color.theme.bgPrimary, for: .navigationBar)
        
        .alert(isPresented: $someThingWrongAlert) {
            Alert(title: Text("필수 조건이 입력되지 않았습니다."),
                  dismissButton: .default(Text("확인"),
                                         action: {})
            )
        }
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
            if editedName != "" && editedJob != "" {
                // 수정 내용 저장
                dotsModel.updateNetworking(id: person.peopleID!, profileImgIdx: editedImageIndex, name: editedName, company: editedCompany, job: editedJob, phoneNum: editedPhoneNum, email: editedMail, snsUrl: editedLink)
                
                isProfileEdited.toggle()
                
                dismiss()
            } else {
                someThingWrongAlert.toggle()
            }
        } label: {
            Text("저장")
        }
    }
}

struct ProfileImageView: View {
    let imageIndex: Int
    
    var body: some View {
        ZStack{
            Group {
                Circle()
                    .foregroundStyle(Color.theme.secondary)

                Image("user_default_profile \(imageIndex)")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 88)
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .offset(x: 30, y: 30)
                .foregroundColor(Color("primary"))
        }
    }
}

struct EditImageModal: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var userImageIdx : Int
    
    var body: some View {
        VStack {
            HStack {
                Text("프로필 이미지")
                    .modifier(semiBoldTitle3(colorName: Color.theme.gray5Dark))

                Spacer()
            }
            .padding(.horizontal, 16)

            Spacer()
                .frame(height: 16)
            
            SelectImage
            
            HStack {
                SelectBtn(fontWeight: .regular, content: "취소", textColor: .black, btnColor: Color.theme.bgBlank, action: { dismiss() })
                
                Spacer()
                
                SelectBtn(fontWeight: .bold, content: "완료", textColor: .white, btnColor: Color.theme.primary, action: { dismiss() })
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var SelectImage: some View {
        VStack {
            ZStack {
                Group {
                    Circle()
                        .foregroundStyle(Color.theme.secondary)
                    
                    Image("user_default_profile \(userImageIdx)")
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 88)
            }
            
            Spacer()
                .frame(height: 4)
            
            HStack {
                ForEach(1...5, id: \.self) { idx in
                    ZStack {
                        Group {
                            Circle()
                                .foregroundStyle(Color.theme.secondary)
                            
                            Image("user_default_profile \(idx)")
                                .resizable()
                                .scaledToFit()
                                .onTapGesture {
                                    userImageIdx = idx
                                }
                        }
                        .frame(width: 64)
                    }
                }
            }
            .padding(16)
        }
    }
}
