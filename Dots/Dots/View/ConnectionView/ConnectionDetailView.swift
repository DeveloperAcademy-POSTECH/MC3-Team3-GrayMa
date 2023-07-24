//
//  ConnectionDetailView.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/20.
//

import SwiftUI
import UIKit

struct ConnectionDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dotsModel: DotsModel
    @State private var showNote = false
    let person: NetworkingPersonEntity
    
    // 데이터 연동 필요 - 강점(StrengthEntity)
    
    var body: some View {
        ZStack {
            Color.yellow  // 이미지 대체 자리
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
                        .frame(height: 44)
                        .padding(.horizontal)
                        .overlay{
                            HStack {
                                Image(systemName: "square.and.pencil")
                                Text("새로운 기록 작성")
                            }
                            .modifier(semiBoldBody(colorName: Fontcolor.fontWhite.colorName))
                        }
                }
                
                // MARK: - 인맥 노트 리스트
                ScrollView {
                    if let notes = person.networkingNotes?.allObjects as? [NetworkingNoteEntity], !notes.isEmpty {
                        ForEach(notes) { note in
                            ConnectionNoteList(noteEntity: note)
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 62)
                            .padding(.horizontal, 16)
                            .overlay()
                        {
                            HStack {
                                Text("저장된 기록이 없습니다.")
                                    .modifier(regularSubHeadLine(colorName: .gray))
                                Spacer()
                            }
                            .padding(.leading, 45)
                        }
                    }
                }
                .padding(.top, -10)
                .scrollIndicators(.hidden)
                Spacer()
            }
        }
        // MARK: Custom NavigationBar
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton)
        // TODO: 인맥 편집 화면 연결 필요(인맥 등록뷰와 동일)
        .navigationBarItems(trailing: Button(action: {}, label: {Text("편집")}))
        .sheet(isPresented: $showNote) {
            ConnectionNoteModal(connection: person)
                .interactiveDismissDisabled()
        }
    }
    private var BackButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 3) {
                Image(systemName: "chevron.backward")
                Text("인맥관리")
            }
        }
    }
}

struct BasicProfile: View {
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


struct StrenthName: View {
    let strenthText: String?
    
    var body: some View {
        Text(strenthText ?? "")
            .padding(10)
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .background(.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .strokeBorder(Color.gray, lineWidth: 1)
            )
            .fixedSize()
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
