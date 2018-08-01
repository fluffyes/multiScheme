//
//  Endpoints.swift
//  MultiScheme
//
//  Created by Soul on 01/08/2018.
//  Copyright © 2018 Fluffy. All rights reserved.
//

import Foundation

struct Endpoints {
	static let baseURL = "https://fluffa.herokuapp.com/"
	
	static func randomFox() -> URL {
		return URL(string: Endpoints.baseURL + "floof")!
	}
}
