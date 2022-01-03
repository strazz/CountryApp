//
//  CombineExtensions.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import Combine

extension Publisher {
    func asyncMap<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>,
                            Publishers.SetFailureType<Self, Error>> {
                                flatMap { value in
                                    Future { promise in
                                        Task {
                                            do {
                                                let output = try await transform(value)
                                                promise(.success(output))
                                            } catch {
                                                promise(.failure(error))
                                            }
                                        }
                                    }
                                }
                            }
}
