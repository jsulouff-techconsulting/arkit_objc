//
//  SwiftUIARView.swift
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/12/25.
//

import SwiftUI
import ARKit
import RealityKit


public struct SwiftUIARView: View {
    var arViewRef:DemoARView {
        return self.arViewRep.view
    }
    let arViewRep:DemoARViewRepresentable
    
    // lesson learned: if you need a reference to the uiview directly for buttons or whatever, do this
    init(arView:DemoARView = DemoARView()) {
        let rep = DemoARViewRepresentable()
        self.arViewRep = rep
    }
    
    public var body: some View {
        self.arViewRep
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                VStack {
                    HStack {
                        Button("Add Cube") {
                            let _ = self.arViewRef.placeBlock()
                        }
                        Button("Cleanup Objects") {
                            let _ = self.arViewRef.cleanup()
                        }
                    }
                    Button("Select Object") {
                        
                    }
                    Spacer()
                }
            }
    }
}

struct DemoARViewRepresentable: UIViewRepresentable {
    var view:DemoARView = DemoARView()
    
    func makeUIView(context: Context) -> DemoARView {
        return self.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

import Combine
class DemoARView: ARView {
    typealias BlockId = Int
    typealias Block = AnchorEntity
    
    enum CustomErrors: Error {
        case notImplemented, raycastFailed
    }
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    required dynamic init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    convenience required init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    var cancellables:[AnyCancellable] = []
    
    static let objName = "visionTest.usdc"
    
    lazy var modelPreCache:ModelEntity? = try? ModelEntity.loadModel(named: Self.objName)
    func initModelCache() {
        Task {
            
            
            
            do {
                // FIXME: it doesnt like this, try to shove into sync bg thread
                // TODO: do a raycast to place the object
                self.modelPreCache = try ModelEntity.loadModel(named: Self.objName)
                self.modelPreCache?.scale *= 0.2 // make it not huge
            }
            catch (let err) {
                debugPrint("Failed to init model precache.")
                sleep(5)
                debugPrint("retrying model precache")
                self.initModelCache()
            }
        }
    }
    
    
    var blocks:[Block] = []
    func placeBlock() -> Future<BlockId, any Error> {
        
        let future = Future<BlockId, any Error> {
            [weak self] promise in
            
            // if gone, dont bother
            if let self = self {
                
                guard let query = self.makeRaycastQuery(from: self.center, allowing: .estimatedPlane, alignment: .horizontal) else {
                    promise(.failure(Self.CustomErrors.raycastFailed));
                    return
                }
                
                guard let result = self.session.raycast(query).first else {
                    promise(.failure(Self.CustomErrors.raycastFailed));
                    return;
                }
                
                do {
                    if let ent = self.modelPreCache {
                        let anchor = AnchorEntity(world: result.worldTransform)
                        anchor.addChild(ent)
                        
                        // FIXME: doing this really fast will create a race condition
                        let id = self.blocks.count
                        self.blocks.append(anchor)
                        
                        self.scene.addAnchor(anchor)
                        promise(.success(id))
                    }
                    else {
                        debugPrint("The model is not cached.")
                    }
                }
                catch (let err) {
                    promise(.failure(err))
                }
            }
        }
        future.sink(receiveCompletion: {_ in}, receiveValue: {_ in}).store(in: &self.cancellables) // shove into cancellables with dummy sink to keep alive
        return future
    }
    
    func trySelectBlock() -> Future<BlockId, any Error> {
        let future = Future<BlockId, any Error> {
            promise in
            // TODO: Not Implemented
            promise(.failure(Self.CustomErrors.notImplemented))
        }
        future.sink(receiveCompletion: {_ in}, receiveValue: {_ in}).store(in: &self.cancellables)
        return future
    }
    
    func deleteBlock(block:BlockId) -> Future<(), any Error> {
        let future = Future<(), any Error> {
            promise in
            // TODO: Not Implemented
            promise(.failure(Self.CustomErrors.notImplemented))
        }
        future.sink(receiveCompletion: {_ in}, receiveValue: {_ in}).store(in: &self.cancellables)
        return future
    }
    
    func cleanup() -> Future<(), any Error> {
        let future = Future<(), any Error> {
            [weak self] promise in
            self?.scene.anchors.removeAll()
            promise(.success(()))
        }
        future.sink(receiveCompletion: {_ in}, receiveValue: {}).store(in: &self.cancellables)
        return future
    }
    
}

#Preview {
    SwiftUIARView()
}
