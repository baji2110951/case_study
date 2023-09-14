pipeline {
    agent any

    stages {
        stage('GitCheckout') {
            steps {
              git branch: 'main', credentialsId: 'git_pwd', url: 'https://github.com/baji2110951/case_study.git'
            }
        }

       stage('Terraform init') {
            steps {
                dir('infra'){
                sh ('terraform init -reconfigure')
                }
            }
        }

        stage('Terraform plan') {
            steps {
                dir('infra'){
                sh ('terraform plan')
                }
            }
        }

        stage('Infrastructure Deploy') {
            steps {
                script {
                    if (params.action == 'apply') {
                        echo "Terraform action is --> ${action}"
                        dir('infra'){
                            sh ('terraform ${action} --auto-approve')
                        }
                    } else {
                        echo "Terraform action is --> ${action}"
                        echo "Destroying infrastructure..."
                        dir('infra'){
                            sh ('terraform ${action} --auto-approve')
                        }
                        currentBuild.result = "SUCCESS"
                        return
                    }
                }
            }

        }

        stage('Get Instance Public Ip') {
            when { expression { params.action == 'apply' } }
            steps {
                sh ('/bin/sh get_public_ip.sh')
            }
        }

        stage('Ansible') {
            when { expression { params.action == 'apply' } }
            steps {
                echo "Configuring Application Server"
                echo "Running Ansible Playbook"
                sh ('/bin/sh scripts/login.sh')
                ansiblePlaybook become: true, extras: '--private-key infra/ec2key.pem', installation: 'ansible', inventory: 'config/hosts', playbook: 'config/dependencies.yaml'
                ansiblePlaybook become: true, extras: '--private-key infra/ec2key.pem', installation: 'ansible', inventory: 'config/hosts', playbook: 'config/nginx.yaml'
                ansiblePlaybook become: true, extras: '--private-key infra/ec2key.pem', installation: 'ansible', inventory: 'config/hosts', playbook: 'config/mariadb.yaml'
                ansiblePlaybook become: true, extras: '--private-key infra/ec2key.pem', installation: 'ansible', inventory: 'config/hosts', playbook: 'config/tomcat.yaml'
            }
        }
    }
}
