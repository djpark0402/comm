/*
 * Copyright 2024 Raonsecure
 */
// IMS-772 진행중
import Foundation

public class CommnunicationClient: CommnunicationProtocol {
    
    // 
    public init() {
        
    }
    
    /// Retrieves data from the specified URL in an asynchronous manner using the GET method.
    /// - Parameters:
    ///   - url: The URL to retrieve data from.
    /// - Returns: Data object containing the retrieved data from the URL.
    /// - Throws: CommunicationAPIError with the error code FAIL if the HTTP response status code is not 200.
    public func doGet(url: URL) async throws -> Data {
        
        CommunicationLogger.shared.debug("\n************** requestUrl: \(url.absoluteString) **************")
        
        guard !url.absoluteString.isEmpty else {
            throw CommunicationAPIError.invaildParameter.getError()
        }
        
        do {
            var request = URLRequest(url: url)
            request.timeoutInterval = 15
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                CommunicationLogger.shared.debug("statusCode: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                CommunicationLogger.shared.debug("resultData: \(String(describing: String(data: data, encoding: .utf8)))\n")
                throw CommunicationAPIError.serverFail((String(describing: String(data: data, encoding: .utf8)))).getError()
            }
            CommunicationLogger.shared.debug("errorcode: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
            CommunicationLogger.shared.debug("resultData: \(String(describing: String(data: data, encoding: .utf8)))\n")
            return data
        } catch _ as URLError {
            throw CommunicationAPIError.incorrectURLconnection.getError()
        }
    }
    
    /// Performs a POST request to the specified URL with the provided JSON data in an asynchronous manner.
    /// - Parameters:
    ///   - url: The URL to send the POST request to.
    ///   - requestJsonData: The JSON data to include in the POST request.
    /// - Returns: Data object containing the response data from the POST request.
    /// - Throws: CommunicationAPIError with the error code FAIL if the HTTP response status code is not 200.
    public func doPost(url: URL, requestJsonData: Data) async throws -> Data {
        
        CommunicationLogger.shared.debug("\n************** requestUrl: \(url.absoluteString) **************")
        CommunicationLogger.shared.debug("requestData Json: \(String(data: requestJsonData, encoding:.utf8)!)")
        
        guard !url.absoluteString.isEmpty else {
            throw CommunicationAPIError.invaildParameter.getError()
        }
        guard !requestJsonData.isEmpty else {
            throw CommunicationAPIError.invaildParameter.getError()
        }
        
        do {
            var request = URLRequest(url: url)
            request.timeoutInterval = 15
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = requestJsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                CommunicationLogger.shared.debug("statusCode: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                CommunicationLogger.shared.debug("resultData: \(String(describing: String(data: data, encoding: .utf8)))\n")
                throw CommunicationAPIError.serverFail(String(data: data, encoding: .utf8)!).getError()
    
            }
            CommunicationLogger.shared.debug("errorcode: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
            CommunicationLogger.shared.debug("resultData: \(String(describing: String(data: data, encoding: .utf8)))\n")
            return data
        } catch _ as URLError {
            throw CommunicationAPIError.incorrectURLconnection.getError()
        }
    }
}
