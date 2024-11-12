import SwiftUI

struct ContentView: View {
    private let sessionHandler = SessionHandler()
    private let entityService = EntityService(
        entityRepository: EntityRepositoryImpl()
    )
    @State private var isShowingSheet = true
    
    var body: some View {
        ARViewContainer(sessionHandler: sessionHandler)
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $isShowingSheet, onDismiss: {
                isShowingSheet = true
            }) {
                InputView(isShowingSheet: $isShowingSheet)
                    .environmentObject(entityService)
                    .environmentObject(sessionHandler)
                    .presentationDetents([.fraction(0.1)])
            }
    }
}
