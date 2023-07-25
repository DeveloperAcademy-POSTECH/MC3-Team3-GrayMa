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
    @State private var showCommon = false
    @State private var addStrength = false
    
    let person: NetworkingPersonEntity
    
    let tempStrenth = ["논리적 사고", "User Test", "SwiftUI", "커뮤니케이션"]
    
    init(person: NetworkingPersonEntity) {
        self.person = person
        
        // 네비게이션바를 투명하게 - 스크롤시에도 색상 유지
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ZStack {
            Color.theme.bgMain
            
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: 280)
                    
                    VStack {    // 강점 목록 및 비교
                        HStack {
                            Text("강점")
                                .modifier(semiBoldTitle3(colorName: Color.theme.gray5Dark))

                            Toggle(isOn: $showCommon) {
                                Text("공통점")
                                    .modifier(regularCallout(colorName: Color.theme.text))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color.theme.primary))
                        }

                        // TODO: 강점 목록 캡슐 자동 레이아웃 -> 현재 임시 뷰(Scroll)
                        ScrollView(.horizontal) {
                            HStack {
                                Button {
                                    addStrength.toggle()
                                } label: {
                                    Circle()
                                        .frame(width: 40)
                                        .foregroundColor(Color.theme.secondary)
                                        .overlay{
                                            Image(systemName: "plus")
                                                .modifier(regularBody(colorName: Color.theme.text))
                                        }
                                }
                                ForEach(tempStrenth, id: \.self) { strength in
                                    StrengthName(strengthText: strength)
                                }
//                                if let strengthSet = person.strengthSet?.allObjects as? [StrengthEntity] {
//                                    ForEach(strengthSet, id: \.self) { strength in
//                                        StrengthName(strengthText: strength.strengthName)
//                                    }
//                                }
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("상대 기록")
                                .modifier(semiBoldTitle3(colorName: Color.theme.gray5Dark))

                            Spacer()
                            
                            Button {
                                showNote.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.theme.primary)
                                    .font(.system(size: 22))
                            }
                        }
                        
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
                                .overlay(
                                    HStack {
                                        Text("저장된 기록이 없습니다.")
                                            .modifier(regularBody(colorName: Color.theme.gray))
                                        Spacer()
                                    }
                                    .padding(.leading, 45)
                                
                                )
                        }
                        Spacer()
                    }
                    .padding(.top, 62)
                }
                .padding()
            }
            .scrollIndicators(.never)
            
            BackgroundCircle()
                .foregroundColor(Color.theme.secondary)
                .ignoresSafeArea()
            
            if let name = person.name, let company = person.company, let job = person.job {
                VStack(spacing: 16) {   // 상단부 개인 정보
                    HStack {    // 기본정보
                        VStack(alignment: .leading, spacing: 16) {
                            Text("\(name)")
                                .modifier(boldTitle1(colorName: Color.theme.gray5Dark))
                            HStack {
                                Text("\(company) ﹒ \(job)")

                            }
                        }
                        Spacer()
                    }
                    
                    HStack {    // 이미지 및 연락 버튼
                        Circle()
                            .frame(width: 88)
                            .foregroundColor(Color.theme.disabled)
                            .overlay{
                                Text("\(convertUserName(name: name))")
                                    .modifier(boldLargeTitle(colorName: Color.theme.text))
                            }
                        
                        Spacer()
                        
                        ContactButtons(phoneNum: person.contanctNum!, mailAdd: person.email!, linkedinLink: person.linkedIn!)
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                }
                .padding()
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
//        .sheet(isPresented: $addStrength)
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
    
    func convertUserName(name: String) -> String {
        var modifiedName = name
        
        if !modifiedName.isEmpty {
            modifiedName.removeFirst()
        }
        
        return modifiedName
    }
}

struct StrengthName: View {
    let strengthText: String?
    
    var body: some View {
        Text(strengthText ?? "")
            .modifier(regularCallout(colorName: Color.theme.text))
            .padding(9)
            .padding(.horizontal, 9.5)
            .background(Color.theme.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .strokeBorder(Color.theme.secondary, lineWidth: 1)
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
                        .opacity(0)
                        .overlay(
                            Image(systemName: "message")
                                .modifier(regularTitle1(colorName: Color.theme.bgPrimary))
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
                        .opacity(0)
                        .overlay(
                            Image(systemName: "phone")
                                .modifier(regularTitle1(colorName: Color.theme.bgPrimary))
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
                        .opacity(0)
                        .overlay(
                            Image(systemName: "envelope")
                                .modifier(regularTitle1(colorName: Color.theme.bgPrimary))
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
                                    .colorMultiply(Color.theme.bgPrimary)
                                    .frame(width: 24)
                            )
                    }
                } else {
                    Button {
                        noLinkAlert.toggle()
                    } label: {
                        Circle()
                            .frame(width: 58)
                            .opacity(0)
                            .overlay(
                                Image("linkedInLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .colorMultiply(Color.theme.bgPrimary)
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

struct BackgroundCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 317))
        path.addQuadCurve(to: CGPoint(x: UIScreen.main.bounds.width, y: 317), control: CGPoint(x: UIScreen.main.bounds.width / 2, y: 360))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        path.closeSubpath()
        
        return path
    }
}