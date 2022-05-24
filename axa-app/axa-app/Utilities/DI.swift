//
//  DI.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 9/5/22.
//

import Swinject

/**
 Represents a project-level abstraction of the dependency injector.
 You can access the shared instance of the project through the `singleton` variable in the class.
 */
class DI {
    
    static let singleton = DI()
    
    private let container: Container
    
    init () {
        container = Container()
        loadDependencies()
    }
    
    /**
     Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
     - Parameter serviceType: The service type to register. (A service is an abstract class that is required to be a protocol.)
     - Parameter factory: The closure to specify how the service type is resolved with the dependencies of the type. It is invoked when the DI needs to instantiate the instance.
     */
    func addDependency<Service>(serviceType: Service.Type, factory: @escaping (Resolver) -> Service) {
        container.register(serviceType, factory: factory)
    }
    
    /**
     Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
     - Parameter serviceType: The service type to register. (A service is an abstract class that is required to be a protocol).
     
     - Returns: The closure to specify how the service type is resolved with the dependencies of the type. It is invoked when the DI needs to instantiate the instance.
     */
    func getDependency<Service>(service: Service.Type) -> Service {
        guard let dependency = container.resolve(service) else {
            Utils.controlledFailure(message: "Failed to get dependency (\(service)")
        }
        return dependency
    }
    
    /**
     Determines whether or not the dependency injector contains a given service.
     - Parameter serviceType: The service to look for. (A service is an abstract class that is required to be a protocol).
     
     - Returns : If DI has that dependency injected.
     */
    func existDependency<Service>(service: Service.Type) -> Bool {
        return container.resolve(service) != nil
    }
    
}

// MARK: - Private Dependency Loading Methods
extension DI {
    
    private func loadDependencies() {
        addDependency(serviceType: LocationService.self, factory: { _ in
            NativeLocationService()
        })
        
        addDependency(serviceType: NetworkService.self, factory: { _ in
            NativeNetworkService()
        })
        
        addDependency(serviceType: BrastlewarkService.self, factory: { resolver in
            BrastlewarkService(service: resolver.resolve(NetworkService.self)!)
        })
        
        addDependency(serviceType: StorageService.self, factory: { _ in
            NativeStorageService()
        })
    }
}
