//
//  Observable.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

public class Observable<Element> : ObservableType {
    
    public typealias E = Element
    
    init() {
    }
    
    public func subscribe<O: ObserverType>(_ observer: O) -> Void where O.E == E {
        
    }
    
    public func asObservable() -> Observable<E> {
        return self
    }
    
    deinit {
    }
    
    internal func composeMap<R>(_ transform: @escaping (Element) throws -> R) -> Observable<R> {
        return _map(source: self, transform: transform)
    }
}
