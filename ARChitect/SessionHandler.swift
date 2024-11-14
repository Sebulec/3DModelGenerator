import ARKit
import GLTFKit2

final class SessionHandler: NSObject, ObservableObject {
    weak var arView: ARSCNView?
    
    fileprivate var screenCenter: CGPoint?
    
    func addEntity(_ entity: Entity) {
        GLTFAsset.load(with: entity.url, options: [:]) { (progress, status, asset, error, _) in
            guard let asset else { return }
            let scene = GLTFKit2.SCNScene.init(gltfAsset: asset)
            
            guard let boxNode = scene.rootNode.childNodes.first else { return }
            
            let planeAnchor = ARAnchor(name: "horizontalPlane", transform: simd_float4x4(SCNMatrix4Identity))
            
            guard let arView = self.arView else { return }
            
            if let position = self.performHitTestForHorizontalPlane(in: arView) {
                boxNode.position = position
            }
            
            arView.session.add(anchor: planeAnchor)
            
            let anchorNode = SCNNode()
            anchorNode.addChildNode(boxNode)
            
            arView.scene.rootNode.addChildNode(anchorNode)
        }
    }
    
    private func performHitTestForHorizontalPlane(in arView: ARSCNView) -> SCNVector3? {
        guard let screenCenter, let raycastQuery = arView.raycastQuery(from: screenCenter, allowing: .estimatedPlane, alignment: .horizontal) else {
            return nil
        }
        
        let results = arView.session.raycast(raycastQuery)
        
        if let result = results.first {
            let translation = result.worldTransform.columns.3
            let position = SCNVector3(x: translation.x, y: translation.y, z: translation.z)
            
            return position
        }
        
        return nil
    }
}

extension SessionHandler: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if screenCenter == nil, let arView = self.arView {
            DispatchQueue.main.async {
                self.screenCenter = CGPoint(x: arView.bounds.midX, y: arView.bounds.midY)
            }
        }
    }
}
