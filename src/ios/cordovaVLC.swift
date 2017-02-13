@objc(cordovaVLC) class cordovaVLC : CDVPlugin {
    @objc(echo:)
    func echo(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        // value passed from the JS
        let msg = command.arguments[0] as? String ?? ""
        
        let secondViewController:ViewController = ViewController()
        
        self.viewController?.present(secondViewController, animated: true, completion: nil)
        
        
        pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: msg
        )
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
}
