import SwiftUI
import SwiftData

struct DashboardView: View {

    @Query(sort: \Delivery.date, order: .reverse)
    private var deliveries: [Delivery]

    @State private var viewModel = DashboardViewModel()

    private var summary: DashboardSummary {

        viewModel.getDashboardSummary(
            deliveries: deliveries
        )
    }

    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 25) {

                    VStack(alignment: .leading, spacing: 5) {

                        Text("Welcome Back!")
                            .font(.title2)
                            .bold()

                        Text("Your daily delivery overview")
                            .foregroundStyle(.secondary)
                    }

                    Text("Monthly Overview")
                        .font(.headline)

                    LazyVGrid(
                        columns: columns,
                        spacing: 15
                    ) {

                        DashboardSummaryCard(
                            title: "Deliveries This Month",
                            value: "\(summary.totalDeliveries)",
                            icon: "shippingbox.fill",
                            color: .blue
                        )

                        DashboardSummaryCard(
                            title: "Days Skipped",
                            value: "\(summary.skippedDays)",
                            icon: "calendar.badge.minus",
                            color: .orange
                        )

                        DashboardSummaryCard(
                            title: "Amount Payable",
                            value: summary.payableAmount.formatted(
                                .currency(code: "INR")
                                .locale(Locale(identifier: "en_IN"))
                            ),
                            icon: "indianrupeesign.circle.fill",
                            color: .green
                        )

                        DashboardSummaryCard(
                            title: "Delivery Records",
                            value: "\(deliveries.count)",
                            icon: "list.bullet.rectangle.fill",
                            color: .purple
                        )
                    }

                    TodayDeliveryStatusView(
                        status: summary.todayStatus
                    )

                    Text("Quick Actions")
                        .font(.headline)

                    VStack(spacing: 12) {

                        NavigationLink {

                            DeliveryListView()

                        } label: {

                            quickAction(
                                title: "View Deliveries",
                                icon: "list.bullet",
                                color: .blue
                            )
                        }
                        NavigationLink {
                            AddDeliveryView()
                        } label: {
                            Label("Add Delivery", systemImage: "plus.circle")
                        }
                        NavigationLink {
                            SearchFilterView()
                        } label: {
                            Label("Search Deliveries", systemImage: "magnifyingglass")
                        }

                        NavigationLink {
                            MonthlyBillView()
                        } label: {
                            Label("Monthly Bill", systemImage: "indianrupeesign.circle")
                        }
                        NavigationLink {
                            Text("Monthly Bill - Coming Soon")
                                .navigationTitle("Monthly Bill")
                        } label: {

                            quickAction(
                                title: "View Monthly Bill",
                                icon: "indianrupeesign.circle",
                                color: .orange
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "person.circle")
                        .font(.title2)
                }
            }
        }
    }

    func quickAction(
        title: String,
        icon: String,
        color: Color
    ) -> some View {

        HStack(spacing: 15) {

            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)

            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
