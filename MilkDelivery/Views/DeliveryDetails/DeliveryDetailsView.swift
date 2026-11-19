
import SwiftUI
import SwiftData

struct DeliveryDetailsView: View {

    var delivery: Delivery

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel = DeleteDeliveryViewModel()
    @State private var showDeleteConfirmation = false

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                VStack(spacing: 12) {

                    Image(systemName: delivery.item == "Milk"
                          ? "waterbottle.fill"
                          : "newspaper.fill")
                        .font(.system(size: 45))
                        .foregroundStyle(.blue)

                    Text(delivery.item)
                        .font(.title)
                        .fontWeight(.bold)

                    Text(delivery.status)
                        .font(.headline)
                        .foregroundStyle(
                            delivery.status == "Delivered" ? .green : .red
                        )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            (delivery.status == "Delivered" ? Color.green : Color.red)
                                .opacity(0.12)
                        )
                        .clipShape(Capsule())
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 16) {

                    Text("Delivery Information")
                        .font(.headline)

                    detailRow(
                        title: "Delivery Date",
                        value: delivery.date.formatted(
                            date: .long,
                            time: .omitted
                        )
                    )

                    Divider()

                    detailRow(title: "Item", value: delivery.item)

                    Divider()

                    detailRow(
                        title: "Quantity",
                        value: "\(delivery.quantity)"
                    )

                    Divider()

                    detailRow(
                        title: "Rate per item",
                        value: "₹\(String(format: "%.2f", delivery.rate))"
                    )

                    Divider()

                    detailRow(
                        title: "Total Amount",
                        value: delivery.totalAmount.formatted(
                            .currency(code: "INR")
                                .locale(Locale(identifier: "en_IN"))
                        )
                    )
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 10) {

                    Text("Notes")
                        .font(.headline)

                    Text(
                        delivery.notes.isEmpty
                        ? "No notes available"
                        : delivery.notes
                    )
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                NavigationLink {
                    EditDeliveryView(delivery: delivery)
                } label: {
                    Image(systemName: "pencil")
                }

                Button {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
            }
        }

        .confirmationDialog(
            "Delete Delivery?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {

            Button("Delete", role: .destructive) {

                let deleted = viewModel.deleteDelivery(
                    delivery: delivery,
                    context: modelContext
                )

                if deleted {
                    dismiss()
                }
            }

            Button("Cancel", role: .cancel) { }

        } message: {
            Text("Are you sure you want to permanently delete this delivery?")
        }

        .alert(
            "Error",
            isPresented: Binding(
                get: { !viewModel.errorMessage.isEmpty },
                set: {
                    if !$0 {
                        viewModel.errorMessage = ""
                    }
                }
            )
        ) {
            Button("OK") {
                viewModel.errorMessage = ""
            }
        } message: {
            Text(viewModel.errorMessage)
        }
    }

    private func detailRow(title: String, value: String) -> some View {

        HStack {

            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.medium)
                .multilineTextAlignment(.trailing)
        }
    }
}

