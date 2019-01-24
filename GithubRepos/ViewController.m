//
//  ViewController.m
//  GithubRepos
//
//  Created by Jun Oh on 2019-01-24.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray* repos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/juuuuuun/repos"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSMutableArray* repoMutableArray = [NSMutableArray array];
        // If we reach this point, we have successfully retrieved the JSON from the API
        for (NSDictionary *repo in repos) { // 4
            
            Repo* repoObj = [[Repo alloc] initWithName:repo[@"name"]];
            [repoMutableArray addObject:repoObj];
            NSString *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
        }
        self.repos = repoMutableArray.copy;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            [self.tableView reloadData];
        }];
        
    }]; // 5
    
    [dataTask resume]; // 6
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Repo* repo = self.repos[indexPath.row];
    cell.textLabel.text = repo.name;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repos.count;
}


@end
