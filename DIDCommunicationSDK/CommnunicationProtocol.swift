/*
 * Copyright 2024 Raonsecure
 */

import Foundation

public protocol CommnunicationProtocol {
    func doGet(url: URL) async throws -> Data
    func doPost(url: URL, requestJsonData: Data) async throws -> Data
}
