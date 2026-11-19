
import Foundation
import SwiftData
import Observation

@MainActor
@Observable
class EditDeliveryViewModel {

    var date: Date
    var item: String
    var quantity: Int
    var rate: String
    var status: String
    var notes: String

    var errorMessage = ""

    private var delivery: Delivery

    init(delivery: Delivery) {
        self.delivery = delivery
        self.date = delivery.date
        self.item = delivery.item
        self.quantity = delivery.quantity
        self.rate = String(delivery.rate)
        self.status = delivery.status
        self.notes = delivery.notes
    }

    func updateDelivery(context: ModelContext) -> Bool {

        guard quantity > 0 else {
            errorMessage = "Quantity must be greater than zero"
            return false
        }

        guard let deliveryRate = Double(rate), deliveryRate > 0 else {
            errorMessage = "Enter a valid rate"
            return false
        }

        delivery.date = date
        delivery.item = item
        delivery.quantity = quantity
        delivery.rate = deliveryRate
        delivery.status = status
        delivery.notes = notes

        do {
            try context.save()
            return true
        } catch {
            errorMessage = "Unable to update delivery: \(error.localizedDescription)"
            return false
        }
    }
}

