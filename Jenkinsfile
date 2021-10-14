try {
stage("Building SONAR ...") {
sh './gradlew clean sonarqube'
}
} catch (e) {emailext attachLog: true, body: 'See attached log', subject: 'BUSINESS Build Failure', to: 'amohsenter09@gmail.com"
step([$class: 'WsCleanup'])
return
             
dependencies {
classpath "org.sonarsource.scanner.gradle: sonarqube-gradle-plugin:2.5"
}
             
             
sonarqube {
properties {
property "sonar.host.url", http://sonarqube:9000 //  url is your sonar server
property "sonar.projectName", "sonar-checks"   //  this name will appear in dashboard
property "sonar.projectKey", "projectKey" // It sould be a keybased on this report is created
property "sonar.groovy.jacoco.reportPath", "${project.buildDir}/jacoco/test.exec"    }
}       
