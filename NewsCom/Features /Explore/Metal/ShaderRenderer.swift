

//ShaderRenderer

internal import MetalKit

class ShaderRenderer: NSObject {

    private let device: MTLDevice
    private let commandQueue: MTLCommandQueue
    private let pipelineState: MTLRenderPipelineState

    private var startTime = CACurrentMediaTime()
    private var uniformBuffer: MTLBuffer!

    init(metalView: MTKView) {

        guard
            let device = metalView.device,
            let commandQueue = device.makeCommandQueue()
        else {
            fatalError("Metal unavailable")
        }

        self.device = device
        self.commandQueue = commandQueue

        // Load shader functions
        let library = device.makeDefaultLibrary()!

        let vertexFunction = library.makeFunction(name: "vertex_main")!
        let fragmentFunction = library.makeFunction(name: "fragment_main")!

        // Pipeline descriptor
        let descriptor = MTLRenderPipelineDescriptor()

        descriptor.vertexFunction = vertexFunction
        descriptor.fragmentFunction = fragmentFunction
        descriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat

        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: descriptor)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        uniformBuffer = device.makeBuffer(length: MemoryLayout<ShaderUniforms>.stride, options: [])

        super.init()
    }
}

extension ShaderRenderer: MTKViewDelegate {

    func draw(in view: MTKView) {

        guard
            let drawable = view.currentDrawable,
            let renderPassDescriptor = view.currentRenderPassDescriptor
        else {
            return
        }

        let commandBuffer = commandQueue.makeCommandBuffer()!

        let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!

        encoder.setRenderPipelineState(pipelineState)
        
        let elapsed = Float(CACurrentMediaTime() - startTime)

        var uniforms = ShaderUniforms(time: elapsed, resolution: SIMD2<Float>(Float(view.drawableSize.width), Float(view.drawableSize.height)))

        memcpy(uniformBuffer.contents(), &uniforms, MemoryLayout<ShaderUniforms>.stride)

        encoder.setFragmentBuffer(uniformBuffer, offset: 0, index: 0)

        // Draw 4 vertices
        encoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)

        encoder.endEncoding()

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
}
