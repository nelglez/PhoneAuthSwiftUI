//
//  HomeView.swift
//  PhoneAuthSwiftUI
//
//  Created by Nelson Gonzalez on 1/2/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
     var body : some View{
             
             VStack {
                 
                 Text("Home")
                 
                 Button(action: {
                     
                     try! Auth.auth().signOut()
                     
                     UserDefaults.standard.set(false, forKey: "status")
                     
                     NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                     
                 }) {
                     
                     Text("Logout")
                 }
             }
         }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
