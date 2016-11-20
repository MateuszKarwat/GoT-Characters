//
//  ArticleTableViewCell.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UIButton *favouriteStatusButton;

@property (weak, nonatomic) id<ArticleTableViewCellDelegate> delegate;

@end
