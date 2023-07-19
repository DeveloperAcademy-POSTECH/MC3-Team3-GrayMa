//
//  ConnectionProfileModal.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/19.
//

import SwiftUI

struct ConnectionProfileModal: View {
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 25) {
                BasicProfile()
                // TODO: 이미지로 된 버튼 코드로 수정하여 개선 필요
                HStack {
                    ZStack {
                        Image("profileImageBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 105)
                        
                        Circle()
                            .frame(width: 88)
                            .foregroundColor(.brown)
                    }
                    Spacer()
                    ZStack {
                        Image("contactButtonBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 72)
                    }
                    .padding(.trailing, 15)
                }
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 361, height: 44)
                        .overlay{
                            HStack {
                                Image(systemName: "square.and.pencil")
                                Text("새로운 기록 작성")
                            }
                            .modifier(semiBoldBody(colorName: Fontcolor.fontWhite.colorName))
                        }
                }
                
                ScrollView {
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                    ConnectionMemoItem(meetingDay: "2023년 7월 19일", summary: "우리집 고양이 기여워~~~~")
                }
                .padding(.top, -10)
                .scrollIndicators(.hidden)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct ConnectionMemoItem: View {
    var meetingDay: String
    var summary: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(meetingDay)")
                    .modifier(semiBoldCallout(colorName: Fontcolor.fontBlack.colorName))    // 컬러 변경 필요
                Text("\(summary)")
                    .modifier(regularSubHeadLine(colorName: Fontcolor.fontGray.colorName))  // 컬러 변경 필요
            }
            .padding(.leading, 29)
            
            Spacer()
        }
        .frame(width: 361, height: 62)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.gray, lineWidth: 1)
        )
    }
}

struct ConnectionProfileModal_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionProfileModal()
    }
}
