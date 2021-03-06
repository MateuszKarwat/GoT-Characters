//
//  GoTWikiaArticleTests.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GoTWikiaArticle.h"

@interface GoTWikiaArticleTests : XCTestCase

@end

@implementation GoTWikiaArticleTests

- (void)testAbsoluteURL
{
    GoTWikiaArticle *article = [[GoTWikiaArticle alloc] init];

    article.relativeURL = @"/wiki/Jon_Snow";

    XCTAssertTrue(article.absoluteURL.absoluteString, @"http://gameofthrones.wikia.com/wiki/Jon_Snow");
}

@end
