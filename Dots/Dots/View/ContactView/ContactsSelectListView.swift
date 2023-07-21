//
//  ContactsSelectListView.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/20.
//

import SwiftUI
import Contacts

struct ContactsSelectListView: View {
    
    //연락처 가져오는 Arr
    //let store = CNContactStore() //리퀘스트 접근 객체
    var contacts : [CNContact] = []
    
    @State private var selectedMode = 0
    @State var contactList : [String] = []
    
    var body: some View {
        NavigationView{
            List {
                //SearchBar(text: $contactList[0])
                
                Picker(selection: $selectedMode, label: Text("연락처")) {
                    ForEach(0 ..< contactList.count) { item in
                        Text("\(contactList[item])")
                    }
                } .pickerStyle(.inline)
                
                ForEach(0 ..< contactList.count) { item in
                    Text("\(contactList[item])")
                        .onTapGesture {
                            
                        }
                }
            }
        }
        .onAppear(perform: fetchContacts)
    }
    
    struct SearchBar: View {
        @Binding var text: String
        
        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
        }
    }
    
    func fetchContacts() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        request.sortOrder = CNContactSortOrder.userDefault
        
        do {
            // 이미 반복되는 형식
            try store.enumerateContacts(with: request) { contact, stop in
                let name = contact.familyName + contact.givenName
                self.contactList.append(name)
                print("\(name)")
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
    }
}

struct ContactsSelectListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsSelectListView()
    }
}
