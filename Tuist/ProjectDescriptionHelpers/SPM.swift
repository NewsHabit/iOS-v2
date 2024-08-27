import ProjectDescription

extension TargetDependency {
    public struct SPM {}
}

public extension TargetDependency.SPM {
    static let Alamofire = Self.package(product: "Alamofire")
    static let FlexLayout = Self.package(product: "FlexLayout")
    static let Kingfisher = Self.package(product: "Kingfisher")
    static let PinLayout = Self.package(product: "PinLayout")

    private static func external(_ name: String) -> TargetDependency {
        return TargetDependency.external(name: name)
    }

    private static func package(product: String) -> TargetDependency {
        return TargetDependency.package(product: product)
    }
}
