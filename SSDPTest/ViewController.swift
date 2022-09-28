//
//  ViewController.swift
//  SSDPTest
//
//  Created by hugo on 9/28/22.
//
import Foundation
import UIKit
import Network

class ViewController: UIViewController {

  
  @IBOutlet weak var stateLabel: UILabel!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let multicastGroup = try! NWMulticastGroup(for: [ .hostPort(host: "239.255.255.250", port: 1900) ])
    let connectionGroup = NWConnectionGroup(with: multicastGroup, using: .udp)
    stateLabel.text = "\(connectionGroup.state)"
    connectionGroup.setReceiveHandler(maximumMessageSize: 16384, rejectOversizedMessages: true) { message, content, isComplete in
      NSLog("Received message from \(String(describing: message.remoteEndpoint))")
      if let content = content, let message = String(data: content, encoding: .utf8) {
        NSLog("Message: \(message)")
      }
    }
    connectionGroup.stateUpdateHandler = { newState in
      NSLog("Group entered state \(String(describing: newState))")
      DispatchQueue.main.async {
        self.stateLabel.text = "\(newState)"
      }
    }
    
    connectionGroup.start(queue: .main)
    
    /*let searchString = "M-SEARCH * HTTP/1.1\r\n" +
    "HOST: 239.255.255.250:1900\r\n" +
    "MAN: \"ssdp:discover\"\r\n" +
    "ST: ssdp:all\r\n" +
    "MX: 1\r\n\r\n"
    let groupSendContent = Data(searchString.utf8)
    connectionGroup.send(content: groupSendContent) { error in
      if let err = error {
        NSLog("Send complete with error \(err)")
      } else {
        NSLog("Send Complete")
      }
    }*/
  }


}

