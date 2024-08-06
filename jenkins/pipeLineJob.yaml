pipeline {
    agent any
    
    tools{
        jdk 'jdk17'
        maven 'maven3'
    }
    
    environment{
        SCANNER_HOME=tool 'sonar-scanner'
    }
    
    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/vijkes/Petclinic.git'
            }
        }
        stage('compile') {
            steps {
                sh "mvn clean compile"
            }
        }
        stage('test cases') {
            steps {
                sh "mvn test"
            }
        }
        
        stage('sonarqube-analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Petclinic \
                    -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=Petclinic '''
                }
            }
        }
        
        stage('build') {
            steps {
                sh "mvn clean package -DskipTests=true"
            }
        }
        
        stage('OWASP dependency check') {
            steps {
                dependencyCheck additionalArguments: '--scan target/', odcInstallation: 'dp_chk'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        
        stage('mvn nexus') {
            steps {
                configFileProvider([configFile(fileId: '3481761b-8c2e-43e1-bd65-c01fbcddf44b', variable: 'mavensettings')]) {
                    sh "mvn -s $mavensettings clean deploy -DskipTests=true"
                }
            }
        }
        
        stage('deploy') {
            steps {
                sh "cp target/*.war /opt/apache-tomcat-9.0.89/webapps"
            }
        }
        // stage('Git checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/vijkes/Petclinic.git'
        //     }
        // }
        // stage('Git checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/vijkes/Petclinic.git'
        //     }
        // }
    }
}
