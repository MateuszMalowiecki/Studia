using System;
using System.Linq;
using System.Linq.Expressions;

namespace POO_L6_Z4 {
    public class PrintExpressionVisitor : ExpressionVisitor{
        protected override Expression VisitBinary( BinaryExpression expression ) {
            Console.WriteLine("{0} {1} {2}", expression.Left, expression.NodeType, expression.Right);
            return base.VisitBinary(expression);
        }
        protected override Expression VisitUnary( UnaryExpression expression ) {
            Console.WriteLine("{0} {1}", expression.NodeType, expression.Operand);
            return base.VisitUnary(expression);
        } 
        protected override Expression VisitConstant( ConstantExpression expression ) {
            Console.WriteLine(expression.Value);
            return base.VisitConstant(expression);
        } 
        protected override Expression VisitTry( TryExpression expression ) {
            Console.WriteLine(expression.Body);
            return base.VisitTry(expression);
        }
        protected override Expression VisitLambda<T>( Expression<T> expression ) {
            Console.WriteLine("{0} -> {1}", expression.Parameters.Aggregate(string.Empty, (a, e) => a += e), expression.Body );
            return base.VisitLambda<T>( expression );
        }
    }
    class Program {
        static void Main(string[] args) {
            Expression<Func<int, int>> f = n => 4 * (7 + n);
            UnaryExpression u = Expression.ArrayLength(Expression.Constant(new [] {2, 57, 18, 74}));
            ConstantExpression c = Expression.Constant(42);
            TryExpression t = Expression.TryCatch(
                Expression.Block(Expression.Throw(
                    Expression.Constant(new DivideByZeroException())), 
                    Expression.Constant(56)),
                Expression.Catch(
                    typeof(DivideByZeroException), 
                    Expression.Constant(78)));

            BlockExpression b= Expression.Block(f, u, c, t);
            PrintExpressionVisitor v = new PrintExpressionVisitor();
            v.Visit(b);
        }
    } 
}