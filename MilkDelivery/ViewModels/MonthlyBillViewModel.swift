

import Foundation
import Observation

struct MonthlyBillSummary {

    var milkQuantity = 0
    var newspaperQuantity = 0

    var milkAmount = 0.0
    var newspaperAmount = 0.0

    var skippedDays = 0

    var totalAmount: Double {
        milkAmount + newspaperAmount
    }
}

@MainActor
@Observable
class MonthlyBillViewModel {

    var selectedMonth = Date()

    func calculateBill(
        deliveries: [Delivery]
    ) -> MonthlyBillSummary {

        let calendar = Calendar.current

        let selectedComponents = calendar.dateComponents(
            [.year, .month],
            from: selectedMonth
        )

        let monthlyRecords = deliveries.filter { delivery in

            let deliveryComponents = calendar.dateComponents(
                [.year, .month],
                from: delivery.date
            )

            return deliveryComponents.year == selectedComponents.year &&
                   deliveryComponents.month == selectedComponents.month
        }

        var summary = MonthlyBillSummary()

        let skippedDates = Set(
            monthlyRecords
                .filter { $0.status == "Skipped" }
                .map {
                    calendar.startOfDay(for: $0.date)
                }
        )

        summary.skippedDays = skippedDates.count

        for delivery in monthlyRecords {

            if delivery.status == "Delivered" {

                let amount = Double(delivery.quantity) * delivery.rate

                if delivery.item == "Milk" {

                    summary.milkQuantity += delivery.quantity
                    summary.milkAmount += amount

                } else if delivery.item == "Newspaper" {

                    summary.newspaperQuantity += delivery.quantity
                    summary.newspaperAmount += amount
                }
            }
        }

        return summary
    }
}
