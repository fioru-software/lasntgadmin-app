void setBuildStatus(String message, String state, String repo ) {
  step([
      $class: "GitHubCommitStatusSetter",
      reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/$repo"],
      contextSource: [$class: "ManuallyEnteredCommitContextSource", context: "ci/jenkins/build-status"],
      errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
      statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
  ]);
}

pipeline {

    parameters {
        string(name: 'WP_VERSION', defaultValue: 'latest', description: 'WordPress version')
        string(name: 'WP_LOCALE', defaultValue: 'en_GB', description: 'WordPress locale')
        gitParameter(name: "BRANCH_NAME", type: "PT_BRANCH", defaultValue: "staging", branchFilter: "origin/(master|staging)")
        booleanParam(name: 'DEPLOY', defaultValue: false, description: "Deploy To Kubernetes")
    }

    agent {
        kubernetes {
            inheritFrom 'jenkins-agent'
            yamlFile 'KubernetesPod.yaml'
        }
    }

    environment {
        COMMIT_SHA = sh(script: "git log -1 --format=%H", returnStdout:true).trim()
        GCLOUD_KEYFILE = credentials('jenkins-gcloud-keyfile');
        ENVIRONMENT = "${env.BRANCH_NAME == "master" ? "production" : env.BRANCH_NAME}"
        USER_ID = 33
    }

    stages {

        stage('Build') {
            when {
                beforeAgent true;
                allOf {
                    expression {return params.DEPLOY}
                    anyOf {
                        branch 'staging';
                        branch 'master';
                    }
                }
            }
            steps {
                container('cloud-sdk') {
                    script {
                        sh 'gcloud auth activate-service-account jenkins-agent@veri-cluster.iam.gserviceaccount.com  --key-file=${GCLOUD_KEYFILE}'
                        env.GCLOUD_TOKEN = sh(script: "gcloud auth print-access-token", returnStdout: true).trim()
                    }
                }
                container('docker') {
                    script {
                        sh 'docker login -u oauth2accesstoken -p $GCLOUD_TOKEN https://eu.gcr.io'
                        sh 'docker build --no-cache --build-arg WP_VERSION=${WP_VERSION} --build-arg WP_LOCALE=${WP_LOCALE} --tag lasntg:${COMMIT_SHA} .'
                        sh 'docker tag moodle:${COMMIT_SHA} eu.gcr.io/veri-cluster/lasntg:${COMMIT_SHA}'
                        sh 'docker tag moodle:${COMMIT_SHA} eu.gcr.io/veri-cluster/lasntg:${ENVIRONMENT}'
                        sh 'docker push eu.gcr.io/veri-cluster/lasntg:${COMMIT_SHA}'
                        sh 'docker push eu.gcr.io/veri-cluster/lasntg:${ENVIRONMENT}'
                    }
                }
            }
        }

        stage ('Deploy') {
            when {
                beforeAgent true;
                allOf {
                    expression {return params.DEPLOY}
                    anyOf {
                        branch 'staging';
                        branch 'master';
                    }
                }
            }
            steps {
                container('cloud-sdk') {
                    script {
                        sh "kubectl --token=$GCLOUD_TOKEN apply -k deployment/k8s/overlays/${ENVIRONMENT}"
                        sh "kubectl --token=$GCLOUD_TOKEN rollout restart deployment ${ENVIRONMENT}-lasntg"
                    }
                }
            }
        }
    }
}
