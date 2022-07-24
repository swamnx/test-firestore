//
//  OnboardingView.swift
//  test-firestore
//
//  Created by Swamnx mac on 22.07.22.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("userId") var userId: String = ""
    @AppStorage("userName") var userName: String = "Some Name"
    
    @State var currentUserName: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Enter your name")
                .font(.largeTitle)
            ZStack {
                Spacer()
                TextField("user name", text: $currentUserName)
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
            }
            Spacer()
            Button("Continue") {
                userId = UUID.init().uuidString
                userName = currentUserName
                
            }
            .frame(width: 150, height: 50, alignment: .center)
            .font(.title)
            .background(.indigo)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .shadow(radius: 5)

        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
