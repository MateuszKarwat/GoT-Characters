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

/**
 Fetches 'limit' most viewed articles from specified category
 from GoT Wikia.

 @param category A category of articles to fetch.
 @param limit A maximum number of articles to fetch.
 @param completionHandler A block which is called when articles are fetched and parsed from JSON.
 */
- (void)fetchMostViewedArticlesFromCategory:(NSString *)category
                                  withLimit:(NSUInteger)limit
                          completionHandler:(void (^)(NSArray *fetchedArticles))completionHandler;

@end
