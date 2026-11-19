

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
class AddDeliveryViewModel {

    var date = Date()
    var item = "Milk"
    var quantity = 1
    var rate = ""
    var status = "Delivered"
    var notes = ""

    var errorMessage = ""

    func saveDelivery(context: ModelContext) -> Bool {

        guard quantity > 0 else {
            errorMessage = "Quantity must be greater than zero"
            return false
        }

        guard let deliveryRate = Double(rate), deliveryRate > 0 else {
            errorMessage = "Enter a valid rate"
            return false
        }

        let delivery = Delivery(
            date: date,
            item: item,
            quantity: quantity,
            rate: deliveryRate,
            status: status,
            notes: notes
        )

        context.insert(delivery)

        do {
            try context.save()
            return true
        } catch {
            errorMessage = "Unable to save delivery: \(error.localizedDescription)"
            return false
        }
    }
}
