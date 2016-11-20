//
//  ArticleDetailsViewController.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "ArticleDetailsViewController.h"
#import <WebImage/UIImageView+WebCache.h>

@interface ArticleDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UIImageView *favouriteStatusImage;
@end

@implementation ArticleDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.article) {
        self.titleLabel.text = self.article.title;
        self.abstractLabel.text = self.article.abstract;
        self.favouriteStatusImage.image = [UIImage imageNamed:self.article.isFavourite ? @"FavouriteButtonSelected" : @"FavouriteButtonNotSelected"];
        [self.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:self.article.thumbnailURL] placeholderImage:[UIImage imageNamed:@"CharacterImagePlaceholder"]];
    }
}

- (IBAction)openInSafariButtonTapped:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:self.article.absoluteURL];
}

@end
