name := "List9"

version := "0.1"

scalaVersion := "2.13.4"

ThisBuild / scalaVersion := "2.13.4"

lazy val commonSettings=Seq(scalacOptions ++= Seq(
  "-deprecation", // Emit warning for usages of deprecated APIs
  "-encoding", "utf-8", // Specify character encoding used by source files
  "-explaintypes", // Explain type errors in more detail
  "-language:experimental.macros", // Allow macro definition
  "-language:implicitConversions", // Allow implicit functions
  "-Xfatal-warnings" // Fail the compilation if there are any warnings
))

libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.2" % "test"

coverageEnabled := true

lazy val blackjack = (project in file("BlackJack")).dependsOn(core).settings(commonSettings)
lazy val core = (project in file("Core")).settings(commonSettings)
