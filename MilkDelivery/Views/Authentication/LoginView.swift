import SwiftUI

struct LoginView: View {

    @State private var viewModel = AuthenticationViewModel()

    var body: some View {

        Group {

            if viewModel.isAuthenticated {

                DashboardView()

            }else {

                loginScreen
            }
        }
        .task {
            if !viewModel.isAuthenticated &&
                !viewModel.showManualLogin {

                await viewModel.authenticateWithFaceID()
            }
        }
    }

    var loginScreen: some View {

        ZStack {

            Color(red: 0.04, green: 0.08, blue: 0.15)
                .ignoresSafeArea()

            VStack(spacing: 25) {

                Spacer()

                Image(systemName: "newspaper.fill")
                    .font(.system(size: 65))
                    .foregroundStyle(.white)

                Text("Daily Delivery Log")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                Text("Milk & Newspaper Management")
                    .foregroundStyle(.gray)

                Spacer()

                if viewModel.showManualLogin {

                    manualLoginForm

                } else {

                    Button {
                        Task {
                            await viewModel.authenticateWithFaceID()
                        }
                    } label: {

                        VStack(spacing: 12) {

                            Image(systemName: "faceid")
                                .font(.system(size: 55))

                            Text("Login with Face ID")
                                .font(.headline)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }

                    Button("Use Manual Login") {
                        viewModel.showManualLogin = true
                    }
                    .foregroundStyle(.white)
                }

                Spacer()

                Text("Securely manage your daily deliveries")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(25)
        }
        .preferredColorScheme(.dark)
    }

    var manualLoginForm: some View {

        VStack(spacing: 18) {

            Text("Manual Login")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)

            TextField("Email Address", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color.white)
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.white)
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            if !viewModel.errorMessage.isEmpty {

                Text(viewModel.errorMessage)
                    .foregroundStyle(.red)
                    .font(.caption)
            }

            Button {
                viewModel.manualLogin()
            } label: {

                Text("Login")
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

        }
    }
}
