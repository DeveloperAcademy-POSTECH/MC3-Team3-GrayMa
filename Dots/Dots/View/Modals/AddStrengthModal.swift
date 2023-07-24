//
//  AddStrengthModal.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct AddStrengthModal: View {
    @EnvironmentObject var dotsModel: DotsModel
    @Binding var strengthName : String
    @Binding var pagenum: Int
    @State var isError: Bool = false
    @State var isKeyboardVisible = false
    @State var tappedNum = 0
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Text("강점 추가")
                        .modifier(semiBoldTitle3(colorName: .theme.gray5Dark))
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 23)
                .padding(.bottom, 31)
                
                RoundedRectangle(cornerRadius: 40)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .shadow(radius: 1)
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
                                .onChange(of: strengthName) {
                                    newvalue in if strengthName.count > 20 {
                                        strengthName = String(strengthName.prefix(20))
                                    }
                                }
                            
                            Spacer()
                            
                            Text("\(strengthName.count)/20")
                                .modifier(regularCallout(colorName: .theme.gray))
                            
                            Button {
                                strengthName = ""
                            } label: {
                                Text("\(Image(systemName: "x.circle.fill"))")
                                    .foregroundColor(.theme.disabled)
                                    .frame(width: 24,height: 24)
                                    .padding(.trailing,15)
                            }
                        }
                    }
                
                Spacer()
                
                // 키보드가 나타났을때에는 ScrollView가 나타남
                if isKeyboardVisible {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray,lineWidth:1)
                            .foregroundColor(.white)
                        // db에 있는 값들을 리스트로 띄움
                        ScrollView {
                            //sample에 filter를 걸어서 포함 되는 단어만 띄우는 반복문 만약 필터에 해당 되는 것이 없다면 직접 입력하라고 리턴
                            if dotsModel.strength.filter({ $0.strengthName!.contains(strengthName) || strengthName.isEmpty }).isEmpty {
                                HStack {
                                    Button {
                                        _ = dotsModel.addStrength(name: strengthName)
                                    } label: {
                                        Label("직접 추가하기", systemImage: "plus.circle.fill")
                                            .padding(.top, 18)
                                            .padding(.leading, 44)
                                            .modifier(regularCallout(colorName: .theme.gray))
                                    }
                                    
                                    Spacer()
                                }
                            } else {
                                VStack(spacing: 0) {
                                    ForEach(dotsModel.strength.filter{ $0.strengthName!.contains(strengthName) || strengthName == "" }, id:\.self) {
                                        filteredStrength in
                                        StrengthList(strength: filteredStrength.strengthName!, strengthName: $strengthName)
                                    }
                                }
                            }
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.top,10)
                    .frame(height: 200)
                } else {
                    VStack {
                        HStack {
                            SelectBtn(fontWeight: .regular, content: "취소", textColor: .gray, btnColor: .theme.bgBlank, action:{ presentation.wrappedValue.dismiss()})
                            SelectBtn(fontWeight: .bold, content: "다음", textColor: .white, btnColor: .accentColor, action: {
                                if dotsModel.addStrength(name: strengthName) == .redunant {
                                    isError = true
                                } else {
                                    pagenum += 1
                                }
                            })
                            .disabled(strengthName.isEmpty)
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        Spacer()
                            .frame(height: 50)
                        
                    }
                }
                
                Spacer()
            }
            // MARK: 키보드가 나타났을때를 감지
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
            .allowsTightening(true)
            .padding(.horizontal,16)
            .frame(width: UIScreen.main.bounds.width)
            .alert("중복에러", isPresented: $isError) {
                Button("확인") {
                    isError = false
                }
            } message: {
                Text("이미 나의 강점에 추가된 강점이거나, 존재하는 강점입니다.")
            }
        }
    }
}
