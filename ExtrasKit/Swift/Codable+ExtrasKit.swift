//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: Codable+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2021/11/23: Created by szwathub on 2021/11/23
//

import Foundation

extension Encodable {
    public func jsonDict() -> NSDictionary? {
        do {
            let data = try JSONEncoder().encode(self)
            let json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? NSDictionary

            return json
        } catch {
#if DEBUG
            print(error)
#endif
        }

        return nil
    }
}

extension Decodable {
    public init?(from value: Any,
                 options: JSONSerialization.WritingOptions = []) {

        do {
            let decoder = JSONDecoder()
            try self.init(from: value, options: options, decoder: decoder)
        } catch {
#if DEBUG
            print(error)
#endif
            return nil
        }
    }

    private init(from value: Any,
                 options: JSONSerialization.WritingOptions = [],
                 decoder: JSONDecoder) throws {

        let data = try JSONSerialization.data(withJSONObject: value, options: options)
        self = try decoder.decode(Self.self, from: data)
    }
}
