import SwiftUI
import SwiftData

@main
struct MilkNewspaperDeliveryApp: App {

    var body: some Scene {

        WindowGroup {

            LoginView()
        }
        .modelContainer(for: Delivery.self)
    }
}
