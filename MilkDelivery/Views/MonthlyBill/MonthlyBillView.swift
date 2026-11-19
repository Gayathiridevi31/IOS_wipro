
import SwiftUI
import SwiftData

struct MonthlyBillView: View {

    @Query private var deliveries: [Delivery]

    @State private var viewModel = MonthlyBillViewModel()

    private var summary: MonthlyBillSummary {
        viewModel.calculateBill(deliveries: deliveries)
    }

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                VStack(alignment: .leading, spacing: 12) {

                    Text("Select Billing Month")
                        .font(.headline)

                    DatePicker(
                        "Month",
                        selection: $viewModel.selectedMonth,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)

                    Text(
                        viewModel.selectedMonth.formatted(
                            .dateTime.month(.wide).year()
                        )
                    )
                    .font(.title2)
                    .fontWeight(.bold)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(spacing: 8) {

                    Text("Total Payable Amount")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.8))

                    Text(
                        summary.totalAmount.formatted(
                            .currency(code: "INR")
                                .locale(Locale(identifier: "en_IN"))
                        )
                    )
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(25)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 16) {

                    Text("Bill Breakdown")
                        .font(.headline)

                    billRow(
                        title: "Milk Quantity",
                        value: "\(summary.milkQuantity)"
                    )

                    Divider()

                    billRow(
                        title: "Milk Charges",
                        value: formatAmount(summary.milkAmount)
                    )

                    Divider()

                    billRow(
                        title: "Newspaper Quantity",
                        value: "\(summary.newspaperQuantity)"
                    )

                    Divider()

                    billRow(
                        title: "Newspaper Charges",
                        value: formatAmount(summary.newspaperAmount)
                    )

                    Divider()

                    billRow(
                        title: "Skipped Days",
                        value: "\(summary.skippedDays)"
                    )

                    Divider()

                    billRow(
                        title: "Total Payable",
                        value: formatAmount(summary.totalAmount),
                        isBold: true
                    )
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle("Monthly Bill")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func billRow(
        title: String,
        value: String,
        isBold: Bool = false
    ) -> some View {

        HStack {

            Text(title)
                .fontWeight(isBold ? .bold : .regular)

            Spacer()

            Text(value)
                .fontWeight(isBold ? .bold : .medium)
        }
    }

    private func formatAmount(_ amount: Double) -> String {

        amount.formatted(
            .currency(code: "INR")
                .locale(Locale(identifier: "en_IN"))
        )
    }
}

