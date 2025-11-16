pipeline {
    agent any

    parameters {
        choice(
            name: 'action',
            choices: ['apply', 'destroy'],
            description: 'Select Terraform action'
        )
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/SudarshanKDeore/Terraform-Jenkins.git']]
                )
            }
        }

        stage("Terraform Init") {
            steps {
                sh "terraform init -reconfigure"
            }
        }

        stage("Terraform Plan") {
            steps {
                sh "terraform plan"
            }
        }

        stage("Terraform Action") {
            steps {
                echo "Terraform action is --> ${params.action}"
                sh "terraform ${params.action} --auto-approve"
            }
        }

    }
}