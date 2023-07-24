//
//  ConnectionProfileModal.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/20.
//

import SwiftUI
import UIKit

struct ConnectionProfileModal: View {
    let person: NetworkingPersonEntity
    
    @State private var showNote = false
    
    // 데이터 연동 필요 - 메모(NetworkingNoteEntity)
    
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 25) {
                BasicProfile(name: person.name, company: person.company, job: person.job)
                HStack {
                    ZStack {
                        Image("profileImageBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 105)
                        
                        Image("user_default_profile \(person.profileImageIndex)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 88)
                    }
                    Spacer()
                    
                    ContactButtons(phoneNum: person.contanctNum!, mailAdd: person.email!, linkedinLink: person.linkedIn!)
                        .padding(.trailing, 15)
                }

                Button {
                    showNote.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 361, height: 44)
                        .overlay{
                            HStack {
                                Image(systemName: "square.and.pencil")
                                Text("새로운 기록 작성")
                            }
                            .modifier(semiBoldBody(colorName: Fontcolor.fontWhite.colorName))
                        }
                }
                
                // MARK: - 인맥 노트 리스트
//                ScrollView {
//                    if let notes = person.networkingNotes?.allObjects as? [NetworkingNoteEntity], !notes.isEmpty {
//                        ForEach(notes) { note in
//                            CustomDetailList(noteEntity: note)
//                        }
//                    } else {
//                        RoundedRectangle(cornerRadius: 12)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 62)
//                            .padding(.horizontal, 16)
//                            .overlay()
//                        {
//                            HStack {
//                                Text("저장된 기록이 없습니다.")
//                                    .modifier(regularSubHeadLine(colorName: .gray))
//                                Spacer()
//                            }
//                            .padding(.leading, 45)
//                        }
//                    }
//                }
                .padding(.top, -10)
                .scrollIndicators(.hidden)
                Spacer()
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showNote) {
            ConnectionNoteModal()
                .interactiveDismissDisabled()
        }
    }
}

struct BasicProfile: View {
    // 데이터 연동 부분
    let name: String?
    let company: String?
    let job: String?
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(.gray)     // 추후 색깔 변경 필요
                .frame(width: 36, height: 5)
                .padding(.top, 5)
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    if let name = name, let company = company, let job = job {
                        Text("\(name)")
                            .modifier(boldTitle1(colorName: Fontcolor.fontBlack.colorName))
                        HStack {
                            Text("\(company) ﹒ \(job)")
                                .modifier(regularBody(colorName: Fontcolor.fontGray.colorName))
                        }
                    }
                }
                .padding(.leading, 17)
                .padding(.top, 26)
                
                Spacer()
            }
        }
    }
}

struct ContactButtons: View {
    @State private var pushMessage = false
    @State private var pushCall = false
    @State private var pushMail = false
    
    @State private var noMessageAlert = false
    @State private var noCallAlert = false
    @State private var noMailAlert = false
    @State private var noLinkAlert = false
    
    // 개인정보 - 입력 필요
    let phoneNum: String
    let mailAdd: String
    let linkedinLink: String
    
