
import SwiftUI

struct InputView: View {
    @Binding var isShowingSheet: Bool
    @State var isLoading: Bool = false
    
    @State private var message: String = ""
    
    @State private var errorMessage: String?
    @State private var alertIsPresented = false
    
    @EnvironmentObject private var sessionHandler: SessionHandler
    @EnvironmentObject private var entityService: EntityService
    
    var body: some View {
        HStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                TextField("Type a message...", text: $message)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                
                Button {
                    sendMessage()
                } label: {
                    Text("Send")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(Color(.white))
                        .cornerRadius(20)
                        .disabled(message.isEmpty)
                }
                .disabled(message.isEmpty)
            }
        }
        .padding()
        .alert(errorMessage ?? "", isPresented: $alertIsPresented) {
            Button("OK", role: .cancel) {}
        }
    }
    
    private func sendMessage() {
        let input = message
        withAnimation {
            isLoading = true
            message = ""
        }

        Task {
            await loadEntity(input)
        }
    }
    
    private func loadEntity(_ input: String) async {
        do {
            guard let entity = try await entityService.fetchEntity(input: input) else { return }
            sessionHandler.addEntity(entity)
        } catch {
            alertIsPresented = true
            self.errorMessage = "Failed to fetch 3D model"
        }
        withAnimation {
            isLoading = false
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputView(isShowingSheet: .constant(true))
            InputView(isShowingSheet: .constant(true), isLoading: true)
        }
    }
}
