//
//  ConnectionProfileModal.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/19.
//

import SwiftUI

struct ConnectionProfileModal: View {
    var body: some View {
        ZStack {
            Color.green
            Text("인맥 프로필이 나타나는 모달입니다.")
        }
        .ignoresSafeArea()
    }
}

struct ConnectionProfileModal_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionProfileModal()
    }
}
