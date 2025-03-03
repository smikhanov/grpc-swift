//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: route_guide.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Interface exported by the server.
///
/// Usage: instantiate `Routeguide_RouteGuideClient`, then call methods of this protocol to make API calls.
public protocol Routeguide_RouteGuideClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? { get }

  func getFeature(
    _ request: Routeguide_Point,
    callOptions: CallOptions?
  ) -> UnaryCall<Routeguide_Point, Routeguide_Feature>

  func listFeatures(
    _ request: Routeguide_Rectangle,
    callOptions: CallOptions?,
    handler: @escaping (Routeguide_Feature) -> Void
  ) -> ServerStreamingCall<Routeguide_Rectangle, Routeguide_Feature>

  func recordRoute(
    callOptions: CallOptions?
  ) -> ClientStreamingCall<Routeguide_Point, Routeguide_RouteSummary>

  func routeChat(
    callOptions: CallOptions?,
    handler: @escaping (Routeguide_RouteNote) -> Void
  ) -> BidirectionalStreamingCall<Routeguide_RouteNote, Routeguide_RouteNote>
}

extension Routeguide_RouteGuideClientProtocol {
  public var serviceName: String {
    return "routeguide.RouteGuide"
  }

  /// A simple RPC.
  ///
  /// Obtains the feature at a given position.
  ///
  /// A feature with an empty name is returned if there's no feature at the given
  /// position.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetFeature.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getFeature(
    _ request: Routeguide_Point,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Routeguide_Point, Routeguide_Feature> {
    return self.makeUnaryCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.getFeature.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetFeatureInterceptors() ?? []
    )
  }

  /// A server-to-client streaming RPC.
  ///
  /// Obtains the Features available within the given Rectangle.  Results are
  /// streamed rather than returned at once (e.g. in a response message with a
  /// repeated field), as the rectangle may cover a large area and contain a
  /// huge number of features.
  ///
  /// - Parameters:
  ///   - request: Request to send to ListFeatures.
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  public func listFeatures(
    _ request: Routeguide_Rectangle,
    callOptions: CallOptions? = nil,
    handler: @escaping (Routeguide_Feature) -> Void
  ) -> ServerStreamingCall<Routeguide_Rectangle, Routeguide_Feature> {
    return self.makeServerStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.listFeatures.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeListFeaturesInterceptors() ?? [],
      handler: handler
    )
  }

  /// A client-to-server streaming RPC.
  ///
  /// Accepts a stream of Points on a route being traversed, returning a
  /// RouteSummary when traversal is completed.
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata, status and response.
  public func recordRoute(
    callOptions: CallOptions? = nil
  ) -> ClientStreamingCall<Routeguide_Point, Routeguide_RouteSummary> {
    return self.makeClientStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.recordRoute.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRecordRouteInterceptors() ?? []
    )
  }

  /// A Bidirectional streaming RPC.
  ///
  /// Accepts a stream of RouteNotes sent while a route is being traversed,
  /// while receiving other RouteNotes (e.g. from other users).
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata and status.
  public func routeChat(
    callOptions: CallOptions? = nil,
    handler: @escaping (Routeguide_RouteNote) -> Void
  ) -> BidirectionalStreamingCall<Routeguide_RouteNote, Routeguide_RouteNote> {
    return self.makeBidirectionalStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.routeChat.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRouteChatInterceptors() ?? [],
      handler: handler
    )
  }
}

@available(*, deprecated)
extension Routeguide_RouteGuideClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Routeguide_RouteGuideNIOClient")
public final class Routeguide_RouteGuideClient: Routeguide_RouteGuideClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol?
  public let channel: GRPCChannel
  public var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  public var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the routeguide.RouteGuide service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

