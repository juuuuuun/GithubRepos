//
//  Repo.m
//  GithubRepos
//
//  Created by Jun Oh on 2019-01-24.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "Repo.h"

@implementation Repo

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if(self) {
        _name = name;
    }
    return self;
}

@end
