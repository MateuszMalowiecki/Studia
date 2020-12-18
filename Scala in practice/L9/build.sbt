name := "List9"

version := "0.1"

scalaVersion := "2.13.4"

import scalariform.formatter.preferences._
scalariformPreferences := scalariformPreferences.value
  .setPreference(AlignSingleLineCaseStatements, true)
  .setPreference(DoubleIndentConstructorArguments, true)
  .setPreference(DanglingCloseParenthesis, Preserve)

inThisBuild(
  List(
    scalaVersion := "2.12.12", // 2.11.12, or 2.13.4
    semanticdbEnabled := true, // enable SemanticDB
    semanticdbVersion := scalafixSemanticdb.revision // use Scalafix compatible version
  )
)

lazy val commonSettings=Seq(scalacOptions ++= Seq(
  "-deprecation", // Emit warning for usages of deprecated APIs
  "-encoding", "utf-8", // Specify character encoding used by source files
  "-unchecked", //Enable additional warnings where generated code depends on assumptions.
  "-explaintypes", // Explain type errors in more detail
  "-language:implicitConversions", //Allow definition of implicit functions called views
  "-language:existentials", //Existential types (besides wildcard types) can be written and inferred
  "-language:postfixOps", //Allow postfix operator notation, such as 1 to 10 toList
  "-language:higherKinds", //Allow higher-kinded types
  "-Xfatal-warnings", // Fail the compilation if there are any warnings
  "-Xlint", //Enable recommended warnings
  "-Yrangepos", //Use range positions for syntax trees(required by SemanticDB compiler plugin).
  "-Ywarn-unused" // Enable or disable specific unused warnings(required by `RemoveUnused` rule)
))

coverageEnabled := true
libraryDependencies ++= Seq("org.scoverage" %% "scalac-scoverage-runtime" % "1.0.4")

lazy val core = (project in file("Core")).settings(commonSettings, libraryDependencies ++= Seq("org.scalatest" %% "scalatest" % "3.2.2"))
lazy val blackjack = (project in file("BlackJack")).dependsOn(core).settings(commonSettings, libraryDependencies ++= Seq("org.scalatest" %% "scalatest" % "3.2.2"))