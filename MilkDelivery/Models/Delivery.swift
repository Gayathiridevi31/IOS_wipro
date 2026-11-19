import Foundation
import SwiftData

@Model
class Delivery {

    var id: UUID
    var date: Date
    var item: String
    var quantity: Int
    var rate: Double
    var status: String
    var notes: String

    var totalAmount: Double {
        status == "Delivered"
        ? Double(quantity) * rate
        : 0
    }

    init(
        date: Date,
        item: String,
        quantity: Int,
        rate: Double,
        status: String,
        notes: String = ""
    ) {
        self.id = UUID()
        self.date = date
        self.item = item
        self.quantity = quantity
        self.rate = rate
        self.status = status
        self.notes = notes
    }
}
