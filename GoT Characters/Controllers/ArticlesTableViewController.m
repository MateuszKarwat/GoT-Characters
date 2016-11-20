//
//  ArticlesTableViewController.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <WebImage/UIImageView+WebCache.h>
#import "ArticlesTableViewController.h"
#import "ArticleTableViewCell.h"
#import "GoTWikiaArticle.h"
#import "GoTWikiaFetcher.h"

NSString * const kMostViewedArticlesDefaultCategory = @"Characters";
NSUInteger const kMostViewedArticlesDefaultLimit    = 75;

@interface ArticlesTableViewController ()
@property NSArray *mostViewedArticles;
@end

@implementation ArticlesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;

    [self refetchMostViewedArticles];
}

- (void)refetchMostViewedArticles
{
    GoTWikiaFetcher *fetcher = [[GoTWikiaFetcher alloc] init];
    [fetcher fetchMostViewedArticlesFromCategory:kMostViewedArticlesDefaultCategory withLimit:kMostViewedArticlesDefaultLimit completionHandler:^(NSArray *fetchedArticles) {
        if (fetchedArticles != nil) {
            self.mostViewedArticles = fetchedArticles;

            [self.tableView reloadData];
        }

        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mostViewedArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleTableViewCellReusableIdentifier forIndexPath:indexPath];
    
    GoTWikiaArticle *article = self.mostViewedArticles[indexPath.row];

    cell.titleLabel.text = article.title;
    cell.abstractLabel.text = article.abstract;
    [cell.favouriteStatusButton setImage:[UIImage imageNamed:article.isFavourite ? @"FavouriteButtonSelected" : @"FavouriteButtonNotSelected"] forState:UIControlStateNormal];
    [cell.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL] placeholderImage:[UIImage imageNamed:@"CharacterImagePlaceholder"]];
    
    return cell;
}

@end
