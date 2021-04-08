//
//  DataRequestExecutable.swift
//  ClubhouseAvatarMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import Alamofire

protocol DataRequestExecutable {
    
    var execute: DataRequest { get }
}

extension DataRequest: DataRequestExecutable {
    
    var execute: DataRequest {
        return self
    }
}
