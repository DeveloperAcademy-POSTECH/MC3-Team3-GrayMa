//
//  newContactsView.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/17.
//

import SwiftUI
import Contacts

struct addContactsView: View {
    //다른 뷰에서 닫기 컨트롤을 위한 변수
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dotsModel: DotsModel
    
    //연락처 가져오는 Arr
    var contacts : [CNContact] = []
    
    let contactsDetailArr = ["이름 *", "연락처", "이메일", "LinkedIn"]
    let contactsModalArr = ["회사", "직무 *"]
    
    //유저 입력 결과 넣을 Arr
    @State private var userDetailInput = ["","","",""]
    @State private var userModalInput = ["",""]
    
    //MARK:CoreDate 연동 변수
    @State var coreDataUSerProfileImgIdx = 0
    @State var coreDataUserName : String? = ""
    
    @State var coreaDataUserCompany =  ""
    @State var coreDataUserJob = ""
    
    @State var coreDataUserPhone = ""
    @State var coreDataUserEmail = ""
    @State var coreDataUserSNS = ""
    @State var coreDataUserStrength = ""
    
    //유저 이미지 모달 컨트롤
    @State private var userImgModal = false
    
    @State var strengthCount = 7
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                
                //이미지 추가
                contactsImageSelect(userName: coreDataUserName, coreDataUserIdx: $coreDataUSerProfileImgIdx)
                    .onTapGesture {
                        userImgModal = true
                    }
                    .sheet(isPresented: $userImgModal) {
                        ProfileImageModal(userName: coreDataUserName, userImageIdx: $coreDataUSerProfileImgIdx)
                            .presentationDetents([.height(UIScreen.main.bounds.height * 0.4)])
                    }
                
                
                VStack (alignment: .leading){
                    
                    //TextField 생성
                    contactsTextField(inputCondition: contactsDetailArr[0], text: $coreDataUserName, option: 0)
                    
                    ForEach(0..<2){ i in
                        contactsJobCompany(inputCondition: contactsModalArr[i], text: $userModalInput[i])
                    }
                    
                    ForEach(1..<4){ j in
                        contactsTextField(inputCondition: contactsDetailArr[j], text: $userDetailInput[j], option: j)
                    }
                    
                    contactsStrengthField(inputStrength: strengthCount, strengthText: $coreDataUserStrength)
                    
                    //선택된 강점 표시 부분
                    Text("\(coreDataUserStrength)")
                }
            }
        }
        .navigationBarItems(leading: Text("􀆉 인맥관리")
            .foregroundColor(.blue)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()},
                            //MARK: CoreDate 연동 버튼
                            trailing: Text("완료")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                userInputToCoreData()
                                dotsModel.addNetworking(profileImgIdx: coreDataUSerProfileImgIdx, name: coreDataUserName, company: coreaDataUserCompany, job: coreDataUserJob, phoneNum: coreDataUserPhone, email: coreDataUserEmail, snsUrl: coreDataUserSNS)
                            })
    }
    
    func userInputToCoreData(){
        coreaDataUserCompany =  userModalInput[0]
        coreDataUserJob = userModalInput[1]
        
        coreDataUserPhone = userDetailInput[1]
        coreDataUserEmail = userDetailInput[2]
        coreDataUserSNS = userDetailInput[3]
        
        
        print("\(coreDataUSerProfileImgIdx)\n\(coreDataUserName)\n\(coreaDataUserCompany)\n\(coreDataUserJob)\n\(coreDataUserPhone)\n\(coreDataUserEmail)\n\(coreDataUserSNS)\n\(coreDataUserStrength)\n")
    }
    
    func fetchContact() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey,CNContactOrganizationNameKey,CNContactJobTitleKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                let name = contact.familyName + contact.givenName
                let company = contact.organizationName
                let Job = contact.jobTitle
                let phoneNum = contact.phoneNumbers
                let email = contact.emailAddresses
                self.contactList.append(name)
                print("\(name)")
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
    }
}


//struct newContactsView_Previews: PreviewProvider {
//    static var previews: some View {
//        newContactsView()
//    }
//}
