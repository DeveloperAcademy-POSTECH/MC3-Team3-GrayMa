//
//  CustomList.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//
// MARK: 이전 커스텀 리스트
//        RoundedRectangle(cornerRadius: 12)
//            .foregroundColor(.white)
//            .frame(maxWidth: .infinity)
//            .frame(height: 84)
//
//            .shadow(radius: 2)
//            .overlay()
//        {
//            HStack(alignment: .center){
//                Image(StrengthLevelImage.allCases[Int(entity.strengthLevel)].rawValue)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 36,height: 36)
//                    .padding(.leading,22)
//                Text(entity.ownStrength?.strengthName ?? "이름")
//                    .font(.system(size: 17,weight: .semibold))
//                    .padding(.leading,12)
//                Spacer()
//                NavigationLink(destination: EmptyView()) {
//                    Text("\(Image(systemName: "chevron.right"))")
//                        .font(.system(size: 15, weight: .regular))
//                        .padding(.trailing, 14)
//                }
//            }
//        }
//        .padding(.top, 10)
//        .padding(.horizontal,16)

import SwiftUI

enum StrengthLevelImage: String, CaseIterable {
    case weakDot
    case moderateDot
    case strongDot
}

struct CustomList: View {
    @EnvironmentObject var dotsModel: DotsModel
    @State private var isNavigation = false
    var entity: MyStrengthEntity
    
    var body: some View {
        HStack{
            SwipeItemView(content: {
                HStack {
                    NavigationLink {
                        MyStrengthDetailView(myStrengthEntity: entity)
                    }label: {
                        HStack(alignment: .center){
                            Image(StrengthLevelImage.allCases[Int(entity.strengthLevel)].rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36,height: 36)
                                .padding(.leading,22)
                            Text(entity.ownStrength?.strengthName ?? "이름")
                                .font(.system(size: 17,weight: .semibold))
                                .padding(.leading,12)
                            Spacer()
                        }
                    }
                    
                }
                
                
                
            }, right: {
                HStack(spacing: 0) {
                    Button(action: {
                        print("삭제 완")
                        dotsModel.deleteMyStrength(myStrength: entity)
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
            }, itemHeight: 84)
            
        }
        
    }
}
