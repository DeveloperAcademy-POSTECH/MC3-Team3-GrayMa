//
//  ContactsSelectListView.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/20.
//

import SwiftUI
import Contacts

struct ContactsSelectListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    //연락처 가져오는 Arr
    //let store = CNContactStore() //리퀘스트 접근 객체
    var contacts : [CNContact] = []
    
    @State private var searchText = ""
    
    @State private var selectedMode = 0
    @State var contactList : [String] = []
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $searchText)
                
                List {
                        if (searchText == ""){
                            Picker("",selection: $selectedMode) {
                                ForEach(0 ..< contactList.count) { item in
                                    Text("\(contactList[item])")
                                }
                            }.pickerStyle(.inline)
                        } else {
                            Picker("",selection: $selectedMode) {
                                ForEach(contactList.filter{$0.hasPrefix(searchText)}, id: \.self) { item in
                                    Text(item)
                                }
                            }.pickerStyle(.inline)
                        }
                    }.listStyle(PlainListStyle())
                }
            
        }
        .navigationBarItems(leading: Text("􀆉 인맥관리")
            .foregroundColor(.blue)
            .onTapGesture {presentationMode.wrappedValue.dismiss()})
        .onAppear(perform: fetchContacts)
    }
    
    struct SearchBar: View {
        
        @Binding var text: String
     
        var body: some View {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
     
                    TextField("Search", text: $text)
                        .foregroundColor(.primary)
     
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    } else {
                        EmptyView()
                    }
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
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
