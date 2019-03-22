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
        
    }
    
    private func setupTerminalTextView() {
        if let _ = DataManager.loadTerminalSettings() {
            view.backgroundColor = .yellow
        }
        
        
    }
    
    private func executeCommand(from: String) {
        
    }
    
    override public func receive(_ message: PlaygroundValue) {
        
        guard case .data(let messageData) = message else { return }
        
        do {
            if let command = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? String {

                executeCommand(from: command)

            }
        } catch let error { fatalError("\(error) Unable to receive the message from the Playground page") }
        
    }
}
