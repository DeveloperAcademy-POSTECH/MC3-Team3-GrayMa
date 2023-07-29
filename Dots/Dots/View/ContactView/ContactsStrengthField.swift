//
//  ContactsStrengthField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsStrengthField: View {
    
    //StrengthField가 가져야할 변수
    @Binding var UserInputStrengthArr : [String]
    
    @State var UserInputStrength = ""
    
    //Field 컨트롤 옵션
    @State var modalControl = false
    
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.theme.gray
    @State var fieldColor = Color("bgBlank")
    let errorMessage = "최대 6개까지 가능"
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("강점 *")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(fieldColor)
                    .frame(width: 361, height: 56)
                    .onTapGesture { modalControl = true }
                    .sheet(isPresented: $modalControl){
                        AddStrengthSheet(selectedStrength: $UserInputStrengthArr)
                    }
                
                HStack{
                    
                    //돋보기 보양
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    Text("\(UserInputStrength)")
                    
                    Spacer()
                    
                    if !UserInputStrengthArr.isEmpty {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color("AlertGreen"))
                            .frame(width: 24, height: 24)
                            .onAppear{
                                fieldColor = Color.theme.secondary
                            }
                    }
                }
                .frame(width: 340)
            }
            //모달에서 직무가 하나라도 있는지 리턴 받아야함
            Text("\(errorMessage)")
                .foregroundColor(textColor)
                .opacity(inputError ? 1 : 0)
        }
    }
}

//강점 모달뷰
 struct strengthModalView: View {
    @Environment(\.presentationMode) var presentationMode
     @EnvironmentObject var dotsModel: DotsModel
    
    @Binding  var searchTextField : String
    @State private var selectedHistoryList: String = ""
    @State private var searchHistory: [SearchHistoryRowModel] = []
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
//                SearchBar
//                ExistJobList
                Spacer()
            }
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        presentationMode.wrappedValue.dismiss()
                        print("취소 ㄱㄱ")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") {
                        presentationMode.wrappedValue.dismiss()
                        //knowFilter()
                        //                        print("\(type) 타입")
                        //                        print("\(companyName) 회사이름")
                        //                        print("\(jobName)  직무이름")
                        //                        print("\(strengthName) 강점이름" )
                        print("완료 ㄱㄱ")
                    }
                }
            }
            .onAppear {
                
//                searchHistory = loadRecentSearches(keyName: "recentjob")
                
            }
        }
    }
}
