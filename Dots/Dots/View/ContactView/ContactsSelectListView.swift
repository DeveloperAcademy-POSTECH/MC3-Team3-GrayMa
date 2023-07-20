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
    
    var contactList : Array<String> = []
    
    var body: some View {
        NavigationView{
            List {
                ForEach(0 ..< contactList.count) { item in
                    Text("\(contactList[item])")
                        .onTapGesture {
                            
                        }
                }
            }
        }
        .onAppear{fetchContacts(contactList: contactList)}
    }
    
    func fetchContacts(contactList: Array<String>){
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        
        do {
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
