package models

import models.{Student, Lecture, Enrollment}

object DB {
    private val stud1: Student = Student(300774, "Mateusz", 4)
    private val stud2: Student = Student(324567, "Michał", 3)
    private val stud3: Student = Student(317415, "Adrian", 2)
    private val stud4: Student = Student(235321, "Wojciech", 5)
    private val stud5: Student = Student(145413, "Alicja", 1)
    private val stud6: Student = Student(412512, "Gabriela", 3)
    private val stud7: Student = Student(812513, "Karolina", 4)
    private val stud8: Student = Student(623512, "Kacper", 2)
    private val stud9: Student = Student(752313, "Krystian", 1)
    private val stud10: Student = Student(412531, "Barbara", 5)
    val students: List[Student] = List(stud1, stud2, stud3, stud4, stud5, stud6, stud7, stud8, stud9, stud10)
    private val lect1: Lecture = Lecture("sip", "Scala in Practice")
    private val lect2: Lecture = Lecture("c++", "Kurs C++")
    private val lect3: Lecture = Lecture("aisd", "Algorytmy i struktury danych")
    private val lect4: Lecture = Lecture("jfizo", "Języki formalne i złożność obliczeniowa")
    val lectures: List[Lecture] = List(lect1, lect2, lect3, lect4)
    private val enrollment1: Enrollment = Enrollment("sip", List(stud1, stud3, stud6, stud7, stud10))
    private val enrollment2: Enrollment = Enrollment("aisd", List(stud1, stud2, stud3, stud7, stud8, stud9))
    private val enrollment3: Enrollment = Enrollment("jfizo", List(stud3, stud4, stud5, stud6, stud10))
    val enrollments: List[Enrollment] = List(enrollment1, enrollment2, enrollment3)
}