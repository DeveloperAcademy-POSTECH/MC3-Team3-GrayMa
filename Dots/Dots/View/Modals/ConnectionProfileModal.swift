//
//  ConnectionProfileModal.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/20.
//

import SwiftUI

struct ConnectionProfileModal: View {
    // 데이터 연동 필요 - 개인정보(NetworkingPersonEntity)
    let profileIdx = 1
    let phoneNum = "010-0000-0000"
    let mailAdd = "apple@academy.com"
    let linkedinLink = "http://linkedin.com/in/upub"
    
    // 데이터 연동 필요 - 메모(NetworkingNoteEntity)
    
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 25) {
                BasicProfile()
                HStack {
                    ZStack {
                        Image("profileImageBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 105)
                        
                        Image("user_default_profile \(profileIdx)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 88)
                    }
                    Spacer()
                    ContactButtons(phoneNum: "\(phoneNum)", mailAdd: "\(mailAdd)", linkedinLink: "\(linkedinLink)")
                        .padding(.trailing, 15)
                }
                
                Button {
                    
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
                
                ScrollView {
                    ConnectionMemoItem(title: "Landing page", meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                }
                .padding(.top, -10)
                .scrollIndicators(.hidden)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct BasicProfile: View {
    // 데이터 연동 부분
    let name = "신채은"
    let company = "애플 디벨로퍼 아카데미"
    let job = "iOS 개발"
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(.gray)     // 추후 색깔 변경 필요
                .frame(width: 36, height: 5)
                .padding(.top, 5)
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("\(name)")     // 이름 데이터 연동 필요
                        .modifier(boldTitle1(colorName: Fontcolor.fontBlack.colorName))
                    HStack {
                        Text("\(company) ﹒ \(job)")    // 직장, 직무 데이터 연동 필요
                            .modifier(regularBody(colorName: Fontcolor.fontGray.colorName))
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
                    pushMessage.toggle()
                } label: {
                    Circle()
                        .frame(width: 58)
                        .foregroundColor(.white)
                        .opacity(pushMessage ? 1 : 0)
                        .overlay(
                            Image(systemName: "message")
                                .modifier(regularTitle1(colorName: pushMessage ? Fontcolor.fontGray.colorName : Fontcolor.fontWhite.colorName))
                        )
                }
                .confirmationDialog("메시지 보내기", isPresented: $pushMessage) {
                    Button {
                        // 메시지 연결 필요
                    } label: {
                        Text("메시지 보내기")
                    }
                    Button {
                        // 전화 번호 복사 기능
                    } label: {
                        Text("복사")
                    }
                    Button(role: .cancel, action: {
                    }, label: {
                        Text("취소")
                    })
                }
                
                Button {
                    pushCall.toggle()
                } label: {
                    Circle()
                        .frame(width: 58)
                        .foregroundColor(.white)
                        .opacity(pushCall ? 1 : 0)
                        .overlay(
                            Image(systemName: "phone")
                                .modifier(regularTitle1(colorName: pushCall ? Fontcolor.fontGray.colorName : Fontcolor.fontWhite.colorName))
                        )
                }
                .confirmationDialog("전화걸기", isPresented: $pushCall) {
                    Button {
                        // 전화 연결 필요
                    } label: {
                        Text("전화걸기")
                    }
                    Button {
                        // 전화 번호 복사 기능
                    } label: {
                        Text("복사")
                    }
                    Button(role: .cancel, action: {
                    }, label: {
                        Text("취소")
                    })
                }
                
                Button {
                    pushMail.toggle()
                } label: {
                    Circle()
                        .frame(width: 58)
                        .foregroundColor(.white)
                        .opacity(pushMail ? 1 : 0)
                        .overlay(
                            Image(systemName: "envelope")
                                .modifier(regularTitle1(colorName: pushMail ? Fontcolor.fontGray.colorName : Fontcolor.fontWhite.colorName))
                        )
                }
                .confirmationDialog("이메일 보내기", isPresented: $pushMail) {
                    Button {
                        // 전화 연결 필요
                    } label: {
                        Text("이메일 보내기")
                    }
                    Button {
                        // 전화 번호 복사 기능
                    } label: {
                        Text("복사")
                    }
                    Button(role: .cancel, action: {
                    }, label: {
                        Text("취소")
                    })
                }
                
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
            }
        }
    }
}

struct ConnectionMemoItem: View {
    let title: String
    let meetingDay: String
    let summary: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(title)")
                    .modifier(semiBoldCallout(colorName: Fontcolor.fontBlack.colorName))    // 컬러 변경 필요
                HStack(spacing: 11) {
                    Text("\(meetingDay)")
                        .modifier(regularSubHeadLine(colorName: Fontcolor.fontGray.colorName))
                    Text("\(summary)")
                        .modifier(regularSubHeadLine(colorName: Fontcolor.fontGray.colorName))
                }  // 컬러 변경 필요
            }
            .padding(.leading, 29)
            
            Spacer()
        }
        .frame(width: 361, height: 62)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.gray, lineWidth: 1)
        )
    }
}

struct ConnectionProfileModal_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionProfileModal()
    }
}
