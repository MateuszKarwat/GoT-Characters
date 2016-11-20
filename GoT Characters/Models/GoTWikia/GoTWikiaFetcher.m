//
//  GoTWikiaFetcher.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "GoTWikiaFetcher.h"
#import "GoTWikiaArticle.h"

NSString * const kGoTWikiaBaseURL = @"http://gameofthrones.wikia.com";
NSString * const kGoTWikiaMostViewedArticlesRelativeURL = @"/api/v1/Articles/Top?expand=1";

NSString * const kGoTWikiaJSONArticlesKey = @"items";

NSString * const kGoTWikiaJSONArticleIdentifierKey  = @"id";
NSString * const kGoTWikiaJSONArticleTitleKey       = @"title";
NSString * const kGoTWikiaJSONArticleAbstractKey    = @"abstract";
NSString * const kGoTWikiaJSONArticleThumbnailKey   = @"thumbnail";
NSString * const kGoTWikiaJSONArticleRelativeURLKey = @"url";

@implementation GoTWikiaFetcher

- (void)fetchMostViewedArticlesFromCategory:(NSString *)category
                                  withLimit:(NSUInteger)limit
                          completionHandler:(void (^)(NSArray *fetched))completionHandler
{
    NSString *stringURL = [NSString stringWithFormat: @"%@%@&category=%@&limit=%lu", kGoTWikiaBaseURL, kGoTWikiaMostViewedArticlesRelativeURL, category, (unsigned long)limit];
    NSURL *url = [NSURL URLWithString:stringURL];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSData *fetchedData = [NSData dataWithContentsOfURL:url];
        NSArray *fetchedArticles = [self mostViewedArticlesFromData:fetchedData];

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            completionHandler(fetchedArticles);
        });
    });
}

- (NSArray *)mostViewedArticlesFromData:(NSData *)data
{
    if (!data) {
        return nil;
    }

    NSMutableArray *newArticles = [[NSMutableArray alloc] init];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];

    if (json) {
        NSArray *articles = [json objectForKey:kGoTWikiaJSONArticlesKey];

        for (NSDictionary *article in articles) {
            GoTWikiaArticle *newArticle = [[GoTWikiaArticle alloc] initWithIdentifier:[[article objectForKey:kGoTWikiaJSONArticleIdentifierKey] integerValue]];

            newArticle.title = [article objectForKey:kGoTWikiaJSONArticleTitleKey];
            newArticle.abstract = [article objectForKey:kGoTWikiaJSONArticleAbstractKey];
            newArticle.thumbnailURL = [article objectForKey:kGoTWikiaJSONArticleThumbnailKey];
            newArticle.relativeURL = [article objectForKey:kGoTWikiaJSONArticleRelativeURLKey];

            [newArticles addObject:newArticle];
        }
    }

    return [newArticles copy];
}

@end
