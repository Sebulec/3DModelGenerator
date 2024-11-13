import ARKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var sessionHandler: SessionHandler
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
        
        guard ARConfiguration.isSupported else { return arView }
        
        sessionHandler.arView = arView
        arView.session.delegate = sessionHandler
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
}
