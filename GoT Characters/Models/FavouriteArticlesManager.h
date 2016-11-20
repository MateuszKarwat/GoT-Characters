//
//  FavouriteArticlesManager.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoTWikiaArticle.h"

@interface FavouriteArticlesManager : NSObject

/**
 Returns identifiers of saved articles to favourites list.

 @return An array of identifiers as 'NSNumber'.
 */
- (NSArray *)getFavouriteArticlesIdentifiers;

/**
 Saves an article on favourites list.

 @param article An article to be saved.
 */
- (void)addArticleToFavourites:(GoTWikiaArticle *)article;

/**
 Removes an article from favourites list.

 @param article An article to be removed.
 */
- (void)removeArticleFromFavourites:(GoTWikiaArticle *)article;

/**
 Checks if an article is already on favourites list.

 @param article Article which will be check if it's saved to favourites.
 @return 'YES' if articles is saved in favourites. 'NO' otherwise.
 */
- (BOOL)isArticleAddedToFavourites:(GoTWikiaArticle *)article;

@end
