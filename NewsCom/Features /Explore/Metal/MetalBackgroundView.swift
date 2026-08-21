//
//  MetalBackgroundView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 26/06/26.
//

import UIKit
internal import MetalKit

class MetalBackgroundView: MTKView {

    private var renderer: ShaderRenderer!

    override init(frame: CGRect, device: MTLDevice?) {

        let metalDevice = MTLCreateSystemDefaultDevice()

        super.init(frame: frame, device: metalDevice)

        commonInit()
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    private func commonInit() {

        framebufferOnly = false

        colorPixelFormat = .bgra8Unorm

        renderer = ShaderRenderer(metalView: self)

        delegate = renderer
    }
}
