//
//  ArticleTableViewCell.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import <WebImage/UIImageView+WebCache.h>

NSString * const kArticleTableViewCellReusableIdentifier = @"ArticleTableViewCellReusableIdentifier";

@interface ArticleTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UIButton *favouriteStatusButton;
@end

@implementation ArticleTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(abstractLabelLongPressed:)];
    [self.abstractLabel addGestureRecognizer:longPressGestureRecognizer];
}

- (void)fillUsingManagableArticle:(GoTWikiaManagableArticle *)article
{
    self.titleLabel.text = article.title;
    self.abstractLabel.text = article.abstract;

    [self favouriteStatusButtonSelected:article.isFavourite];
    [self abstractLabelExpanded:article.isExpanded];

    [self.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL]
                           placeholderImage:[UIImage imageNamed:@"CharacterImagePlaceholder"]];
}

- (void)favouriteStatusButtonSelected:(BOOL)isSelected
{
    [self.favouriteStatusButton setImage:[UIImage imageNamed:isSelected ? @"FavouriteButtonSelected" : @"FavouriteButtonNotSelected"]
                                forState:UIControlStateNormal];
}

- (void)abstractLabelExpanded:(BOOL)isExpanded
{
    self.abstractLabel.numberOfLines = isExpanded ? 0 : 2;
}

#pragma mark - User Interation

- (IBAction)favouriteStatusButtonTapped:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapFavouriteStatusButton:)]) {
        [self.delegate didTapFavouriteStatusButton:self];
    }
}

- (void)abstractLabelLongPressed:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didLongPressOnAbstractLabel:)]) {
            [self.delegate didLongPressOnAbstractLabel:self];
        }
    }
}

@end
