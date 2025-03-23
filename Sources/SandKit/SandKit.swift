//
//  SandKit.swift
//
//
//  Created by Ritesh Pakala Rao on 5/5/23.
//  More info on MLX and Swift: https://github.com/ml-explore/mlx-swift-examples
//

import Foundation
import MLX
import MLXLLM
import MLXLMCommon
import MLXRandom
import Tokenizers

public class SandKit {
    var modelInfo = ""
    
    let modelConfiguration = LLMModels.DeepSeek.Local.r1_32_distill_qwen_4bit

    /// Parameters controlling the output length
    let maxTokens: Int

    /// update the display every N tokens -- 4 looks like it updates continuously
    /// and is low overhead.  observed ~15% reduction in tokens/s when updating on every N token
    let displayEveryNTokens: Int

    public enum LoadState {
        case idle
        case loaded(ModelContainer)
    }

    public var loadState = LoadState.idle
    
    public init(maxTokens: Int = 4800,
                displayEveryNTokens: Int = 4) {
        self.maxTokens = maxTokens
        self.displayEveryNTokens = displayEveryNTokens
    }
    
    package func load() async throws -> ModelContainer {
        switch loadState {
        case .idle:
            // limit the buffer cache
            MLX.GPU.set(cacheLimit: 100 * 1024 * 1024)
            
            let modelContainer = try await LLMModelFactory.shared.loadContainer(
                configuration: modelConfiguration
            ) {
                [modelConfiguration] progress in
                Task { @MainActor in
                    self.modelInfo =
                    "Downloading \(modelConfiguration.name): \(Int(progress.fractionCompleted * 100))%"
                }
            }
            let numParams = await modelContainer.perform { context in
                context.model.numParameters()
            }
            
            self.modelInfo =
            "Loaded \(modelConfiguration.id).  Weights: \(numParams / (1024*1024))M"
            loadState = .loaded(modelContainer)
            
            print("[SandKit] Loaded model container.")
            
            return modelContainer
            
        case .loaded(let modelContainer):
            print("[SandKit] Model container already loaded.")
            return modelContainer
        }
    }
}
