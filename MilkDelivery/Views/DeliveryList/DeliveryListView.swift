import SwiftUI
import SwiftData

struct DeliveryListView: View {

    @Query(sort: \Delivery.date, order: .reverse)
    private var deliveries: [Delivery]

    @State private var viewModel = DeliveryListViewModel()

    var body: some View {

        List {

            if deliveries.isEmpty {

                ContentUnavailableView(
                    "No Deliveries Found",
                    systemImage: "shippingbox",
                    description: Text(
                        "Your delivery records will appear here."
                    )
                )

            } else {

                ForEach(
                    viewModel.sortDeliveries(deliveries),
                    id: \.id
                ) { delivery in
                    NavigationLink {
                        DeliveryDetailsView(delivery: delivery)
                    } label: {
                        DeliveryRowView(delivery: delivery)
                    }
                    
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Delivery List")
        .navigationBarTitleDisplayMode(.large)
    }
}
