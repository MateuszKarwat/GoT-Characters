//
//  GoTWikiaArticle.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "GoTWikiaArticle.h"
#import "GoTWikiaFetcher.h"

@implementation GoTWikiaArticle

- (instancetype)initWithIdentifier:(NSInteger)identifier
{
    self = [super init];

    if (self) {
        _identifier = identifier;
    }

    return self;
}

- (NSURL *)absoluteURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kGoTWikiaBaseURL, self.relativeURL]];
}

@end
