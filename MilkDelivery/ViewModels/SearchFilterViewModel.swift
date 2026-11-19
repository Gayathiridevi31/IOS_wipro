

import Foundation
import Observation

@MainActor
@Observable
class SearchFilterViewModel {

    var searchText = ""
    var selectedStatus = "All"
    var selectedItem = "All"

    var startDate: Date?
    var endDate: Date?

    func filteredDeliveries(_ deliveries: [Delivery]) -> [Delivery] {

        return deliveries.filter { delivery in

            let matchesSearch =
                searchText.isEmpty ||
                delivery.item.localizedCaseInsensitiveContains(searchText)

            let matchesStatus =
                selectedStatus == "All" ||
                delivery.status == selectedStatus

            let matchesItem =
                selectedItem == "All" ||
                delivery.item == selectedItem

            let matchesStartDate =
                startDate == nil ||
                delivery.date >= Calendar.current.startOfDay(
                    for: startDate!
                )

            let matchesEndDate =
                endDate == nil ||
                delivery.date < Calendar.current.date(
                    byAdding: .day,
                    value: 1,
                    to: Calendar.current.startOfDay(for: endDate!)
                )!

            return matchesSearch &&
                   matchesStatus &&
                   matchesItem &&
                   matchesStartDate &&
                   matchesEndDate
        }
        .sorted { $0.date > $1.date }
    }

    func resetFilters() {
        searchText = ""
        selectedStatus = "All"
        selectedItem = "All"
        startDate = nil
        endDate = nil
    }
}
