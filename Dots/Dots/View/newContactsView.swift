//
//  newContactsView.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/17.
//

import SwiftUI
import Contacts

struct newContactsView: View {
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    
                    //이미지 추가
                    HStack{
                        Image(systemName: "pencil")
                    }
                    
                    
                }
                
            }
            
        }
    }
}


struct newContactsView_Previews: PreviewProvider {
    static var previews: some View {
        newContactsView()
    }
}
