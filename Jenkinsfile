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
          try {
            def sites = readJSON file: 'sites.json'
            def mycolor = 'good'
            sites.each { site ->
              sh "curl -o ${site}-latest.txt https://www.${site}.com/robots.txt"
              def identical = sh(script: "diff -q -B ${site}-latest.txt seo-robots/${site}.txt", returnStatus: true) == 0
              if (!identical) {
                mycolor = 'danger'
                def check_robots = sh(script: "set +e; diff -s -B ${site}-latest.txt seo-robots/${site}.txt; true", returnStdout: true).trim()
                echo "${site} differed:\n${check_robots}"
                currentBuild.result = 'UNSTABLE'
                slackSend color: 'danger',
                          channel: '#seo-robots-check',
                          message: "Processed robots.txt for ${site} and found differences: ```${check_robots}```"
              }
            }
            slackSend color: "${mycolor}",
                      channel: '#seo-robots-check',
                      message: "robots.txt check has been run and succesfully completed for all uscp sites. Discrepancies (if any) have been listed above."

          }catch(err){
            slackSend color: 'danger',
                      channel: '#seo-robots-check',
                      message: "robots.txt check has resulted in failure. Please contact `#sre` to troubleshoot the jenkins Cron job. ```${err}```"
          }
        }
      }
      post {
        cleanup {
          sh 'rm -r *-latest.txt || true'
        }
      }
    }
  }
}
