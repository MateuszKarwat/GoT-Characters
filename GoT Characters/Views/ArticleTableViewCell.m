//
//  ArticleTableViewCell.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "ArticleTableViewCell.h"

NSString * const kArticleTableViewCellReusableIdentifier = @"ArticleTableViewCellReusableIdentifier";

@implementation ArticleTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(abstractLabelLongPressed:)];
    [self.abstractLabel addGestureRecognizer:longPressGestureRecognizer];
}

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
