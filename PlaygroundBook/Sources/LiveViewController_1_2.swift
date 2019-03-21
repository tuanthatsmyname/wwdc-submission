//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import Foundation
import PlaygroundSupport

public class LiveViewController_1_2: LiveViewController {
    @IBOutlet weak var terminalTextView: UITextView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTerminalTextView()
//        if let _ = DataManager.loadTerminalSettings() {
//            view.backgroundColor = .blue
//        }
        
    }
    
    private func setupTerminalTextView() {
        
    }
    
    override public func receive(_ message: PlaygroundValue) {
        
        guard case .data(let messageData) = message else { return }
        
        do {
            if let incomingObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? String {

                //do something with the incoming object from the playground page here
                print(incomingObject)

            }
        } catch let error { fatalError("\(error) Unable to receive the message from the Playground page") }
        
    }
}
