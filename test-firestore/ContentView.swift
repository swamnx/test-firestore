//
//  ContentView.swift
//  test-firestore
//
//  Created by Vlad Sobchuk on 7/19/22.
//

import SwiftUI

struct ContentView: View {

    @StateObject var contentModel: ContentModel = .init()

    var body: some View {
            NavigationView {
                VStack {
                    Button("Host") {
                        contentModel.createAndCheckSession()
                    }
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
                    .background(.ultraThickMaterial)
                    .clipped(antialiased: false)
                    .clipShape(Capsule())
                    .padding()
                    Text("Enter host link")
                        .font(.title)
                    TextField("host link", text: $contentModel.sessionId)
                        .padding()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    Button("Client") {
                        if contentModel.sessionId.isEmpty {
                            contentModel.errorText = "Host link is empty"
                            contentModel.showErrorAlert = true
                        } else {
                            contentModel.connectToSessionAndCheckForHost()
                        }
                    }
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
                    .background(.ultraThickMaterial)
                    .clipped(antialiased: false)
                    .clipShape(Capsule())
                    .padding()
                    NavigationLink(destination: ClientView(sessionId: contentModel.sessionId, userId: contentModel.userId, userName: contentModel.userName), tag: "client", selection: $contentModel.currentScreen) { EmptyView() }
                    NavigationLink(destination: HostView(sessionId: contentModel.sessionId).environmentObject(contentModel), tag: "host", selection: $contentModel.currentScreen) { EmptyView() }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle(contentModel.userName)
            }
            .alert(contentModel.errorText, isPresented: $contentModel.showErrorAlert) {
                Button("Ok") {}
            }
            .confirmationDialog("Host session is already exists", isPresented: $contentModel.sessionAlreadyExistDialog) {
                Button("Connect to session") {
                    contentModel.currentScreen = "host"
                }
                Button("Delete session", role:.destructive) {
                    contentModel.deleteSessions()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
