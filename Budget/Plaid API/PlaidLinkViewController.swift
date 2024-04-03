//
//  PlaidLinkViewController.swift
//  SamplePlaidClients
//
//  Created by Todd Kerpelman on 8/18/23.
//

import UIKit
import LinkKit

class PlaidLinkViewController: UIViewController {
    @IBOutlet var startLinkButton: UIButton!
    let communicator = ServerCommunicator()
    var linkToken: String?
    var handler: Handler?
    
    
    private func createLinkConfiguration(linkToken: String) -> LinkTokenConfiguration {
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
    
    @IBAction func startLinkWasPressed(_ sender: Any) {
        // Handle the button being clicked
        guard let linkToken = linkToken else {return}
        let config = createLinkConfiguration(linkToken: linkToken)
        
        let creationResult = Plaid.create(config)
        switch creationResult {
        case .success(let handler):
            self.handler = handler
            handler.open(presentUsing: .viewController(self))
        case .failure(let error):
            print("Handler creation error \(error)")
        }
        
    }
    
    private func exchangePublicTokenForAccessToken(_ publicToken: String) {
        // Exchange our public token for an access token
        self.communicator.callMyServer(path: "/server/swap_public_token", httpMethod: .post, params: ["public_token": publicToken]) {
            (result: Result<SwapPublicTokenResponse, ServerCommunicator.Error>) in
            switch result {
            case . success(_):
                self.navigationController?.popViewController (animated: true)
            case .failure(let error):
                print("Got an error \(error)")
            }
        }
    }
    
    
    private func fetchLinkToken() {
        // Fetch a link token from our server
        self.communicator.callMyServer(path: "/server/generate_link_token", httpMethod: .post) { (result: Result<LinkTokenCreateResponse, ServerCommunicator.Error>) in
            switch result {
            case .success(let response):
                self.linkToken = response.linkToken
                self.startLinkButton.isEnabled = true
            case .failure(let error):
                print(error)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLinkButton.isEnabled = false
        fetchLinkToken()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
