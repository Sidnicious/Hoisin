import Cocoa
import HoisinKit

final class Document: NSDocument {
    
    var history: [TerminalCell]
    var selectedHistoryEntry: Int
    var cwd: HoisinKit.Cwd
    
    override init() {
        cwd = HoisinKit.Cwd(at: "~") ?? HoisinKit.Cwd(at: "/")!
        history = [WorkingDirectoryCell(path: cwd.path), TaskCell(), CommandLineCell()]
        selectedHistoryEntry = history.count-1
        super.init()
    }
    
    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as! NSWindowController
        let contentVC = windowController.contentViewController as! ViewController
        contentVC.representedObject = self

        let terminalVC = storyboard.instantiateControllerWithIdentifier("terminal") as! TerminalViewController
        terminalVC.representedObject = self
        terminalVC.view.translatesAutoresizingMaskIntoConstraints = false

        contentVC.addChildViewController(terminalVC)

        contentVC.splitView.addChildView(terminalVC.view)
        self.addWindowController(windowController)
    }
    
    override func dataOfType(typeName: String) throws -> NSData {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func readFromData(data: NSData, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override class func canConcurrentlyReadDocumentsOfType(typeName: String) -> Bool {
        return true
    }
}
