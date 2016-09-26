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
            
            definition?.injectProperty( "appAssembly", with: self)
            
            definition?.scope = TyphoonScope.singleton
        } as AnyObject
    }
    /*
     * A config definition, referencing properties that will be loaded from a plist.
     */
    dynamic func config() -> AnyObject {
        
        return TyphoonDefinition.withConfigName("Configuration.plist")
    }
    
    dynamic func storyboard() -> AnyObject {
        return TyphoonDefinition.withClass(TyphoonStoryboard.self){
            (definition) in
            
            definition?.useInitializer("storyboardWithName:factory:bundle:"){
                (initializer) in
                
                initializer?.injectParameter(with: "Main")
                initializer?.injectParameter(with: self)
                initializer?.injectParameter(with: Bundle.main )
                
            }
            definition?.scope = .singleton; //Let's make this a singleton
        } as AnyObject
    }
    
    dynamic func twitterService() -> AnyObject {
        return TyphoonDefinition.withClass(TwitterStreamingService.self) {
            (definintion) in
            
            definintion?.scope = .singleton
        } as AnyObject
    }
    
    dynamic func mainScreenViewController() -> AnyObject {
        return TyphoonDefinition.withClass(STMainScreenViewController.self) {
            (definintion) in
            
            definintion?.injectProperty("service", with: self.twitterService())
            definintion?.injectProperty("tableViewDDM", with: self.mainScreenDDM())
            
            definintion?.scope = .singleton
        } as AnyObject
    }
    
    dynamic func mainScreenDDM() -> AnyObject {
        return TyphoonDefinition.withClass(STMainScreenDDM.self) {
            (definintion) in
            
            definintion?.useInitializer("initWithDelegate:dataSource:") {
                (initializer) in
                
                initializer?.injectParameter( with: self.mainScreenViewController() )
                initializer?.injectParameter( with: self.twitterService() )
            }
        } as AnyObject
    }
    
    
}
