//
//  AnyObserver.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

public struct AnyObserver<Element> : ObserverType {
    
    public typealias E = Element
    
    public typealias EventHandler = (Event<Element>) -> Void
    
    private let observer: EventHandler
    
    public init(eventHandler: @escaping EventHandler) {
        self.observer = eventHandler
    }
    

    public init<O : ObserverType>(_ observer: O) where O.E == Element {
        self.observer = observer.on
    }
    

    public func on(_ event: Event<Element>) {
        return self.observer(event)
    }
    
    public func asObserver() -> AnyObserver<E> {
        return self
    }
}



extension ObserverType {

    public func asObserver() -> AnyObserver<E> {
        return AnyObserver(self)
    }
    

    public func mapObserver<R>(_ transform: @escaping (R) throws -> E) -> AnyObserver<R> {
        return AnyObserver { e in
            self.on(e.map(transform))
        }
    }
}
