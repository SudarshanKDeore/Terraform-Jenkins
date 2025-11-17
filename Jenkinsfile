pipeline {
    agent any

      environment {
        TF_HOME = "${WORKSPACE}/terraform"
        TF_PLUGIN_CACHE_DIR = "/opt/terraform/plugins"
      }    
    
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
                    userRemoteConfigs: [[url: 'https://github.com/SudarshanKDeore/Terraform-Jenkins.git']],
                    extensions: [
                        [$class: 'CloneOption', noTags: true, shallow: true, depth: 1]
                    ]
                )
            }
        }

        stage("Terraform Init") {
            steps {
                sh '''
                  mkdir -p "$TF_PLUGIN_CACHE_DIR"
                  terraform init -input=false
              '''
            }
        }

        stage("Terraform Plan") {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage("Terraform Action") {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds']]) 
                {
                echo "Terraform action is --> ${params.action}"
                sh "terraform ${params.action} --auto-approve"
                }
            }
        }
    }
}
