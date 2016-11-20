//
//  GoTWikiaFetcher.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kGoTWikiaBaseURL;

@interface GoTWikiaFetcher : NSObject

- (void)fetchMostViewedArticlesFromCategory:(NSString *)category
                                  withLimit:(NSUInteger)limit
                          completionHandler:(void (^)(NSArray *fetchedArticles))completionHandler;

@end
