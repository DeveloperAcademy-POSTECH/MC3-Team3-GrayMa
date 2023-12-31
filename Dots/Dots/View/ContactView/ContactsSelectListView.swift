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
    @Binding var modalControl : Bool
    
    @State private var searchText = ""
    
    @State private var selectedName = ""
    @State var contactList : [String] = []
    
    @State private var navigationActive = false
    
    @State private var addAlert = false
    @Binding var isContactsAdd : Bool
    
    var body: some View {
        NavigationView{
            
            VStack{
                HStack{
                    Text("\(Image(systemName: "chevron.left")) 인맥관리")
                        .font(.system(size: 17))
                        .foregroundColor(Color.theme.primary)
                        .onTapGesture {presentationMode.wrappedValue.dismiss()}
                    
                    Spacer()
                        .frame(width: 240)
                    
                    Text("다음")
                        .foregroundColor(Color.theme.primary)
                        .onTapGesture {
                            navigationActive = true
                        }
                }.padding(8)
                
                SearchBar(text: $searchText)
                
                List {
                    if (searchText == ""){
                        Picker("",selection: $selectedName) {
                            ForEach(contactList, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.inline)
                        //디버깅용
//                        Text("\(selectedName)")
                    } else {
                        Picker("",selection: $selectedName) {
                            ForEach(contactList.filter{$0.contains(searchText)}, id: \.self) { item in
                                Text(item)
                            }
                        }.pickerStyle(.inline)
                        //디버깅용
//                        Text("\(selectedName)")
                    }
                    
                }.listStyle(PlainListStyle())
            }
            
        }
        .onAppear(perform: fetchContacts)
        .fullScreenCover(isPresented: $navigationActive, onDismiss: {presentationMode.wrappedValue.dismiss()}) {
            AddContactsView(modalComtrol: $modalControl, selectedUserName: selectedName, isContactsAdd: $isContactsAdd)
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
            try store.enumerateContacts(with: request) { (contact, stop) in
                let name = contact.familyName + contact.givenName
                self.contactList.append(name)
                print("\(name)")
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
    }
}

//struct ContactsSelectListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactsSelectListView()
//    }
//}
