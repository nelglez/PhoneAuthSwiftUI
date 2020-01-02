//
//  SecondView.swift
//  PhoneAuthSwiftUI
//
//  Created by Nelson Gonzalez on 1/2/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SecondView: View {
         @State var code = ""
         @Binding var show : Bool
         @Binding var ID : String
         @State var msg = ""
         @State var alert = false
         
         var body : some View{
             
             ZStack(alignment: .topLeading) {
                 
                 GeometryReader{_ in
                     
                     VStack(spacing: 20){
                         
                         //Image("pic")
                         
                         Text("Verification Code").font(.largeTitle).fontWeight(.heavy)
                         
                         Text("Please Enter The Verification Code")
                             .font(.body)
                             .foregroundColor(.gray)
                             .padding(.top, 12)
     
                         TextField("Code", text: self.$code)
                                 .keyboardType(.numberPad)
                                 .padding()
                                 .background(Color("Color"))
                                 .clipShape(RoundedRectangle(cornerRadius: 10))
                                 .padding(.top, 15)
     
                         
                         Button(action: {
                             
                            let credential =  PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                             
                             Auth.auth().signIn(with: credential) { (res, err) in
                                 
                                 if err != nil{
                                     
                                     self.msg = (err?.localizedDescription)!
                                     self.alert.toggle()
                                     return
                                 }
                                let id = res?.user.uid
                                print(id!)
                                 //Send data to the database
                                 UserDefaults.standard.set(true, forKey: "status")
                                 
                                 NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                             }
                             
                         }) {
                             
                             Text("Verify").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                             
                         }.foregroundColor(.white)
                         .background(Color.orange)
                         .cornerRadius(10)
                         .navigationBarTitle("")
                         .navigationBarHidden(true)
                         .navigationBarBackButtonHidden(true)
                         
                     }
                     
                 }
                 
                 Button(action: {
                     
                     self.show.toggle()
                     
                 }) {
                     
                     Image(systemName: "chevron.left").font(.title)
                     
                 }.foregroundColor(.orange)
                 
             }
             .padding()
             .alert(isPresented: $alert) {
                     
                 Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
             }
         }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(show: .constant(true), ID: .constant("hfkasowj"))
    }
}
