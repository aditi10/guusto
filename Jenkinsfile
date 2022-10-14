pipeline {
    agent any
    tools {
        nodejs '16.17.0'
    }
    stages {
        stage('clone repository and install') {
            steps {
                sh '''
                rm -rf docs
                git clone --recurse-submodules https://github.com/mendix/docs
                npm version
                cd docs
                ls -lrth
                npm install
                echo ${WORKSPACE}
                chmod +x ./hugo
                ls -lrth


'''         }
        }

        stage('Run the server') {
            steps {
                sh '''
                cd ${WORKSPACE}/docs
                ls -lrth
                ./hugo server --debug --verbose --environment development'''

            }
        }

        stage('Deploy') {
            steps {
                sh '''Deploying the application'''
                sh '''echo "Starting sync to AWS"
                cd ./public
                aws s3 sync . s3://$TARGETAWSBUCKET --delete --only-show-errors --exclude "*.png" # sync all files except png files
                aws s3 sync . s3://$TARGETAWSBUCKET --delete --only-show-errors --size-only --exclude "*" --include "*.png" # sync all png files
                echo "Upload to AWS took $((SECONDS - start)) seconds" '''

            }
        }
    }
}