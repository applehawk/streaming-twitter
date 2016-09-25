//
//  MainAssembly.swift
//  StreamingTwitter
//
//  Created by Hawk on 25/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Typhoon

class MainAssembly: TyphoonAssembly {
    /*
     * This is the definition for our AppDelegate. Typhoon will inject the specified properties
     * at application startup.
     */
    dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
            
            definition?.injectProperty("appAssembly", with: self)
            
            definition?.scope = TyphoonScope.singleton
        } as AnyObject
    }
    
    dynamic func twitterService() -> AnyObject {
        return TyphoonDefinition.withClass(TwitterStreamingService.self) {
            (definintion) in
            
            definintion?.scope = .singleton
        } as AnyObject
    }
    
    
}
