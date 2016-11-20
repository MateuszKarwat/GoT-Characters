//
//  GoTWikiaManagableArticle.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "GoTWikiaManagableArticle.h"

@implementation GoTWikiaManagableArticle

- (instancetype)initWithArticle:(GoTWikiaArticle *)article
{
    GoTWikiaManagableArticle *managableArticle = [[GoTWikiaManagableArticle alloc] initWithIdentifier:article.identifier];

    managableArticle.title = article.title;
    managableArticle.abstract = article.abstract;
    managableArticle.thumbnailURL = article.thumbnailURL;
    managableArticle.relativeURL = article.relativeURL;
    
    managableArticle.favourite = NO;
    managableArticle.expanded = NO;

    return managableArticle;
}

@end
