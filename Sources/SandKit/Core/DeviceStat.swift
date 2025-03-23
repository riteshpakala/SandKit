//
//  DeviceStat.swift
//  SandKit
//
//  Created by Ritesh Pakala on 3/23/25.
//  From: https://github.com/ml-explore/mlx-swift-examples/blob/main/Applications/LLMEval/ViewModels/DeviceStat.swift

import Foundation
import MLX

@Observable
final public class DeviceStat: @unchecked Sendable {

    @MainActor
    public var gpuUsage = GPU.snapshot()

    @MainActor
    public var deviceMemoryUsage: String {
        gpuUsage.activeMemory.formatted(.byteCount(style: .memory))
    }
    
    public var GPUMemoryLimit: String {
        GPU.memoryLimit.formatted(.byteCount(style: .memory))
    }
    
    @MainActor
    public var memoryDetailedInfo: String {
        """
        Active Memory: \(deviceMemoryUsage)/\(GPUMemoryLimit))
        Cache Memory: \(gpuUsage.cacheMemory.formatted(.byteCount(style: .memory)))/\(GPU.cacheLimit.formatted(.byteCount(style: .memory)))
        Peak Memory: \(gpuUsage.peakMemory.formatted(.byteCount(style: .memory)))
        """
    }
    
    private let initialGPUSnapshot = GPU.snapshot()
    private var timer: Timer?

    public init() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.updateGPUUsages()
        }
    }

    deinit {
        timer?.invalidate()
    }

    private func updateGPUUsages() {
        let gpuSnapshotDelta = initialGPUSnapshot.delta(GPU.snapshot())
        DispatchQueue.main.async { [weak self] in
            self?.gpuUsage = gpuSnapshotDelta
        }
    }

}
