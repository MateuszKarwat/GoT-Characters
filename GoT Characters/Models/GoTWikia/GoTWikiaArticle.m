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

- (id)initWithIdentifier:(NSInteger)identifier
                   title:(NSString *)title
                abstract:(NSString *)abstract
            thumbnailURL:(NSString *)thumbnailURL
             relativeURL:(NSString *)relativeURL
{
    self = [super init];

    if (self) {
        _identifier = identifier;
        _title = title;
        _abstract = abstract;
        _thumbnailURL = thumbnailURL;
        _relativeURL = relativeURL;
        _favourite = NO;
        _absoluteURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kGoTWikiaBaseURL, relativeURL]];
    }

    return self;
}

@end
