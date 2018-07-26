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
                if("${site}"=="gametimepa"){
                  mycolor = 'good'
                  slackSend color: 'warning',
                            channel: '#seo-robots-check',
                            message: "Processed robots.txt for ${site} and the difference probably is just an http instead of https. Don't worry about it. Here's the difference. ${check_robots}"
                  currentBuild.result = 'SUCCESS'
                }else {
                  slackSend color: 'danger',
                            channel: '#seo-robots-check',
                            message: "Processed robots.txt for ${site} and found differences: ```${check_robots}``` Here's the robots live : https://www.${site}.com/robots.txt"
                }
              }
            }
            slackSend color: "${mycolor}",
                      channel: '#seo-robots-check',
                      message: "Hey @here ! robots.txt check has been run and succesfully completed for all uscp sites. Discrepancies (if any) have been listed above."

          }catch(err){
            slackSend color: 'danger',
                      channel: '#seo-robots-check',
                      message: "Hey @here! robots.txt check has resulted in failure. Please contact `#sre` to troubleshoot the jenkins Cron job. ```${err}```"
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
