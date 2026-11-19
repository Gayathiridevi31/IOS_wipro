
import SwiftUI

struct DeliveryRecordPreviewView: View {

    var delivery: Delivery

    var body: some View {

        Form {

            Section("Delivery Information") {

                LabeledContent(
                    "Date",
                    value: delivery.date.formatted(
                        date: .long,
                        time: .omitted
                    )
                )

                LabeledContent(
                    "Item",
                    value: delivery.item
                )

                LabeledContent(
                    "Quantity",
                    value: "\(delivery.quantity)"
                )

                LabeledContent(
                    "Rate",
                    value: "₹\(String(format: "%.2f", delivery.rate))"
                )
            }

            Section("Status") {

                LabeledContent(
                    "Delivery Status",
                    value: delivery.status
                )
            }

            Section("Payment") {

                LabeledContent(
                    "Total Amount",
                    value: delivery.totalAmount.formatted(
                        .currency(code: "INR")
                            .locale(Locale(identifier: "en_IN"))
                    )
                )
            }

            Section("Notes") {

                Text(
                    delivery.notes.isEmpty
                    ? "No notes available"
                    : delivery.notes
                )
            }
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

