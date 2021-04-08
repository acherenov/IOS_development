//
//  ApplicationAssembly.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import Foundation

class ApplicationAssembly {
    
    static var appRouter: AppRouter = {
        return MainAppRouter()
    }()
}
