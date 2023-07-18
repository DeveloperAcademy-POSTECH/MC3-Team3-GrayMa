//
//  contactsMemoField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/18.
//

import SwiftUI

struct contactsMemoField: View {
    
    
    //모달 컨트롤
    @State private var modalVissable = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .strokeBorder(Color.gray, lineWidth: 1)
            .onTapGesture{ modalVissable = true }
            .sheet(isPresented: $modalVissable) { ModalView()}
        .frame(width: 361, height: 56)
    }
    
    
}

//임시 모달뷰
struct memoModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("This is a modal view")
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}


struct contactsMemoField_Previews: PreviewProvider {
    static var previews: some View {
        contactsMemoField()
    }
}
