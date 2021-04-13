using System;

namespace POO_L6_Z3 {
    public abstract class Tree {}

    public class TreeNode : Tree {
        public Tree Left { get; set; }
        public Tree Right { get; set; }
    }

    public class TreeLeaf : Tree {
        public int Value { get; set; }
    }

    public abstract class TreeVisitor {
        public int Visit( Tree tree ) {
            if (tree is TreeNode) {
                return this.VisitNode( (TreeNode)tree );
            }
            else {
                return this.VisitLeaf( (TreeLeaf)tree );
            }
        }
        public abstract int VisitNode( TreeNode node );
        public abstract int VisitLeaf( TreeLeaf leaf );
    }

    public class DepthTreeVisitor : TreeVisitor { 

        public override int VisitNode( TreeNode node ) {
            return Math.Max(Visit(node.Left), Visit(node.Right)) + 1;
        }

        public override int VisitLeaf( TreeLeaf leaf ) {
            return 0;
        }
    }

    public class Test {
        public static void Main() {
            Tree root = new TreeNode() {
                Left = new TreeNode() {
                    Left = new TreeLeaf() { Value = 1 },
                    Right = new TreeLeaf() { Value = 2 },
                },
                Right = new TreeLeaf() { Value = 3 }
            };
            DepthTreeVisitor visitor = new DepthTreeVisitor();
            var depth=visitor.Visit(root);

            Console.WriteLine("Głębokość drzewa to {0}", depth);
        }
    }
}