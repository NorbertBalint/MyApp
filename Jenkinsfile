pipeline {

    agent any
        stages {
        stage('Log') {
            steps {
                    echo "BuildId: ${BUILD_ID}"
                    echo "BRANCH_NAME: ${GIT_BRANCH}"
                }
        }
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
        }
}