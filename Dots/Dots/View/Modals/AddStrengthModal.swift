//
//  AddStrengthModal.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct AddStrengthModal: View {
    var samples: [String] = ["UIkit","SwiftUI","UI구현","샘플입니다","검색어에안떠야해요"]
    @EnvironmentObject var dotsModel: DotsModel
    @Binding var strengthName : String
    @Binding var pagenum: Int
    @State var isError: Bool = false
    @State var isKeyboardVisible = false
    @State var tappedNum = 0
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack{
                Text("강점 추가")
                    .font(.system(.title3))
                Spacer()
                CloseBtn(btncolor: Fontcolor.fontGray.colorName, action: {presentation.wrappedValue.dismiss()})
            }
            RoundedRectangle(cornerRadius: 40)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .shadow(radius: 2)
                .foregroundColor(.white)
                .overlay() {
                    HStack {
                        Button {
                            print("검색기능 예정")
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                        .padding(.leading,14)
                        TextField("예) 디자인 시스템", text: $strengthName)
                            .onChange(of: strengthName){
                                newvalue in if strengthName.count > 20 {
                                    strengthName = String(strengthName.prefix(20))
                                }
                            }
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .foregroundColor(.blue)
//                                    .frame(height: 40)
//                            )
                        Spacer()
                        Text("\(strengthName.count)/20")
                        Button {
                            strengthName = ""
                        } label: {
                            Text("\(Image(systemName: "x.circle.fill"))")
                                .foregroundColor(.gray)
                                .frame(width: 24,height: 24)
                                .padding(.trailing,15)
                        }
                        
                        
                    }
                }
            if isKeyboardVisible {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray,lineWidth: 0.5)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                    VStack {
                        ScrollView {
                            
                            ForEach(samples.indices, id: \.self) { i in
                                StrengthList(strength: samples[i], strengthName: $strengthName)
                                
                            }
                            Button {
                            } label: {
                                Text("\(Image(systemName: "plus.circle.fill")) 직접 추가하기")
                                    .modifier(regularCallout(colorName: Fontcolor.fontGray.colorName))
                            }
                            
                        }
                     
                    }
                    .padding(.top,18)
                    
                }
            }
            
            else {
                HStack {
                    Spacer()
                    SelectBtn(fontWeight: .regular, content: "이전", textColor: .gray, btnColor: .accentColor, action:{ presentation.wrappedValue.dismiss()})
                    SelectBtn(fontWeight: .bold, content: "다음", textColor: .white, btnColor: .blue,action: {
                        if dotsModel.addStrength(name: strengthName) == .redunant {
                            isError = true
                        } else {
                            pagenum += 1
                        }
                    })
                    .disabled(strengthName.isEmpty)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                isKeyboardVisible = true
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                Notification in isKeyboardVisible = false
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
        .interactiveDismissDisabled()
        .allowsTightening(true)
        .padding(.horizontal,16)
        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
        .fixedSize()
        .alert("중복에러", isPresented: $isError) {
            Button("확인") {
                isError = false
            }
        } message: {
            Text("이미 나의 강점에 추가된 강점이거나, 존재하는 강점입니다.")
        }
    }
}
