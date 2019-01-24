//
//  Repo.h
//  GithubRepos
//
//  Created by Jun Oh on 2019-01-24.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Repo : NSObject

@property (nonatomic) NSString* name;

- (instancetype) initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
