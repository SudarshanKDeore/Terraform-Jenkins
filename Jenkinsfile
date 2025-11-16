pipeline {
    agent any

<<<<<<< HEAD
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

=======
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ygminds73/Terraform-Automation.git']])
            }
        }
    
        stage ("terraform init") {
            steps {
                sh ("terraform init -reconfigure") 
            }
        }
        
        stage ("plan") {
            steps {
                sh ('terraform plan') 
            }
        }

        stage (" Action") {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve')         # FOR CHOICE PARAMETER: parameters { choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select Terraform action') }
           }
        }
>>>>>>> 3d479b842da850bd26db903b463740f59b6e5106
    }
}