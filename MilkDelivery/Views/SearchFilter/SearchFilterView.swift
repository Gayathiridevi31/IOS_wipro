

import SwiftUI
import SwiftData

struct SearchFilterView: View {

    @Query(sort: \Delivery.date, order: .reverse)
    private var deliveries: [Delivery]

    @State private var viewModel = SearchFilterViewModel()

    var filteredRecords: [Delivery] {
        viewModel.filteredDeliveries(deliveries)
    }

    var body: some View {

        VStack {

            List {

                Section("Search") {

                    TextField(
                        "Search Milk or Newspaper",
                        text: $viewModel.searchText
                    )

                    Picker(
                        "Item",
                        selection: $viewModel.selectedItem
                    ) {
                        Text("All").tag("All")
                        Text("Milk").tag("Milk")
                        Text("Newspaper").tag("Newspaper")
                    }

                    Picker(
                        "Status",
                        selection: $viewModel.selectedStatus
                    ) {
                        Text("All").tag("All")
                        Text("Delivered").tag("Delivered")
                        Text("Skipped").tag("Skipped")
                    }
                }

                Section("Date Filter") {

                    DatePicker(
                        "Start Date",
                        selection: Binding(
                            get: {
                                viewModel.startDate ?? Date()
                            },
                            set: {
                                viewModel.startDate = $0
                            }
                        ),
                        displayedComponents: .date
                    )

                    Toggle(
                        "Use Start Date",
                        isOn: Binding(
                            get: {
                                viewModel.startDate != nil
                            },
                            set: {
                                viewModel.startDate = $0 ? Date() : nil
                            }
                        )
                    )

                    DatePicker(
                        "End Date",
                        selection: Binding(
                            get: {
                                viewModel.endDate ?? Date()
                            },
                            set: {
                                viewModel.endDate = $0
                            }
                        ),
                        displayedComponents: .date
                    )

                    Toggle(
                        "Use End Date",
                        isOn: Binding(
                            get: {
                                viewModel.endDate != nil
                            },
                            set: {
                                viewModel.endDate = $0 ? Date() : nil
                            }
                        )
                    )
                }

                Section {

                    HStack {
                        Text("Results")
                        Spacer()
                        Text("\(filteredRecords.count) records")
                            .foregroundStyle(.secondary)
                    }

                    if filteredRecords.isEmpty {

                        ContentUnavailableView(
                            "No Deliveries Found",
                            systemImage: "magnifyingglass",
                            description: Text(
                                "Try changing your search or filters."
                            )
                        )

                    } else {

                        ForEach(filteredRecords) { delivery in

                            NavigationLink {
                                DeliveryDetailsView(delivery: delivery)
                            } label: {
                                DeliveryRowView(delivery: delivery)
                            }
                        }
                    }
                }
            }

            Button("Reset Filters") {
                viewModel.resetFilters()
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .navigationTitle("Search Deliveries")
        .navigationBarTitleDisplayMode(.inline)
    }
}
