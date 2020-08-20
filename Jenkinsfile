pipeline {
  agent {
        node {
          label "clusterops-development-ephemeral"
        }
      }
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
              sh "curl --verbose -o ${site}-latest.txt https://www.${site}.com/robots.txt"
              // def identical = sh(script: "diff -q -B ${site}-latest.txt seo-robots/${site}.txt", returnStatus: true) == 0
              /* if (!identical) {
                mycolor = 'danger'
                def check_robots = sh(script: "set +e; diff -s -B ${site}-latest.txt seo-robots/${site}.txt; true", returnStdout: true).trim()
                echo "${site} differed:\n${check_robots}" */
              }
            }catch(err){
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
