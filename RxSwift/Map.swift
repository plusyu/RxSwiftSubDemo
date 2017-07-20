//
//  Map.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

extension ObservableType {
    

    public func map<R>(_ transform: @escaping (E) throws -> R)
        -> Observable<R> {
            return self.asObservable().composeMap(transform)
    }
}

final fileprivate class MapSink<SourceType, O : ObserverType> : Sink<O>, ObserverType {
    typealias Transform = (SourceType) throws -> ResultType
    
    typealias ResultType = O.E
    typealias Element = SourceType
    
    private let _transform: Transform
    
    init(transform: @escaping Transform, observer: O) {
        _transform = transform
        super.init(observer: observer)
    }
    
    func on(_ event: Event<SourceType>) {
        switch event {
        case .next(let element):
            do {
                let mappedElement = try _transform(element)
                forwardOn(.next(mappedElement))
            }
            catch let e {
                forwardOn(.error(e))
            }
        case .error(let error):
            forwardOn(.error(error))
        case .completed:
            forwardOn(.completed)
        }
    }
}

internal func _map<Element, R>(source: Observable<Element>, transform: @escaping (Element) throws -> R) -> Observable<R> {
    return Map(source: source, transform: transform)
}

final fileprivate class Map<SourceType, ResultType>: Producer<ResultType> {
    typealias Transform = (SourceType) throws -> ResultType
    
    private let _source: Observable<SourceType>
    
    private let _transform: Transform
    
    init(source: Observable<SourceType>, transform: @escaping Transform) {
        _source = source
        _transform = transform
    }
    
    override func composeMap<R>(_ selector: @escaping (ResultType) throws -> R) -> Observable<R> {
        let originalSelector = _transform
        return Map<SourceType, R>(source: _source, transform: { (s: SourceType) throws -> R in
            let r: ResultType = try originalSelector(s)
            return try selector(r)
        })
    }
    
    override func run<O: ObserverType>(_ observer: O) -> Void where O.E == ResultType {
        let sink = MapSink(transform: _transform, observer: observer)
        _source.subscribe(sink)
    }
}
