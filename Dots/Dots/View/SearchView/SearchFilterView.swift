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
    @State var keyName: String = ""
    @State var companyName: String = "삼성"
    @State var jobName: String = "ios 개발"
    @State var strengthName: String = "재능"
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Button {
                    type = "회사"
                    isSheetOn = true
                    keyName = "recentCompany"
                } label: {
                    SearchFilterListRow(companyName: $companyName, jobName: $jobName, strengthName: $strengthName, type: "회사",   imageName: "building.2.fill")
                }
                .padding(.top, 24)
                
                Button {
                    type = "직무"
                    keyName = "recentJob"
                    isSheetOn = true
                    
                } label: {
                    SearchFilterListRow(companyName: $companyName, jobName: $jobName, strengthName: $strengthName,
                                        type: "직무", imageName: "person.text.rectangle.fill")
                }
                
                Button {
                    type = "강점"
                    keyName = "recentStrength"
                    isSheetOn = true
                } label: {
                    SearchFilterListRow(companyName: $companyName, jobName: $jobName, strengthName: $strengthName,type: "강점", imageName: "chart.bar.fill")
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
                SearchFilterDetailView(isSheetOn: $isSheetOn, companyName: $companyName ,jobName: $jobName, strengthName: $strengthName, type: type, keyName: keyName)
            }
            
        }
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView()
    }
}
