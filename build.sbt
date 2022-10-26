name := "EasyNPU"
version := "1.0"
scalaVersion := "2.11.12"
val spinalVersion = "1.7.3"

libraryDependencies ++= Seq(
  "org.scalanlp" % "breeze_2.11" % "0.12",
  "org.scalanlp" % "breeze-natives_2.11" % "0.12",
  "com.github.spinalhdl" % "spinalhdl-core_2.11" % spinalVersion,
  "com.github.spinalhdl" % "spinalhdl-lib_2.11" % spinalVersion,
  compilerPlugin("com.github.spinalhdl" % "spinalhdl-idsl-plugin_2.11" % spinalVersion)
)

fork := true
//EclipseKeys.withSource := true
