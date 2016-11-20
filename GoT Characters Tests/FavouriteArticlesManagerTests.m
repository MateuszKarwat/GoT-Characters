//
//  FavouriteArticlesManagerTests.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FavouriteArticlesManager.h"
#import "GoTWikiaArticle.h"

@interface FavouriteArticlesManagerTests : XCTestCase

@end

@implementation FavouriteArticlesManagerTests

- (void)setUp
{
    [super setUp];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FavouriteArticles"];
}

- (void)testAddArticleToFavourites
{
    FavouriteArticlesManager *manager = [[FavouriteArticlesManager alloc] init];
    GoTWikiaArticle *article = [[GoTWikiaArticle alloc] initWithIdentifier:1 title:@"" abstract:@"" thumbnailURL:@"" relativeURL:@""];

    [manager addArticleToFavourites:article];
    [manager addArticleToFavourites:article];

    NSArray *savedArticlesIdentifiers = [manager getFavouriteArticlesIdentifiers];
    NSNumber *savedIdentifier = [savedArticlesIdentifiers objectAtIndex:0];

    XCTAssertTrue(savedArticlesIdentifiers.count == 1);
    XCTAssertEqual([savedIdentifier integerValue], 1);
}

- (void)testRemoveArticleFromFavourites
{
    FavouriteArticlesManager *manager = [[FavouriteArticlesManager alloc] init];
    GoTWikiaArticle *article = [[GoTWikiaArticle alloc] initWithIdentifier:1 title:@"" abstract:@"" thumbnailURL:@"" relativeURL:@""];

    [manager addArticleToFavourites:article];
    [manager removeArticleFromFavourites:article];

    XCTAssertTrue([manager getFavouriteArticlesIdentifiers].count == 0);
}

@end
