//
//  SandKit.Generate.swift
//  SandKit
//
//  Created by Ritesh Pakala on 3/23/25.
//

import MLX
import MLXLLM
import MLXRandom
import Foundation
import MLXLMCommon

extension SandKit {
    public func generate(
        prompt: String,
        systemPrompt: String? = nil,
        config: PromptConfig,
        stream: Bool = true,
        output: (String, Bool) -> Void
    ) async throws {
        let modelContainer = try await load()
        MLXRandom.seed(UInt64(Date.timeIntervalSinceReferenceDate * 1000))
        
        let generateParameters = GenerateParameters(
            temperature: Float(config.temperature ?? 0.5),
            topP: Float(config.topP ?? 1.0)
        )
        
        let sanitizedPrompt: String
        
        if let systemPrompt {
            sanitizedPrompt = "<system>\(systemPrompt)</system>\n\(prompt)"
        } else {
            sanitizedPrompt = prompt
        }
        
        var currentOutput: String = ""
        
        let result = try await modelContainer.perform { context in
            let input = try await context.processor.prepare(input: .init(prompt: sanitizedPrompt))
            
            return try MLXLMCommon.generate(
                input: input, parameters: generateParameters, context: context
            ) { tokens in
                // update the output -- this will make the view show the text as it generates
                
                if stream {
                    if tokens.count % displayEveryNTokens == 0 {
                        let text = context.tokenizer.decode(tokens: tokens)
                        
                        if let result = Postprocessor.sanitize(text) {
                            currentOutput = result
                            output(result, false)
                        }
                    }
                }
                
                if tokens.count >= maxTokens {
                    return .stop
                } else {
                    return .more
                }
            }
        }
        
        if let result = Postprocessor.sanitize(result.output) {
            output(result, true)
        }
    }
}
