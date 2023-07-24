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
    
    @State private var searchText = ""
    
    @State private var selectedName = ""
    @State var contactList : [String] = []
    
    @State private var navigationActive = false
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $searchText)
                
                List {
                    if (searchText == ""){
                        Picker("",selection: $selectedName) {
                            ForEach(contactList, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.inline)
                        //디버깅용
                        Text("\(selectedName)")
                    } else {
                        Picker("",selection: $selectedName) {
                            ForEach(contactList.filter{$0.hasPrefix(searchText)}, id: \.self) { item in
                                Text(item)
                            }
                        }.pickerStyle(.inline)
                        //디버깅용
                        Text("\(selectedName)")
                    }
                    
                }.listStyle(PlainListStyle())
            }
            
        }
        .navigationBarItems(leading: Text("􀆉 인맥관리")
            .foregroundColor(.blue)
            .onTapGesture {presentationMode.wrappedValue.dismiss()},
                            trailing: Text("다음")
            .foregroundColor(.blue)
            .onTapGesture { navigationActive = true })
        .onAppear(perform: fetchContacts)
        .fullScreenCover(isPresented: $navigationActive) {
            NavigationView{
                addContactsView(selectedUserName: selectedName)
            }
        }
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
            // 이미 반복되는 형식?
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
