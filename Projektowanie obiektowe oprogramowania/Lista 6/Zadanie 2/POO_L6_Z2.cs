using System;
using System.Collections.Generic;
namespace POO_L6_Z2{
    public class Context {
        Dictionary<string, bool> valuation=new Dictionary<string, bool>();
        public bool GetValue( string VariableName ) { 
            var keys = valuation.Keys;
            foreach( string s in keys ) {
                if (s == VariableName) {
                    return valuation[VariableName];
                }
            }
            throw new ArgumentException(String.Format("Undefined variable: {0}", VariableName));        
        }
        public void SetValue( string VariableName, bool Value ) { 
            valuation[VariableName]=Value;    
        }
    }
    public abstract class AbstractExpression {
        public abstract bool Interpret( Context context );
    }

    public class VarExpression : AbstractExpression { 
        private string name;
        public VarExpression(string name) {
            this.name=name;
        }
        public override bool Interpret( Context context ) {
            return context.GetValue(name);
        } 
    }

    public class ConstExpression : AbstractExpression { 
        private bool constVal;
        public ConstExpression(bool constVal) {
            this.constVal=constVal;
        }
        public override bool Interpret( Context context ) {
            return constVal;
        } 
    }
    public abstract class BinaryExpression : AbstractExpression { 
        protected AbstractExpression left;
        protected AbstractExpression right;
        public BinaryExpression(AbstractExpression left, AbstractExpression right) {
            this.left=left;
            this.right=right;
        }
    }
    public class AndExpression : BinaryExpression {
        public AndExpression(AbstractExpression left, AbstractExpression right): base(left, right) {}
        public override bool Interpret( Context context ) {
            return left.Interpret(context) && right.Interpret(context);
        }
    }

    public class OrExpression : BinaryExpression {
        public OrExpression(AbstractExpression left, AbstractExpression right): base(left, right) {}
        public override bool Interpret( Context context ) {
            return left.Interpret(context) || right.Interpret(context);
        }
    }
    
    public abstract class UnaryExpression : AbstractExpression { 
        protected AbstractExpression subExp;
        public UnaryExpression(AbstractExpression subExp) {
            this.subExp=subExp;
        }
    }
    public class NotExpression : UnaryExpression {
        public NotExpression(AbstractExpression subExp) : base(subExp) {}
        public override bool Interpret( Context context ) {
            return !subExp.Interpret(context);
        }
    }
    public class Test {
        public static void Main() {
            Context ctx = new Context();
            ctx.SetValue( "x", false );
            ctx.SetValue( "y", true );
            AbstractExpression exp = new AndExpression(
                new OrExpression(new ConstExpression(true), new VarExpression("y")),
                new NotExpression(new VarExpression("x"))); // jakieś wyrażenie logiczne ze stałymi i zmiennymi
            bool Value = exp.Interpret( ctx );
            Console.WriteLine("Value of expression: {0}", Value);
        }
    }
}