// Autogenerated from Pigeon (v10.1.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Models
///
/// Generated class from Pigeon that represents data sent in messages.
struct UUID {
  var value: String

  static func fromList(_ list: [Any?]) -> UUID? {
    let value = list[0] as! String

    return UUID(
      value: value
    )
  }
  func toList() -> [Any?] {
    return [
      value,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct BleDescriptor {
  var uuid: UUID
  var value: FlutterStandardTypedData? = nil
  var permissions: [Int64?]? = nil

  static func fromList(_ list: [Any?]) -> BleDescriptor? {
    let uuid = UUID.fromList(list[0] as! [Any?])!
    let value: FlutterStandardTypedData? = nilOrValue(list[1])
    let permissions: [Int64?]? = nilOrValue(list[2])

    return BleDescriptor(
      uuid: uuid,
      value: value,
      permissions: permissions
    )
  }
  func toList() -> [Any?] {
    return [
      uuid.toList(),
      value,
      permissions,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct BleCharacteristic {
  var uuid: UUID
  var properties: [Int64?]
  var permissions: [Int64?]
  var descriptors: [BleDescriptor?]? = nil
  var value: FlutterStandardTypedData? = nil

  static func fromList(_ list: [Any?]) -> BleCharacteristic? {
    let uuid = UUID.fromList(list[0] as! [Any?])!
    let properties = list[1] as! [Int64?]
    let permissions = list[2] as! [Int64?]
    let descriptors: [BleDescriptor?]? = nilOrValue(list[3])
    let value: FlutterStandardTypedData? = nilOrValue(list[4])

    return BleCharacteristic(
      uuid: uuid,
      properties: properties,
      permissions: permissions,
      descriptors: descriptors,
      value: value
    )
  }
  func toList() -> [Any?] {
    return [
      uuid.toList(),
      properties,
      permissions,
      descriptors,
      value,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct BleService {
  var uuid: UUID
  var primary: Bool
  var characteristics: [BleCharacteristic?]

  static func fromList(_ list: [Any?]) -> BleService? {
    let uuid = UUID.fromList(list[0] as! [Any?])!
    let primary = list[1] as! Bool
    let characteristics = list[2] as! [BleCharacteristic?]

    return BleService(
      uuid: uuid,
      primary: primary,
      characteristics: characteristics
    )
  }
  func toList() -> [Any?] {
    return [
      uuid.toList(),
      primary,
      characteristics,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct BleCentral {
  var uuid: UUID

  static func fromList(_ list: [Any?]) -> BleCentral? {
    let uuid = UUID.fromList(list[0] as! [Any?])!

    return BleCentral(
      uuid: uuid
    )
  }
  func toList() -> [Any?] {
    return [
      uuid.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct ReadRequestResult {
  var value: FlutterStandardTypedData
  var offset: Int64? = nil

  static func fromList(_ list: [Any?]) -> ReadRequestResult? {
    let value = list[0] as! FlutterStandardTypedData
    let offset: Int64? = list[1] is NSNull ? nil : (list[1] is Int64? ? list[1] as! Int64? : Int64(list[1] as! Int32))

    return ReadRequestResult(
      value: value,
      offset: offset
    )
  }
  func toList() -> [Any?] {
    return [
      value,
      offset,
    ]
  }
}
private class BlePeripheralChannelCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return BleCentral.fromList(self.readValue() as! [Any?])
      case 129:
        return BleCharacteristic.fromList(self.readValue() as! [Any?])
      case 130:
        return BleDescriptor.fromList(self.readValue() as! [Any?])
      case 131:
        return BleService.fromList(self.readValue() as! [Any?])
      case 132:
        return UUID.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class BlePeripheralChannelCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? BleCentral {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? BleCharacteristic {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? BleDescriptor {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? BleService {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? UUID {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class BlePeripheralChannelCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return BlePeripheralChannelCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return BlePeripheralChannelCodecWriter(data: data)
  }
}

class BlePeripheralChannelCodec: FlutterStandardMessageCodec {
  static let shared = BlePeripheralChannelCodec(readerWriter: BlePeripheralChannelCodecReaderWriter())
}

/// Flutter -> Native
///
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol BlePeripheralChannel {
  func initialize() throws
  func isAdvertising() throws -> Bool
  func isSupported() throws -> Bool
  func stopAdvertising() throws
  func addServices(services: [BleService]) throws
  func startAdvertising(services: [UUID], localName: String) throws
  func updateCharacteristic(central: BleCentral, characteristic: BleCharacteristic, value: FlutterStandardTypedData) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class BlePeripheralChannelSetup {
  /// The codec used by BlePeripheralChannel.
  static var codec: FlutterStandardMessageCodec { BlePeripheralChannelCodec.shared }
  /// Sets up an instance of `BlePeripheralChannel` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: BlePeripheralChannel?) {
    let initializeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BlePeripheralChannel.initialize", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      initializeChannel.setMessageHandler { _, reply in
        do {
          try api.initialize()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      initializeChannel.setMessageHandler(nil)
    }
    let isAdvertisingChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BlePeripheralChannel.isAdvertising", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      isAdvertisingChannel.setMessageHandler { _, reply in
        do {
          let result = try api.isAdvertising()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      isAdvertisingChannel.setMessageHandler(nil)
    }
    let isSupportedChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BlePeripheralChannel.isSupported", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      isSupportedChannel.setMessageHandler { _, reply in
        do {
          let result = try api.isSupported()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      isSupportedChannel.setMessageHandler(nil)
    }
    let stopAdvertisingChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BlePeripheralChannel.stopAdvertising", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      stopAdvertisingChannel.setMessageHandler { _, reply in
        do {
          try api.stopAdvertising()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      stopAdvertisingChannel.setMessageHandler(nil)
    }
    let addServicesChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BlePeripheralChannel.addServices", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      addServicesChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let servicesArg = args[0] as! [BleService]
        do {
          try api.addServices(services: servicesArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addServicesChannel.setMessageHandler(nil)
    }
    let startAdvertisingChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BlePeripheralChannel.startAdvertising", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startAdvertisingChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let servicesArg = args[0] as! [UUID]
        let localNameArg = args[1] as! String
        do {
          try api.startAdvertising(services: servicesArg, localName: localNameArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startAdvertisingChannel.setMessageHandler(nil)
    }
    let updateCharacteristicChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BlePeripheralChannel.updateCharacteristic", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      updateCharacteristicChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let centralArg = args[0] as! BleCentral
        let characteristicArg = args[1] as! BleCharacteristic
        let valueArg = args[2] as! FlutterStandardTypedData
        do {
          try api.updateCharacteristic(central: centralArg, characteristic: characteristicArg, value: valueArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      updateCharacteristicChannel.setMessageHandler(nil)
    }
  }
}
private class BleCallbackCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return BleCentral.fromList(self.readValue() as! [Any?])
      case 129:
        return BleCharacteristic.fromList(self.readValue() as! [Any?])
      case 130:
        return BleDescriptor.fromList(self.readValue() as! [Any?])
      case 131:
        return BleService.fromList(self.readValue() as! [Any?])
      case 132:
        return ReadRequestResult.fromList(self.readValue() as! [Any?])
      case 133:
        return UUID.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class BleCallbackCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? BleCentral {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? BleCharacteristic {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? BleDescriptor {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? BleService {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? ReadRequestResult {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else if let value = value as? UUID {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class BleCallbackCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return BleCallbackCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return BleCallbackCodecWriter(data: data)
  }
}

class BleCallbackCodec: FlutterStandardMessageCodec {
  static let shared = BleCallbackCodec(readerWriter: BleCallbackCodecReaderWriter())
}

/// Native -> Flutter
///
/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class BleCallback {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  var codec: FlutterStandardMessageCodec {
    return BleCallbackCodec.shared
  }
  func onReadRequest(characteristic characteristicArg: BleCharacteristic, offset offsetArg: Int64, value valueArg: FlutterStandardTypedData?, completion: @escaping (ReadRequestResult?) -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onReadRequest", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([characteristicArg, offsetArg, valueArg] as [Any?]) { response in
      let result: ReadRequestResult? = nilOrValue(response)
      completion(result)
    }
  }
  func onWriteRequest(characteristic characteristicArg: BleCharacteristic, offset offsetArg: Int64, value valueArg: FlutterStandardTypedData?, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onWriteRequest", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([characteristicArg, offsetArg, valueArg] as [Any?]) { _ in
      completion()
    }
  }
  func onCharacteristicSubscriptionChange(central centralArg: BleCentral, characteristic characteristicArg: BleCharacteristic, isSubscribed isSubscribedArg: Bool, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onCharacteristicSubscriptionChange", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([centralArg, characteristicArg, isSubscribedArg] as [Any?]) { _ in
      completion()
    }
  }
  func onSubscribe(bleCentral bleCentralArg: BleCentral, characteristic characteristicArg: BleCharacteristic, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onSubscribe", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([bleCentralArg, characteristicArg] as [Any?]) { _ in
      completion()
    }
  }
  func onUnsubscribe(bleCentral bleCentralArg: BleCentral, characteristic characteristicArg: BleCharacteristic, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onUnsubscribe", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([bleCentralArg, characteristicArg] as [Any?]) { _ in
      completion()
    }
  }
  func onAdvertisingStarted(error errorArg: String?, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onAdvertisingStarted", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([errorArg] as [Any?]) { _ in
      completion()
    }
  }
  func onBleStateChange(state stateArg: Bool, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onBleStateChange", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([stateArg] as [Any?]) { _ in
      completion()
    }
  }
  func onServiceAdded(service serviceArg: BleService, error errorArg: String?, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onServiceAdded", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([serviceArg, errorArg] as [Any?]) { _ in
      completion()
    }
  }
  func onConnectionStateChange(central centralArg: BleCentral, connected connectedArg: Bool, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onConnectionStateChange", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([centralArg, connectedArg] as [Any?]) { _ in
      completion()
    }
  }
  func onBondStateChange(central centralArg: BleCentral, bondState bondStateArg: Int64, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ble_peripheral.BleCallback.onBondStateChange", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([centralArg, bondStateArg] as [Any?]) { _ in
      completion()
    }
  }
}
