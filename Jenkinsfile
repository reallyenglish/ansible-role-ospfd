node ('virtualbox') {
  def directory = "ansible-role-ospfd"
  env.ANSIBLE_VAULT_PASSWORD_FILE = "~/.ansible_vault_key"
  stage 'Clean up'
  deleteDir()

  stage 'Checkout'
  sh "mkdir $directory"
  dir("$directory") {
    checkout scm
  }
  dir("$directory") {
    stage 'bundle'
    sh 'bundle install --path vendor/bundle'

    stage 'bundle exec kitchen test'
    try {
      sh 'bundle exec kitchen test'
    } catch (e) {
      notifyFailed()
      throw e
    } finally {
      sh 'bundle exec kitchen destroy'
    }
    stage 'integration'
    try {
      // use native rake instead of bundle exec rake
      // https://github.com/docker-library/ruby/issues/73
      sh 'rake test'
      notifySuccessful()
    } catch (e) {
      notifyFailed()
      throw e
    } finally {
      sh 'rake clean'
    }
    stage 'Notify'
    step([$class: 'GitHubCommitNotifier', resultOnFailure: 'FAILURE'])
  }
}

def notifyFailed() {
  hipchatSend (color: 'RED', notify: true,
    message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
  )
}

def notifySuccessful() {
  hipchatSend (color: 'GREEN', notify: true,
    message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
  )
}
