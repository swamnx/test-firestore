//
//  HostView.swift
//  test-firestore
//
//  Created by Vlad Sobchuk on 7/20/22.
//

import SwiftUI

struct HostView: View {

    var sessionId: String
    @StateObject var hostModel: HostModel = .init()
    @EnvironmentObject var contentModel: ContentModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("Back to Home") {
                    contentModel.currentScreen = "home"
                }
                .frame(width: 200, height: 50, alignment: .center)
                .background(.indigo)
                .font(.title)
                .foregroundColor(.black)
                .clipShape(Capsule())
                .shadow(radius: 5)

            }
        }
        .onAppear {
            Task{await hostModel.fetchSession(sessionId)}
        }
    }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        HostView(sessionId: "")
    }
}