public struct Routeguide_RouteGuideNIOClient: Routeguide_RouteGuideClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol?

  /// Creates a client for the routeguide.RouteGuide service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Interface exported by the server.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Routeguide_RouteGuideAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? { get }

  func makeGetFeatureCall(
    _ request: Routeguide_Point,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Routeguide_Point, Routeguide_Feature>

  func makeListFeaturesCall(
    _ request: Routeguide_Rectangle,
    callOptions: CallOptions?
  ) -> GRPCAsyncServerStreamingCall<Routeguide_Rectangle, Routeguide_Feature>

  func makeRecordRouteCall(
    callOptions: CallOptions?
  ) -> GRPCAsyncClientStreamingCall<Routeguide_Point, Routeguide_RouteSummary>

  func makeRouteChatCall(
    callOptions: CallOptions?
  ) -> GRPCAsyncBidirectionalStreamingCall<Routeguide_RouteNote, Routeguide_RouteNote>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Routeguide_RouteGuideAsyncClientProtocol {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Routeguide_RouteGuideClientMetadata.serviceDescriptor
  }

  public var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? {
    return nil
  }

  public func makeGetFeatureCall(
    _ request: Routeguide_Point,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Routeguide_Point, Routeguide_Feature> {
    return self.makeAsyncUnaryCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.getFeature.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetFeatureInterceptors() ?? []
    )
  }

  public func makeListFeaturesCall(
    _ request: Routeguide_Rectangle,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncServerStreamingCall<Routeguide_Rectangle, Routeguide_Feature> {
    return self.makeAsyncServerStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.listFeatures.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeListFeaturesInterceptors() ?? []
    )
  }

  public func makeRecordRouteCall(
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncClientStreamingCall<Routeguide_Point, Routeguide_RouteSummary> {
    return self.makeAsyncClientStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.recordRoute.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRecordRouteInterceptors() ?? []
    )
  }

  public func makeRouteChatCall(
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncBidirectionalStreamingCall<Routeguide_RouteNote, Routeguide_RouteNote> {
    return self.makeAsyncBidirectionalStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.routeChat.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRouteChatInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Routeguide_RouteGuideAsyncClientProtocol {
  public func getFeature(
    _ request: Routeguide_Point,
    callOptions: CallOptions? = nil
  ) async throws -> Routeguide_Feature {
    return try await self.performAsyncUnaryCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.getFeature.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetFeatureInterceptors() ?? []
    )
  }

  public func listFeatures(
    _ request: Routeguide_Rectangle,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Routeguide_Feature> {
    return self.performAsyncServerStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.listFeatures.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeListFeaturesInterceptors() ?? []
    )
  }

  public func recordRoute<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) async throws -> Routeguide_RouteSummary where RequestStream: Sequence, RequestStream.Element == Routeguide_Point {
    return try await self.performAsyncClientStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.recordRoute.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRecordRouteInterceptors() ?? []
    )
  }

  public func recordRoute<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) async throws -> Routeguide_RouteSummary where RequestStream: AsyncSequence & Sendable, RequestStream.Element == Routeguide_Point {
    return try await self.performAsyncClientStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.recordRoute.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRecordRouteInterceptors() ?? []
    )
  }

  public func routeChat<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Routeguide_RouteNote> where RequestStream: Sequence, RequestStream.Element == Routeguide_RouteNote {
    return self.performAsyncBidirectionalStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.routeChat.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRouteChatInterceptors() ?? []
    )
  }

  public func routeChat<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Routeguide_RouteNote> where RequestStream: AsyncSequence & Sendable, RequestStream.Element == Routeguide_RouteNote {
    return self.performAsyncBidirectionalStreamingCall(
      path: Routeguide_RouteGuideClientMetadata.Methods.routeChat.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRouteChatInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct Routeguide_RouteGuideAsyncClient: Routeguide_RouteGuideAsyncClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol?

  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

public protocol Routeguide_RouteGuideClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'getFeature'.
  func makeGetFeatureInterceptors() -> [ClientInterceptor<Routeguide_Point, Routeguide_Feature>]

  /// - Returns: Interceptors to use when invoking 'listFeatures'.
  func makeListFeaturesInterceptors() -> [ClientInterceptor<Routeguide_Rectangle, Routeguide_Feature>]

  /// - Returns: Interceptors to use when invoking 'recordRoute'.
  func makeRecordRouteInterceptors() -> [ClientInterceptor<Routeguide_Point, Routeguide_RouteSummary>]

  /// - Returns: Interceptors to use when invoking 'routeChat'.
  func makeRouteChatInterceptors() -> [ClientInterceptor<Routeguide_RouteNote, Routeguide_RouteNote>]
}

public enum Routeguide_RouteGuideClientMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "RouteGuide",
    fullName: "routeguide.RouteGuide",
    methods: [
      Routeguide_RouteGuideClientMetadata.Methods.getFeature,
      Routeguide_RouteGuideClientMetadata.Methods.listFeatures,
      Routeguide_RouteGuideClientMetadata.Methods.recordRoute,
      Routeguide_RouteGuideClientMetadata.Methods.routeChat,
    ]
  )

  public enum Methods {
    public static let getFeature = GRPCMethodDescriptor(
      name: "GetFeature",
      path: "/routeguide.RouteGuide/GetFeature",
      type: GRPCCallType.unary
    )

    public static let listFeatures = GRPCMethodDescriptor(
      name: "ListFeatures",
      path: "/routeguide.RouteGuide/ListFeatures",
      type: GRPCCallType.serverStreaming
    )

    public static let recordRoute = GRPCMethodDescriptor(
      name: "RecordRoute",
      path: "/routeguide.RouteGuide/RecordRoute",
      type: GRPCCallType.clientStreaming
    )

    public static let routeChat = GRPCMethodDescriptor(
      name: "RouteChat",
      path: "/routeguide.RouteGuide/RouteChat",
      type: GRPCCallType.bidirectionalStreaming
    )
  }
}

