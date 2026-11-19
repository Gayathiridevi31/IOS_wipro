
import Foundation
import SwiftData
import Observation

@MainActor
@Observable
class DeleteDeliveryViewModel {

    var errorMessage = ""

    func deleteDelivery(
        delivery: Delivery,
        context: ModelContext
    ) -> Bool {

        context.delete(delivery)

        do {
            try context.save()
            return true
        } catch {
            errorMessage = "Unable to delete delivery: \(error.localizedDescription)"
            return false
        }
    }
}

