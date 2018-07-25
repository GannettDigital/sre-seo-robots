pipeline {
  agent any
  options {
    disableConcurrentBuilds()
  }
  triggers {
    cron 'H 16 * * *'
  }
  stages {
    stage('check sites') {
      steps {
        script {
          //testing
          def site = "app"
          def check_robots
          sh "curl -o ${site}-latest.txt https://www.${site}.com/robots.txt && echo RADIOHEAD_IN_RAINBOWS >> ${site}-latest.txt"
          sh "cat ${site}-latest.txt"
            def identical = sh(script: "diff -q -B ${site}-latest.txt seo-robots/${site}.txt", returnStatus: true) == 0
            if (!identical) {
              check_robots = sh(script: "set +e; diff -s -B ${site}-latest.txt seo-robots/${site}.txt; true", returnStdout: true).trim()
              println check_robots
              echo "${site} differed:\n${check_robots}"
              currentBuild.result = 'UNSTABLE'
              slackSend color: 'danger',
                        channel: '#seo-robots-check',
                        message: "Processed robots.txt for ${site} and found differences: ```${check_robots}```"
            }

          // def sites = readJSON file: 'sites.json'
          // sites.each { site ->
          //   sh "curl -o ${site}-latest.txt https://www.${site}.com/robots.txt"
          //   def identical = sh(script: "diff -q -B ${site}-latest.txt seo-robots/${site}.txt", returnStatus: true) == 0
          //   if (!identical) {
          //     def check_robots = sh(script: "diff -s -B ${site}-latest.txt seo-robots/${site}.txt", returnStdout: true).trim()
          //     echo "${site} differed:\n${check_robots}"
          //     currentBuild.result = 'UNSTABLE'
          //     slackSend color: 'danger',
          //               channel: '#seo-robots-check',
          //               message: "Processed robots.txt for ${site} and found differences: ```${check_robots}```"
          //   }
          // }
        // }
      }
      post {
        cleanup {
          sh 'rm -r *-latest.txt || true'
        }
      }
    }
  }
}
}
