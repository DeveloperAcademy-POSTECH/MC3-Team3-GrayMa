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
                        .foregroundColor(.green)
                        .frame(height: 203)
                        .gesture(
                            // TODO: 세로 제스쳐만 인식하도록 개선
                            DragGesture()
                                .onEnded{ _ in showProfile.toggle() }
                    )
                    
                    Text("기본 프로필 공간입니다.")
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showProfile) {
            ConnectionProfileModal()
        }
    }
}

struct ConnectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionDetailView()
    }
}
