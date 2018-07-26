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
            def check_robots
            sites.each { site ->
              sh "curl -o ${site}-latest.txt https://www.${site}.com/robots.txt && curl -o ${site}-http-latest.txt http://www.${site}.com/robots.txt"
              def httpCheck = sh(script: "cat ${site}-http-latest.txt", returnStatus: true)
              println "${httpCheck}".size()
              def identical = sh(script: "diff -q -B ${site}-latest.txt seo-robots/${site}.txt", returnStatus: true) == 0
              if("${httpCheck}".size() > 0 ){
                def identical2 = sh(script: "diff -q -B ${site}-http-latest.txt seo-robots/${site}.txt", returnStatus: true) == 0
              }
              if (!identical || !identical2) {
                mycolor = 'danger'
                check_robots = sh(script: "set +e; diff -s -B ${site}-latest.txt seo-robots/${site}.txt; true", returnStdout: true).trim()
                if(!identical2){
                  check_robots = sh(script: "set +e; diff -s -B ${site}-http-latest.txt seo-robots/${site}.txt; true", returnStdout: true).trim()
                }
                echo "${site} differed:\n${check_robots}"
                currentBuild.result = 'UNSTABLE'
                slackSend color: 'danger',
                          channel: '#seo-robots-check',
                          message: "Hey @here ! Processed robots.txt for ${site} and found differences: ```${check_robots}```"
              }
            }
            slackSend color: "${mycolor}",
                      channel: '#seo-robots-check',
                      message: "Hey @here ! robots.txt check has been run and succesfully completed for all uscp sites. Discrepancies (if any) have been listed above."

          }catch(err){
            slackSend color: 'danger',
                      channel: '#seo-robots-check',
                      message: "Hey @here ! robots.txt check has resulted in failure. Please contact `#sre` to troubleshoot the jenkins Cron job. ```${err}```"
          }
        }
      }
      post {
        cleanup {
          sh 'rm -r *-latest.txt || true'
          sh 'rm -r *-http-latest.txt || true'
        }
      }
    }
  }
}