/// Interface exported by the server.
///
/// To build a server, implement a class that conforms to this protocol.
public protocol Routeguide_RouteGuideProvider: CallHandlerProvider {
  var interceptors: Routeguide_RouteGuideServerInterceptorFactoryProtocol? { get }

  /// A simple RPC.
  ///
  /// Obtains the feature at a given position.
  ///
  /// A feature with an empty name is returned if there's no feature at the given
  /// position.
  func getFeature(request: Routeguide_Point, context: StatusOnlyCallContext) -> EventLoopFuture<Routeguide_Feature>

  /// A server-to-client streaming RPC.
  ///
  /// Obtains the Features available within the given Rectangle.  Results are
  /// streamed rather than returned at once (e.g. in a response message with a
  /// repeated field), as the rectangle may cover a large area and contain a
  /// huge number of features.
  func listFeatures(request: Routeguide_Rectangle, context: StreamingResponseCallContext<Routeguide_Feature>) -> EventLoopFuture<GRPCStatus>

  /// A client-to-server streaming RPC.
  ///
  /// Accepts a stream of Points on a route being traversed, returning a
  /// RouteSummary when traversal is completed.
  func recordRoute(context: UnaryResponseCallContext<Routeguide_RouteSummary>) -> EventLoopFuture<(StreamEvent<Routeguide_Point>) -> Void>

  /// A Bidirectional streaming RPC.
  ///
  /// Accepts a stream of RouteNotes sent while a route is being traversed,
  /// while receiving other RouteNotes (e.g. from other users).
  func routeChat(context: StreamingResponseCallContext<Routeguide_RouteNote>) -> EventLoopFuture<(StreamEvent<Routeguide_RouteNote>) -> Void>
}

extension Routeguide_RouteGuideProvider {
  public var serviceName: Substring {
    return Routeguide_RouteGuideServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetFeature":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_Point>(),
        responseSerializer: ProtobufSerializer<Routeguide_Feature>(),
        interceptors: self.interceptors?.makeGetFeatureInterceptors() ?? [],
        userFunction: self.getFeature(request:context:)
      )

    case "ListFeatures":
      return ServerStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_Rectangle>(),
        responseSerializer: ProtobufSerializer<Routeguide_Feature>(),
        interceptors: self.interceptors?.makeListFeaturesInterceptors() ?? [],
        userFunction: self.listFeatures(request:context:)
      )

    case "RecordRoute":
      return ClientStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_Point>(),
        responseSerializer: ProtobufSerializer<Routeguide_RouteSummary>(),
        interceptors: self.interceptors?.makeRecordRouteInterceptors() ?? [],
        observerFactory: self.recordRoute(context:)
      )

    case "RouteChat":
      return BidirectionalStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_RouteNote>(),
        responseSerializer: ProtobufSerializer<Routeguide_RouteNote>(),
        interceptors: self.interceptors?.makeRouteChatInterceptors() ?? [],
        observerFactory: self.routeChat(context:)
      )

    default:
      return nil
    }
  }
}

