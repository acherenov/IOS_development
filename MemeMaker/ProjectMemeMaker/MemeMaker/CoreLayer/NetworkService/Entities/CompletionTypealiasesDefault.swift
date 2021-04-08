//
//  CompletionTypealiasesDefault.swift
//  ClubhouseAvatarMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import Alamofire

typealias DefaultRequestCompletion<T: Codable> = (Result<T, NetworkServiceError>) -> Void
