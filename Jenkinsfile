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

	agent {
		kubernetes {
			inheritFrom 'jenkins-agent'
			yamlFile 'KubernetesPod.yaml'
		}
	}

	parameters {
		string(name: 'WP_VERSION', defaultValue: '6.7.2', description: 'WordPress version')
		string(name: 'WP_LOCALE', defaultValue: 'en_GB', description: 'WordPress locale')
		booleanParam(name: 'DEPLOY', defaultValue: false, description: "Deploy To Kubernetes")
	}

	environment {
		DOCKER_REGISTRY = 'europe-west1-docker.pkg.dev/veri-cluster/docker-belgium'
		GCLOUD_KEYFILE = credentials('jenkins-gcloud-keyfile');
		GITHUB_TOKEN = credentials('jenkins-github-personal-access-token')
		ENVIRONMENT = "${GIT_LOCAL_BRANCH == "master" ? "production" : GIT_LOCAL_BRANCH}"
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
						sh 'docker login -u oauth2accesstoken -p $GCLOUD_TOKEN https://$DOCKER_REGISTRY'
						sh 'docker build --no-cache --build-arg GITHUB_TOKEN=${GITHUB_TOKEN} --build-arg USER_ID=${USER_ID} --build-arg WP_VERSION=${WP_VERSION} --build-arg WP_LOCALE=${WP_LOCALE} --tag lasntgadmin:${GIT_COMMIT} .'
						sh 'docker tag lasntgadmin:${GIT_COMMIT} ${DOCKER_REGISTRY}/lasntgadmin:${GIT_COMMIT}'
						sh 'docker tag lasntgadmin:${GIT_COMMIT} ${DOCKER_REGISTRY}/lasntgadmin:${ENVIRONMENT}'
						sh 'docker push ${DOCKER_REGISTRY}/lasntgadmin:${GIT_COMMIT}'
						sh 'docker push ${DOCKER_REGISTRY}/lasntgadmin:${ENVIRONMENT}'
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
						sh "kubectl --token=$GCLOUD_TOKEN rollout restart deployment ${ENVIRONMENT}-lasntgadmin"
						sh "kubectl --token=$GCLOUD_TOKEN rollout status deployment ${ENVIRONMENT}-lasntgadmin"
					}
				}
			}
		}
	}
}
