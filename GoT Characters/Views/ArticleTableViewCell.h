//
//  ArticleTableViewCell.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoTWikiaManagableArticle.h"

extern NSString * const kArticleTableViewCellReusableIdentifier;

@protocol ArticleTableViewCellDelegate <NSObject>
@optional

/**
 Called when user taps on a 'favouriteStatusButton'.

 @param sender A 'ArticleTableViewCell' which contains a tapped button.
 */
- (void)didTapFavouriteStatusButton:(id)sender;

/**
 Called when user long press on a 'abstractLabel'.

 @param sender A 'ArticleTableViewCell' which contains a tapped button.
 */
- (void)didLongPressOnAbstractLabel:(id)sender;
@end

#pragma mark -

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) id<ArticleTableViewCellDelegate> delegate;

/**
 Fills all UI elements based on article's properties.

 @param article An article which should be presented.
 */
- (void)fillUsingManagableArticle:(GoTWikiaManagableArticle *)article;

/**
 Changes the status of favourite status button.
 */
- (void)favouriteStatusButtonSelected:(BOOL)isSelected;

/**
 Changes the number of lines in abstract label to be expanded or collapsed.
 */
- (void)abstractLabelExpanded:(BOOL)isExpanded;

@end
