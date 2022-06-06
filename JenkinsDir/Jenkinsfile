pipeline {
    agent any
	stages {
        stage('Build') {
            steps{
			    sh 'mvn package' 
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true 
			}
        }
    }
}
