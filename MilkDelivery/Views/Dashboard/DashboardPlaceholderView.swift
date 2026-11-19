import SwiftUI

struct DashboardPlaceholderView: View {

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 65))
                    .foregroundStyle(.green)

                Text("Login Successful!")
                    .font(.title)
                    .bold()

                Text("Welcome to Milk & Newspaper Delivery Log")
                    .multilineTextAlignment(.center)
            }
            .padding()
            .navigationTitle("Dashboard")
        }
    }
}
