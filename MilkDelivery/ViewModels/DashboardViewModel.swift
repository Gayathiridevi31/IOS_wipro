import Foundation
import Observation

struct DashboardSummary {

    var totalDeliveries: Int
    var skippedDays: Int
    var payableAmount: Double
    var todayStatus: String
}

@MainActor
@Observable
class DashboardViewModel {

    func getDashboardSummary(
        deliveries: [Delivery]
    ) -> DashboardSummary {

        let calendar = Calendar.current
        let today = Date()

        let currentMonthDeliveries = deliveries.filter {

            calendar.isDate(
                $0.date,
                equalTo: today,
                toGranularity: .month
            )
        }

        let deliveredRecords = currentMonthDeliveries.filter {
            $0.status == DeliveryStatus.delivered.rawValue
        }

        let skippedRecords = currentMonthDeliveries.filter {
            $0.status == DeliveryStatus.skipped.rawValue
        }

        let skippedDays = Set(
            skippedRecords.map {
                calendar.startOfDay(for: $0.date)
            }
        ).count

        let totalAmount = deliveredRecords.reduce(0.0) {

            $0 + (Double($1.quantity) * $1.rate)
        }

        let todayDeliveries = deliveries.filter {

            calendar.isDate($0.date, inSameDayAs: today)
        }

        var todayStatus = "Not Recorded"

        if !todayDeliveries.isEmpty {

            let allDelivered = todayDeliveries.allSatisfy {
                $0.status == DeliveryStatus.delivered.rawValue
            }

            let allSkipped = todayDeliveries.allSatisfy {
                $0.status == DeliveryStatus.skipped.rawValue
            }

            if allDelivered {
                todayStatus = "Delivered"
            } else if allSkipped {
                todayStatus = "Skipped"
            } else {
                todayStatus = "Partially Delivered"
            }
        }

        return DashboardSummary(
            totalDeliveries: deliveredRecords.count,
            skippedDays: skippedDays,
            payableAmount: totalAmount,
            todayStatus: todayStatus
        )
    }
}
