/*
 * Copyright 2024 Raonsecure
 */

import Foundation

public struct CommunicationSDKError: Error {
    public var code: String
    public var message: String
}

protocol CommunicationAPIErrorProtocol {
    func getCodeAndMessage() -> (String, String)
    func getError() -> CommunicationSDKError
}

extension CommunicationAPIErrorProtocol {
    func getError() -> CommunicationSDKError {
        let (code, message) = getCodeAndMessage()
        return .init(code: "MSDKCMM" + code, message: message)
    }
}

enum CommunicationAPIError: CommunicationAPIErrorProtocol {
    case unknown
    case incorrectURLconnection
    case invaildParameter
    case serverFail(String)

    public func getCodeAndMessage() -> (String, String) {
        switch self {
        case .unknown:
            return ("00000", "unknown error")
        case .incorrectURLconnection:
            return ("00001", "incorrect url connection")
        case .invaildParameter:
            return ("00002", "invaild parameter")
        case .serverFail(let message):
            return ("00003", "\(String(describing: message))")
        }
    }
}
