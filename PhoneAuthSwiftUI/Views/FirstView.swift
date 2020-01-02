//
//  FirstView.swift
//  PhoneAuthSwiftUI
//
//  Created by Nelson Gonzalez on 1/2/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct FirstView: View {
        @State var ccode = ""
        @State var no = ""
        @State var show = false
        @State var msg = ""
        @State var alert = false
        @State var ID = ""
        
        var body : some View{
            
            VStack(spacing: 20) {
                
               // Image("pic")
                
                Text("Verify Your Number").font(.largeTitle).fontWeight(.heavy)
                
                Text("Please Enter Your Number To Verify Your Account")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 12)
                
                HStack{
                    
                    TextField("+1", text: $ccode)
                        .keyboardType(.numberPad)
                        .frame(width: 45)
                        .padding()
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                       
                    
                    TextField("Number", text: $no)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                } .padding(.top, 15)
    
                NavigationLink(destination: SecondView(show: $show, ID: $ID), isActive: $show) {
                    
                    
                    Button(action: {
                        
                        PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.ccode+self.no, uiDelegate: nil) { (verificationID, err) in
                            
                            if err != nil{
                                
                                self.msg = (err?.localizedDescription)!
                                self.alert.toggle()
                                return
                            }
                            
                            self.ID = verificationID!
                            self.show.toggle()
                        }
                        
                        
                    }) {
                        
                        Text("Send").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                        
                    }.foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(10)
                }
    
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                
            }.padding()
            .alert(isPresented: $alert) {
                    
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
            }
        }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
