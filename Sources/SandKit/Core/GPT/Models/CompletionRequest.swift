//
//  Copyright © 2023 Dennis Müller and all collaborators
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation


public struct CompletionRequest {

    /// The model to use.
    ///
    /// The default is to use the current model, that continuously receives updates.
    public var model: String
  
    /// The prompt for the request.
    public var prompt: String

    /// The suffix that comes after a completion.
    public var suffix: String?

    /// The maximum number of tokens allowed for the response. If this is `nil`, it will default to allow the maximum number of tokens (4096 - message tokens). This does not mean, that all answers will generate that many tokens.
    public var maximumTokens: Int?

    /// The temperature for the request. This determines the randomness of the response.
    public var temperature: Double?

    /// An alternative way of controlling the temperature. Do not use at the same time as `temperature`.
    public var topP: Double?

    /// The number of answers that GPT should generate.
    ///
    /// The default is 1.
    public var numberOfAnswers: Double?

    public var logProbabilities: Int?

    public var includePromptsInResponse: Bool

    public var stopSequences: [String]?

    /// A mechanism to penalize the occurrence of new tokens based on whether they appear in the text so far.
    ///
    /// Should be a number between `-2.0` and `2.0`.
    public var presencePenalty: Double?

    /// A mechanism to penalize the occurrence of new tokens based on their frequency in the text.
    ///
    /// Should be a number between `-2.0` and `2.0`.
    public var frequencyPenalty: Double?

    /// Generates n results server-side, where n is the provided value, and returns the one with the highest log probability per token.
    public var bestOf: Int?

    /// Modifies the likelihood of specified tokens appearing in the answer.
    ///
    /// This maps token IDs to their bias value.
    public var logitBias: [String: Double]?

    /// An optional user identifier to help detect misuse of the API.
    public var user: String?

    var stream: Bool

    /// A chat request is the main interface to ChatGPT's API.
    public init(
        model: GPTModel = .davinci,
        prompt: String,
        suffix: String? = nil,
        maximumTokens: Int? = nil,
        temperature: Double? = nil,
        topP: Double? = nil,
        numberOfAnswers: Double? = nil,
        logProbabilities: Int? = nil,
        includePromptsInResponse: Bool = false,
        stopSequences: [String]? = nil,
        presencePenalty: Double? = nil,
        frequencyPenalty: Double? = nil,
        bestOf: Int? = nil,
        logitBias: [String : Double]? = nil,
        user: String? = nil
    ) {
        self.model = model.rawValue
        self.prompt = prompt
        self.suffix = suffix
        self.maximumTokens = maximumTokens
        self.temperature = temperature
        self.topP = topP
        self.numberOfAnswers = numberOfAnswers
        self.logProbabilities = logProbabilities
        self.includePromptsInResponse = includePromptsInResponse
        self.stopSequences = stopSequences
        self.presencePenalty = presencePenalty
        self.frequencyPenalty = frequencyPenalty
        self.bestOf = bestOf
        self.logitBias = logitBias
        self.user = user
        self.stream = false
    }

    /// Convenience initializer that sets the model to `davinci` and configures the request with the provided closure.
    /// - Parameters:
    ///   - prompt: The prompt for the request.
    ///   - configure: the configuration.
    /// - Returns: A configured instance of `CompletionRequest`.
    public static func davinci(prompt: String, configuration configure: ((_ request: inout CompletionRequest) -> Void)? = nil) -> CompletionRequest {
        var request = CompletionRequest(model: .davinci, prompt: prompt)
        configure?(&request)
        return request
    }

    static func streamed(model: GPTModel, prompt: String) -> Self {
        var request = CompletionRequest(model: model, prompt: prompt)
        request.stream = true
        return request
    }
}

extension CompletionRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case model
        case prompt
        case suffix
        case maximumTokens = "max_tokens"
        case temperature
        case topP = "top_p"
        case logProbabilities = "logprobs"
        case includePromptsInResponse = "echo"
        case stopSequences = "stop"
        case numberOfAnswers = "n"
        case presencePenalty = "presence_penalty"
        case frequencyPenalty = "frequency_penalty"
        case bestOf = "best_of"
        case logitBias = "logit_bias"
        case stream
        case user
    }
}

public struct CompletionRequestAzure {

//    /// The model to use.
//    ///
//    /// The default is to use the current model, that continuously receives updates.
//    public var model: String
  
    /// The prompt for the request.
    public var prompt: String

