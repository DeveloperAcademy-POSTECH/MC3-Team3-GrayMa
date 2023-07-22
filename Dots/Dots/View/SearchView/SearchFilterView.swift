//
//  SearchFilterView.swift
//  Dots
//
//  Created by 정승균 on 2023/07/22.
//

import SwiftUI

struct SearchFilterView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                NavigationLink {
                    Text("거기")
                } label: {
                    SearchFilterListRow()
                }
                .padding(.top, 24)

                NavigationLink {
                    Text("거기")
                } label: {
                    SearchFilterListRow()
                }
                
                NavigationLink {
                    Text("거기")
                } label: {
                    SearchFilterListRow()
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .tint(.black)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("재설정") {
                        print("초기화 기능인듯?")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("적용") {
                        print("필터 적용")
                    }
                }
            }

        }
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView()
    }
}
