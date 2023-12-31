//
//  CustomList.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.

import SwiftUI

struct CustomList: View {
    @EnvironmentObject var dotsModel: DotsModel
    @State private var isNavigation = false
    @State var isDeleteAlert: Bool = false
    @State private var resetSwipe: Bool = false
    @State private var trashPresented: Bool = false
    
    let images = StrengthLevelImage.allCases
    var entity: MyStrengthEntity
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.theme.gray5, lineWidth: 1.5)
            .foregroundColor(.theme.bgPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 84)
            .background(.ultraThinMaterial)
            .overlay() {
                SwipeItemView(content: {
                    HStack {
                        NavigationLink {
                            MyStrengthDetailView(selectedLevel: Int(entity.strengthLevel), myStrengthEntity: entity)
                        }label: {
                            HStack(alignment: .center){
                                Image(StrengthLevelImage.allCases[Int(entity.strengthLevel)].rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36,height: 36)
                                    .padding(.leading,22)
                                
                                Text(entity.ownStrength?.strengthName ?? "이름")
                                    .modifier(semiBoldSubHeadLine(colorName: .theme.gray5Dark))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding(.leading, 12)
                                    .padding(.trailing, 13)
                                
                                if let numberOfNotes = entity.notes?.count, numberOfNotes > 0 {
                                    Text("\(numberOfNotes)")
                                        .modifier(mediumCaption1(colorName: .theme.text))
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 2)
                                        .background(Color.theme.secondary)
                                        .cornerRadius(4, corners: .allCorners)
                                }
                                
                                Spacer()
                            }

                        }
                  
                    }

           
                }, right: {
                    HStack(spacing: 0) {
                        Button(action: {
                            isDeleteAlert = true
                        }, label: {
                            Rectangle()
                                .fill(.red)
                                .cornerRadius(12, corners: .topRight)
                                .cornerRadius(12, corners: .bottomRight)
                                .overlay(){
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.white)
                                        .offset(x: -2)
                                }
                        })
                    }
                }, itemHeight: 84, resetSwipe: $resetSwipe, trashPresented: $trashPresented)
            }
            .cornerRadius(12, corners: .allCorners)
            .alert("이 강점을 삭제하겠습니까?", isPresented: $isDeleteAlert) {
                HStack {
                    Button("취소",role: .cancel) {
                        isDeleteAlert = false
                    }
                    Button("삭제",role: .destructive) {
                        isDeleteAlert = false
                        dotsModel.deleteMyStrength(myStrength: entity)
                    }
                }
            } message: {
                Text("강점과 강점 기록들이 모두 삭제됩니다.")
            }
    }
}
