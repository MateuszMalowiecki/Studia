using System;

namespace POO_L8_Z4 {
    public class TicketMachine {
        IState state;
        public TicketMachine() {
            state=new WaitingForTicketsSelectionState(this);
        }

        public void SetState(IState newState) {
            this.state=newState;
        }

        public void ChooseTickets(string type, int amount, bool selectMore) {
            this.state.ChooseTickets(type, amount, selectMore);
        }
        
        public void InsertMoney(int amount) {
            this.state.InsertMoney(amount);
        }

        public void TakeRestAndTickets() {
            this.state.TakeRestAndTickets();
        }
    }
    public interface IState {
        void ChooseTickets(string type, int amount, bool selectMore);
        void InsertMoney(int amount);
        void TakeRestAndTickets();
    }
    public class WaitingForTicketsSelectionState: IState {
        TicketMachine machine;
        
        public WaitingForTicketsSelectionState(TicketMachine machine) {
            this.machine=machine;
        }

        public void ChooseTickets(string type, int amount, bool selectMore) {
            Console.WriteLine("You chose {0} tickets of type {1}", amount, type);
            if(!selectMore) {
                this.machine.SetState(new WaitingForMoneyState(machine));
            }   
        }

        public void InsertMoney(int amount) {
            throw new Exception("You need to decide, which tickets you choose and then you can insert money");
        }

        public void TakeRestAndTickets() {
            throw new Exception("You need to decide, which tickets you choose and then you can take them");
        }
    }
    public class WaitingForMoneyState: IState {
        TicketMachine machine;

        public WaitingForMoneyState(TicketMachine machine) {
            this.machine=machine;
        }
        public void ChooseTickets(string type, int amount, bool selectMore) {
            throw new Exception("You need to pay for chosen tickets and then you can choose some others");
        }
        public void InsertMoney(int amount) {
            Console.WriteLine("Paid {0} dollars", amount);
            this.machine.SetState(new RestAndTicketsIssuingState(machine));
        }
        public void TakeRestAndTickets() {
            throw new Exception("You need to pay for chosen tickets and then you can take them");            
        }
    }
    public class RestAndTicketsIssuingState: IState {
        TicketMachine machine;

        public RestAndTicketsIssuingState(TicketMachine machine) {
            this.machine=machine;
        }
        public void ChooseTickets(string type, int amount, bool selectMore) {
            throw new Exception("You need to take your tickets and rest, and then you can choose some others");
        }
        public void InsertMoney(int amount) {
            throw new Exception("You just paid for tickets, so you just need to take them.");
        }
        public void TakeRestAndTickets() {
            Console.WriteLine("Here you have your tickets.");
            this.machine.SetState(new WaitingForTicketsSelectionState(machine));
        }
    }
    public class Test {
        public static void Main() {
            TicketMachine machine=new TicketMachine();
            machine.ChooseTickets("Ulgowy", 2, false);
            machine.InsertMoney(5);
            machine.TakeRestAndTickets();
            machine.ChooseTickets("Normalny", 3, true);
            machine.ChooseTickets("Ulgowy", 2, false);
            machine.InsertMoney(9);
            machine.TakeRestAndTickets();
        }
    }
}