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

import Foundation

public struct API {
    private init() {}
    public static let base = "https://api.openai.com/"
    public static let v1ChatCompletion = "v1/chat/completions"
    public static let v1Completion = "v1/completions"
    public static let v1Models = "v1/models"

    public static func v1Model(withId id: String) -> String {
        "v1/models/\(id)"
    }
}

public struct AZURE_API {
    private init() {}
    public static let base = "https://{RESOURCE}.openai.azure.com/"
    public static let v1ChatCompletion = "openai/deployments/{DEPLOYMENT}/chat/completions"
    public static let v1Completion = "openai/deployments/{DEPLOYMENT}/completions"
    public static let v1Models = "v1/models"

    public static func v1Model(withId id: String) -> String {
        "v1/models/\(id)"
    }
}

public enum APITYPE: String, Equatable, Codable {
    case azure
    case openai
}

