import AppKit
import ArgumentParser

@main
struct SetBrowserTo: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A utility to set default browser.",
        version: "v0.0.1",
        subcommands: [Name.self],
        defaultSubcommand: Name.self
    )
}

struct Name: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Enter the browser name to make default."
    )

    @Argument(help: "The supported browser name is safari, chrome, edge, firefox.")
    var browser_name: String {
        didSet {
            browser_name = browser_name.lowercased()
        }
    }

    func run() throws {
        switch self.browser_name {
        case "safari":
            setDefaultBrowser(for: "com.apple.safari", scheme: "http")
        case "chrome":
            setDefaultBrowser(for: "com.google.chrome", scheme: "http")
        case "edge":
            setDefaultBrowser(for: "com.microsoft.edgemac", scheme: "http")
        case "firefox":
            setDefaultBrowser(for: "org.mozilla.firefox", scheme: "http")
        default:
            print("Not support browser \(self.browser_name) yet!")
        }

        print("Confirm your decision to change default browser!")
    }
}

func setDefaultBrowser(for bundleIdentifier: String, scheme: String) {
    if let applicationURL = NSWorkspace.shared.urlForApplication(
        withBundleIdentifier: bundleIdentifier)
    {
        if #available(macOS 12, *) {
            // if let url = URL(string: "https://www.apple.com"),
            //     let appURL = NSWorkspace.shared.urlForApplication(toOpen: url)
            // {
            //     print("Default app: \(appURL)")
            // } else {
            //     print("Invalid URL")
            // }

            NSWorkspace.shared.setDefaultApplication(
                at: applicationURL,
                toOpenURLsWithScheme: scheme,
                completion: {
                    (error: Error?) -> Void in
                    if error != nil {
                        print("Error setting default app: \(error!.localizedDescription)")
                    } else {
                        print(
                            "Successfully requested default app change for \(scheme) to \(bundleIdentifier)"
                        )
                    }
                }
            )

            // Block current thread for showing notification
            sleep(1)
        } else {
            print("Not supported on this macOS version.")
        }
    } else {
        print("Application with bundle identifier \(bundleIdentifier) not found.")
    }
}
