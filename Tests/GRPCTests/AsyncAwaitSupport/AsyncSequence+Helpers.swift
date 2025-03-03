/*
 * Copyright 2021, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
@available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
extension AsyncSequence {
  internal func collect() async throws -> [Element] {
    return try await self.reduce(into: []) { accumulated, next in
      accumulated.append(next)
    }
  }

  internal func count() async throws -> Int {
    return try await self.reduce(0) { count, _ in count + 1 }
  }
}