    /// The suffix that comes after a completion.
    public var suffix: String?

    /// The maximum number of tokens allowed for the response. If this is `nil`, it will default to allow the maximum number of tokens (4096 - message tokens). This does not mean, that all answers will generate that many tokens.
    public var maximumTokens: Int?

    /// The temperature for the request. This determines the randomness of the response.
    public var temperature: Double?

    /// An alternative way of controlling the temperature. Do not use at the same time as `temperature`.
    public var topP: Double?

    /// The number of answers that GPT should generate.
    ///
    /// The default is 1.
    public var numberOfAnswers: Double?

    public var logProbabilities: Int?

    public var includePromptsInResponse: Bool

    public var stopSequences: [String]?

    /// A mechanism to penalize the occurrence of new tokens based on whether they appear in the text so far.
    ///
    /// Should be a number between `-2.0` and `2.0`.
    public var presencePenalty: Double?

    /// A mechanism to penalize the occurrence of new tokens based on their frequency in the text.
    ///
    /// Should be a number between `-2.0` and `2.0`.
    public var frequencyPenalty: Double?

    /// Generates n results server-side, where n is the provided value, and returns the one with the highest log probability per token.
    public var bestOf: Int?

    /// Modifies the likelihood of specified tokens appearing in the answer.
    ///
    /// This maps token IDs to their bias value.
    public var logitBias: [String: Double]?

    /// An optional user identifier to help detect misuse of the API.
    public var user: String?

    var stream: Bool

    /// A chat request is the main interface to ChatGPT's API.
    public init(
        prompt: String,
        suffix: String? = nil,
        maximumTokens: Int? = nil,
        temperature: Double? = nil,
        topP: Double? = nil,
        numberOfAnswers: Double? = nil,
        logProbabilities: Int? = nil,
        includePromptsInResponse: Bool = false,
        stopSequences: [String]? = nil,
        presencePenalty: Double? = nil,
        frequencyPenalty: Double? = nil,
        bestOf: Int? = nil,
        logitBias: [String : Double]? = nil,
        user: String? = nil
    ) {
        self.prompt = prompt
        self.suffix = suffix
        self.maximumTokens = maximumTokens
        self.temperature = temperature
        self.topP = topP
        self.numberOfAnswers = numberOfAnswers
        self.logProbabilities = logProbabilities
        self.includePromptsInResponse = includePromptsInResponse
        self.presencePenalty = presencePenalty
        self.frequencyPenalty = frequencyPenalty
        self.bestOf = bestOf
        self.logitBias = logitBias
        self.user = user
        self.stream = false
    }
    
    public init(
        prompt: String,
        config: PromptConfig
    ) {
        self.prompt = prompt
        self.suffix = nil
        self.maximumTokens = config.maximumTokens
        self.temperature = config.useTopP ? nil : config.temperature
        self.topP = config.useTopP ? config.topP : nil
        self.numberOfAnswers = config.numberOfAnswers
        self.stopSequences = config.stop
        self.logProbabilities = nil
        self.includePromptsInResponse = false
        self.presencePenalty = config.presencePenalty
        self.frequencyPenalty = config.frequencyPenalty
        self.logitBias = config.logitBias
        self.user = config.user
        self.stream = false
    }

    /// Convenience initializer that sets the model to `davinci` and configures the request with the provided closure.
    /// - Parameters:
    ///   - prompt: The prompt for the request.
    ///   - configure: the configuration.
    /// - Returns: A configured instance of `CompletionRequest`.
    public static func complete(prompt: String, configuration configure: ((_ request: inout CompletionRequestAzure) -> Void)? = nil) -> CompletionRequestAzure {
        var request = CompletionRequestAzure(prompt: prompt)
        configure?(&request)
        return request
    }

//    static func streamed(model: GPTModel, prompt: String) -> Self {
//        var request = CompletionRequestAzure(model: model, prompt: prompt)
//        request.stream = true
//        return request
//    }
}

extension CompletionRequestAzure: Codable {
    enum CodingKeys: String, CodingKey {
        case prompt
        case suffix
        case maximumTokens = "max_tokens"
        case temperature
        case topP = "top_p"
        case logProbabilities = "logprobs"
        case includePromptsInResponse = "echo"
        case stopSequences = "stop"
        case numberOfAnswers = "n"
        case presencePenalty = "presence_penalty"
        case frequencyPenalty = "frequency_penalty"
        case bestOf = "best_of"
        case logitBias = "logit_bias"
        case stream
        case user
    }
}
