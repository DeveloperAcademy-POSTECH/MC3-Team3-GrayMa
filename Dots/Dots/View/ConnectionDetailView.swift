//
//  ConnectionDetailView.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/19.
//

import SwiftUI

struct ConnectionDetailView: View {
    @State private var showProfile = false
    
    var body: some View {
        ZStack {
            Color.yellow
            Text("인맥 디테일 뷰입니다.")
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(height: 203)
                        .gesture(
                            // TODO: 세로 제스쳐만 인식하도록 개선 필요
                            DragGesture()
                                .onEnded{ _ in showProfile.toggle() }
                        )
                        .overlay(
                            VStack {
                                BasicProfile()
                                Spacer()
                            }
                        )
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showProfile) {
            ConnectionProfileModal()
        }
    }
}

struct BasicProfile: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(.gray)     // 추후 색깔 변경 필요
                .frame(width: 36, height: 5)
                .padding(.top, 5)
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("신채은")     // 이름 데이터 연동 필요
                        .modifier(boldTitle1(colorName: Fontcolor.fontBlack.colorName))
                    HStack {
                        Text("애플 디벨로퍼 아카데미 ﹒ iOS 개발")    // 직장, 직무 데이터 연동 필요
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

struct ConnectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionDetailView()
    }
}
