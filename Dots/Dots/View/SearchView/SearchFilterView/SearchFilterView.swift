//
//  SearchFilterListRow.swift
//  Dots
//
//  Created by 정승균 on 2023/07/22.
//

import SwiftUI

struct SearchFilterView: View {
    @State private var isSheetOn: Bool = false
    @State private var type: String = ""
    @State private var keyName: String = ""
    @State private var companyName: String = ""
    @State private var jobName: String = ""
    @State private var strengthName: String = ""
    
    @Binding var isFilterd: Bool
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Button {
                    type = "회사"
                    print(type)
                    isSheetOn = true
                    keyName = "recentCompany"
                } label: {
                    SearchFilterListRow(companyName: $companyName, jobName: $jobName, strengthName: $strengthName, isSheetOn: $isSheetOn, type: "회사",   imageName: "building.2.fill")
                }
                .padding(.top, 24)
                
                Button {
                    type = "직무"
                    keyName = "recentJob"
                    isSheetOn = true
                    
                } label: {
                    SearchFilterListRow(companyName: $companyName, jobName: $jobName, strengthName: $strengthName,
                                        isSheetOn: $isSheetOn, type: "직무", imageName: "person.text.rectangle.fill")
                }
                
                Button {
                    type = "강점"
                    keyName = "recentStrength"
                    isSheetOn = true
                } label: {
                    SearchFilterListRow(companyName: $companyName, jobName: $jobName, strengthName: $strengthName,isSheetOn: $isSheetOn, type: "강점", imageName: "chart.bar.fill")
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .tint(.black)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("재설정") {
                        companyName = ""
                        jobName = ""
                        strengthName = ""
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("적용") {
                        isFilterd = true
                    }
                }
            }
            .sheet(isPresented: $isSheetOn) {
                SearchFilterDetailView(isSheetOn: $isSheetOn, companyName: $companyName ,jobName: $jobName, strengthName: $strengthName, type: $type, keyName: $keyName)
            }
            
        }
    }
}

//struct SearchFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchFilterView()
//    }
//}
