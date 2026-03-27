pipeline {
	agent any
	
	parameters {
        gitParameter branchFilter: 'origin/(.*)',
            defaultValue: 'main',
            name: 'BRANCH',
            quickFilterEnabled: true,
            selectedValue: 'NONE',
            sortMode: 'ASCENDING_SMART',
            tagFilter: '*',
            type: 'PT_BRANCH'
    }

    options {
        skipDefaultCheckout(true)
    }
    stages {
    stage('Clone') {
        steps {
            script {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "*/${params.BRANCH}"]],
                    userRemoteConfigs: [[
                        url: env.GIT_REPO,
                    ]]
                ])
            }
        }
    }
			stage('Log') {
				steps {
                    echo "BuildId: ${BUILD_ID}"
                    echo "PARAM_BRANCH_NAME: ${params.BRANCH}"
                    }
                }
            }
    }
    //echo "BRANCH_NAME: ${GIT_BRANCH}"
//             stage('Build APK') {
//                         steps {
//                             sh 'chmod +x ./gradlew'
//                             sh './gradlew clean assembleDebug'
//                         }
//                     }
//             stage('Archive APK') {
//                         steps {
//                             archiveArtifacts artifacts: '**/*.apk', fingerprint: true
//                         }
//             }
