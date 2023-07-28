//
//  newContactsView.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/17.
//

import SwiftUI
import Contacts

struct AddContactsView: View {
    //다른 뷰에서 닫기 컨트롤을 위한 변수
    @Environment(\.presentationMode) var presentationMode
    @Binding var modalComtrol : Bool
    
    //CoreData 연동
    @EnvironmentObject var dotsModel: DotsModel
    
    //연락처 가져오는 Arr
    @State var selectedUserName : String? = ""
    
    //MARK:CoreDate 연동 변수
    @State var coreDataUSerProfileImgIdx = 0
    @State var coreDataUserName  = ""
    
    @State var coreaDataUserCompany =  ""
    @State var coreDataUserJob = ""
    
    @State var coreDataUserPhone = ""
    @State var coreDataUserEmail = ""
    @State var coreDataUserSNS = ""
    
    //MARK: 추후에 Arr 형식으로 전환되어야함
    @State var coreDataUserStrength: [String] = []
    @State var selectedUserStrength: [StrengthEntity] = []

    
    @State var fieldFocus = false
    
    //유저 이미지 모달 컨트롤
    @State private var userImgModal = false

    //Alert 컨트롤
    @State private var someThingWrongAlert = false
    
   //Alert 연락처
    @State private var addAlert = false
    @Binding var isContactsAdd : Bool
    
    var body: some View {
        NavigationView{
            VStack{
                
                // 상단 메뉴바
                HStack{
                    Text("\(Image(systemName: "chevron.left")) 인맥관리")
                        .font(.system(size: 17))
                        .foregroundColor(Color.theme.primary)
                        .onTapGesture {presentationMode.wrappedValue.dismiss()}
                    
                    Spacer()
                        .frame(width: 240)
                    
                    Text("완료")
                        .font(.system(size: 17))
                        .foregroundColor(Color.theme.primary)
                    
                        .onTapGesture {
                            if (coreDataUserName != "" && coreDataUserJob != "" && !coreDataUserStrength.isEmpty){
                                //MARK: 균규니 코어 연동 부분 해당뷰에서 coreDataUserStrength를 변수로 가짐
                                dotsModel.addNetworking(profileImgIdx: coreDataUSerProfileImgIdx, name: coreDataUserName, company: coreaDataUserCompany, job: coreDataUserJob, phoneNum: coreDataUserPhone, email: coreDataUserEmail, snsUrl: coreDataUserSNS /*, userStrength: coreDataUserStrength*/)
                                //인맥 추가 알림 띄움
                                presentationMode.wrappedValue.dismiss()
                                isContactsAdd = true
                            }else
                            {
                                someThingWrongAlert = true
                            }
                        }
                }
                .padding(8)
                
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
                        
                        ContactsNameField(UserInputName: $coreDataUserName, fieldFocus: fieldFocus)
                        
                        ContactsCompanyField(UserInputCompany: $coreaDataUserCompany)
                        
                        ContactsJobField(UserInputJob: $coreDataUserJob)
                        
                        ContactsPhoneField(UserInputPhone: $coreDataUserPhone, fieldFocus: fieldFocus)
                        
                        ContactsEmailField(UserInputEmail: $coreDataUserEmail, fieldFocus: fieldFocus)
                        
                        ContactsSNSField(UserInputSNS: $coreDataUserSNS, fieldFocus: fieldFocus)
                        
                        ContactsStrengthField(UserInputStrengthArr: $coreDataUserStrength)
                        
                        //선택된 강점 표시 부분
                        ForEach(coreDataUserStrength, id: \.self) { Strength in
                            Text(Strength)
                        }
                        
                    }
                }
            }
        }
        .navigationBarHidden(true)
        
//        .alert(isPresented: $addAlert) {
//            Alert(title: Text("알림"),
//                  message: Text("인맥이 추가되었습니다."),
//                  dismissButton: .default(Text("확인"), action: {
//                // 모달을 닫습니다.
//                presentationMode.wrappedValue.dismiss()
//                modalComtrol = false
//            }))
//        }
        
        .alert(isPresented: $someThingWrongAlert){
            Alert(title: Text("알림"),
                  message: Text("필수 조건이 입력되지 않았습니다."),
                  dismissButton: .default(Text("확인"), action: {
                someThingWrongAlert.toggle()
            }))
        }
        .onAppear{
            if !(selectedUserName?.isEmpty ?? true){
                let selectedUser = fetchContact(name: selectedUserName ?? "")
                for contact in selectedUser {
                    coreDataUserName = contact.Name
                    
                    coreaDataUserCompany = contact.Company ?? ""
                    coreDataUserJob = contact.Job ?? ""
                    
                    coreDataUserPhone = contact.PhoneNumber ?? ""
                    coreDataUserEmail = contact.Email ?? ""
                    //coreDataUserSNS = contact.SNS ?? ""
                }
            }
        }
    }
       
    
    //기존에서 가져오기를 선택하였을 경우 이름을 사용해 연락처에서 정보를 가져옴
    func fetchContact(name: String) -> [(Name: String, Company: String?, Job: String?, PhoneNumber: String?, Email: String? /*, SNS: String?*/)]{
        var selectedUserContacts : [(Name: String, Company: String?, Job: String?, PhoneNumber: String?, Email: String? /*, SNS: String?)*/)] = []
        
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey,CNContactOrganizationNameKey,CNContactJobTitleKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey]
        let predicate = CNContact.predicateForContacts(matchingName: name)
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        request.predicate = predicate
        
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                let name = contact.familyName + contact.givenName
                let company = contact.organizationName
                let job = contact.jobTitle
                let phoneNum = contact.phoneNumbers.first?.value.stringValue
                let email = contact.emailAddresses.first
                //let SNS = contact.urlAddresses
                selectedUserContacts.append((Name: name, Company: company, Job: job, PhoneNumber: phoneNum, Email: email?.value as String?/*, SNS: SNS.hashValue as! String*/))
                print("\(name)")
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
        return selectedUserContacts
    }
}


//struct newContactsView_Previews: PreviewProvider {
//    static var previews: some View {
//        newContactsView()
//    }
//}
