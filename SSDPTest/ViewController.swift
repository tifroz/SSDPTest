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
  
  
  var connectionGroup: NWMulticastGroup!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let multicastGroup = try! NWMulticastGroup(for: [ .hostPort(host: "239.255.255.250", port: 1900) ])
    let parameters = NWParameters.udp
    parameters.allowLocalEndpointReuse = true
    
    let connectionGroup = NWConnectionGroup(with: multicastGroup, using: .udp)
    stateLabel.text = "\(connectionGroup.state)"
    
    connectionGroup.setReceiveHandler(maximumMessageSize: 16384, rejectOversizedMessages: true) { message, content, isComplete in
      NSLog("Received \(content?.count ?? 0) bytes from \(String(describing: message.remoteEndpoint))")
    }
    
    connectionGroup.stateUpdateHandler = { newState in
      NSLog("Group entered state \(String(describing: newState))")
      self.stateLabel.text = "\(newState)"
    }
    
    connectionGroup.start(queue: .main)
  }
}
