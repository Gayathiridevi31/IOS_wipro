import Foundation
import Observation

@MainActor
@Observable
class DeliveryListViewModel {

    func sortDeliveries(
        _ deliveries: [Delivery]
    ) -> [Delivery] {

        return deliveries.sorted {
            $0.date > $1.date
        }
    }

    func formattedDate(_ date: Date) -> String {

        return date.formatted(
            date: .abbreviated,
            time: .omitted
        )
    }

    func statusColor(_ status: String) -> String {

        switch status {
        case "Delivered":
            return "green"

        case "Skipped":
            return "red"

        default:
            return "gray"
        }
    }
}
