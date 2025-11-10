//
//  ListViewController.m
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 10/31/25.
//
#import "ListViewController.h"

@implementation ListViewController

/*
- (void) loadView {
    [super loadView];
    printf("Entering loadview code");
    UILabel* label = [[UILabel alloc] initWithFrame:self.view.bounds];
    [label setText:@"Hello Objective C"];
    [label setTextColor:[UIColor systemRedColor]];
    [label setBackgroundColor:[UIColor systemBackgroundColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    self.view = label;
}
*/

- (void) viewDidLoad {
    [super viewDidLoad];
    printf("Entering viewDidLoad code");
    [self setTitle:@"My View"];
    
    self.content = @[
        @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday",
        @"Sunday"
    ];
    
}

- (UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"week_cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // allocate cell if non existence
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // I will say, objective C did good getting rid of that god awful -> formatting for pointer deref
    cell.textLabel.text = [self.content objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.content count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *day = [self.content objectAtIndex:indexPath.row];
    NSLog(@"User selected: %@", day);
}

@end
