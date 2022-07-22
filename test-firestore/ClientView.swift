//
//  ClientView.swift
//  test-firestore
//
//  Created by Vlad Sobchuk on 7/20/22.
//

import SwiftUI

struct ClientView: View {

    var sessionId: String
    var userId: String
    var userName: String
    @StateObject var clientModel: ClientModel = .init()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                Task{await clientModel.fetchSession(sessionId)}
            }
    }
}

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView(sessionId: "", userId: "", userName: "")
    }
}
