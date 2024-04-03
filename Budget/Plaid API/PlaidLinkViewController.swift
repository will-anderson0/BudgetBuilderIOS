//
//  PlaidLinkViewController.swift
//  Budget
//
//  Created by Will Anderson on 4/3/24.
//

import SwiftUI
import LinkKit

struct PlaidLinkView: View {
    @State var linkToken: String?
    @State var handler: Handler?
    @State var isLinkStarted = false
    let communicator: ServerCommunicator

    init(communicator: ServerCommunicator) {
        self.communicator = communicator
    }
    
    var body: some View {
        VStack {
            if let linkToken = linkToken {
                Button(action: {
                    startLink()
                }) {
                    Text("Start Link")
                }
                .disabled(isLinkStarted) // Disable button when link is started
            }
        }
        .onAppear {
            fetchLinkToken()
        }
    }
    
    func createLinkConfiguration(linkToken: String) -> LinkTokenConfiguration {
        // Create our link configuration object
        // This return type will be a LinkTokenConfiguration object
        var linkTokenConfig = LinkTokenConfiguration(token: linkToken) { success in
            print("Link was finished successfully! \(success)")
            self.exchangePublicTokenForAccessToken(success.publicToken)
        }
        linkTokenConfig.onExit = { linkEvent in
            print("User exited Link early \(linkEvent)")
        }
        linkTokenConfig.onEvent = { linkEvent in
            print("Hit an event \(linkEvent.eventName)")
        }
        return linkTokenConfig
    }
    
    func startLink() {
        // Handle the button being clicked
        guard let linkToken = linkToken else {return}
        let config = createLinkConfiguration(linkToken: linkToken)
        self.isLinkStarted = true
        
        let creationResult = Plaid.create(config)
        switch creationResult {
        case .success(let handler):
            self.handler = handler
            //handler.open(presentUsing: .viewController(self))
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                handler.open(presentUsing: .viewController(rootViewController))
            } else {
                print("Unable to get root view controller")
            }
        case .failure(let error):
            print("Handler creation error \(error)")
        }
        
    }
    
    func exchangePublicTokenForAccessToken(_ publicToken: String) {
        // Exchange our public token for an access token
        self.communicator.callMyServer(path: "/server/swap_public_token", httpMethod: .post, params: ["public_token": publicToken]) {
            (result: Result<SwapPublicTokenResponse, ServerCommunicator.Error>) in
            switch result {
            case .success(_):
                print("Token Exchanged")
            case .failure(let error):
                print("Got an error \(error)")
            }
        }
    }

    func fetchLinkToken() {
        // Fetch a link token from our server
        self.communicator.callMyServer(path: "/server/generate_link_token", httpMethod: .post) { (result: Result<LinkTokenCreateResponse, ServerCommunicator.Error>) in
            switch result {
            case .success(let response):
                self.linkToken = response.linkToken
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
