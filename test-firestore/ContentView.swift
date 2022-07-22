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
                ZStack {
                    LinearGradient(colors: [.red, .yellow, .blue], startPoint: .init(x: 0.2, y: 0.3), endPoint: .init(x: 0.6, y: 0.7))
                        .ignoresSafeArea()

                    VStack {
                        HStack {
                            Spacer()
                            TextField("User name", text: $contentModel.userName)
                                .padding()
                                .font(.largeTitle)
                            Spacer()
                        }
                        Button("Host") {
                            contentModel.createSession()
                        }
                        .font(.title)
                        .padding()
                        .foregroundColor(.black)
                        .background(.ultraThickMaterial)
                        .clipped(antialiased: false)
                        .clipShape(Capsule())
                        .padding()
                        NavigationLink(destination: HostView(sessionId: contentModel.sessionId), tag: "host", selection: $contentModel.currentScreen) { EmptyView() }

                        Button("Client") {
                            contentModel.connectToSession()
                        }
                        .font(.title)
                        .padding()
                        .foregroundColor(.black)
                        .background(.ultraThickMaterial)
                        .clipped(antialiased: false)
                        .clipShape(Capsule())
                        .padding()
                        NavigationLink(destination: ClientView(sessionId: contentModel.sessionId, userId: contentModel.userId, userName: contentModel.userName), tag: "client", selection: $contentModel.currentScreen) { EmptyView() }
                        HStack {
                            Spacer()
                            TextField("fff", text: $contentModel.sessionId)
                                .padding()
                                .font(.largeTitle)
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .alert("Error", isPresented: $contentModel.showErrorAlert) {
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
            .onAppear {
                if contentModel.userId.isEmpty {
                    contentModel.userId = UUID.init().uuidString
                }
                print($contentModel.userId)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
