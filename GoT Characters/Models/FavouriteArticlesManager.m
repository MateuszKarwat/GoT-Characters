//
//  FavouriteArticlesManager.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "FavouriteArticlesManager.h"

NSString * const kFavouriteArticlesUserDefaultsKey = @"FavouriteArticles";

@interface FavouriteArticlesManager ()
@property (nonatomic) NSMutableArray *favouriteArticlesIdentifiers;
@end

@implementation FavouriteArticlesManager

- (NSArray *)getFavouriteArticlesIdentifiers
{
    return self.favouriteArticlesIdentifiers;
}

- (void)addArticleToFavourites:(GoTWikiaArticle *)article
{
    NSNumber *articleIdentifier = [NSNumber numberWithInteger:article.identifier];
    if (![self.favouriteArticlesIdentifiers containsObject:articleIdentifier]) {
        [self.favouriteArticlesIdentifiers addObject:articleIdentifier];
        [self saveFavouriteArticlesIdentifiersToUserDefaults];
    }
}

- (void)removeArticleFromFavourites:(GoTWikiaArticle *)article
{
    [self.favouriteArticlesIdentifiers removeObject:[NSNumber numberWithInteger:article.identifier]];
    [self saveFavouriteArticlesIdentifiersToUserDefaults];
}

- (BOOL)isArticleAddedToFavourites:(GoTWikiaArticle *)article
{
    return [self.favouriteArticlesIdentifiers containsObject:[NSNumber numberWithInteger:article.identifier]];
}

#pragma mark - Private Methods

- (NSMutableArray *)favouriteArticlesIdentifiers
{
    if (!_favouriteArticlesIdentifiers) {
        NSArray *favouritesFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:kFavouriteArticlesUserDefaultsKey];
        _favouriteArticlesIdentifiers = [[NSMutableArray alloc] initWithArray:favouritesFromUserDefaults];
    }

    return _favouriteArticlesIdentifiers;
}

- (void)saveFavouriteArticlesIdentifiersToUserDefaults
{
    [[NSUserDefaults standardUserDefaults] setObject:self.favouriteArticlesIdentifiers forKey:kFavouriteArticlesUserDefaultsKey];
}

@end
