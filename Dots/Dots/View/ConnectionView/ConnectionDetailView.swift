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
    @State private var editProfile = false
    
    let person: NetworkingPersonEntity

    init(person: NetworkingPersonEntity) {
        self.person = person

//         네비게이션바를 투명하게 - 스크롤시에도 색상 유지
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.bgMain

                BackgroundCircle(height: 210)
                    .foregroundColor(Color.theme.secondary)
                    .ignoresSafeArea()


                ScrollView {
                    ZStack {
                        BackgroundCircle(height: 120)
                            .foregroundColor(Color.theme.secondary)
                            
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            if let company = person.company, let job = person.job {
                                HStack {
                                    Text("\(company) ﹒ \(job)")
                                        .modifier(regularBody(colorName: Color.theme.text))
                                    
                                    Spacer()
                                }
                                .padding()
                            }
                            Section(header: StickyHeader) {
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

                                    WrappingHStack(alignment: .leading) {
                                        let myStrength = dotsModel.myStrength.map{ $0.ownStrength!.strengthName }

                                        // 실제 DB 연결된 내용
                                        if let strengthSet = person.strengthSet?.allObjects as? [StrengthEntity] {
                                            ForEach(strengthSet, id: \.self) { strength in
                                                let isCommon = myStrength.contains(strength.strengthName ?? "")

                                                StrengthName(showCommon: $showCommon, strengthText: strength.strengthName, isCommon: isCommon)
                                            }
                                        }
                                        
                                        Button {
                                            addStrength.toggle()
                                        } label: {
                                            Circle()
                                                .frame(width: 40)
                                                .foregroundColor(Color.theme.secondary)
                                                .overlay {
                                                    Image(systemName: "plus")
                                                        .modifier(regularBody(colorName: Color.theme.text))
                                                }
                                        }
                                    }
                                }
                                .padding()
                                
                                VStack {    // 노트 추가 및 목록
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
                                .padding()
                                .padding(.top, 46)
                            }
                        }   // LazyVStack
                    }   // ZStack
                    .ignoresSafeArea()
                }
                .scrollIndicators(.never)
            }
        }
        .navigationTitle(person.name!)
        .navigationBarTitleDisplayMode(.large)
        
        .toolbarBackground(Color.theme.secondary, for: .navigationBar)
        
        // MARK: Custom NavigationBar
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton)

        // TODO: 인맥 편집 화면 연결 필요(인맥 등록뷰와 동일)
//        .navigationBarItems(trailing: Button(action: { editProfile.toggle() }, label: { Text("편집") }))
        .navigationBarItems(trailing: NavigationLink(destination: ConnectionProfileEditView(person: person), label: { Text("편집") }))
        .sheet(isPresented: $showNote) {
            CreateNoteModal(entity: person, placeholder: "상대에 대해 남기고 싶은 점을 자유롭게 기록해주세요.")
        }
        .sheet(isPresented: $addStrength) {
            ConnectionAddStrengthModal(person: person)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.4)])
        }
//        .sheet(isPresented: $editProfile) {
//            ConnectionProfileEditView(person: person)
//        }
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
    
    private var StickyHeader: some View {
        ZStack {
            BackgroundCircle(height: 120)
                .foregroundColor(Color.theme.secondary)
            
            HStack {    // 이미지 및 연락 버튼
                // MARK: 이미지 index가 없으면 일단 1번 이미지로 보이도록 임시로 처리 추후 수정 필요
                Image("user_default_profile \(person.profileImageIndex == 0 ? 1 : person.profileImageIndex)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88)
                
                Spacer()
                
                if let phoneNum = person.contanctNum, let mailAdd = person.email, let link = person.linkedIn {
                    ContactButtons(phoneNum: phoneNum, mailAdd: mailAdd, linkedinLink: link)
                }
            }
            .padding()
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
    @Binding var showCommon: Bool
    
    let strengthText: String?
    let isCommon: Bool

    var body: some View {
        if showCommon {
            Text(strengthText ?? "")
                .modifier(regularCallout(colorName: isCommon ? Color.theme.bgPrimary : Color.theme.text))
                .padding(9)
                .padding(.horizontal, 9.5)
                .background(isCommon ? Color.theme.primary : Color.theme.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(isCommon ? Color.theme.primary : Color.theme.secondary, lineWidth: 1)
                )
                .fixedSize()
        } else {
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
    let height: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addQuadCurve(to: CGPoint(x: Int(UIScreen.main.bounds.width), y: height), control: CGPoint(x: Int(UIScreen.main.bounds.width) / 2, y: height + 35))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        path.closeSubpath()
        
        return path
    }
}