    var body: some View {
        ZStack {
            Image("contactButtonBackground")
                .resizable()
                .scaledToFit()
                .frame(height: 72)
                .fixedSize()
            HStack(spacing: 2.5) {
                Button {
                    if phoneNum != "" {
                        pushMessage.toggle()
                    } else {
                        noMessageAlert.toggle()
                    }
                } label: {
                    Circle()
                        .frame(width: 58)
                        .foregroundColor(.white)
                        .opacity(pushMessage || noMessageAlert ? 1 : 0)
                        .overlay(
                            Image(systemName: "message")
                                .modifier(regularTitle1(colorName: pushMessage || noMessageAlert ? Fontcolor.fontGray.colorName : Fontcolor.fontWhite.colorName))
                        )
                }
                .confirmationDialog("메시지 보내기", isPresented: $pushMessage) {
                    Link("메시지 보내기", destination: URL(string: "sms:\(phoneNum)")!)
                    Button {
                        copyToClipboard(text: phoneNum)
                    } label: {
                        Text("복사")
                    }
                    Button(role: .cancel, action: {
                    }, label: {
                        Text("취소")
                    })
                }
                .alert("등록된 연락처가 없습니다.", isPresented: $noMessageAlert)  {
                    Button(role: .cancel, action: {
                        noMessageAlert.toggle()
                    }, label: {
                        Text("확인")
                    })
                }
                
                Button {
                    if phoneNum != "" {
                        pushCall.toggle()
                    } else {
                        noCallAlert.toggle()
                    }
                } label: {
                    Circle()
                        .frame(width: 58)
                        .foregroundColor(.white)
                        .opacity(pushCall || noCallAlert ? 1 : 0)
                        .overlay(
                            Image(systemName: "phone")
                                .modifier(regularTitle1(colorName: pushCall || noCallAlert ? Fontcolor.fontGray.colorName : Fontcolor.fontWhite.colorName))
                        )
                }
                .confirmationDialog("전화걸기", isPresented: $pushCall) {
                    Link("전화걸기", destination: URL(string: "tel:\(phoneNum)")!)
                    Button {
                        copyToClipboard(text: phoneNum)
                    } label: {
                        Text("복사")
                    }
                    Button(role: .cancel, action: {
                    }, label: {
                        Text("취소")
                    })
                }
                .alert("등록된 연락처가 없습니다.", isPresented: $noCallAlert)  {
                    Button(role: .cancel, action: {
                        noCallAlert.toggle()
                    }, label: {
                        Text("확인")
                    })
                }
                
                Button {
                    if mailAdd != "" {
                        pushMail.toggle()
                    } else {
                        noMailAlert.toggle()
                    }
                } label: {
                    Circle()
                        .frame(width: 58)
                        .foregroundColor(.white)
                        .opacity(pushMail || noMailAlert ? 1 : 0)
                        .overlay(
                            Image(systemName: "envelope")
                                .modifier(regularTitle1(colorName: pushMail || noMailAlert ? Fontcolor.fontGray.colorName : Fontcolor.fontWhite.colorName))
                        )
                }
                .confirmationDialog("이메일 보내기", isPresented: $pushMail) {
                    Link("이메일 보내기", destination: URL(string: "mailto:\(mailAdd)")!)
                    Button {
                        copyToClipboard(text: mailAdd)
                    } label: {
                        Text("복사")
                    }
                    Button(role: .cancel, action: {
                    }, label: {
                        Text("취소")
                    })
                }
                .alert("등록된 이메일이 없습니다.", isPresented: $noMailAlert)  {
                    Button(role: .cancel, action: {
                        noMailAlert.toggle()
                    }, label: {
                        Text("확인")
                    })
                }
                
                if linkedinLink != "" {
                    Link(destination: URL(string: linkedinLink)!) {
                        Circle()
                            .frame(width: 58)
                            .opacity(0)
                            .overlay(
                                Image("linkedInLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .colorMultiply(Fontcolor.fontWhite.colorName)
                                    .frame(width: 24)
                            )
                    }
                } else {
                    Button {
                        noLinkAlert.toggle()
                    } label: {
                        Circle()
                            .frame(width: 58)
                            .foregroundColor(.white)
                            .opacity(noLinkAlert ? 1 : 0)
                            .overlay(
                                Image("linkedInLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .colorMultiply(noLinkAlert ? Fontcolor.fontGray.colorName : Fontcolor.fontWhite.colorName)
                                    .frame(width: 24)
                            )
                    }
                    .alert("등록된 링크가 없습니다.", isPresented: $noLinkAlert)  {
                        Button(role: .cancel, action: {
                            noLinkAlert.toggle()
                        }, label: {
                            Text("확인")
                        })
                    }
                }
            }
        }
    }
    
    private func copyToClipboard(text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
}

//struct ConnectionMemoItem: View {   // CustomDetailList로 대체 예정
//    let title: String
//    let meetingDay: String
//    let summary: String
//
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 8) {
//                Text("\(title)")
//                    .modifier(semiBoldCallout(colorName: Fontcolor.fontBlack.colorName))    // 컬러 변경 필요
//                HStack(spacing: 11) {
//                    Text("\(meetingDay)")
//                        .modifier(regularSubHeadLine(colorName: Fontcolor.fontGray.colorName))
//                    Text("\(summary)")
//                        .modifier(regularSubHeadLine(colorName: Fontcolor.fontGray.colorName))
//                }  // 컬러 변경 필요
//            }
//            .padding(.leading, 29)
//
//            Spacer()
//        }
//        .frame(width: 361, height: 62)
//        .background(.white)
//        .clipShape(RoundedRectangle(cornerRadius: 12))
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .strokeBorder(Color.gray, lineWidth: 1)
//        )
//    }
//}

//import CoreData
//
//struct ConnectionProfileModal_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = NSPersistentContainer(name: "DotsDataContainer").viewContext
//        //Test data
//        let newEntity = NetworkingPersonEntity(context: context)
//        newEntity.peopleID = UUID()
//        newEntity.profileImageIndex = Int16(2)
//        newEntity.name = "김철수"
//        newEntity.company = "apple"
//        newEntity.contanctNum = "010-1111-2222"
//        newEntity.email = "kkkk@mail.com"
//        newEntity.job = "Dev"
//        newEntity.linkedIn = "linkedin.com/lol"
//
//        return ConnectionProfileModal(person: newEntity)
//    }
//}
