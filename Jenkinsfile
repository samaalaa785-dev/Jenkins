
pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
        timestamps()
    }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stg', 'prod'],
            description: 'Choose the Terraform environment'
        )
    }

    environment {
        TF_IN_AUTOMATION = 'true'
        AWS_ACCESS_KEY_ID = 'test'
        AWS_SECRET_ACCESS_KEY = 'test'
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Workspace') {
            steps {
                script {
                    def environmentName = params.ENVIRONMENT

                    if (!(environmentName in ['dev', 'stg', 'prod'])) {
                        error("Invalid environment: ${environmentName}")
                    }

                    sh """
                        terraform workspace select '${environmentName}' ||
                        terraform workspace new '${environmentName}'
                    """
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh """
                    terraform plan \
                        -input=false \
                        -var-file="${params.ENVIRONMENT}.tfvars" \
                        -out=tfplan
                """
            }
        }

        stage('Approval') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input(
                        message: "Review the Terraform plan and approve deployment to ${params.ENVIRONMENT}?",
                        ok: 'Approve Apply'
                    )
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -input=false -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            echo 'Terraform pipeline finished.'
        }

        success {
            echo 'Terraform pipeline executed successfully!'
        }

        failure {
            echo 'Terraform pipeline failed!'
        }

        aborted {
            echo 'Terraform pipeline was aborted.'
        }
    }
}

pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
        timestamps()
    }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stg', 'prod'],
            description: 'Choose the Terraform environment'
        )
    }

    environment {
        TF_IN_AUTOMATION = 'true'
        AWS_ACCESS_KEY_ID = 'test'
        AWS_SECRET_ACCESS_KEY = 'test'
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Workspace') {
            steps {
                script {
                    def environmentName = params.ENVIRONMENT

                    if (!(environmentName in ['dev', 'stg', 'prod'])) {
                        error("Invalid environment: ${environmentName}")
                    }

                    sh """
                        terraform workspace select '${environmentName}' ||
                        terraform workspace new '${environmentName}'
                    """
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh """
                    terraform plan \
                        -input=false \
                        -var-file="${params.ENVIRONMENT}.tfvars" \
                        -out=tfplan
                """
            }
        }

        stage('Approval') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input(
                        message: "Review the Terraform plan and approve deployment to ${params.ENVIRONMENT}?",
                        ok: 'Approve Apply'
                    )
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -input=false -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            echo 'Terraform pipeline finished.'
        }

        success {
            echo 'Terraform pipeline executed successfully!'
        }

        failure {
            echo 'Terraform pipeline failed!'
        }

        aborted {
            echo 'Terraform pipeline was aborted.'
        }
    }
}

pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stg', 'prod'],
            description: 'Choose environment'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Workspace') {
            steps {
                sh '''
                    terraform workspace select $ENVIRONMENT || \
                    terraform workspace new $ENVIRONMENT
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform plan \
                    -var-file="$ENVIRONMENT.tfvars" \
                    -out=tfplan
                '''
            }
        }

        stage('Approval') {
            steps {
                input message: "Approve deployment to ${params.ENVIRONMENT}?",
                      ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