/// Interface exported by the server.
///
/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Routeguide_RouteGuideAsyncProvider: CallHandlerProvider {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Routeguide_RouteGuideServerInterceptorFactoryProtocol? { get }

  /// A simple RPC.
  ///
  /// Obtains the feature at a given position.
  ///
  /// A feature with an empty name is returned if there's no feature at the given
  /// position.
  @Sendable func getFeature(
    request: Routeguide_Point,
    context: GRPCAsyncServerCallContext
  ) async throws -> Routeguide_Feature

  /// A server-to-client streaming RPC.
  ///
  /// Obtains the Features available within the given Rectangle.  Results are
  /// streamed rather than returned at once (e.g. in a response message with a
  /// repeated field), as the rectangle may cover a large area and contain a
  /// huge number of features.
  @Sendable func listFeatures(
    request: Routeguide_Rectangle,
    responseStream: GRPCAsyncResponseStreamWriter<Routeguide_Feature>,
    context: GRPCAsyncServerCallContext
  ) async throws

  /// A client-to-server streaming RPC.
  ///
  /// Accepts a stream of Points on a route being traversed, returning a
  /// RouteSummary when traversal is completed.
  @Sendable func recordRoute(
    requestStream: GRPCAsyncRequestStream<Routeguide_Point>,
    context: GRPCAsyncServerCallContext
  ) async throws -> Routeguide_RouteSummary

  /// A Bidirectional streaming RPC.
  ///
  /// Accepts a stream of RouteNotes sent while a route is being traversed,
  /// while receiving other RouteNotes (e.g. from other users).
  @Sendable func routeChat(
    requestStream: GRPCAsyncRequestStream<Routeguide_RouteNote>,
    responseStream: GRPCAsyncResponseStreamWriter<Routeguide_RouteNote>,
    context: GRPCAsyncServerCallContext
  ) async throws
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Routeguide_RouteGuideAsyncProvider {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Routeguide_RouteGuideServerMetadata.serviceDescriptor
  }

  public var serviceName: Substring {
    return Routeguide_RouteGuideServerMetadata.serviceDescriptor.fullName[...]
  }

  public var interceptors: Routeguide_RouteGuideServerInterceptorFactoryProtocol? {
    return nil
  }

  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetFeature":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_Point>(),
        responseSerializer: ProtobufSerializer<Routeguide_Feature>(),
        interceptors: self.interceptors?.makeGetFeatureInterceptors() ?? [],
        wrapping: self.getFeature(request:context:)
      )

    case "ListFeatures":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_Rectangle>(),
        responseSerializer: ProtobufSerializer<Routeguide_Feature>(),
        interceptors: self.interceptors?.makeListFeaturesInterceptors() ?? [],
        wrapping: self.listFeatures(request:responseStream:context:)
      )

    case "RecordRoute":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_Point>(),
        responseSerializer: ProtobufSerializer<Routeguide_RouteSummary>(),
        interceptors: self.interceptors?.makeRecordRouteInterceptors() ?? [],
        wrapping: self.recordRoute(requestStream:context:)
      )

    case "RouteChat":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Routeguide_RouteNote>(),
        responseSerializer: ProtobufSerializer<Routeguide_RouteNote>(),
        interceptors: self.interceptors?.makeRouteChatInterceptors() ?? [],
        wrapping: self.routeChat(requestStream:responseStream:context:)
      )

    default:
      return nil
    }
  }
}

public protocol Routeguide_RouteGuideServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'getFeature'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetFeatureInterceptors() -> [ServerInterceptor<Routeguide_Point, Routeguide_Feature>]

  /// - Returns: Interceptors to use when handling 'listFeatures'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeListFeaturesInterceptors() -> [ServerInterceptor<Routeguide_Rectangle, Routeguide_Feature>]

  /// - Returns: Interceptors to use when handling 'recordRoute'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeRecordRouteInterceptors() -> [ServerInterceptor<Routeguide_Point, Routeguide_RouteSummary>]

  /// - Returns: Interceptors to use when handling 'routeChat'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeRouteChatInterceptors() -> [ServerInterceptor<Routeguide_RouteNote, Routeguide_RouteNote>]
}

public enum Routeguide_RouteGuideServerMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "RouteGuide",
    fullName: "routeguide.RouteGuide",
    methods: [
      Routeguide_RouteGuideServerMetadata.Methods.getFeature,
      Routeguide_RouteGuideServerMetadata.Methods.listFeatures,
      Routeguide_RouteGuideServerMetadata.Methods.recordRoute,
      Routeguide_RouteGuideServerMetadata.Methods.routeChat,
    ]
  )

  public enum Methods {
    public static let getFeature = GRPCMethodDescriptor(
      name: "GetFeature",
      path: "/routeguide.RouteGuide/GetFeature",
      type: GRPCCallType.unary
    )

    public static let listFeatures = GRPCMethodDescriptor(
      name: "ListFeatures",
      path: "/routeguide.RouteGuide/ListFeatures",
      type: GRPCCallType.serverStreaming
    )

    public static let recordRoute = GRPCMethodDescriptor(
      name: "RecordRoute",
      path: "/routeguide.RouteGuide/RecordRoute",
      type: GRPCCallType.clientStreaming
    )

    public static let routeChat = GRPCMethodDescriptor(
      name: "RouteChat",
      path: "/routeguide.RouteGuide/RouteChat",
      type: GRPCCallType.bidirectionalStreaming
    )
  }
}
