//
//  ContactsListRow.swift
//  Dots
//
//  Created by 정승균 on 2023/07/27.
//

import SwiftUI

struct ContactsListRow: View {
    let person: NetworkingPersonEntity
    
    @State private var resetSwipe: Bool = false
    @State private var trashPresented: Bool = false
    @State var isDeleteAlertOn = false
    
    @EnvironmentObject var dotsModel: DotsModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.theme.bgPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 84)
            .overlay() {
                SwipeItemView(content: {
                    NavigationLink {
                        ConnectionDetailView(person: person)
                    } label: {
                        CustomConnectionList(entity: person)
                        
                    }
                }, right: {
                    HStack(spacing: 0) {
                        Button(action: {
                            print("삭제 완")
                            isDeleteAlertOn = true
                        }, label: {
                            Rectangle()
                                .fill(.red)
                                .cornerRadius(12, corners: .topRight)
                                .cornerRadius(12, corners: .bottomRight)
                                .overlay(){
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 17))
                                        .foregroundColor(.white)
                                }
                        })
                    }
                }, itemHeight: 84, resetSwipe: $resetSwipe, trashPresented: $trashPresented)
            }
            .overlay(content: {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.theme.gray5, lineWidth: 2)
            })
            .cornerRadius(12, corners: .allCorners)
            .alert("인맥을 삭제하겠습니까?", isPresented: $isDeleteAlertOn, actions: {
                Button("취소", role: .cancel) {
                    isDeleteAlertOn = false
                }
                
                Button("삭제", role: .destructive) {
                    withAnimation {
                        dotsModel.deleteConnection(person: person)
                    }
                    isDeleteAlertOn = false
                }
                .foregroundColor(.theme.alertRed)
            }, message: {
                Text("이 사람과 관련된 모든 정보가 삭제됩니다.")
            })
    }
}
