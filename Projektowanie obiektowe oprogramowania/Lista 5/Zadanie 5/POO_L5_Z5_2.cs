using System;

namespace POO_L5_Z5_2 {
    public abstract class PersonNotifier {
        PersonRegistry registry;
        public PersonNotifier(PersonRegistry registry) {
            this.registry=registry;
        }
        public List<Person> GetPersons() {
            this.registry.GetPersons();
        }
        public abstract void NotifyPersons(List<Person> persons);
    }
    public abstract class PersonRegistry {
        public abstract void GetPersons();
    }
}