using System;

namespace POO_L5_Z5 {
    public abstract class PersonRegistry {
        PersonNotifier notifier;
        public PersonRegistry(PersonNotifier notifier) {
            this.notifier=notifier;
        }
        public abstract List<Person> GetPersons();
        public void NotifyPersons() {
            this.notifier.NotifyPersons(GetPersons());
        }
    }
    public abstract class PersonNotifier {
        public abstract void NotifyPersons(List<Person> persons);
    }
}