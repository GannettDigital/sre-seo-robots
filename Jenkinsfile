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
              sh "curl --verbose -o ${site}-latest.txt http://www.${site}.com/robots.txt"
              def identical = sh(script: "diff -q -B ${site}-latest.txt seo-robots/${site}.txt", returnStatus: true) == 0
              if (!identical) {
                mycolor = 'danger'
                def check_robots = sh(script: "set +e; diff -s -B ${site}-latest.txt seo-robots/${site}.txt; true", returnStdout: true).trim()
                echo "${site} differed:\n${check_robots}"
                currentBuild.result = 'UNSTABLE'
                  slackSend color: 'danger',
                            channel: '#seo-robots-check',
                            message: "Processed robots.txt for ${site} and found differences: ```${check_robots}``` Here's the robots live : https://www.${site}.com/robots.txt"

              }
            }
            if (currentBuild.result == 'UNSTABLE') {
              slackSend color: 'danger',
                          channel: '#seo-robots-check',
                          message: "One or more sites had robots.txt differences. Check out the Google Bot dashboard for more context: https://service.us2.sumologic.com/ui/#/dashboard/MVoM95VCwQLbl97vfjd5dawKz2aVwZBxn41m3t3uaXtHACHCnQRrOr1qY5Ea"
            }
            slackSend color: "${mycolor}",
                      channel: '#seo-robots-check',
                      message: "Hey! robots.txt check has been run and succesfully completed for usatoday and all uscp sites. Discrepancies (if any) have been listed above."

          }catch(err){
            slackSend color: 'danger',
                      channel: '#seo-robots-check',
                      message: "Hey! robots.txt check has resulted in failure. Please contact `#sre` to troubleshoot the jenkins Cron job. ```${err}```"
          }
        }
      }
      post {
        cleanup {
          sh 'rm -f *-latest.txt || true'
        }
      }
    }
  }
}
