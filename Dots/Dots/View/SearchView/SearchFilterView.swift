//
//  SearchFilterView.swift
//  Dots
//
//  Created by 정승균 on 2023/07/22.
//

import SwiftUI

struct SearchFilterView: View {
    @State var isSheetOn: Bool = false
    @State var type: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Button {
                    type = "회사"
                    isSheetOn = true
                } label: {
                    SearchFilterListRow(type: "회사")
                }
                .padding(.top, 24)

                Button {
                    type = "직무"
                    isSheetOn = true
                } label: {
                    SearchFilterListRow(type: "직무")
                }
                
                Button {
                    type = "강점"
                    isSheetOn = true
                } label: {
                    SearchFilterListRow(type: "강점")
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
            .sheet(isPresented: $isSheetOn) {
                SearchFilterDetailView(isSheetOn: $isSheetOn, type: type)
            }

        }
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView()
    }
}
