//
//  contactsMemoField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/18.
//

import SwiftUI

struct contactsMemo: View {
    
    @State private var memoDate = Date()
    @State private var memoText = ""
    
    //모달 컨트롤
    @State private var modalVissable = false
    
    var body: some View {
        ZStack {
            //기본 컨포넌트
            VStack (alignment: .leading){
                Text("제목")
                    .frame(width: 350 ,alignment: .leading)
                Text("내용")
                    .frame(width: 350, alignment: .leading)
            }
            
            RoundedRectangle(cornerRadius: 40)
                .strokeBorder(Color.gray, lineWidth: 1)
                //클릭시 모달 소환
                .onTapGesture{ modalVissable = true }
                .sheet(isPresented: $modalVissable) {
                    //모달 네비게이션뷰
                    NavigationView{
                        memoModalView(modalMemoText: memoText)
                        //모달의 취소, 저장
                            .navigationBarItems(leading:Button("취소"){modalVissable = false}, trailing: Button("저장"){ print("\(memoDate)")})
                    }
                }
            .frame(width: 361, height: 62)
        }
    }
}

//임시 모달뷰
struct memoModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var modalMemoDate = Date()
    @State var modalMemoText : String
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("상대에 대해 남기고 싶은 점을 자유롭게 기록해주세요.", text: $modalMemoText)
            }
        }
        .navigationBarTitle(Text("Custom Title \u{F0026}"))
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct contactsMemoField_Previews: PreviewProvider {
    static var previews: some View {
        contactsMemo()
    }
}
