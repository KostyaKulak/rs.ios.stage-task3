#import "LevelOrderTraversal.h"

@interface Node : NSObject

@property NSNumber *key;
@property Node *left;
@property Node *right;

- (Node *)initWithKey:(NSNumber *)value;

- (Node *)treeFromPreorder:(NSMutableArray *)preorder;

- (NSMutableArray *)levelOrderTraversal;

- (void)appendLevelOrderTraversalResultsTo:(NSMutableArray *)traversal;

@end

@implementation Node

- (Node *)initWithKey:(NSNumber *)value {

    self = [super init];
    if (self != nil) {
        self.key = value;
        self.left = NULL;
        self.right = NULL;
    }
    return self;
}

- (Node *)treeFromPreorder:(NSMutableArray *)preorder {
    if (preorder.count == 0) {
        return nil;
    }

    id key = preorder.firstObject;
    [preorder removeObjectAtIndex:0];

    if (key == NSNull.null) {
        return nil;
    }

    Node *node = [Node.alloc initWithKey:key];
    node.left = [Node.alloc treeFromPreorder:preorder];
    node.right = [Node.alloc treeFromPreorder:preorder];

    return node;
}

- (NSMutableArray *)levelOrderTraversal {
    NSMutableArray *traversal = [@[[@[self.key] mutableCopy]] mutableCopy];
    [self.left appendLevelOrderTraversalResultsTo:traversal];
    [self.right appendLevelOrderTraversalResultsTo:traversal];
    return traversal;
}

- (void)appendLevelOrderTraversalResultsTo:(NSMutableArray *)traversal {
    if (self != nil) {
        NSArray *results = self.levelOrderTraversal;
        for (NSUInteger i = 0; i < results.count; ++i) {
            if (i < traversal.count - 1) {
                [traversal[i + 1] addObjectsFromArray:results[i]];
            } else {
                [traversal addObject:results[i]];
            }
        }
    }
}


@end

NSUInteger GlobalIndex = 0;

NSArray *LevelOrderTraversalForTree(NSArray *tree) {

    GlobalIndex = 0;
    Node *restoredTree = [[Node alloc] treeFromPreorder:[tree mutableCopy]];

    if (restoredTree) {
        return [restoredTree levelOrderTraversal];
    } else {
        return @[];
    }
}